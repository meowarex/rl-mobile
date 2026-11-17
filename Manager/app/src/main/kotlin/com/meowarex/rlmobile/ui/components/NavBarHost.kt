package com.meowarex.rlmobile.ui.components

import androidx.compose.runtime.compositionLocalOf
import cafe.adriel.voyager.core.screen.Screen
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import kotlin.random.Random

// Shared bits for the floating nav
object NavBarHost {
    // Home builds the screen, bar navigates
    var openPatches: ((go: (Screen) -> Unit) -> Unit)? = null

    // 10% chance of the heart icon <3
    val luckyHeart = Random.nextInt(10) == 0
}

// Extra bottom room so lists clear the bar
val LocalNavBarInset = compositionLocalOf<Dp> { 0.dp }
