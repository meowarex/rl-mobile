package com.meowarex.rlmobile.patcher.steps.download

import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.base.DownloadStep
import com.meowarex.rlmobile.patcher.steps.prepare.FetchInfoStep
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

@Stable
class DownloadTidalStep : DownloadStep<Int>(), KoinComponent {
    private val paths: PathManager by inject()

    override val localizedName = R.string.patch_step_dl_tidal_apk

    override fun getVersion(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalVersionCode

    override fun getRemoteUrl(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalApkUrl

    override fun getStoredFile(container: StepRunner) =
        paths.cachedTidalApk(getVersion(container))
}
