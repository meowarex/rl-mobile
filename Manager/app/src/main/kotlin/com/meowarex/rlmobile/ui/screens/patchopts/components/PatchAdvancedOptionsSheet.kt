package com.meowarex.rlmobile.ui.screens.patchopts.components

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.fromHtml
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog
import com.meowarex.rlmobile.ui.components.radiant.RadiantDropdown
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonStyle
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantSegmented
import com.meowarex.rlmobile.ui.components.radiant.RadiantSlider
import com.meowarex.rlmobile.ui.components.radiant.RadiantSwitch
import com.meowarex.rlmobile.ui.components.radiant.RadiantTextField
import com.meowarex.rlmobile.ui.components.ResetToDefaultButton
import com.meowarex.rlmobile.ui.screens.patchopts.OptionLock
import com.meowarex.rlmobile.ui.screens.patchopts.OptionSpec
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionState
import com.meowarex.rlmobile.ui.screens.patchopts.conflictingChoices
import com.meowarex.rlmobile.ui.screens.patchopts.hiddenForVariant
import com.meowarex.rlmobile.ui.screens.patchopts.isInline
import com.meowarex.rlmobile.ui.screens.patchopts.optionLock
import com.meowarex.rlmobile.ui.screens.patchopts.PatchSpec
import kotlinx.coroutines.launch
import kotlin.math.roundToInt

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PatchAdvancedOptionsSheet(
    patch: PatchSpec,
    state: PatchOptionState,
    selectedVariant: Int,
    onDismiss: () -> Unit,
) {
    val sheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
    val scope = rememberCoroutineScope()
    var lockDialog by remember { mutableStateOf<OptionLock?>(null) }

    fun dismiss() {
        scope.launch { sheetState.hide() }.invokeOnCompletion {
            if (!sheetState.isVisible) onDismiss()
        }
    }

    ModalBottomSheet(
        onDismissRequest = onDismiss,
        sheetState = sheetState,
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState())
                .padding(horizontal = 24.dp)
                .padding(bottom = 16.dp),
            verticalArrangement = Arrangement.spacedBy(20.dp),
        ) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                modifier = Modifier.fillMaxWidth(),
            ) {
                Column(
                    verticalArrangement = Arrangement.spacedBy(2.dp),
                    modifier = Modifier.weight(1f),
                ) {
                    Text(
                        text = stringResource(R.string.patchopts_advanced_sheet_label),
                        style = MaterialTheme.typography.labelMedium,
                        color = MaterialTheme.colorScheme.primary,
                    )
                    Text(
                        text = patch.title,
                        style = MaterialTheme.typography.headlineSmall,
                    )
                }

                ResetToDefaultButton(
                    enabled = state.isModified(patch),
                    onClick = { state.reset(patch) },
                )
            }

            HorizontalDivider()

            val parentKeys = patch.advancedOptions
                .filterIsInstance<OptionSpec.Toggle>()
                .filter { !it.isInline }
                .map { it.key }
                .toSet()
            val sheetOptions = patch.advancedOptions.filter { option ->
                when {
                    option.isInline -> false
                    option is OptionSpec.Toggle && option.requiresOption in parentKeys -> false
                    // Options belonging to another variant are hidden, not greyed out.
                    option.hiddenForVariant(selectedVariant) -> false
                    else -> true
                }
            }
            for (option in sheetOptions) key(option.key) {
                val lock = patch.optionLock(option, selectedVariant) { state.toggle(patch, it) }
                when (option) {
                    is OptionSpec.Toggle -> {
                        val toggleOn = state.toggle(patch, option)
                        val gatedChoices = patch.advancedOptions.filterIsInstance<OptionSpec.Choice>()
                            .filter { it.requiresOption == option.key && !it.isInline }
                        val gatedToggles = patch.advancedOptions.filterIsInstance<OptionSpec.Toggle>()
                            .filter { it.requiresOption == option.key && !it.inline }
                        val hasSubOptions = gatedChoices.isNotEmpty() || gatedToggles.isNotEmpty()
                        val carded = hasSubOptions && toggleOn

                        Column(
                            modifier = if (carded) {
                                Modifier
                                    .fillMaxWidth()
                                    .clip(MaterialTheme.shapes.medium)
                                    .background(MaterialTheme.colorScheme.primary.copy(alpha = 0.07f))
                                    .border(
                                        width = 1.5.dp,
                                        color = MaterialTheme.colorScheme.primary.copy(alpha = 0.55f),
                                        shape = MaterialTheme.shapes.medium,
                                    )
                                    .padding(horizontal = 12.dp, vertical = 4.dp)
                            } else {
                                Modifier.fillMaxWidth()
                            },
                        ) {
                            ToggleOptionRow(
                                title = option.title,
                                description = option.description,
                                checked = toggleOn,
                                onCheckedChange = { state.setToggle(patch, option, it) },
                                locked = lock != OptionLock.Free,
                                onLockedTap = { lockDialog = lock },
                                modifier = if (hasSubOptions) Modifier.padding(vertical = 6.dp) else Modifier,
                            )
                            if (hasSubOptions) {
                                AnimatedVisibility(visible = toggleOn) {
                                    Column(
                                        verticalArrangement = Arrangement.spacedBy(10.dp),
                                        modifier = Modifier
                                            .fillMaxWidth()
                                            .padding(bottom = 8.dp),
                                    ) {
                                        gatedChoices.forEach { choice ->
                                            key(choice.key) {
                                                ChoiceOptionRow(
                                                    title = choice.title,
                                                    description = choice.description,
                                                    entries = choice.entries,
                                                    selectedIndex = state.choice(patch, choice),
                                                    forceDropdown = choice.forceDropdown,
                                                    disabledIndices = patch.conflictingChoices(choice)
                                                        .map { state.choice(patch, it) }
                                                        .filter { it != 0 }
                                                        .toSet(),
                                                    onSelect = { state.setChoice(patch, choice, it) },
                                                )
                                            }
                                        }
                                        gatedToggles.forEach { sub ->
                                            key(sub.key) {
                                                val subLock = patch.optionLock(sub, selectedVariant) { state.toggle(patch, it) }
                                                ToggleOptionRow(
                                                    title = sub.title,
                                                    description = sub.description,
                                                    checked = state.toggle(patch, sub),
                                                    onCheckedChange = { state.setToggle(patch, sub, it) },
                                                    locked = subLock != OptionLock.Free,
                                                    onLockedTap = { lockDialog = subLock },
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    is OptionSpec.Slider -> SliderOptionRow(
                        title = option.title,
                        description = option.description,
                        value = state.slider(patch, option),
                        valueLabel = formatSliderValue(option, state.slider(patch, option)),
                        valueRange = option.valueRange,
                        steps = option.steps,
                        onValueChange = { state.setSlider(patch, option, it) },
                    )

                    is OptionSpec.Choice ->
                        if (option.requiresOption == null) {
                            ChoiceOptionRow(
                                title = option.title,
                                description = option.description,
                                entries = option.entries,
                                selectedIndex = state.choice(patch, option),
                                forceDropdown = option.forceDropdown,
                                disabledIndices = patch.conflictingChoices(option)
                                    .map { state.choice(patch, it) }
                                    .filter { it != 0 }
                                    .toSet(),
                                onSelect = { state.setChoice(patch, option, it) },
                            )
                        }

                    is OptionSpec.Color -> ColorOptionRow(
                        title = option.title,
                        color = state.color(patch, option),
                        defaultColor = option.default,
                        onColorChange = { state.setColor(patch, option, it) },
                    )
                }
            }

            RadiantButton(
                text = stringResource(R.string.action_done),
                onClick = { dismiss() },
                style = RadiantButtonStyle.Accent,
                modifier = Modifier
                    .align(Alignment.End)
                    .padding(top = 4.dp),
            )
        }
    }

    lockDialog?.let { lock ->
        OptionLockDialog(lock = lock, onDismiss = { lockDialog = null })
    }
}

@Composable
private fun ToggleOptionRow(
    title: String,
    description: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    locked: Boolean = false,
    onLockedTap: () -> Unit = {},
    modifier: Modifier = Modifier,
) {
    val interactionSource = remember(::MutableInteractionSource)

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = modifier
            .fillMaxWidth()
            .clickable(
                interactionSource = interactionSource,
                indication = null,
                role = Role.Switch,
            ) { if (locked) onLockedTap() else onCheckedChange(!checked) }
            .alpha(if (locked) 0.45f else 1f),
    ) {
        OptionText(
            title = title,
            description = description,
            modifier = Modifier.weight(1f),
        )

        Box {
            RadiantSwitch(
                checked = checked,
                enabled = !locked,
                onCheckedChange = onCheckedChange,
                interactionSource = interactionSource,
            )
            if (locked) {
                Box(
                    modifier = Modifier
                        .matchParentSize()
                        .clickable(
                            interactionSource = remember(::MutableInteractionSource),
                            indication = null,
                            role = Role.Switch,
                        ) { onLockedTap() }
                )
            }
        }
    }
}

@Composable
private fun SliderOptionRow(
    title: String,
    description: String,
    value: Float,
    valueLabel: String,
    valueRange: ClosedFloatingPointRange<Float>,
    steps: Int,
    onValueChange: (Float) -> Unit,
) {
    // Whether the slider snaps to the step dots
    var snap by rememberSaveable { mutableStateOf(true) }

    Column(
        modifier = Modifier.fillMaxWidth(),
        verticalArrangement = Arrangement.spacedBy(2.dp),
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                modifier = Modifier.weight(1f),
            )
            Text(
                text = valueLabel,
                style = MaterialTheme.typography.labelLarge,
                color = MaterialTheme.colorScheme.primary,
            )
            if (steps > 0) {
                RadiantIconButton(
                    icon = painterResource(
                        if (snap) R.drawable.ic_lock else R.drawable.ic_lock_open,
                    ),
                    contentDescription = stringResource(R.string.patchopts_toggle_snap),
                    tint = if (snap) MaterialTheme.colorScheme.primary
                    else MaterialTheme.colorScheme.onSurfaceVariant,
                    subtle = true,
                    size = 32.dp,
                    onClick = {
                        snap = !snap
                        if (snap) onValueChange(snapToNearestStep(value, valueRange, steps))
                    },
                )
            }
        }

        Text(
            text = description,
            style = MaterialTheme.typography.bodySmall,
            modifier = Modifier.alpha(.7f),
        )

        // Locked -> native stepped slider (dots + snapping), left exactly as-is
        // Unlocked -> plain continuous slider with the trailing stop-indicator dot removed
        if (snap) {
            RadiantSlider(
                value = value,
                onValueChange = onValueChange,
                valueRange = valueRange,
                steps = steps,
            )
        } else {
            RadiantSlider(
                value = value,
                onValueChange = onValueChange,
                valueRange = valueRange,
                showStopIndicator = false,
            )
        }
    }
}

private fun snapToNearestStep(
    value: Float,
    range: ClosedFloatingPointRange<Float>,
    steps: Int,
): Float {
    if (steps <= 0) return value
    val stepSize = (range.endInclusive - range.start) / (steps + 1)
    if (stepSize <= 0f) return value
    val snapped = range.start + Math.round((value - range.start) / stepSize) * stepSize
    return snapped.coerceIn(range.start, range.endInclusive)
}

@Composable
internal fun ChoiceOptionRow(
    entries: List<String>,
    selectedIndex: Int,
    onSelect: (Int) -> Unit,
    title: String = "",
    description: String = "",
    forceDropdown: Boolean = false,
    disabledIndices: Set<Int> = emptySet(),
    modifier: Modifier = Modifier,
) {
    Column(
        modifier = modifier.fillMaxWidth(),
        verticalArrangement = Arrangement.spacedBy(6.dp),
        horizontalAlignment = Alignment.Start,
    ) {
        if (title.isNotEmpty()) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleSmall,
            )
        }
        if (description.isNotEmpty()) {
            Text(
                text = description,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
            )
        }
        if (forceDropdown || entries.size > 3) {
            RadiantDropdown(
                options = entries,
                selectedIndex = selectedIndex,
                onSelect = onSelect,
                disabledIndices = disabledIndices,
            )
            return@Column
        }
        RadiantSegmented(
            options = entries,
            selectedIndex = selectedIndex,
            onSelect = onSelect,
            disabledIndices = disabledIndices,
        )
    }
}

