package com.meowarex.rlmobile.network.models

import androidx.compose.runtime.Immutable

// One APKPure build, versions can have a few
@Immutable
data class ApkPureVersion(
    val versionName: String,
    val versionCode: Int,
    val isXapk: Boolean,
    val size: Long,
    val sha1: String?,
    val url: String,
)
