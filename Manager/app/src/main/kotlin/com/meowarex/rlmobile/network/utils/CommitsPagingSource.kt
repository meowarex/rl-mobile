package com.meowarex.rlmobile.network.utils

import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.meowarex.rlmobile.network.models.GithubCommit
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService

class CommitsPagingSource(
    private val github: RadiantLyricsGithubService,
) : PagingSource<Int, GithubCommit>() {

    override fun getRefreshKey(state: PagingState<Int, GithubCommit>): Int? =
        state.anchorPosition?.let {
            val page = state.closestPageToPosition(it) ?: return null
            page.prevKey?.plus(1) ?: page.nextKey?.minus(1)
        }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, GithubCommit> {
        val page = params.key ?: 0
        return when (val r = github.getCommits(page)) {
            is ApiResponse.Success -> LoadResult.Page(
                data = r.data,
                prevKey = if (page > 0) page - 1 else null,
                nextKey = if (r.data.isNotEmpty()) page + 1 else null,
            )
            is ApiResponse.Failure -> LoadResult.Error(r.error)
            is ApiResponse.Error -> LoadResult.Error(r.error)
        }
    }
}
