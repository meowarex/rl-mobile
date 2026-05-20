package com.meowarex.rlmobile.ui.screens.plugins.model

import androidx.compose.runtime.*

@Stable
data class PluginItem(
    val manifest: PluginManifest,
    val path: String,
) {
    // Plugins are enabled by default unless disabled in Radiant Lyrics settings
    var enabled by mutableStateOf(true)
}
