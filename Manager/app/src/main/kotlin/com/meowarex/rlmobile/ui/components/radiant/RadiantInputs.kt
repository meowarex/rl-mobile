package com.meowarex.rlmobile.ui.components.radiant

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.MutableTransitionState
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.rememberTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsFocusedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.role
import androidx.compose.ui.semantics.selected
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.DpOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Popup
import androidx.compose.ui.window.PopupProperties
import com.meowarex.rlmobile.R
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
 * Dropdown
 */
@Composable
fun RadiantDropdown(
    options: List<String>,
    selectedIndex: Int,
    onSelect: (Int) -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    disabledIndices: Set<Int> = emptySet(),
) {
    var expanded by rememberSaveable { mutableStateOf(false) }
    val visibilityState = remember { MutableTransitionState(false) }
    visibilityState.targetState = expanded
    val transition = rememberTransition(visibilityState, label = "Dropdown")
    val progress by transition.animateFloat(
        transitionSpec = { tween(durationMillis = 160, easing = FastOutSlowInEasing) },
        label = "DropdownProgress",
    ) {
        if (it) 1f else 0f
    }
    val scheme = MaterialTheme.colorScheme
    val selectedLabel = options.getOrNull(selectedIndex).orEmpty()
    val shape = if (radiantStyle.native) MaterialTheme.shapes.extraSmall else RoundedCornerShape(16.dp)
    var anchorWidthPx by remember { mutableIntStateOf(0) }
    val anchorWidth = with(LocalDensity.current) { anchorWidthPx.toDp() }
    val positionProvider = MenuDefaults.rememberDropdownMenuPopupPositionProvider(
        dropdownMenuAnchorPosition = MenuAnchorPosition.Below,
        offset = DpOffset(0.dp, 6.dp),
    )
    Box(modifier = modifier.fillMaxWidth()) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            modifier = Modifier
                .fillMaxWidth()
                .onSizeChanged { anchorWidthPx = it.width }
                .background(scheme.surfaceContainerLowest.copy(alpha = 0.8f), shape)
                .then(
                    if (radiantStyle.native) Modifier.border(1.dp, scheme.outline, shape)
                    else Modifier.border(
                        RadiantDesign.Hairline,
                        hairlineBrush(scheme.onSurface, RadiantDesign.BORDER_ALPHA * 1.5f),
                        shape,
                    )
                )
                .clip(shape)
                .clickable(enabled = enabled, role = Role.Button) { expanded = !expanded }
                .alpha(if (enabled) 1f else 0.45f)
                .heightIn(min = 52.dp)
                .padding(horizontal = 16.dp, vertical = 10.dp),
        ) {
            Text(
                text = selectedLabel,
                style = MaterialTheme.typography.bodyLarge,
                color = scheme.onSurface,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier.weight(1f),
            )
            Icon(
                painter = painterResource(R.drawable.ic_arrow_down_small),
                contentDescription = null,
                modifier = Modifier.rotate(180f * progress),
            )
        }

        if (
            anchorWidthPx > 0 &&
            (visibilityState.currentState || visibilityState.targetState || transition.isRunning)
        ) {
            Popup(
                popupPositionProvider = positionProvider,
                onDismissRequest = { expanded = false },
                properties = PopupProperties(focusable = true),
            ) {
                Surface(
                    modifier = Modifier
                        .width(anchorWidth)
                        .graphicsLayer {
                            alpha = progress
                            scaleX = 0.92f + 0.08f * progress
                            scaleY = 0.92f + 0.08f * progress
                            transformOrigin = positionProvider.transformOrigin
                        },
                    shape = shape,
                    color = scheme.surfaceContainer,
                    tonalElevation = 0.dp,
                    shadowElevation = 8.dp,
                    border = BorderStroke(
                        RadiantDesign.Hairline,
                        scheme.onSurface.copy(alpha = RadiantDesign.BORDER_ALPHA * 2f),
                    ),
                ) {
                    Column(
                        modifier = Modifier
                            .heightIn(max = 320.dp)
                            .verticalScroll(rememberScrollState())
                            .padding(vertical = 6.dp),
                    ) {
                        options.forEachIndexed { index, option ->
                            val selected = index == selectedIndex
                            val itemEnabled = enabled && index !in disabledIndices
                            DropdownMenuItem(
                                text = {
                                    Text(
                                        text = option,
                                        style = MaterialTheme.typography.bodyLarge,
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis,
                                    )
                                },
                                trailingIcon = {
                                    RadiantRadio(
                                        selected = selected,
                                        onClick = null,
                                        enabled = itemEnabled,
                                    )
                                },
                                enabled = itemEnabled,
                                onClick = {
                                    onSelect(index)
                                    expanded = false
                                },
                                modifier = Modifier
                                    .padding(horizontal = 6.dp, vertical = 2.dp)
                                    .clip(RoundedCornerShape(12.dp))
                                    .semantics {
                                        this.selected = selected
                                        role = Role.RadioButton
                                    }
                                    .then(
                                        if (selected) Modifier.background(scheme.primary.copy(alpha = 0.1f))
                                        else Modifier
                                    ),
                            )
                        }
                    }
                }
            }
        }
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
