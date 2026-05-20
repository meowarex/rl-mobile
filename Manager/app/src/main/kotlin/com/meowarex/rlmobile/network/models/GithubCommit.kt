package com.meowarex.rlmobile.network.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GithubCommit(
    val sha: String,
    @SerialName("html_url")
    val htmlUrl: String,
    val commit: CommitDetails,
    val author: Author? = null,
) {
    @Serializable
    data class CommitDetails(
        val message: String,
        val author: AuthorMeta,
    )

    @Serializable
    data class AuthorMeta(
        val name: String,
        val email: String,
        val date: String,
    )

    @Serializable
    data class Author(
        val login: String,
        @SerialName("avatar_url")
        val avatarUrl: String,
        @SerialName("html_url")
        val htmlUrl: String,
    )
}
