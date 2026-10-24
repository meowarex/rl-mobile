package com.meowarex.rlmobile.network.utils

import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.meowarex.rlmobile.network.models.GithubCommit
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService

class CommitsPagingSource(
    private val github: RadiantLyricsGithubService,
    /** Bypasses the http response cache */
    private val force: Boolean = false,
) : PagingSource<Int, GithubCommit>() {
    private val seenShas = mutableSetOf<String>()
    private val seenTitles = mutableSetOf<String>()

    override fun getRefreshKey(state: PagingState<Int, GithubCommit>): Int? =
        state.anchorPosition?.let {
            val page = state.closestPageToPosition(it) ?: return null
            page.prevKey?.plus(1) ?: page.nextKey?.minus(1)
        }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, GithubCommit> {
        val page = params.key ?: 0
        // Only the first page skips the cache
        return when (val r = github.getCommits(page, force = force && page == 0)) {
            is ApiResponse.Success -> LoadResult.Page(
                data = r.data.listed(seenShas, seenTitles),
                prevKey = if (page > 0) page - 1 else null,
                nextKey = if (r.data.isNotEmpty()) page + 1 else null,
            )
            is ApiResponse.Failure -> LoadResult.Error(r.error)
            is ApiResponse.Error -> LoadResult.Error(r.error)
        }
    }
}

/** First line of the commit message */
val GithubCommit.title: String
    get() = commit.message.lineSequence().first().trim()

/** Commit list filter, no merges or repeats */
fun List<GithubCommit>.listed(
    seenShas: MutableSet<String> = mutableSetOf(),
    seenTitles: MutableSet<String> = mutableSetOf(),
): List<GithubCommit> = filter { commit ->
    when {
        commit.title.startsWith("Merge ") -> false
        !seenShas.add(commit.sha) -> false
        !seenTitles.add(commit.title) -> false
        else -> true
    }
}