@Composable
private fun ColorOptionRow(
    title: String,
    color: Int,
    defaultColor: Int,
    onColorChange: (Int) -> Unit,
) {
    var showPicker by rememberSaveable { mutableStateOf(false) }
    val selectedColor = color.withOpaqueAlpha()
    val isNeutralPalette = defaultColor.withOpaqueAlpha() == NEUTRAL
    val presets = if (isNeutralPalette) {
        listOf(
            stringResource(R.string.patch_color_neutral),
            stringResource(R.string.patch_color_green),
            stringResource(R.string.patch_color_cyan),
        )
    } else {
        listOf(
            stringResource(R.string.patch_waze_color_waze_default),
            stringResource(R.string.patch_waze_color_tidal_cyan),
            stringResource(R.string.patch_waze_color_material_you),
        )
    }
    val presetColors = if (isNeutralPalette) {
        listOf(NEUTRAL, GREEN, CYAN)
    } else {
        listOf(
            defaultColor.withOpaqueAlpha(),
            TIDAL_CYAN,
            MaterialTheme.colorScheme.primary.toArgb().withOpaqueAlpha(),
        )
    }
    val selectedPreset = presetColors.indexOf(selectedColor)

    Column(
        modifier = Modifier.fillMaxWidth(),
        verticalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        Text(
            text = title,
            style = MaterialTheme.typography.labelMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            modifier = Modifier.align(Alignment.CenterHorizontally),
        )
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(10.dp),
            modifier = Modifier
                .fillMaxWidth()
                .clip(MaterialTheme.shapes.medium)
                .clickable { showPicker = true }
                .padding(vertical = 4.dp),
        ) {
            ColorSwatch(color = selectedColor)
            Text(
                text = selectedColor.toRgbHex(),
                style = MaterialTheme.typography.labelLarge,
                color = MaterialTheme.colorScheme.primary,
            )
            Icon(
                painter = painterResource(R.drawable.ic_edit),
                contentDescription = stringResource(R.string.patch_color_edit),
                tint = MaterialTheme.colorScheme.primary,
                modifier = Modifier.size(18.dp),
            )
        }
        RadiantSegmented(
            options = presets,
            selectedIndex = selectedPreset,
            onSelect = { index -> onColorChange(presetColors[index]) },
        )
    }

    if (showPicker) {
        ColorPickerDialog(
            initialColor = selectedColor,
            onDismiss = { showPicker = false },
            onColorSelected = {
                onColorChange(it)
                showPicker = false
            },
        )
    }
}

