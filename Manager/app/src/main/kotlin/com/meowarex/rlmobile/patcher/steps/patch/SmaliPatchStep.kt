package com.meowarex.rlmobile.patcher.steps.patch

import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.IDexProvider
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.patcher.steps.download.CopyDependenciesStep
import com.meowarex.rlmobile.patcher.steps.download.DownloadPatchesStep
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

class SmaliPatchStep : Step(), IDexProvider, KoinComponent {
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

        // Load and parse all the patches from the smali patch archive.
        // Extension classes (extension/**/*.smali) are extracted into smaliDir
        // so they get assembled into the new dex alongside patched classes.
        container.log("Loading patches from smali patch archive: ${patchesZip.absolutePath}")
        smaliDir.mkdirs()
        ZipReader(patchesZip).use { zip ->
            // Iterate in filename order so patches apply deterministically, matching
            // the apply-order contract in patches/README. Zip iteration order would
            // otherwise depend on archive layout and could break ordered patches that
            // share a target file.
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

                val lines = zip.openEntry(patchFile)!!.read()
                    .decodeToString()
                    .replace("\r\n", "\n") // Replace CRLF endings with LF endings to be sure here
                    .trimEnd { it == '\n' } // Remove trailing new lines to work with diff output properly
                    .split('\n')

                try {
                    val targetLine = lines.firstOrNull { it.startsWith("--- a/") }
                        ?: throw Error("Patch $patchFile is missing a '--- a/...' header")
                    val fullClassName = targetLine
                        .removePrefix("--- a/")
                        .removeSuffix(".smali")
                        .trim()
                    val patch = LoadedPatch(
                        fullClassName = fullClassName,
                        patch = UnifiedDiffUtils.parseUnifiedDiff(lines),
                    )
                    patches.add(patch)
                    container.log("Loaded patch file $patchFile for class ${patch.fullClassName}")
                } catch (t: Throwable) {
                    throw Error("Failed to parse patch file $patchFile", t)
                }
            }
        }

        // Disassemble all the classes we have patches for from all the dex files
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
                        /* options = */ BaksmaliOptions().apply {
                            localsDirective = true
                            // Match apktool's label naming (:cond_0, :cond_1, ...) so patches
                            // authored from `apktool d` decompilation apply cleanly. Default
                            // would emit offset-based labels like :cond_8de.
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

        // Apply all the patches to the smali files
        container.log("Applying smali patches to disassembled files")
        for ((fullClassName, patch) in patches) {
            container.log("Applying patch to class $fullClassName")

            val smaliFile = smaliDir.resolve("$fullClassName.smali")
            if (!smaliFile.exists()) {
                throw FileNotFoundException("Target smali file $fullClassName.smali not found for patching!")
            }

            val patched = try {
                DiffUtils.patch(smaliFile.readLines(), patch)
            } catch (t: Throwable) {
                throw Error("Failed to smali patch $fullClassName", t)
            }

            smaliFile.bufferedWriter().use { writer ->
                patched.forEach(writer::appendLine)
            }
        }

        // Assemble the patched classes back into a single dex
        container.log("Reassembling patches smali classes into new dex")
        smaliDir.mkdir()

        // Capture stdout/stderr while assembling smali
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
}

private data class LoadedPatch(
    val fullClassName: String,
    val patch: Patch<String>,
)
