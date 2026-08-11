package com.meowarex.rlmobile.ui.components.radiant

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.ui.theme.*

/**
 * How much a button shrinks while held.
 */
private const val PRESS_SCALE = 0.965f

enum class RadiantButtonStyle {
    /** Gradient fill + glow. */
    Accent,

    /** Translucent accent wash + hairline. */
    Glass,

    /** Hairline only. */
    Ghost,

    /** Error-tinted glass. */
    Danger,
}

/**
 * Sizes are matched to the pre-redesign UI.
 */
enum class RadiantButtonSize(
    val height: Dp,
    val horizontalPadding: Dp,
    val iconSize: Dp,
    val corner: Dp,
) {
    Small(36.dp, 14.dp, 16.dp, 12.dp),
    Medium(40.dp, 18.dp, 18.dp, 14.dp),
    Large(46.dp, 22.dp, 20.dp, 16.dp),
}

/**
 * The app's button. (forgot specifically what this means but.. claude did this part)
 */
@Composable
fun RadiantButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    icon: Painter? = null,
    style: RadiantButtonStyle = RadiantButtonStyle.Glass,
    size: RadiantButtonSize = RadiantButtonSize.Medium,
    enabled: Boolean = true,
    fillWidth: Boolean = false,
) {
    val ui = radiantStyle

    // Legacy renders the old Material widget
    if (ui.legacy) {
        LegacyButton(
            text = text,
            onClick = onClick,
            icon = icon,
            variant = style,
            enabled = enabled,
            fillWidth = fillWidth,
            modifier = modifier,
        )
        return
    }

    val interaction = remember(::MutableInteractionSource)
    val pressed by interaction.collectIsPressedAsState()
    val scale by animateFloatAsState(
        targetValue = if (pressed && enabled) ui.pressScale else 1f,
        label = "RadiantButtonScale",
    )

    val shape: Shape = RoundedCornerShape(size.corner)
    val scheme = MaterialTheme.colorScheme

    val contentColor = when {
        !enabled -> scheme.onSurface.copy(alpha = 0.38f)
        style == RadiantButtonStyle.Accent -> scheme.onPrimary
        style == RadiantButtonStyle.Danger -> scheme.error
        else -> scheme.primary
    }

    // Glow only on the accent style
    val glowModifier = if (style == RadiantButtonStyle.Accent && enabled) {
        Modifier.glow(
            color = scheme.primary,
            radius = if (pressed) 22.dp else 14.dp,
            shape = shape,
        )
    } else {
        Modifier
    }

    val fillModifier = when (style) {
        RadiantButtonStyle.Accent -> Modifier.background(
            brush = if (enabled) accentBrush else accentBrushDisabled,
            shape = shape,
        )

        RadiantButtonStyle.Glass -> Modifier.glassSurface(
            shape = shape,
            tint = scheme.primary,
            fillAlpha = if (pressed) RadiantDesign.GLASS_ALPHA_PRESSED else RadiantDesign.GLASS_ALPHA,
        )

        RadiantButtonStyle.Danger -> Modifier.glassSurface(
            shape = shape,
            tint = scheme.error,
            fillAlpha = if (pressed) RadiantDesign.GLASS_ALPHA_PRESSED else RadiantDesign.GLASS_ALPHA,
        )

        RadiantButtonStyle.Ghost -> Modifier.border(
            width = RadiantDesign.Hairline,
            brush = hairlineBrush(scheme.onSurface, RadiantDesign.BORDER_ALPHA * 2f),
            shape = shape,
        )
    }

    Row(
        horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally),
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier
            .scale(scale)
            .then(if (fillWidth) Modifier.fillMaxWidth() else Modifier)
            .height(size.height)
            .then(glowModifier)
            .then(fillModifier)
            .clip(shape)
            .clickable(
                interactionSource = interaction,
                indication = null,
                enabled = enabled,
                role = Role.Button,
                onClick = onClick,
            )
            .padding(horizontal = size.horizontalPadding)
            .alpha(if (enabled) 1f else 0.6f),
    ) {
        if (icon != null) {
            Icon(
                painter = icon,
                contentDescription = null,
                tint = contentColor,
                modifier = Modifier.size(size.iconSize),
            )
        }

        Text(
            text = text,
            style = MaterialTheme.typography.labelLarge,
            color = contentColor,
            textAlign = TextAlign.Center,
            maxLines = 1,
        )
    }
}

