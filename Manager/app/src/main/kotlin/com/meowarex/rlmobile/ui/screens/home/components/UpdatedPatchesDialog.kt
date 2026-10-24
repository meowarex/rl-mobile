package com.meowarex.rlmobile.ui.screens.home.components

import android.os.Parcelable
import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.koin.koinScreenModel
import cafe.adriel.voyager.navigator.Navigator
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonStyle
import com.meowarex.rlmobile.ui.screens.patchopts.LocalPatchChanges
import com.meowarex.rlmobile.ui.screens.patchopts.PatchChanges
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsModel
import com.meowarex.rlmobile.ui.screens.patchopts.PatchUpdateKind
import com.meowarex.rlmobile.ui.screens.patchopts.components.PatchSelectionList
import com.meowarex.rlmobile.ui.theme.glassSurface
import com.meowarex.rlmobile.ui.theme.radiantSurface
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize
import org.koin.core.parameter.parametersOf

@get:StringRes
val PatchUpdateKind.labelRes: Int
    get() = when (this) {
        PatchUpdateKind.Updated -> R.string.patch_update_updated
        PatchUpdateKind.NewOptions -> R.string.patch_update_new_options
        PatchUpdateKind.NewPatches -> R.string.patch_update_new_patches
    }

@get:DrawableRes
val PatchUpdateKind.iconRes: Int
    get() = when (this) {
        PatchUpdateKind.Updated -> R.drawable.ic_healing
        PatchUpdateKind.NewOptions -> R.drawable.ic_tune
        PatchUpdateKind.NewPatches -> R.drawable.ic_sparkle
    }

@get:StringRes
private val PatchUpdateKind.descriptionRes: Int
    get() = when (this) {
        PatchUpdateKind.Updated -> R.string.patch_update_dialog_desc_updated
        PatchUpdateKind.NewOptions -> R.string.patch_update_dialog_desc_new_options
        PatchUpdateKind.NewPatches -> R.string.patch_update_dialog_desc_new_patches
    }

private class UpdatedPatchesActions(
    val installEnabled: Boolean,
    val onDismiss: () -> Unit,
    val onInstall: (PatchOptions) -> Unit,
)

private val LocalUpdatedPatchesActions = staticCompositionLocalOf<UpdatedPatchesActions> {
    error("UpdatedPatchesActions not provided")
}

/**
 * Just the new patches, same model as repatch
 */
@Composable
fun UpdatedPatchesDialog(
    prefilledOptions: PatchOptions,
    changes: PatchChanges,
    installEnabled: Boolean,
    onDismiss: () -> Unit,
    onInstall: (PatchOptions) -> Unit,
) {
    val actions = UpdatedPatchesActions(installEnabled, onDismiss, onInstall)

    Dialog(
        onDismissRequest = onDismiss,
        properties = DialogProperties(usePlatformDefaultWidth = false),
    ) {
        CompositionLocalProvider(LocalUpdatedPatchesActions provides actions) {
            // Disposes the model with the dialog, back still dismisses
            Navigator(UpdatedPatchesScreen(prefilledOptions, changes), onBackPressed = null)
        }
    }
}

@Parcelize
internal class UpdatedPatchesScreen(
    private val prefilledOptions: PatchOptions,
    private val changes: PatchChanges,
) : Screen, Parcelable {
    @IgnoredOnParcel
    override val key = "UpdatedPatches"

    @Composable
    override fun Content() {
        val model = koinScreenModel<PatchOptionsModel> { parametersOf(prefilledOptions) }
        val actions = LocalUpdatedPatchesActions.current

        CompositionLocalProvider(LocalPatchChanges provides changes) {
            UpdatedPatchesContent(
                model = model,
                changes = changes,
                installEnabled = actions.installEnabled,
                onDismiss = actions.onDismiss,
                onInstall = { actions.onInstall(model.generateConfig()) },
            )
        }
    }
}

@Composable
private fun UpdatedPatchesContent(
    model: PatchOptionsModel,
    changes: PatchChanges,
    installEnabled: Boolean,
    onDismiss: () -> Unit,
    onInstall: () -> Unit,
) {
    val shape = RoundedCornerShape(30.dp)
    val kind = changes.kind
    val ready = model.specsReady && !model.specsLoading
    val specs = remember(model.specs, changes) { model.specs.filter(changes::hasNew) }

    Column(
        verticalArrangement = Arrangement.spacedBy(14.dp),
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 24.dp)
            .radiantSurface(shape = shape, base = MaterialTheme.colorScheme.surfaceContainer)
            .clip(shape)
            .padding(20.dp),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier
                    .size(44.dp)
                    .clip(RoundedCornerShape(15.dp))
                    .glassSurface(RoundedCornerShape(15.dp)),
            ) {
                Icon(
                    painter = painterResource(kind.iconRes),
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.primary,
                )
            }
            Text(
                text = stringResource(kind.labelRes),
                style = MaterialTheme.typography.headlineSmall,
                color = MaterialTheme.colorScheme.onSurface,
            )
        }

        Text(
            text = stringResource(kind.descriptionRes),
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
        )

        if (!ready) {
            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 24.dp),
            ) {
                CircularProgressIndicator()
            }
        } else if (specs.isNotEmpty()) {
            Column(
                verticalArrangement = Arrangement.spacedBy(4.dp),
                modifier = Modifier
                    .weight(1f, fill = false)
                    .verticalScroll(rememberScrollState()),
            ) {
                PatchSelectionList(
                    specs = specs,
                    isEnabled = model::isPatchEnabled,
                    onToggle = model::setPatchEnabled,
                    lockState = model::lockState,
                    variantIndex = model::variantIndex,
                    onSelectVariant = model::selectVariant,
                    optionState = model.optionState,
                )

                // New options only show under an enabled patch
                val hiddenOptions = specs.any { !changes.isNew(it) && !model.isPatchEnabled(it) }
                if (hiddenOptions) {
                    Text(
                        text = stringResource(R.string.patch_update_dialog_disabled_hint),
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(top = 6.dp),
                    )
                }
            }
        }

        Column(
            verticalArrangement = Arrangement.spacedBy(8.dp),
            modifier = Modifier.padding(top = 4.dp),
        ) {
            RadiantButton(
                text = stringResource(R.string.patch_update_dialog_install),
                icon = painterResource(R.drawable.ic_download),
                onClick = onInstall,
                enabled = installEnabled && ready && model.isConfigValid,
                style = RadiantButtonStyle.Accent,
                size = RadiantButtonSize.Large,
                fillWidth = true,
            )
            RadiantButton(
                text = stringResource(R.string.action_cancel),
                onClick = onDismiss,
                style = RadiantButtonStyle.Ghost,
                fillWidth = true,
            )
        }
    }
}
