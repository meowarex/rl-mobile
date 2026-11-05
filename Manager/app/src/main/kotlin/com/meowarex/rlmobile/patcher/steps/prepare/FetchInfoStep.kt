package com.meowarex.rlmobile.patcher.steps.prepare

import android.app.Application
import android.util.Log
import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.CachedReleaseInfo
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.manager.ReleaseInfoCache
import com.meowarex.rlmobile.network.models.RLBuildInfo
import com.meowarex.rlmobile.network.models.RLRelease
import com.meowarex.rlmobile.network.services.RLReleasesService
import com.meowarex.rlmobile.network.utils.getOrThrow
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.util.isOnline
import kotlinx.serialization.json.Json
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import kotlin.coroutines.cancellation.CancellationException

@Stable
class FetchInfoStep(
    // Set while the Manager is outdated, no newer patches
    private val pinnedVersion: String? = null,
) : Step(), KoinComponent {
    private val releases: RLReleasesService by inject()
    private val context: Application by inject()
    private val paths: PathManager by inject()
    private val json: Json by inject()

    override val group = StepGroup.Prepare
    override val localizedName = R.string.patch_step_fetch_info

    lateinit var data: RLBuildInfo
        private set

    lateinit var patchesAssetUrl: String
        private set

    override suspend fun execute(container: StepRunner) {
        // Fetch the latest release and refresh the cache (when online)
        if (context.isOnline()) {
            try {
                if (pinnedVersion != null) fetchPinned(container, pinnedVersion) else fetchFromRemote(container)
                return
            } catch (e: CancellationException) {
                throw e
            } catch (t: Throwable) {
                container.log("Failed to fetch latest release: ${Log.getStackTraceString(t)}")
                container.log("Falling back to cached release info for a local re-patch")
            }
        } else {
            container.log("No network connection — using cached release info for a local re-patch")
        }

        val cached = ReleaseInfoCache.load(paths, json)
            ?: throw IllegalStateException(
                "Could not fetch the latest release and no cached release info is available. " +
                    "Connect to the internet and try again."
            )
        if (pinnedVersion != null && cached.data.patchesVersion.toString() != pinnedVersion) {
            throw IllegalStateException(
                "Patches v$pinnedVersion aren't cached for a local re-patch. " +
                    "Connect to the internet or update the Manager."
            )
        }
        data = cached.data
        patchesAssetUrl = cached.patchesAssetUrl
        container.log("Using cached build info: $data")
        container.log("Cached patches asset URL: $patchesAssetUrl")
    }

    private suspend fun fetchFromRemote(container: StepRunner) {
        container.log("Fetching latest release from ${RLReleasesService.SITE_URL}")
        val release = releases.getReleases(force = true).getOrThrow()
            .latestWith(RLReleasesService.PATCHES_ZIP)
            ?: throw IllegalStateException("No release with ${RLReleasesService.PATCHES_ZIP} found")
        useRelease(container, release)
    }

    private suspend fun fetchPinned(container: StepRunner, version: String) {
        container.log("Manager update pending, staying on patches v$version")
        val release = releases.getReleases(force = true).getOrThrow().find(version)
            ?: throw IllegalStateException("No release found for patches v$version, update the Manager to repatch")
        useRelease(container, release)
    }

    private suspend fun useRelease(container: StepRunner, release: RLRelease) {
        for (file in listOf(RLReleasesService.DATA_JSON, RLReleasesService.PATCHES_ZIP)) {
            if (!release.has(file)) throw IllegalStateException("No $file in release ${release.version}")
        }
        val patchesUrl = release.url(RLReleasesService.PATCHES_ZIP)

        container.log("Fetching build info from ${release.url(RLReleasesService.DATA_JSON)}")
        val buildInfo = releases.getBuildInfo(release, force = true).getOrThrow()

        data = buildInfo
        patchesAssetUrl = patchesUrl
        container.log("Fetched build info: $data")
        container.log("Patches asset URL: $patchesAssetUrl")

        ReleaseInfoCache.save(paths, json, CachedReleaseInfo(buildInfo, patchesUrl))
    }
}
