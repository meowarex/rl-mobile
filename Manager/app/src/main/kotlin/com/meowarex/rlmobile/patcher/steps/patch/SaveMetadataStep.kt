package com.meowarex.rlmobile.patcher.steps.patch

import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.network.utils.SemVer
import com.meowarex.rlmobile.patcher.InstallMetadata
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.patcher.steps.download.CopyDependenciesStep
import com.meowarex.rlmobile.patcher.steps.download.DownloadPatchesStep
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.github.diamondminer88.zip.ZipWriter
import kotlinx.serialization.json.Json
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class SaveMetadataStep(private val options: PatchOptions) : Step(), KoinComponent {
    private val json: Json by inject()

    override val group = StepGroup.Patch
    override val localizedName = R.string.patch_step_save_metadata

    override suspend fun execute(container: StepRunner) {
        val apk = container.getStep<CopyDependenciesStep>().apk
        val patches = container.getStep<DownloadPatchesStep>()

        val metadata = InstallMetadata(
            customManager = !BuildConfig.RELEASE,
            managerVersion = SemVer.parse(BuildConfig.VERSION_NAME),
            patchesVersion = patches.getVersion(container),
            options = options,
        )

        container.log("Writing serialized install metadata to APK")
        ZipWriter(apk, /* append = */ true).use {
            it.writeEntry("rlmobile.json", json.encodeToString<InstallMetadata>(metadata))
        }
    }
}
