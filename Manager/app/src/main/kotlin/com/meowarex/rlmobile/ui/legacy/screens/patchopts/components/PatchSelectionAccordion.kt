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
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.fromHtml
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.screens.patchopts.OptionSpec
import com.meowarex.rlmobile.ui.screens.patchopts.PatchLock
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionState
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.screens.patchopts.PatchSpec
import com.meowarex.rlmobile.ui.screens.patchopts.effectiveVariants
import com.meowarex.rlmobile.ui.screens.patchopts.resolveVariantIndex

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
                Text(
                    text = stringResource(titleRes),
                    style = MaterialTheme.typography.titleMedium,
                )
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

                    val inlineToggles = patch.advancedOptions
                        .filterIsInstance<OptionSpec.Toggle>()
                        .filter { it.inline }
                    val hasSheetOptions = patch.advancedOptions.any { it !is OptionSpec.Toggle || !it.inline }
                    val hasSettings = patch.variants.isNotEmpty() || inlineToggles.isNotEmpty() || hasSheetOptions

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

                                    for (option in inlineToggles) key(option.key) {
                                        val show = option.requiresVariant == null ||
                                            option.requiresVariant == resolvedVariant
                                        if (show) {
                                            InlineToggleRow(
                                                title = option.title,
                                                description = option.description,
                                                checked = optionState.toggle(patch, option),
                                                onCheckedChange = { optionState.setToggle(patch, option, it) },
                                            )
                                        }
                                    }

                                    if (hasSheetOptions) {
                                        Box(
                                            modifier = Modifier.fillMaxWidth(),
                                            contentAlignment = Alignment.Center,
                                        ) {
                                            AdvancedOptionsButton(
                                                modified = optionState.isModified(patch),
                                                onClick = { advancedFor = patch },
                                            )
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
) {
    FilledTonalButton(
        onClick = onClick,
        modifier = modifier,
    ) {
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
}

@Composable
private fun InlineToggleRow(
    title: String,
    description: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
) {
    val interactionSource = remember(::MutableInteractionSource)

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier
            .fillMaxWidth()
            .clickable(
                interactionSource = interactionSource,
                indication = null,
                role = Role.Switch,
            ) { onCheckedChange(!checked) }
            .padding(vertical = 4.dp),
    ) {
        Column(
            verticalArrangement = Arrangement.spacedBy(2.dp),
            modifier = Modifier.weight(1f),
        ) {
            Text(text = title, style = MaterialTheme.typography.titleSmall)
            Text(
                text = description,
                style = MaterialTheme.typography.bodySmall,
                modifier = Modifier.alpha(.7f),
            )
        }
        Switch(
            checked = checked,
            onCheckedChange = onCheckedChange,
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
            Text(
                text = title,
                style = MaterialTheme.typography.titleSmall,
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
