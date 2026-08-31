package com.meowarex.rlmobile.ui.components.radiant

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsFocusedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.ui.theme.*

/**
 * Text field.
 */
@Composable
fun RadiantTextField(
    value: String,
    onValueChange: (String) -> Unit,
    modifier: Modifier = Modifier,
    placeholder: String? = null,
    isError: Boolean = false,
    enabled: Boolean = true,
    singleLine: Boolean = true,
    visualTransformation: VisualTransformation = VisualTransformation.None,
    trailing: @Composable (() -> Unit)? = null,
) {
    if (radiantStyle.native) {
        OutlinedTextField(
            value = value,
            onValueChange = onValueChange,
            enabled = enabled,
            isError = isError,
            singleLine = singleLine,
            visualTransformation = visualTransformation,
            placeholder = placeholder?.let { { Text(it) } },
            trailingIcon = trailing,
            modifier = modifier.fillMaxWidth(),
        )
        return
    }

    val scheme = MaterialTheme.colorScheme
    val interaction = remember(::MutableInteractionSource)
    val focused by interaction.collectIsFocusedAsState()
    val shape = RoundedCornerShape(16.dp)

    val borderColor by animateColorAsState(
        targetValue = when {
            isError -> scheme.error
            focused -> scheme.primary
            else -> scheme.onSurface.copy(alpha = RadiantDesign.BORDER_ALPHA * 2f)
        },
        label = "TextFieldBorder",
    )
    val borderWidth by animateDpAsState(
        targetValue = if (focused || isError) 2.dp else RadiantDesign.Hairline,
        label = "TextFieldBorderWidth",
    )

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        modifier = modifier
            .fillMaxWidth()
            .background(scheme.surfaceContainerLowest.copy(alpha = 0.7f), shape)
            .border(borderWidth, borderColor, shape)
            .clip(shape)
            .padding(horizontal = 16.dp, vertical = 4.dp)
            .heightIn(min = 52.dp),
    ) {
        Box(
            contentAlignment = Alignment.CenterStart,
            modifier = Modifier.weight(1f),
        ) {
            if (value.isEmpty() && placeholder != null) {
                Text(
                    text = placeholder,
                    style = MaterialTheme.typography.bodyLarge,
                    color = scheme.onSurfaceVariant.copy(alpha = 0.6f),
                )
            }

            BasicTextField(
                value = value,
                onValueChange = onValueChange,
                enabled = enabled,
                singleLine = singleLine,
                interactionSource = interaction,
                visualTransformation = visualTransformation,
                textStyle = MaterialTheme.typography.bodyLarge.copy(color = scheme.onSurface),
                cursorBrush = SolidColor(scheme.primary),
                modifier = Modifier.fillMaxWidth(),
            )
        }

        trailing?.invoke()
    }
}

/**
 * Slider. (i prefer the old on tbh so i reverted it back <3)
 */
@Composable
fun RadiantSlider(
    value: Float,
    onValueChange: (Float) -> Unit,
    modifier: Modifier = Modifier,
    valueRange: ClosedFloatingPointRange<Float> = 0f..1f,
    steps: Int = 0,
    enabled: Boolean = true,
    showStopIndicator: Boolean = true,
    onValueChangeFinished: (() -> Unit)? = null,
) {
    if (showStopIndicator) {
        Slider(
            value = value,
            onValueChange = onValueChange,
            onValueChangeFinished = onValueChangeFinished,
            valueRange = valueRange,
            steps = steps,
            enabled = enabled,
            modifier = modifier,
        )
    } else {
        Slider(
            value = value,
            onValueChange = onValueChange,
            onValueChangeFinished = onValueChangeFinished,
            valueRange = valueRange,
            steps = steps,
            enabled = enabled,
            modifier = modifier,
            track = { SliderDefaults.Track(sliderState = it, drawStopIndicator = null) },
        )
    }
}

/**
 * Pill segmented control.
 */
@Composable
fun RadiantSegmented(
    options: List<String>,
    selectedIndex: Int,
    onSelect: (Int) -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    disabledIndices: Set<Int> = emptySet(),
) {
    if (radiantStyle.native) {
        SingleChoiceSegmentedButtonRow(modifier = modifier.fillMaxWidth()) {
            options.forEachIndexed { index, label ->
                SegmentedButton(
                    selected = index == selectedIndex,
                    onClick = { onSelect(index) },
                    enabled = enabled && index !in disabledIndices,
                    shape = SegmentedButtonDefaults.itemShape(index = index, count = options.size),
                    icon = {},
                    label = { Text(text = label, maxLines = 1) },
                )
            }
        }
        return
    }

    val scheme = MaterialTheme.colorScheme
    val trackShape = RoundedCornerShape(16.dp)

    Row(
        modifier = modifier
            .fillMaxWidth()
            .background(scheme.surfaceContainerLowest.copy(alpha = 0.8f), trackShape)
            .border(
                RadiantDesign.Hairline,
                hairlineBrush(scheme.onSurface, RadiantDesign.BORDER_ALPHA),
                trackShape,
            )
            .clip(trackShape)
            .padding(3.dp),
        horizontalArrangement = Arrangement.spacedBy(3.dp),
    ) {
        options.forEachIndexed { index, label ->
            val selected = index == selectedIndex
            val segmentEnabled = enabled && index !in disabledIndices
            val pillShape = RoundedCornerShape(13.dp)
            val alpha by animateFloatAsState(
                targetValue = if (selected) 1f else 0f,
                label = "SegmentedPill",
            )

            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier
                    .weight(1f)
                    .height(34.dp)
                    .clip(pillShape)
                    .then(
                        if (alpha > 0.01f) {
                            Modifier.background(
                                accentBrush,
                                pillShape,
                                alpha = alpha,
                            )
                        } else Modifier
                    )
                    .clickable(
                        enabled = segmentEnabled,
                        role = Role.RadioButton,
                        onClick = { onSelect(index) },
                    ),
            ) {
                Text(
                    text = label,
                    style = MaterialTheme.typography.labelLarge,
                    color = when {
                        selected -> scheme.onPrimary
                        segmentEnabled -> scheme.onSurfaceVariant
                        else -> scheme.onSurface.copy(alpha = 0.38f)
                    },
                    maxLines = 1,
                )
            }
        }
    }
}

/** something.. */
