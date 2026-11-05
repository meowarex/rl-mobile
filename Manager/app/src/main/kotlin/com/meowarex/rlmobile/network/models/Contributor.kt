package com.meowarex.rlmobile.network.models

import androidx.compose.runtime.Immutable
import com.meowarex.rlmobile.util.serialization.ImmutableListSerializer
import kotlinx.collections.immutable.ImmutableList
import kotlinx.collections.immutable.persistentListOf
import kotlinx.serialization.Serializable

// contributors.json on the release site
@Immutable
@Serializable
data class Contributor(
    val username: String,
    val avatarUrl: String? = null,
    // Profile page, null if not on GitCafe
    val url: String? = null,
    val commits: Int,
    // Commit author names for this person
    @Serializable(with = ImmutableListSerializer::class)
    val aliases: ImmutableList<String> = persistentListOf(),
    @Serializable(with = ImmutableListSerializer::class)
    val repositories: ImmutableList<Repository> = persistentListOf(),
) {
    @Immutable
    @Serializable
    data class Repository(
        val name: String,
        val commits: Int,
    )
}
