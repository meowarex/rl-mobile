package com.meowarex.rlmobile.patcher.steps.download

import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.base.DownloadStep
import com.meowarex.rlmobile.patcher.steps.base.StepState
import com.meowarex.rlmobile.patcher.steps.prepare.FetchInfoStep
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import java.io.FileNotFoundException

@Stable
class DownloadTidalStep(
    private val custom: PatchComponent?,
) : DownloadStep<Int>(), KoinComponent {
    private val paths: PathManager by inject()

    override val localizedName = R.string.patch_step_dl_tidal_apk

    override fun getVersion(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalVersionCode

    override fun getRemoteUrl(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalApkUrl

    override fun getStoredFile(container: StepRunner) =
        custom?.getFile(paths) ?: paths.cachedTidalApk(getVersion(container))

    override suspend fun execute(container: StepRunner) {
        if (custom != null) {
            container.log("Using custom TIDAL APK with version ${custom.version} imported ${custom.timestamp}")

            if (!custom.getFile(paths).exists()) {
                throw FileNotFoundException(
                    "Selected custom TIDAL APK does not exist on disk! If this is an update, " +
                        "updates cannot occur when the originally selected custom component has been deleted."
                )
            }

            state = StepState.Skipped
            return
        }

        super.execute(container)
    }
}
