package com.meowarex.rlmobile.network.utils

import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.meowarex.rlmobile.network.models.Contributor
import com.meowarex.rlmobile.network.models.GitCafeCommit
import com.meowarex.rlmobile.network.models.RLCommit
import com.meowarex.rlmobile.network.services.GitCafeService
import com.meowarex.rlmobile.network.services.RLReleasesService

class CommitsPagingSource(
    private val gitcafe: GitCafeService,
    private val releases: RLReleasesService,
    /** Bypasses the http response cache */
    private val force: Boolean = false,
) : PagingSource<String, RLCommit>() {
    private val seenShas = mutableSetOf<String>()
    private val seenTitles = mutableSetOf<String>()

    // Lowercase alias -> contributor
    private var people: Map<String, Contributor>? = null

    // Cursors only go forward
    override fun getRefreshKey(state: PagingState<String, RLCommit>): String? = null

    override suspend fun load(params: LoadParams<String>): LoadResult<String, RLCommit> {
        val after = params.key
        val people = people ?: loadPeople().also { people = it }

        // Only the first page skips the cache
        return when (val r = gitcafe.getCommits(after, force = force && after == null)) {
            is ApiResponse.Success -> LoadResult.Page(
                data = r.data.items.listed(seenShas, seenTitles).map { (commit, title) ->
                    val person = people[commit.author.name.lowercase()]
                    RLCommit(
                        sha = commit.oid,
                        url = GitCafeService.commitUrl(commit.oid),
                        title = title,
                        authorName = person?.username ?: commit.author.name,
                        avatarUrl = person?.avatarUrl,
                        timestamp = commit.author.timestamp,
                    )
                },
                prevKey = null,
                nextKey = r.data.next,
            )
            is ApiResponse.Failure -> LoadResult.Error(r.error)
            is ApiResponse.Error -> LoadResult.Error(r.error)
        }
    }

    // No contributors.json, no avatars
    private suspend fun loadPeople(): Map<String, Contributor> =
        releases.getContributors().getOrNull().orEmpty()
            .flatMap { c -> (c.aliases + c.username).map { it.lowercase() to c } }
            .toMap()
}

private val TRAILER = Regex("""^[\w-]+-By:|^Signed-off-by:""", RegexOption.IGNORE_CASE)
private val PR_MERGE = Regex("""^Merge pull request #\d+ from """)

/** Row title, PR merges use the PR's */
val GitCafeCommit.title: String?
    get() {
        if (parentCount <= 1) return summary.trim()
        if (!PR_MERGE.containsMatchIn(summary)) return null
        return message.lineSequence()
            .drop(1)
            .map { it.trim() }
            .firstOrNull { it.isNotEmpty() && !TRAILER.containsMatchIn(it) }
    }

/** No plain merges or repeats */
fun List<GitCafeCommit>.listed(
    seenShas: MutableSet<String> = mutableSetOf(),
    seenTitles: MutableSet<String> = mutableSetOf(),
): List<Pair<GitCafeCommit, String>> = mapNotNull { commit ->
    val title = commit.title ?: return@mapNotNull null
    when {
        title.startsWith("Merge ") -> null
        !seenShas.add(commit.oid) -> null
        !seenTitles.add(title) -> null
        else -> commit to title
    }
}