@Composable
private fun ColorSwatch(color: Int, modifier: Modifier = Modifier) {
    Box(
        modifier = modifier
            .size(32.dp)
            .clip(CircleShape)
            .background(Color(color))
            .border(1.dp, MaterialTheme.colorScheme.outlineVariant, CircleShape),
    )
}

@Composable
private fun ColorPickerDialog(
    initialColor: Int,
    onDismiss: () -> Unit,
    onColorSelected: (Int) -> Unit,
) {
    var color by rememberSaveable(initialColor) { mutableIntStateOf(initialColor.withOpaqueAlpha()) }
    var hex by rememberSaveable(initialColor) { mutableStateOf(color.toRgbHex()) }
    val parsedHex = parseRgbHex(hex)

    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.patch_color_picker_title),
        confirmText = stringResource(R.string.action_done),
        onConfirm = { parsedHex?.let(onColorSelected) },
        confirmEnabled = parsedHex != null,
        dismissText = stringResource(R.string.action_cancel),
        onDismissAction = onDismiss,
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(12.dp),
            ) {
                ColorSwatch(color = parsedHex ?: color, modifier = Modifier.size(44.dp))
                RadiantTextField(
                    value = hex,
                    onValueChange = { value ->
                        hex = value
                        parseRgbHex(value)?.let { color = it }
                    },
                    placeholder = stringResource(R.string.patch_color_picker_hex),
                    isError = parsedHex == null,
                    modifier = Modifier.weight(1f),
                )
            }

            if (parsedHex == null) {
                Text(
                    text = stringResource(R.string.patch_color_picker_hex_error),
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.error,
                )
            }
        }
    }
}