/**
 * Icon-only sibling of RadiantButton.
 */
@Composable
fun RadiantIconButton(
    icon: Painter,
    contentDescription: String?,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    subtle: Boolean = false,
    accent: Boolean = false,
    size: Dp = 40.dp,
    tint: Color? = null,
) {
    val ui = radiantStyle

    if (ui.legacy) {
        val content = @Composable {
            Icon(
                painter = icon,
                contentDescription = contentDescription,
                tint = tint ?: LocalContentColor.current,
            )
        }
        if (subtle) {
            IconButton(onClick = onClick, enabled = enabled, modifier = modifier) { content() }
        } else {
            FilledTonalIconButton(onClick = onClick, enabled = enabled, modifier = modifier) { content() }
        }
        return
    }

    val interaction = remember(::MutableInteractionSource)
    val pressed by interaction.collectIsPressedAsState()
    val scale by animateFloatAsState(
        targetValue = if (pressed && enabled) 0.9f else 1f,
        label = "RadiantIconButtonScale",
    )

    val shape = RoundedCornerShape(size / 3f)
    val scheme = MaterialTheme.colorScheme

    val container = when {
        subtle -> Modifier
        accent -> Modifier
            .glow(scheme.primary, if (pressed) 18.dp else 12.dp, shape)
            .background(accentBrush, shape)

        else -> Modifier.glassSurface(shape = shape, tint = scheme.primary)
    }

    val contentColor = tint ?: when {
        !enabled -> scheme.onSurface.copy(alpha = 0.38f)
        accent -> scheme.onPrimary
        subtle -> LocalContentColor.current
        else -> scheme.primary
    }

    Box(
        contentAlignment = Alignment.Center,
        modifier = modifier
            .scale(scale)
            .size(size)
            .then(container)
            .clip(shape)
            .clickable(
                interactionSource = interaction,
                indication = null,
                enabled = enabled,
                role = Role.Button,
                onClick = onClick,
            ),
    ) {
        Icon(
            painter = icon,
            contentDescription = contentDescription,
            tint = contentColor,
            modifier = Modifier.size(size * 0.48f),
        )
    }
}

/** Border stroke matching the hairline (technically a duplicate but i was lazy)*/
@Composable
fun radiantHairline(
    color: Color = MaterialTheme.colorScheme.onSurface,
    alpha: Float = RadiantDesign.BORDER_ALPHA,
) = BorderStroke(RadiantDesign.Hairline, hairlineBrush(color, alpha))

/**
 * Material equivalents for RadiantButtonStyle.
 */
@Composable
private fun LegacyButton(
    text: String,
    onClick: () -> Unit,
    icon: Painter?,
    variant: RadiantButtonStyle,
    enabled: Boolean,
    fillWidth: Boolean,
    modifier: Modifier = Modifier,
) {
    val m = if (fillWidth) modifier.fillMaxWidth() else modifier

    val content: @Composable RowScope.() -> Unit = {
        if (icon != null) {
            Icon(
                painter = icon,
                contentDescription = null,
                modifier = Modifier.size(18.dp),
            )
            Spacer(Modifier.width(ButtonDefaults.IconSpacing))
        }
        Text(text = text, maxLines = 1)
    }

    when (variant) {
        RadiantButtonStyle.Accent ->
            Button(onClick = onClick, enabled = enabled, modifier = m, content = content)

        RadiantButtonStyle.Glass ->
            FilledTonalButton(onClick = onClick, enabled = enabled, modifier = m, content = content)

        RadiantButtonStyle.Ghost ->
            OutlinedButton(onClick = onClick, enabled = enabled, modifier = m, content = content)

        RadiantButtonStyle.Danger -> FilledTonalButton(
            onClick = onClick,
            enabled = enabled,
            colors = ButtonDefaults.filledTonalButtonColors(
                containerColor = MaterialTheme.colorScheme.errorContainer,
                contentColor = MaterialTheme.colorScheme.onErrorContainer,
            ),
            modifier = m,
            content = content,
        )
    }
}
