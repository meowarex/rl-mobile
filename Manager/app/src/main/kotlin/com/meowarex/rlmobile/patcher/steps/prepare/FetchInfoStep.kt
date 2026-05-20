package com.meowarex.rlmobile.patcher.steps.prepare

import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.network.models.RLBuildInfo
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
import com.meowarex.rlmobile.network.utils.getOrThrow
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

@Stable
class FetchInfoStep : Step(), KoinComponent {
    private val github: RadiantLyricsGithubService by inject()

    override val group = StepGroup.Prepare
    override val localizedName = R.string.patch_step_fetch_info

    lateinit var data: RLBuildInfo
        private set

    lateinit var patchesAssetUrl: String
        private set

    override suspend fun execute(container: StepRunner) {
        container.log("Fetching latest release from ${RadiantLyricsGithubService.REPO_OWNER}/${RadiantLyricsGithubService.REPO_NAME}")
        val release = github.getLatestRelease(force = true).getOrThrow()

        val dataJsonUrl = release.assets
            .find { it.name == RadiantLyricsGithubService.DATA_JSON_ASSET_NAME }
            ?.browserDownloadUrl
            ?: throw IllegalStateException("No ${RadiantLyricsGithubService.DATA_JSON_ASSET_NAME} asset found in latest release ${release.tagName}")

        patchesAssetUrl = release.assets
            .find { it.name == RadiantLyricsGithubService.PATCHES_ASSET_NAME }
            ?.browserDownloadUrl
            ?: throw IllegalStateException("No ${RadiantLyricsGithubService.PATCHES_ASSET_NAME} asset found in latest release ${release.tagName}")

        container.log("Fetching build info from $dataJsonUrl")
        data = github.getBuildInfo(dataJsonUrl, force = true).getOrThrow()
        container.log("Fetched build info: $data")
        container.log("Patches asset URL: $patchesAssetUrl")
    }
}
