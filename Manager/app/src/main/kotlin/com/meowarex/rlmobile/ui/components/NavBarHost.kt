package com.meowarex.rlmobile.ui.components

import androidx.compose.runtime.compositionLocalOf
import cafe.adriel.voyager.core.screen.Screen
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

// Shared bits for the floating nav
object NavBarHost {
    // Home builds the screen, bar navigates
    var openPatches: ((go: (Screen) -> Unit) -> Unit)? = null
}

// Extra bottom room so lists clear the bar
val LocalNavBarInset = compositionLocalOf<Dp> { 0.dp }
