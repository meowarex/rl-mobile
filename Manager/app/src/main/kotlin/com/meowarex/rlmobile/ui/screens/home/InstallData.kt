package com.meowarex.rlmobile.ui.screens.home

import androidx.compose.runtime.Immutable
import androidx.compose.ui.graphics.painter.BitmapPainter
import com.meowarex.rlmobile.ui.util.TidalVersion

@Immutable
data class InstallData(
    val name: String,
    val packageName: String,
    val version: TidalVersion,
    val icon: BitmapPainter,
    val isUpToDate: Boolean?,
)
