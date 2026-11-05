package com.meowarex.rlmobile.network.models

import androidx.compose.runtime.Immutable
import kotlinx.serialization.Serializable

// GitCafe commit list page
@Serializable
data class GitCafeCommitPage(
    val items: List<GitCafeCommit>,
    val next: String? = null,
)

@Serializable
data class GitCafeCommit(
    val oid: String,
    val parentCount: Int = 1,
    val message: String,
    val summary: String,
    val author: Author,
) {
    @Serializable
    data class Author(
        val name: String,
        val email: String,
        // Unix seconds
        val timestamp: Long,
    )
}

// One row in the Home commit list
@Immutable
data class RLCommit(
    val sha: String,
    val url: String,
    val title: String,
    val authorName: String,
    val avatarUrl: String?,
    val timestamp: Long,
)
