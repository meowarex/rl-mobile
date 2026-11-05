package com.meowarex.rlmobile.ui.components

import androidx.compose.animation.ContentTransform
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.VisibilityThreshold
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.scaleIn
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.animation.togetherWith
import androidx.compose.ui.unit.IntOffset
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.core.stack.StackEvent

// Slide for push/pop, Essentials fade for tabs
fun appTransition(event: StackEvent, from: Screen, to: Screen): ContentTransform {
    if (event == StackEvent.Replace) {
        // Little nudge towards the picked tab
        val dir = if (tabIndexOf(to) >= tabIndexOf(from)) 1 else -1
        val enter = tween<Float>(durationMillis = 260, easing = FastOutSlowInEasing)
        // Old page stays solid, no black flash
        return (fadeIn(enter) +
            scaleIn(enter, initialScale = 0.96f) +
            slideInHorizontally(tween(260, easing = FastOutSlowInEasing)) { dir * it / 12 }) togetherWith
            fadeOut(tween(durationMillis = 1, delayMillis = 260))
    }
    val spec = spring(stiffness = Spring.StiffnessMedium, visibilityThreshold = IntOffset.VisibilityThreshold)
    return if (event == StackEvent.Pop) {
        slideInHorizontally(spec) { -it } togetherWith slideOutHorizontally(spec) { it }
    } else {
        slideInHorizontally(spec) { it } togetherWith slideOutHorizontally(spec) { -it }
    }
}
