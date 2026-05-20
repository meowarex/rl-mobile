package com.meowarex.rlmobile.network.models

import com.meowarex.rlmobile.network.utils.SemVer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RLBuildInfo(
    @SerialName("tidalVersionCode")
    val tidalVersionCode: Int,
    @SerialName("tidalApkUrl")
    val tidalApkUrl: String,
    @SerialName("patchesVersion")
    val patchesVersion: SemVer,
)
