package com.meowarex.rlmobile.network.models

import com.meowarex.rlmobile.network.utils.SemVer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RLBuildInfo(
    @SerialName("tidalVersionCode")
    val tidalVersionCode: Int,
    // Optional, TIDAL comes from APKPure now
    @SerialName("tidalApkUrl")
    val tidalApkUrl: String? = null,
    @SerialName("patchesVersion")
    val patchesVersion: SemVer,
)
