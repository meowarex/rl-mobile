package com.meowarex.rlmobile.network.services

import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.network.models.Contributor
import com.meowarex.rlmobile.network.models.RLBuildInfo
import com.meowarex.rlmobile.network.models.RLRelease
import com.meowarex.rlmobile.network.models.RLReleases
import com.meowarex.rlmobile.network.utils.ApiResponse
import com.meowarex.rlmobile.network.utils.chain
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.client.request.header
import io.ktor.client.request.url
import io.ktor.http.HttpHeaders

// Releases from the new site <3
class RLReleasesService(
    private val http: HttpService,
) {
    suspend fun getReleases(force: Boolean = false): ApiResponse<RLReleases> =
        http.request {
            url("${BuildConfig.RELEASES_URL}/versions.json")
            cache(force)
        }

    suspend fun getBuildInfo(release: RLRelease, force: Boolean = false): ApiResponse<RLBuildInfo> =
        http.request {
            url(release.url(DATA_JSON))
            cache(force)
        }

    // Built by CI from full git history
    suspend fun getContributors(force: Boolean = false): ApiResponse<List<Contributor>> =
        getReleases(force).chain { all ->
            val release = all.latestWith(CONTRIBUTORS_JSON)
                ?: return@chain ApiResponse.Success(emptyList())
            http.request {
                url(release.url(CONTRIBUTORS_JSON))
                cache(force)
            }
        }

    private fun HttpRequestBuilder.cache(force: Boolean) {
        header(HttpHeaders.CacheControl, if (force) "no-cache" else "public, max-age=60, s-maxage=60")
    }

    companion object {
        const val SITE_URL = BuildConfig.RELEASES_URL
        const val DATA_JSON = "data.json"
        const val PATCHES_ZIP = "patches.zip"
        const val MANAGER_APK = "manager.apk"
        const val CONTRIBUTORS_JSON = "contributors.json"
    }
}
