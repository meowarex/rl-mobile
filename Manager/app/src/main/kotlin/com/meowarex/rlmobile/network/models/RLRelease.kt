package com.meowarex.rlmobile.network.models

import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.network.utils.SemVer
import kotlinx.serialization.Serializable

// versions.json from the release site
@Serializable
data class RLReleases(
    val latest: String,
    val versions: List<RLRelease>,
) {
    // Newest release that ships this file
    fun latestWith(file: String): RLRelease? =
        versions.filter { file in it.files && it.semVer != null }.maxByOrNull { it.semVer!! }

    fun find(version: String): RLRelease? =
        versions.firstOrNull { it.version == version.removePrefix("v") }
}

@Serializable
data class RLRelease(
    val version: String,
    // Like /2-2-0/
    val path: String,
    val files: List<String>,
    val date: String? = null,
) {
    val semVer: SemVer?
        get() = SemVer.parseOrNull(version)

    fun has(file: String) = file in files

    fun url(file: String) = BuildConfig.RELEASES_URL + path + file
}