@Composable
private fun OptionText(
    title: String,
    description: String,
    modifier: Modifier = Modifier,
) {
    Column(
        modifier = modifier,
        verticalArrangement = Arrangement.spacedBy(2.dp),
    ) {
        Text(
            text = title,
            style = MaterialTheme.typography.titleMedium,
        )
        Text(
            text = description,
            style = MaterialTheme.typography.bodySmall,
            modifier = Modifier.alpha(.7f),
        )
    }
}

private fun formatSliderValue(option: OptionSpec.Slider, value: Float): String {
    val rounded = value.roundToInt()
    val unit = option.unit
    return when {
        option.displayAsPercent -> "$rounded%"
        unit != null -> "$rounded $unit"
        else -> rounded.toString()
    }
}

private const val OPAQUE_ALPHA = -0x1000000
private const val NEUTRAL = -14408663 // #ff242429
private const val GREEN = -14749031 // #ff1ef299
private const val CYAN = -14748953 // #ff1ef2e7
private const val TIDAL_CYAN = -14549268 // #ff21feec

private fun Int.withOpaqueAlpha(): Int = (this and 0x00FFFFFF) or OPAQUE_ALPHA

private fun Int.toRgbHex(): String = "#" +
        (this and 0x00FFFFFF).toString(16).uppercase().padStart(6, '0')

private fun parseRgbHex(value: String): Int? {
    val clean = value.trim()
        .removePrefix("#")
        .removePrefix("0x")
        .removePrefix("0X")
    if (clean.length != 6 && clean.length != 8) return null
    val parsed = clean.toLongOrNull(16) ?: return null
    val rgb = if (clean.length == 8) parsed and 0x00FFFFFFL else parsed
    return (0xFF000000L or rgb).toInt()
}

@Composable
private fun OptionLockDialog(lock: OptionLock, onDismiss: () -> Unit) {
    val message = when (lock) {
        is OptionLock.NeedsVariant -> stringResource(R.string.patch_opt_lock_needs_variant, lock.title)
        is OptionLock.NeedsOption -> stringResource(R.string.patch_opt_lock_needs_option, lock.title)
        OptionLock.Free -> return
    }

    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.patch_opt_lock_title),
        confirmText = stringResource(R.string.action_got_it),
        onConfirm = onDismiss,
    ) {
        Text(AnnotatedString.fromHtml(message))
    }
}
