package com.meowarex.rlmobile.patcher.steps.patch

import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.patcher.steps.download.CopyDependenciesStep
import com.meowarex.rlmobile.patcher.util.ManifestPatcher
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.github.diamondminer88.zip.ZipReader
import com.github.diamondminer88.zip.ZipWriter

/**
 * Patch the APK's AndroidManifest.xml
 */
class PatchManifestStep(private val options: PatchOptions) : Step() {
    override val group = StepGroup.Patch
    override val localizedName = R.string.patch_step_patch_manifests

    override suspend fun execute(container: StepRunner) {
        val apk = container.getStep<CopyDependenciesStep>().apk

        container.log("Reading manifest from apk")
        val manifest = ZipReader(apk)
            .use { zip -> zip.openEntry("AndroidManifest.xml")?.read() }
            ?: throw IllegalArgumentException("No manifest found in APK")

        container.log("Patching manifest")
        val patchedManifest = ManifestPatcher.patchManifest(
            manifestBytes = manifest,
            packageName = options.packageName,
            appName = options.appName,
            debuggable = options.debuggable,
        )

        container.log("Repacking apk with patched manifest")
        val repacked = apk.resolveSibling(apk.name + ".repack")
        repacked.delete()

        ZipReader(apk).use { reader ->
            ZipWriter(repacked, /* append = */ false).use { writer ->
                for (name in reader.entryNames) {
                    val bytes = if (name == "AndroidManifest.xml") {
                        patchedManifest
                    } else {
                        reader.openEntry(name)!!.read()
                    }
                    writer.writeEntry(name, bytes)
                }
            }
        }

        if (!apk.delete() || !repacked.renameTo(apk))
            throw Error("Failed to replace apk with repacked manifest variant")
    }
}
