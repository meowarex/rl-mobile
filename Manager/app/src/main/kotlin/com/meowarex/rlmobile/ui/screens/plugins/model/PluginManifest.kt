package com.meowarex.rlmobile.ui.screens.plugins.model

import androidx.compose.runtime.Immutable
import com.meowarex.rlmobile.util.serialization.ImmutableListSerializer
import kotlinx.collections.immutable.ImmutableList
import kotlinx.serialization.Serializable

@Immutable
@Serializable
data class PluginManifest(
    val name: String,
    @Serializable(with = ImmutableListSerializer::class)
    val authors: ImmutableList<Author>,
    val description: String,
    val version: String,
    val updateUrl: String?,
    val changelog: String?,
    val changelogMedia: String?,
) {
    val repositoryUrl: String?
        get() = updateUrl?.replaceFirst(
            "https://(raw\\.githubusercontent\\.com|cdn\\.jsdelivr\\.net/gh)/([^/]+)/([^/@]+).*".toRegex(),
            "https://github.com/$2/$3"
        )

    @Immutable
    @Serializable
    data class Author(
        val name: String,
        val id: Long,
        val hyperlink: Boolean = true,
    ) {
        val socialUrl: String
            get() = "https://tidal.com/users/$id"
    }
}
