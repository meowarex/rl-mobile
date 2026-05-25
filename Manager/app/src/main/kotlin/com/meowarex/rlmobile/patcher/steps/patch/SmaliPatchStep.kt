package com.meowarex.rlmobile.patcher.steps.patch

import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.IDexProvider
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.patcher.steps.download.CopyDependenciesStep
import com.meowarex.rlmobile.patcher.steps.download.DownloadPatchesStep
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.android.tools.smali.baksmali.Baksmali
import com.android.tools.smali.baksmali.BaksmaliOptions
import com.android.tools.smali.dexlib2.Opcodes
import com.android.tools.smali.dexlib2.dexbacked.DexBackedDexFile
import com.android.tools.smali.smali.Smali
import com.android.tools.smali.smali.SmaliOptions
import com.github.diamondminer88.zip.ZipReader
import com.github.difflib.DiffUtils
import com.github.difflib.UnifiedDiffUtils
import com.github.difflib.patch.Patch
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import java.io.*

class SmaliPatchStep(
    private val options: PatchOptions,
) : Step(), IDexProvider, KoinComponent {
    private val paths: PathManager by inject()

    override val group = StepGroup.Patch
    override val localizedName = R.string.patch_step_patch_smali

    private val coreCount = Runtime.getRuntime().availableProcessors()
    private val smaliDir = paths.patchingWorkingDir.resolve("smali")
    private val outDex = smaliDir.resolve("patched.dex")

    override suspend fun execute(container: StepRunner) {
        val apk = container.getStep<CopyDependenciesStep>().apk
        val patchesZip = container.getStep<DownloadPatchesStep>().getStoredFile(container)

        val patches = mutableListOf<LoadedPatch>()
        val localsBumps = mutableMapOf<Pair<String, String>, Int>()

        // Load and parse all the patches from the smali archive.
        container.log("Loading patches from smali patch archive: ${patchesZip.absolutePath}")
        smaliDir.mkdirs()
        ZipReader(patchesZip).use { zip ->
            // Iterate in filename order so patches apply deterministically
            for (patchFile in zip.entryNames.sorted()) {
                container.log("Parsing patch file $patchFile")
                if (patchFile.endsWith("/")) continue

                if (patchFile.endsWith(".smali") && patchFile.startsWith("extension/")) {
                    val relative = patchFile.removePrefix("extension/")
                    val out = smaliDir.resolve(relative)
                    // Guard against zip-slip: a crafted entry could otherwise escape smaliDir.
                    val baseCanonical = smaliDir.canonicalPath + File.separator
                    val outCanonical = out.canonicalPath
                    if (!outCanonical.startsWith(baseCanonical)) {
                        throw SecurityException("Zip entry escapes target directory: $patchFile")
                    }
                    val entry = zip.openEntry(patchFile)
                        ?: throw FileNotFoundException("Missing zip entry: $patchFile")
                    out.canonicalFile.parentFile?.mkdirs()
                    out.writeBytes(entry.read())
                    container.log("Extracted extension smali: $relative")
                    continue
                }

                if (!patchFile.endsWith(".patch")) continue

                val basename = patchFile.substringAfterLast('/')
                if (basename in options.disabledPatches) {
                    container.log("Skipping disabled patch $patchFile")
                    continue
                }

                val lines = zip.openEntry(patchFile)!!.read()
                    .decodeToString()
                    .replace("\r\n", "\n") // Replace CRLF endings with LF
                    .trimEnd { it == '\n' } // Remove trailing new lines
                    .split('\n')

                try {
                    for (directive in lines) {
                        val match = LOCALS_DIRECTIVE.matchEntire(directive) ?: continue
                        val (smaliPath, methodSubstring, value) = match.destructured
                        val key = smaliPath.removeSuffix(".smali") to methodSubstring
                        val newValue = value.toInt()
                        localsBumps[key] = maxOf(localsBumps[key] ?: 0, newValue)
                        container.log("Recorded rl-locals bump: $smaliPath method≈\"$methodSubstring\" >= $newValue")
                    }

                    // Split into per-target sections — a single .patch may contain multiple
                    // `--- a/...` blocks targeting different classes.
                    val sections = splitMultiTargetPatch(lines)
                    if (sections.isEmpty()) {
                        throw Error("Patch $patchFile is missing a '--- a/...' header")
                    }
                    for (section in sections) {
                        val targetLine = section.first { it.startsWith("--- a/") }
                        val fullClassName = targetLine
                            .removePrefix("--- a/")
                            .removeSuffix(".smali")
                            .trim()
                        val patch = LoadedPatch(
                            fullClassName = fullClassName,
                            patch = UnifiedDiffUtils.parseUnifiedDiff(section),
                        )
                        patches.add(patch)
                        container.log("Loaded patch file $patchFile for class ${patch.fullClassName}")
                    }
                } catch (t: Throwable) {
                    throw Error("Failed to parse patch file $patchFile", t)
                }
            }
        }

        // Disassemble all the classes
        container.log("Disassembling target classes in APK")
        ZipReader(apk).use { zip ->
            for (file in zip.entryNames) {
                if (!file.endsWith(".dex")) continue
                container.log("Disassembling dex $file")

                val dexFile = try {
                    DexBackedDexFile(
                        /* opcodes = */ Opcodes.getDefault(),
                        /* buf = */ zip.openEntry(file)!!.read(),
                    )
                } catch (t: Throwable) {
                    throw Error("Failed to parse dex $file", t)
                }

                val result = try {
                    Baksmali.disassembleDexFile(
                        /* dexFile = */ dexFile,
                        /* outputDir = */ smaliDir,
                        /* jobs = */ coreCount - 1,
                        /* options = */
                        BaksmaliOptions().apply {
                            localsDirective = true
                            // Match apktool label naming
                            sequentialLabels = true
                        },
                        /* classes = */ patches.map { "L${it.fullClassName};" },
                    )
                } catch (t: Throwable) {
                    throw Error("Failed to disassemble dex $file", t)
                }

                assert(result) { "Failed to disassemble dex $file (unknown reason)" }
                container.log("Disassembled dex file for potential target classes")
            }
        }

        if (localsBumps.isNotEmpty()) {
            container.log("Applying ${localsBumps.size} rl-locals bump(s)")
            for ((key, minLocals) in localsBumps) {
                val (classPath, methodSubstring) = key
                val smaliFile = smaliDir.resolve("$classPath.smali")
                if (!smaliFile.exists()) {
                    throw FileNotFoundException("rl-locals target $classPath.smali not found")
                }
                val applied = bumpLocals(
                    lines = smaliFile.readLines(),
                    methodSubstring = methodSubstring,
                    minLocals = minLocals,
                ) ?: throw Error("rl-locals: no .locals line found in $classPath for method≈\"$methodSubstring\"")

                if (applied.changed) {
                    smaliFile.bufferedWriter().use { writer ->
                        applied.lines.forEach(writer::appendLine)
                    }
                    container.log("Bumped .locals in $classPath (method≈\"$methodSubstring\") ${applied.previous} -> $minLocals")
                } else {
                    container.log("Skipped .locals bump in $classPath (method≈\"$methodSubstring\"): already ${applied.previous} >= $minLocals")
                }
            }
        }

        // Apply all the patches to smali files
        container.log("Applying smali patches to disassembled files")
        for ((fullClassName, patch) in patches) {
            container.log("Applying patch to class $fullClassName")

            val smaliFile = smaliDir.resolve("$fullClassName.smali")
            if (!smaliFile.exists()) {
                throw FileNotFoundException("Target smali file $fullClassName.smali not found for patching!")
            }

            val source = smaliFile.readLines()
            val patched = try {
                DiffUtils.patch(source, patch)
            } catch (t: Throwable) {
                container.log("Strict apply failed for $fullClassName, retrying with fuzzy context match: ${t.message}")
                try {
                    applyPatchFuzzy(source, patch)
                } catch (fuzzy: Throwable) {
                    throw Error("Failed to smali patch $fullClassName", fuzzy)
                }
            }

            smaliFile.bufferedWriter().use { writer ->
                patched.forEach(writer::appendLine)
            }
        }

        // Assemble patched dex
        container.log("Reassembling patches smali classes into new dex")
        smaliDir.mkdir()

        // Capture stdout/stderr assembling smali
        val originalStdout = System.out
        val originalStderr = System.err
        val captured = ByteArrayOutputStream()
        System.setOut(PrintStream(captured))
        System.setErr(PrintStream(captured))
        val success = Smali.assemble(
            SmaliOptions().apply {
                this.jobs = coreCount - 1
                this.outputDexFile = outDex.absolutePath
            },
            listOf(smaliDir.absolutePath),
        )
        System.setOut(originalStdout)
        System.setErr(originalStderr)

        if (!success) {
            container.log(captured.toString("UTF-8").trim())
            throw Exception("Failed to assemble patched smali!")
        }
    }

    override val dexPriority = 2
    override val dexCount = 1
    override fun getDexFiles(container: StepRunner) = listOf(outDex.readBytes())

    private fun bumpLocals(
        lines: List<String>,
        methodSubstring: String,
        minLocals: Int,
    ): BumpResult? {
        val result = lines.toMutableList()
        var inTargetMethod = false
        for (i in result.indices) {
            val raw = result[i]
            val trimmed = raw.trimStart()

            if (trimmed.startsWith(".method ")) {
                inTargetMethod = methodSubstring in trimmed
                continue
            }

            if (!inTargetMethod) continue

            if (trimmed.startsWith(".locals ")) {
                val current = trimmed.removePrefix(".locals ").substringBefore(' ').toInt()
                if (current >= minLocals) return BumpResult(lines, current, changed = false)
                val indent = raw.substring(0, raw.length - trimmed.length)
                result[i] = "$indent.locals $minLocals    # rl-locals bump (was $current)"
                return BumpResult(result, current, changed = true)
            }

            if (trimmed.startsWith(".end method")) return null
        }
        return null
    }

    private data class BumpResult(val lines: List<String>, val previous: Int, val changed: Boolean)

    private fun applyPatchFuzzy(target: List<String>, patch: Patch<String>): List<String> {
        val result = target.toMutableList()
        val deltas = patch.deltas.sortedByDescending { it.source.position }

        for (delta in deltas) {
            val sourceLines = delta.source.lines
            val matchPos = findContextMatch(result, sourceLines, delta.source.position)
                ?: throw Exception(
                    "Fuzzy match failed: could not locate context for hunk near line " +
                            "${delta.source.position + 1} (${sourceLines.size} lines)"
                )

            repeat(sourceLines.size) { result.removeAt(matchPos) }
            result.addAll(matchPos, delta.target.lines)
        }

        return result
    }

    private fun findContextMatch(target: List<String>, sourceLines: List<String>, hint: Int): Int? {
        if (sourceLines.isEmpty()) return hint.coerceIn(0, target.size)

        // Try at the exact hint first.
        if (matchesAt(target, sourceLines, hint)) return hint

        // Walk outward from the hint, alternating below/above, until finds a unique match.
        val maxRadius = target.size
        for (offset in 1..maxRadius) {
            val below = hint + offset
            if (below + sourceLines.size <= target.size && matchesAt(target, sourceLines, below)) {
                return below
            }
            val above = hint - offset
            if (above >= 0 && matchesAt(target, sourceLines, above)) {
                return above
            }
        }
        return null
    }

    private fun matchesAt(target: List<String>, sourceLines: List<String>, pos: Int): Boolean {
        if (pos < 0 || pos + sourceLines.size > target.size) return false
        for ((i, line) in sourceLines.withIndex()) {
            if (target[pos + i] != line) return false
        }
        return true
    }

    private companion object {
        val LOCALS_DIRECTIVE = Regex("""^#\s*rl-locals:\s+(\S+)\s+(\S+)\s+(\d+)\s*$""")
    }

    /**
     * Splits a unified diff into per-target sections. A single `.patch` file may bundle
     * multiple file diffs (each starting with `--- a/...`); each section becomes its own
     * patch with its own target class. The header lines before the first `--- a/` (and
     * any `# rl-locals:` directives) are preserved by being copied into every section so
     * that `UnifiedDiffUtils.parseUnifiedDiff` can still parse the section in isolation.
     */
    private fun splitMultiTargetPatch(lines: List<String>): List<List<String>> {
        val headerEnd = lines.indexOfFirst { it.startsWith("--- a/") }
        if (headerEnd < 0) return emptyList()
        val header = lines.subList(0, headerEnd)

        val sectionStarts = lines.withIndex()
            .filter { (_, line) -> line.startsWith("--- a/") }
            .map { it.index }

        return sectionStarts.mapIndexed { i, start ->
            val end = sectionStarts.getOrNull(i + 1) ?: lines.size
            header + lines.subList(start, end)
        }
    }
}

private data class LoadedPatch(
    val fullClassName: String,
    val patch: Patch<String>,
)
