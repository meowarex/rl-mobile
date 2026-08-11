package com.meowarex.rlmobile.ui.components.radiant

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.toggleable
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.theme.*

private val TrackWidth = 52.dp
private val TrackHeight = 32.dp
private val ThumbSize = 24.dp
private val ThumbInset = 4.dp

/**
 * Capsule switch.
 */
@Composable
fun RadiantSwitch(
    checked: Boolean,
    onCheckedChange: ((Boolean) -> Unit)?,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    interactionSource: MutableInteractionSource? = null,
) {
    if (radiantStyle.native) {
        Switch(
            checked = checked,
            onCheckedChange = onCheckedChange,
            enabled = enabled,
            interactionSource = interactionSource,
            modifier = modifier,
        )
        return
    }

    val scheme = MaterialTheme.colorScheme
    val offset by animateDpAsState(
        targetValue = if (checked) TrackWidth - ThumbSize - ThumbInset else ThumbInset,
        animationSpec = spring(dampingRatio = 0.55f, stiffness = Spring.StiffnessMediumLow),
        label = "SwitchThumbOffset",
    )
    val trackColor by animateColorAsState(
        targetValue = if (checked) Color.Transparent else scheme.surfaceContainerHighest,
        label = "SwitchTrack",
    )
    val thumbColor by animateColorAsState(
        targetValue = if (checked) scheme.onPrimary else scheme.outline,
        label = "SwitchThumb",
    )

    val trackShape = RoundedCornerShape(percent = 50)

    Box(
        contentAlignment = Alignment.CenterStart,
        modifier = modifier
            .alpha(if (enabled) 1f else 0.45f)
            .then(
                if (checked && enabled) {
                    Modifier.glow(scheme.primary, 14.dp, trackShape, alpha = 0.5f)
                } else Modifier
            )
            .size(TrackWidth, TrackHeight)
            .clip(trackShape)
            .then(if (checked) Modifier.background(accentBrush, trackShape) else Modifier)
            .background(trackColor, trackShape)
            .border(
                width = RadiantDesign.Hairline,
                brush = hairlineBrush(
                    color = if (checked) scheme.primary else scheme.onSurface,
                    alpha = if (checked) RadiantDesign.BORDER_ALPHA_ACTIVE else RadiantDesign.BORDER_ALPHA * 2f,
                ),
                shape = trackShape,
            )
            .then(
                if (onCheckedChange != null) {
                    Modifier.toggleable(
                        value = checked,
                        enabled = enabled,
                        role = Role.Switch,
                        interactionSource = interactionSource,
                        indication = null,
                        onValueChange = onCheckedChange,
                    )
                } else Modifier
            ),
    ) {
        Box(
            modifier = Modifier
                .padding(start = offset)
                .size(ThumbSize)
                .clip(CircleShape)
                .background(thumbColor, CircleShape),
        )
    }
}

/**
 * Ring & Core radio button.
 */
@Composable
fun RadiantRadio(
    selected: Boolean,
    onClick: (() -> Unit)?,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    interactionSource: MutableInteractionSource? = null,
) {
    if (radiantStyle.native) {
        RadioButton(
            selected = selected,
            onClick = onClick,
            enabled = enabled,
            interactionSource = interactionSource,
            modifier = modifier,
        )
        return
    }

    val scheme = MaterialTheme.colorScheme
    val coreScale by animateFloatAsState(
        targetValue = if (selected) 1f else 0f,
        animationSpec = spring(dampingRatio = 0.5f, stiffness = Spring.StiffnessMediumLow),
        label = "RadioCore",
    )

    Box(
        contentAlignment = Alignment.Center,
        modifier = modifier
            .alpha(if (enabled) 1f else 0.45f)
            .size(20.dp)
            .clip(CircleShape)
            .border(
                width = 2.dp,
                color = if (selected) scheme.primary else scheme.outline.copy(alpha = 0.6f),
                shape = CircleShape,
            )
            .then(
                if (onClick != null) {
                    Modifier.selectable(
                        selected = selected,
                        enabled = enabled,
                        role = Role.RadioButton,
                        interactionSource = interactionSource,
                        indication = null,
                        onClick = onClick,
                    )
                } else Modifier
            ),
    ) {
        Box(
            modifier = Modifier
                .scale(coreScale)
                .size(10.dp)
                .clip(CircleShape)
                .background(accentBrush, CircleShape),
        )
    }
}

/**
 * Squircle checkbox that fills with the accent gradient when checked.
 */
@Composable
fun RadiantCheckbox(
    checked: Boolean,
    onCheckedChange: ((Boolean) -> Unit)?,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
) {
    if (radiantStyle.native) {
        Checkbox(
            checked = checked,
            onCheckedChange = onCheckedChange,
            enabled = enabled,
            modifier = modifier,
        )
        return
    }

    val scheme = MaterialTheme.colorScheme
    val shape = RoundedCornerShape(7.dp)
    val fillScale by animateFloatAsState(
        targetValue = if (checked) 1f else 0f,
        animationSpec = spring(dampingRatio = 0.5f, stiffness = Spring.StiffnessMediumLow),
        label = "CheckboxFill",
    )

    Box(
        contentAlignment = Alignment.Center,
        modifier = modifier
            .alpha(if (enabled) 1f else 0.45f)
            .size(20.dp)
            .clip(shape)
            .border(
                width = 2.dp,
                color = if (checked) Color.Transparent else scheme.outline.copy(alpha = 0.6f),
                shape = shape,
            )
            .then(
                if (onCheckedChange != null) {
                    Modifier.toggleable(
                        value = checked,
                        enabled = enabled,
                        role = Role.Checkbox,
                        onValueChange = onCheckedChange,
                    )
                } else Modifier
            ),
    ) {
        Box(
            modifier = Modifier
                .scale(fillScale)
                .matchParentSize()
                .clip(shape)
                .background(accentBrush, shape),
        )

        if (checked) {
            Icon(
                painter = painterResource(R.drawable.ic_check_circle),
                contentDescription = null,
                tint = scheme.onPrimary,
                modifier = Modifier.size(13.dp),
            )
        }
    }
}
