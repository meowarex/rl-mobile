package com.meowarex.rlmobile.network.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GithubContributor(
    val login: String,
    @SerialName("avatar_url")
    val avatarUrl: String,
    val contributions: Int,
    val type: String? = null,
)
