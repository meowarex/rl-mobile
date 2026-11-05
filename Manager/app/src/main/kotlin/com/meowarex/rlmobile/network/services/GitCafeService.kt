package com.meowarex.rlmobile.network.services

import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.network.models.GitCafeCommitPage
import com.meowarex.rlmobile.network.utils.ApiResponse
import com.meowarex.rlmobile.network.utils.listed
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.client.request.url
import io.ktor.http.HttpHeaders

// Commit history from GitCafe <3
class GitCafeService(
    private val http: HttpService,
) {
    // First-parent only, PR merges carry titles
    suspend fun getCommits(
        after: String? = null,
        limit: Int = 30,
        force: Boolean = false,
    ): ApiResponse<GitCafeCommitPage> =
        http.request {
            url("$API_URL/repos/$REPO/commits")
            parameter("ref", BRANCH)
            parameter("limit", limit)
            if (after != null) parameter("after", after)
            header(HttpHeaders.CacheControl, if (force) "no-cache" else "public, max-age=120, s-maxage=120")
        }

    /** Latest commit titles for the update notification */
    suspend fun getLatestCommitTitles(count: Int = 3): List<String> = try {
        when (val response = getCommits()) {
            is ApiResponse.Success -> response.data.items.listed().take(count).map { it.second }
            else -> emptyList()
        }
    } catch (t: Throwable) {
        emptyList()
    }

    companion object {
        const val SITE_URL = "https://git.cafe"
        const val API_URL = "$SITE_URL/api"
        const val REPO = "${BuildConfig.PATCHES_REPO_OWNER}/${BuildConfig.PATCHES_REPO_NAME}"
        const val REPO_URL = "$SITE_URL/$REPO"

        // dev has every commit, main is merges
        const val BRANCH = "refs/heads/dev"

        fun commitUrl(oid: String) = "$REPO_URL/commit/$oid"
    }
}
