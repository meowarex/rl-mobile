package com.meowarex.rlmobile.ui.legacy.screens.patchopts.components

import com.meowarex.rlmobile.ui.screens.patchopts.components.*
import com.meowarex.rlmobile.ui.screens.patchopts.*


import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.fromHtml
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.compose.LocalLifecycleOwner
import androidx.lifecycle.repeatOnLifecycle
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.pebble.PebbleWatchapp
import com.meowarex.rlmobile.ui.components.NewPin
import com.meowarex.rlmobile.ui.components.TitleWithNewPin
import com.meowarex.rlmobile.ui.screens.patchopts.OptionSpec
import com.meowarex.rlmobile.ui.screens.patchopts.PatchLock
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionState
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.screens.patchopts.PatchSpec
import com.meowarex.rlmobile.ui.screens.patchopts.effectiveVariants
import com.meowarex.rlmobile.ui.screens.patchopts.resolveVariantIndex
import com.meowarex.rlmobile.ui.screens.patchopts.conflictingChoices
import com.meowarex.rlmobile.ui.screens.patchopts.isInline

private data class LockInfo(val patch: PatchSpec, val lock: PatchLock)

@Composable
fun PatchSelectionAccordion(
    @DrawableRes iconRes: Int,
    @StringRes titleRes: Int,
    @StringRes descriptionRes: Int,
    specs: List<PatchSpec>,
    enabledCount: Int,
    totalCount: Int,
    isEnabled: (PatchSpec) -> Boolean,
    onToggle: (PatchSpec, Boolean) -> Unit,
    lockState: (PatchSpec) -> PatchLock,
    variantIndex: (PatchSpec) -> Int,
    onSelectVariant: (PatchSpec, Int) -> Unit,
    optionState: PatchOptionState,
    modifier: Modifier = Modifier,
) {
    var expanded by rememberSaveable { mutableStateOf(false) }
    val rotation by animateFloatAsState(
        targetValue = if (expanded) 180f else 0f,
        label = "patch-accordion-arrow",
    )

    var lockInfo by remember { mutableStateOf<LockInfo?>(null) }
    var advancedFor by remember { mutableStateOf<PatchSpec?>(null) }
    val changes = LocalPatchChanges.current
    val newCount = specs.count(changes::hasNew)

    Column(
        modifier = modifier
            .fillMaxWidth()
            .clip(MaterialTheme.shapes.large)
            .background(MaterialTheme.colorScheme.surfaceContainerLow),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            modifier = Modifier
                .fillMaxWidth()
                .clickable(role = Role.Button) { expanded = !expanded }
                .padding(horizontal = 16.dp, vertical = 14.dp),
        ) {
            Icon(
                painter = painterResource(iconRes),
                contentDescription = null,
            )

            Column(
                verticalArrangement = Arrangement.spacedBy(2.dp),
                modifier = Modifier.weight(1f),
            ) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text(
                        text = stringResource(titleRes),
                        style = MaterialTheme.typography.titleMedium,
                    )
                    if (newCount > 0) NewPin(text = stringResource(R.string.patchopts_new_count, newCount))
                }
                Text(
                    text = stringResource(
                        R.string.patchopts_patches_summary,
                        enabledCount,
                        totalCount,
                    ),
                    style = MaterialTheme.typography.bodySmall,
                    modifier = Modifier.alpha(.7f),
                )
            }

            Icon(
                painter = painterResource(R.drawable.ic_arrow_down_small),
                contentDescription = stringResource(
                    if (expanded) R.string.action_collapse else R.string.action_expand,
                ),
                modifier = Modifier.rotate(rotation),
            )
        }

        AnimatedVisibility(visible = expanded) {
            Column(
                verticalArrangement = Arrangement.spacedBy(4.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .background(MaterialTheme.colorScheme.background.copy(0.4f))
                    .padding(horizontal = 16.dp, vertical = 12.dp),
            ) {
                Text(
                    text = stringResource(descriptionRes),
                    style = MaterialTheme.typography.bodySmall,
                    modifier = Modifier
                        .alpha(.7f)
                        .padding(bottom = 8.dp),
                )

                for (patch in specs) key(patch.id) {
                    val checked = isEnabled(patch)
                    val lock = lockState(patch)

                    val inlineOptions = patch.advancedOptions.filter { it.isInline }
                    val hasSheetOptions = patch.advancedOptions.any { !it.isInline }
                    val companionApp = patch.companionApp
                    val hasSettings = patch.variants.isNotEmpty() || inlineOptions.isNotEmpty() || hasSheetOptions ||
                        companionApp != null

                    // When a patch is enabled and has settings show a carded view of the settings
                    val carded = checked && hasSettings
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
                        PatchSwitchRow(
                            title = patch.title,
                            description = patch.description,
                            isNew = changes.isNew(patch),
                            hasNewOptions = !changes.isNew(patch) && changes.hasNew(patch),
                            checked = checked,
                            lock = lock,
                            onCheckedChange = { onToggle(patch, it) },
                            onLockedTap = { lockInfo = LockInfo(patch, lock) },
                        )

                        if (hasSettings) {
                            AnimatedVisibility(visible = checked) {
                                Column(
                                    verticalArrangement = Arrangement.spacedBy(10.dp),
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .padding(bottom = 8.dp),
                                ) {
                                    val resolvedVariant =
                                        if (patch.variants.isNotEmpty())
                                            patch.resolveVariantIndex(variantIndex(patch)) {
                                                optionState.toggle(patch, it)
                                            }
                                        else -1
                                    // Toggles that change the variants go above
                                    for (option in inlineOptions) key("above-" + option.key) {
                                        if (option is OptionSpec.Toggle && option.aboveVariants) {
                                            InlineToggleRow(
                                                title = option.title,
                                                description = option.description,
                                                isNew = changes.isNew(patch, option),
                                                checked = optionState.toggle(patch, option),
                                                onCheckedChange = { optionState.setToggle(patch, option, it) },
                                            )
                                        }
                                    }
                                    if (patch.variants.isNotEmpty()) {
                                        val effective = patch.effectiveVariants { optionState.toggle(patch, it) }
                                        PatchVariantSelector(
                                            variants = effective,
                                            selectedIndex = effective
                                                .indexOfFirst { it.originalIndex == resolvedVariant }
                                                .coerceAtLeast(0),
                                            onSelect = { pos ->
                                                effective.getOrNull(pos)?.let { onSelectVariant(patch, it.originalIndex) }
                                            },
                                        )
                                    }

                                    for (option in inlineOptions) key(option.key) {
                                        when (option) {
                                            is OptionSpec.Toggle -> {
                                                val show = !option.aboveVariants && (option.requiresVariant == null ||
                                                    option.requiresVariant == resolvedVariant)
                                                if (show) {
                                                    InlineToggleRow(
                                                        title = option.title,
                                                        description = option.description,
                                                        isNew = changes.isNew(patch, option),
                                                        checked = optionState.toggle(patch, option),
                                                        onCheckedChange = { optionState.setToggle(patch, option, it) },
                                                        enabled = patch.lockingToggle(option) { optionState.toggle(patch, it) } == null,
                                                    )
                                                }
                                            }
                                            is OptionSpec.Choice -> {
                                                val requiredToggle = option.requiresOption?.let { key ->
                                                    patch.advancedOptions.filterIsInstance<OptionSpec.Toggle>()
                                                        .firstOrNull { it.key == key }
                                                }
                                                if (requiredToggle == null || optionState.toggle(patch, requiredToggle)) {
                                                    ChoiceOptionRow(
                                                        title = option.title,
                                                        description = option.description,
                                                        isNew = changes.isNew(patch, option),
                                                        entries = option.entries,
                                                        selectedIndex = optionState.choice(patch, option),
                                                        forceDropdown = option.forceDropdown,
                                                        disabledIndices = patch.conflictingChoices(option)
                                                            .map { optionState.choice(patch, it) }
                                                            .filter { it != 0 }
                                                            .toSet(),
                                                        onSelect = { optionState.setChoice(patch, option, it) },
                                                    )
                                                }
                                            }
                                            else -> Unit
                                        }
                                    }

                                    if (hasSheetOptions) {
                                        Box(
                                            modifier = Modifier.fillMaxWidth(),
                                            contentAlignment = Alignment.Center,
                                        ) {
                                            AdvancedOptionsButton(
                                                modified = optionState.isModified(patch),
                                                hasNew = changes.hasNewSheetOptions(patch),
                                                onClick = { advancedFor = patch },
                                            )
                                        }
                                    }

                                    if (companionApp != null) {
                                        val context = LocalContext.current
                                        val lifecycleOwner = LocalLifecycleOwner.current
                                        var installState by remember { mutableStateOf(PebbleWatchapp.InstallState.Unknown) }
                                        // Recheck on resume
                                        LaunchedEffect(lifecycleOwner) {
                                            lifecycleOwner.repeatOnLifecycle(Lifecycle.State.RESUMED) {
                                                installState = PebbleWatchapp.installState(context)
                                            }
                                        }
                                        val installed = installState == PebbleWatchapp.InstallState.Installed
                                        Row(
                                            horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally),
                                            modifier = Modifier.fillMaxWidth(),
                                        ) {
                                            FilledTonalButton(
                                                onClick = { PebbleWatchapp.install(context, companionApp) },
                                                enabled = !installed && PebbleWatchapp.canInstall(companionApp),
                                                modifier = Modifier.weight(1f),
                                            ) {
                                                Icon(
                                                    painter = painterResource(if (installed) R.drawable.ic_check_circle else R.drawable.ic_download),
                                                    contentDescription = null,
                                                    modifier = Modifier.size(18.dp),
                                                )
                                                Spacer(Modifier.width(8.dp))
                                                Text(
                                                    if (installed) {
                                                        stringResource(R.string.patchopts_companion_installed)
                                                    } else {
                                                        companionApp.installTitle.ifBlank { stringResource(R.string.patchopts_companion_install) }
                                                    }
                                                )
                                            }
                                            FilledTonalButton(
                                                onClick = { PebbleWatchapp.openSettings(context) },
                                                enabled = installed,
                                                modifier = Modifier.weight(1f),
                                            ) {
                                                Icon(
                                                    painter = painterResource(R.drawable.ic_tune),
                                                    contentDescription = null,
                                                    modifier = Modifier.size(18.dp),
                                                )
                                                Spacer(Modifier.width(8.dp))
                                                Text(companionApp.customizeTitle.ifBlank { stringResource(R.string.patchopts_companion_customize) })
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    lockInfo?.let { info ->
        PatchLockDialog(
            thisPatch = info.patch,
            lock = info.lock,
            onDismiss = { lockInfo = null },
        )
    }

    advancedFor?.let { patch ->
        PatchAdvancedOptionsSheet(
            patch = patch,
            state = optionState,
            selectedVariant = patch.resolveVariantIndex(variantIndex(patch)) { optionState.toggle(patch, it) },
            onDismiss = { advancedFor = null },
        )
    }
}

@Composable
private fun AdvancedOptionsButton(
    modified: Boolean,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    hasNew: Boolean = false,
) {
    Row(
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier,
    ) {
        FilledTonalButton(onClick = onClick) {
            Icon(
                painter = painterResource(R.drawable.ic_tune),
                contentDescription = null,
                modifier = Modifier.size(18.dp),
            )
            Spacer(Modifier.width(8.dp))
            Text(stringResource(R.string.patchopts_advanced_button))
            if (modified) {
                Spacer(Modifier.width(8.dp))
                Box(
                    modifier = Modifier
                        .size(8.dp)
                        .clip(CircleShape)
                        .background(MaterialTheme.colorScheme.primary),
                )
            }
        }
        if (hasNew) NewPin()
    }
}

@Composable
private fun InlineToggleRow(
    title: String,
    description: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    // False when another option pins it
    enabled: Boolean = true,
    isNew: Boolean = false,
) {
    val interactionSource = remember(::MutableInteractionSource)

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier
            .fillMaxWidth()
            .alpha(if (enabled) 1f else .4f)
            .clickable(
                interactionSource = interactionSource,
                indication = null,
                role = Role.Switch,
                enabled = enabled,
            ) { onCheckedChange(!checked) }
            .padding(vertical = 4.dp),
    ) {
        Column(
            verticalArrangement = Arrangement.spacedBy(2.dp),
            modifier = Modifier.weight(1f),
        ) {
            TitleWithNewPin(title = title, isNew = isNew, style = MaterialTheme.typography.titleSmall)
            Text(
                text = description,
                style = MaterialTheme.typography.bodySmall,
                modifier = Modifier.alpha(.7f),
            )
        }
        Switch(
            checked = checked,
            onCheckedChange = onCheckedChange,
            enabled = enabled,
            interactionSource = interactionSource,
        )
    }
}

@Composable
private fun PatchSwitchRow(
    title: String,
    description: String,
    checked: Boolean,
    lock: PatchLock,
    onCheckedChange: (Boolean) -> Unit,
    onLockedTap: () -> Unit,
    isNew: Boolean = false,
    // Only its options are new
    hasNewOptions: Boolean = false,
) {
    val interactionSource = remember(::MutableInteractionSource)
    val isLocked = lock !is PatchLock.Free

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier
            .fillMaxWidth()
            .clickable(
                interactionSource = interactionSource,
                indication = null,
                role = Role.Switch,
            ) {
                if (isLocked) onLockedTap() else onCheckedChange(!checked)
            }
            .alpha(if (isLocked) 0.45f else 1f)
            .padding(vertical = 6.dp),
    ) {
        Column(
            verticalArrangement = Arrangement.spacedBy(2.dp),
            modifier = Modifier.weight(1f),
        ) {
            TitleWithNewPin(
                title = title,
                isNew = isNew || hasNewOptions,
                style = MaterialTheme.typography.titleSmall,
                pinText = stringResource(if (isNew) R.string.patchopts_new else R.string.patchopts_new_options),
            )
            Text(
                text = description,
                style = MaterialTheme.typography.bodySmall,
                modifier = Modifier.alpha(.7f),
            )
        }

        Box {
            Switch(
                checked = checked,
                enabled = !isLocked,
                onCheckedChange = onCheckedChange,
                interactionSource = interactionSource,
            )
            if (isLocked) {
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

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PatchLockDialog(
    thisPatch: PatchSpec,
    lock: PatchLock,
    onDismiss: () -> Unit,
) {
    val (titleRes, msgRes, blockerTitle) = when (lock) {
        is PatchLock.LockedOn -> Triple(
            R.string.patch_lock_required_title,
            R.string.patch_lock_required_msg,
            lock.by.title,
        )
        is PatchLock.LockedOff -> Triple(
            R.string.patch_lock_blocked_title,
            R.string.patch_lock_blocked_msg,
            lock.by.title,
        )
        PatchLock.RequiresDefaultPackage -> Triple(
            R.string.patch_lock_pkgname_title,
            R.string.patch_lock_pkgname_msg,
            PatchOptions.Default.packageName,
        )
        PatchLock.Free -> return
    }

    BasicAlertDialog(onDismissRequest = onDismiss) {
        Surface(
            shape = MaterialTheme.shapes.large,
            color = MaterialTheme.colorScheme.surfaceContainerHigh,
            tonalElevation = 6.dp,
        ) {
            Column(
                modifier = Modifier.padding(start = 24.dp, end = 12.dp, top = 20.dp, bottom = 8.dp),
                verticalArrangement = Arrangement.spacedBy(6.dp),
            ) {
                Text(
                    text = stringResource(titleRes),
                    style = MaterialTheme.typography.titleLarge,
                )
                Text(
                    text = AnnotatedString.fromHtml(stringResource(msgRes, blockerTitle)),
                    style = MaterialTheme.typography.bodyLarge,
                )
                Box(modifier = Modifier.fillMaxWidth()) {
                    TextButton(
                        onClick = onDismiss,
                        modifier = Modifier.align(Alignment.CenterEnd),
                    ) {
                        Text(stringResource(R.string.action_got_it))
                    }
                }
            }
        }
    }
}
