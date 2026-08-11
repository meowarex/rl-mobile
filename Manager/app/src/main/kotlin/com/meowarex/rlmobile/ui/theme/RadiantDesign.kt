package com.meowarex.rlmobile.ui.theme

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.ReadOnlyComposable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.compositeOver
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * The primitives the Radiant control set is built from
 */
object RadiantDesign {
    /** Hairline border width used on every raised surface. */
    val Hairline: Dp = 1.dp

    /** How far a container's top edge is lightened to fake a light source from above. */
    const val TOP_LIT_ALPHA = 0.06f

    /** Border opacity for inert containers vs. ones that are selected/active. */
    const val BORDER_ALPHA = 0.10f
    const val BORDER_ALPHA_ACTIVE = 0.55f

    /** Fill opacity for "glass" (translucent tinted) controls. */
    const val GLASS_ALPHA = 0.10f
    const val GLASS_ALPHA_PRESSED = 0.18f
}

/**
 * The accent - flat brand pink. (unless using M-YOU)
 */
val accentColor: Color
    @Composable @ReadOnlyComposable
    get() = MaterialTheme.colorScheme.primary

/** [accentColor] as a Brush, for the `background(brush, shape)` call sites. */
val accentBrush: Brush
    @Composable @ReadOnlyComposable
    get() = SolidColor(accentColor)

/** Muted variant of [accentBrush] for disabled primary controls. */
val accentBrushDisabled: Brush
    @Composable @ReadOnlyComposable
    get() = SolidColor(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.12f))

/**
 * Vertical gradient for a raised container: a lit top edge falling to the flat container colour.
 */
@Composable
@ReadOnlyComposable
fun surfaceBrush(base: Color = MaterialTheme.colorScheme.surfaceContainerLow): Brush {
    val lit = Color.White.copy(alpha = RadiantDesign.TOP_LIT_ALPHA).compositeOver(base)
    return Brush.verticalGradient(listOf(lit, base))
}

/** Hairline border brush — brighter at the top, matching the surface's implied light source. */
@Composable
@ReadOnlyComposable
fun hairlineBrush(
    color: Color = MaterialTheme.colorScheme.onSurface,
    alpha: Float = RadiantDesign.BORDER_ALPHA,
): Brush = Brush.verticalGradient(
    listOf(
        color.copy(alpha = alpha * 1.8f),
        color.copy(alpha = alpha * 0.6f),
    )
)

/**
 * The house container treatment: gradient fill + hairline border, clipped to [shape].
 */
@Composable
fun Modifier.radiantSurface(
    shape: Shape,
    base: Color = MaterialTheme.colorScheme.surfaceContainerLow,
    active: Boolean = false,
    borderColor: Color = if (active) {
        MaterialTheme.colorScheme.primary
    } else {
        MaterialTheme.colorScheme.onSurface
    },
): Modifier {
    val style = radiantStyle
    return this
        .background(
            // Legacy drops the falloff and paints the flat container colour Material would use. (thx claude)
            brush = if (style.surfaceGradient) surfaceBrush(base) else SolidColor(base),
            shape = shape,
        )
        .then(
            if (style.hairline) {
                Modifier.border(
                    width = RadiantDesign.Hairline,
                    brush = hairlineBrush(
                        color = borderColor,
                        alpha = if (active) {
                            RadiantDesign.BORDER_ALPHA_ACTIVE
                        } else {
                            RadiantDesign.BORDER_ALPHA
                        },
                    ),
                    shape = shape,
                )
            } else Modifier
        )
}

/**
 * Coloured outer glow
 */
@Composable
fun Modifier.glow(
    color: Color = MaterialTheme.colorScheme.primary,
    radius: Dp = 16.dp,
    shape: Shape,
    alpha: Float = 0.55f,
): Modifier {
    if (!radiantStyle.glow) return this
    return this.shadow(
        elevation = radius,
        shape = shape,
        clip = false,
        ambientColor = color.copy(alpha = alpha),
        spotColor = color.copy(alpha = alpha),
    )
}

/**
 * Translucent tinted fill used by secondary "glass" controls
 */
@Composable
fun Modifier.glassSurface(
    shape: Shape,
    tint: Color = MaterialTheme.colorScheme.primary,
    fillAlpha: Float = RadiantDesign.GLASS_ALPHA,
    borderAlpha: Float = RadiantDesign.BORDER_ALPHA_ACTIVE,
): Modifier {
    val style = radiantStyle
    // In Legacy this becomes Material's secondaryContainer fill with no edge.
    if (!style.hairline) {
        return this.background(
            color = MaterialTheme.colorScheme.secondaryContainer,
            shape = shape,
        )
    }
    return this
        .background(color = tint.copy(alpha = fillAlpha), shape = shape)
        .border(
            width = RadiantDesign.Hairline,
            brush = hairlineBrush(color = tint, alpha = borderAlpha),
            shape = shape,
        )
}
