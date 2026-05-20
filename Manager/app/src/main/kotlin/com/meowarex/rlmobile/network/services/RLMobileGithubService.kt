package com.meowarex.rlmobile.network.services

import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.network.models.GithubRelease
import com.meowarex.rlmobile.network.models.RLBuildInfo
import com.meowarex.rlmobile.network.utils.ApiResponse
import io.ktor.client.request.header
import io.ktor.client.request.url
import io.ktor.http.HttpHeaders

class RadiantLyricsGithubService(
    private val http: HttpService,
) {
    /**
     * Fetches the latest release from meowarex/rl-mobile to determine current patch + TIDAL versions.
     */
    suspend fun getLatestRelease(force: Boolean = false): ApiResponse<GithubRelease> =
        http.request {
            url("https://api.github.com/repos/${BuildConfig.PATCHES_REPO_OWNER}/${BuildConfig.PATCHES_REPO_NAME}/releases/latest")
            if (force) {
                header(HttpHeaders.CacheControl, "no-cache")
            } else {
                header(HttpHeaders.CacheControl, "public, max-age=60, s-maxage=60")
            }
        }

    /**
     * Fetches build metadata from the data.json asset in the latest GitHub release.
     * The data.json asset URL is obtained from [getLatestRelease].
     */
    suspend fun getBuildInfo(dataJsonUrl: String, force: Boolean = false): ApiResponse<RLBuildInfo> =
        http.request {
            url(dataJsonUrl)
            if (force) {
                header(HttpHeaders.CacheControl, "no-cache")
            }
        }

    /**
     * Fetches manager self-update releases.
     */
    suspend fun getManagerReleases(): ApiResponse<List<GithubRelease>> =
        http.request {
            url("https://api.github.com/repos/${BuildConfig.PATCHES_REPO_OWNER}/${BuildConfig.PATCHES_REPO_NAME}/releases")
            header(HttpHeaders.CacheControl, "public, max-age=60, s-maxage=60")
        }

    /**
     * Fetches the contributors list from GitHub for the repo.
     */
    suspend fun getContributors(): ApiResponse<List<com.meowarex.rlmobile.network.models.GithubContributor>> =
        http.request {
            url("https://api.github.com/repos/${BuildConfig.PATCHES_REPO_OWNER}/${BuildConfig.PATCHES_REPO_NAME}/contributors?per_page=100")
            header(HttpHeaders.CacheControl, "public, max-age=600, s-maxage=600")
        }

    /**
     * Fetches the latest commit on the default branch.
     */
    suspend fun getLatestCommit(): ApiResponse<com.meowarex.rlmobile.network.models.GithubCommit> =
        http.request {
            url("https://api.github.com/repos/${BuildConfig.PATCHES_REPO_OWNER}/${BuildConfig.PATCHES_REPO_NAME}/commits/HEAD")
            header(HttpHeaders.CacheControl, "public, max-age=120, s-maxage=120")
        }

    /**
     * Fetches a page of commits (paginated). Used by the Home screen's commit list.
     */
    suspend fun getCommits(page: Int, perPage: Int = 30): ApiResponse<List<com.meowarex.rlmobile.network.models.GithubCommit>> =
        http.request {
            url("https://api.github.com/repos/${BuildConfig.PATCHES_REPO_OWNER}/${BuildConfig.PATCHES_REPO_NAME}/commits?per_page=$perPage&page=${page + 1}")
            header(HttpHeaders.CacheControl, "public, max-age=120, s-maxage=120")
        }

    companion object {
        const val REPO_OWNER = BuildConfig.PATCHES_REPO_OWNER
        const val REPO_NAME  = BuildConfig.PATCHES_REPO_NAME
        const val PATCHES_ASSET_NAME = "patches.zip"
        const val DATA_JSON_ASSET_NAME = "data.json"
    }
}
