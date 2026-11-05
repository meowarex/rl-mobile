package com.meowarex.rlmobile.patcher.steps.download

import android.app.Application
import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.manager.TidalApkSource
import com.meowarex.rlmobile.network.services.ApkPureService
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.base.DownloadStep
import com.meowarex.rlmobile.patcher.steps.base.StepState
import com.meowarex.rlmobile.patcher.steps.prepare.FetchInfoStep
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import java.io.FileNotFoundException
import kotlin.coroutines.cancellation.CancellationException

@Stable
class DownloadTidalStep(
    private val custom: PatchComponent?,
) : DownloadStep<Int>(), KoinComponent {
    private val paths: PathManager by inject()
    private val source: TidalApkSource by inject()
    private val application: Application by inject()

    override val localizedName = R.string.patch_step_dl_tidal_apk

    override fun getVersion(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalVersionCode

    // Release-hosted APK, only if APKPure fails
    override fun getRemoteUrl(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalApkUrl
            ?: throw IllegalStateException("APKPure failed and this release has no fallback TIDAL APK")

    override fun getStoredFile(container: StepRunner) =
        custom?.getFile(paths) ?: paths.cachedTidalApk(getVersion(container))

    override suspend fun verify(container: StepRunner) {
        super.verify(container)
        if (custom != null) return

        val file = getStoredFile(container)
        @Suppress("DEPRECATION")
        val info = application.packageManager.getPackageArchiveInfo(file.absolutePath, 0)
            ?: throw Error("Downloaded TIDAL APK could not be parsed")
        @Suppress("DEPRECATION")
        if (info.packageName != ApkPureService.TIDAL_PACKAGE || info.versionCode != getVersion(container))
            throw Error("Downloaded APK is ${info.packageName} ${info.versionCode}, expected TIDAL ${getVersion(container)}")
    }

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

        val file = getStoredFile(container)
        if (file.exists()) {
            try {
                verify(container)
                container.log("Cached TIDAL APK verified, skipping download")
                state = StepState.Skipped
                return
            } catch (t: Throwable) {
                container.log("Cached TIDAL APK failed verification: $t")
                file.delete()
            }
        }

        try {
            source.download(
                versionCode = getVersion(container),
                out = file,
                log = container::log,
                onProgress = { progress = it ?: -1f },
            )
            verify(container)
            return
        } catch (e: CancellationException) {
            file.delete()
            throw e
        } catch (t: Throwable) {
            file.delete()
            container.log("APKPure download failed: ${t.stackTraceToString()}")
            if (container.getStep<FetchInfoStep>().data.tidalApkUrl == null) throw t
            container.log("Falling back to the release's TIDAL APK")
        }

        super.execute(container)
    }
}
