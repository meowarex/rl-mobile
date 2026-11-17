package com.meowarex.rlmobile.ui.util

import androidx.compose.animation.core.animateOffsetAsState
import androidx.compose.animation.core.spring
import androidx.compose.foundation.gestures.awaitEachGesture
import androidx.compose.foundation.gestures.awaitFirstDown
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.TransformOrigin
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.PointerEventPass
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import kotlin.math.abs
import kotlin.math.exp
import kotlin.math.min
import kotlin.math.sign

// Stretchy drag effect from the nav bar <3
fun Modifier.fluidStretch(enabled: Boolean = true): Modifier = composed {
    if (!enabled) return@composed this
    val density = LocalDensity.current.density
    var pull by remember { mutableStateOf(Offset.Zero) }
    var held by remember { mutableStateOf(false) }
    val anim by animateOffsetAsState(
        targetValue = pull,
        // Follows the finger, wobbles back on release
        animationSpec = if (held) spring(dampingRatio = 1f, stiffness = 900f)
        else spring(dampingRatio = 0.32f, stiffness = 420f),
        label = "fluid_pull",
    )

    this
        .pointerInput(Unit) {
            awaitEachGesture {
                // Final pass so scrolling lists take priority
                val down = awaitFirstDown(requireUnconsumed = false, pass = PointerEventPass.Final)
                val slop = viewConfiguration.touchSlop
                var moved = false
                while (true) {
                    val event = awaitPointerEvent(PointerEventPass.Final)
                    val change = event.changes.firstOrNull { it.id == down.id } ?: break
                    if (!change.pressed) break
                    if (moved && change.isConsumed) break
                    if (!moved && (change.position - down.position).getDistance() > slop) {
                        if (change.isConsumed) break
                        moved = true
                        held = true
                    }
                    if (moved) {
                        val w = size.width.toFloat()
                        val h = size.height.toFloat()
                        pull = fluidPull(
                            p = change.position,
                            w = w,
                            h = h,
                            zone = min(24f * density, w / 4f),
                            maxX = min(32f * density, w / 4f),
                            maxY = min(16f * density, h / 4f),
                        )
                    }
                }
                held = false
                pull = Offset.Zero
            }
        }
        .graphicsLayer {
            val w = size.width
            val h = size.height
            if (w <= 0f || h <= 0f || anim == Offset.Zero) return@graphicsLayer
            val sx = 0.75f * abs(anim.x) / w
            val sy = 0.75f * abs(anim.y) / h
            // Stretch one axis, squash the other
            scaleX = 1f + sx - 0.4f * sy
            scaleY = 1f + sy - 0.5f * sx
            translationX = anim.x * 0.25f
            translationY = anim.y * 0.25f
            transformOrigin = TransformOrigin(
                if (anim.x >= 0f) 0f else 1f,
                if (anim.y >= 0f) 0f else 1f,
            )
        }
}

// Rubber band pull past the edges
fun fluidPull(p: Offset, w: Float, h: Float, zone: Float, maxX: Float, maxY: Float): Offset {
    val rawX = when {
        p.x < zone -> p.x - zone
        p.x > w - zone -> p.x - (w - zone)
        else -> 0f
    }
    val rawY = when {
        p.y < 0f -> p.y
        p.y > h -> p.y - h
        else -> 0f
    }
    return Offset(rubber(rawX, maxX), rubber(rawY, maxY))
}

private fun rubber(over: Float, max: Float): Float =
    if (over == 0f || max <= 0f) 0f else sign(over) * max * (1f - exp(-abs(over) / max))
