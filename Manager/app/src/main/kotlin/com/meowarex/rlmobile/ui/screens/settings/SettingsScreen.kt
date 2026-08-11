package com.meowarex.rlmobile.ui.screens.settings

import android.os.Build
import android.os.Parcelable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.koin.koinScreenModel
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton
import com.meowarex.rlmobile.ui.components.BackButton
import com.meowarex.rlmobile.ui.components.DangerActionButton
import com.meowarex.rlmobile.ui.components.MainActionButton
import com.meowarex.rlmobile.ui.components.settings.*
import com.meowarex.rlmobile.ui.screens.settings.components.InstallersDialog
import com.meowarex.rlmobile.ui.screens.settings.components.ThemeDialog
import com.meowarex.rlmobile.ui.screens.settings.components.UiStyleDialog
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize

@Parcelize
class SettingsScreen : Screen, Parcelable {
    @IgnoredOnParcel
    override val key = "Settings"

    @Composable
    override fun Content() {
        val model = koinScreenModel<SettingsModel>()
        var clearedCache by rememberSaveable { mutableStateOf(false) }
        val preferences = model.preferences

        if (model.showThemeDialog) {
            ThemeDialog(
                currentTheme = preferences.theme,
                onDismiss = model::hideThemeDialog,
                onConfirm = model::setTheme
            )
        }

        if (model.showUiStyleDialog) {
            UiStyleDialog(
                current = preferences.uiStyle,
                onDismiss = model::hideUiStyleDialog,
                onConfirm = model::setUiStyle,
            )
        }

        if (model.showInstallersDialog) {
            InstallersDialog(
                currentInstaller = preferences.installer,
                onDismiss = model::hideInstallersDialog,
                onConfirm = model::setInstaller,
            )
        }

        Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text(stringResource(R.string.navigation_settings)) },
                    navigationIcon = { BackButton() },
                )
            },
        ) { padding ->
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .verticalScroll(rememberScrollState())
                    .padding(padding),
            ) {
                SettingsHeader(stringResource(R.string.settings_header_appearance))

                SettingsGroup {
                    val dynamicColorAvailable = Build.VERSION.SDK_INT >= 31
                    val appearanceCount = if (dynamicColorAvailable) 4 else 3

                    SettingsItem(
                        position = groupPosition(0, appearanceCount),
                        onClick = model::showThemeDialog,
                        icon = { Icon(painterResource(R.drawable.ic_brush), null) },
                        text = { Text(stringResource(R.string.setting_theme)) },
                        secondaryText = { Text(stringResource(R.string.setting_theme_desc)) }
                    ) {
                        RadiantButton(
                            text = preferences.theme.toDisplayName(),
                            onClick = model::showThemeDialog,
                            size = RadiantButtonSize.Small,
                        )
                    }

                    SettingsItem(
                        position = groupPosition(1, appearanceCount),
                        onClick = model::showUiStyleDialog,
                        icon = { Icon(painterResource(R.drawable.ic_sparkle), null) },
                        text = { Text(stringResource(R.string.setting_ui_style)) },
                        secondaryText = { Text(stringResource(R.string.setting_ui_style_desc)) },
                    ) {
                        RadiantButton(
                            text = preferences.uiStyle.toDisplayName(),
                            onClick = model::showUiStyleDialog,
                            size = RadiantButtonSize.Small,
                        )
                    }

                    // Material You theming on Android 12+
                    if (dynamicColorAvailable) {
                        SettingsSwitch(
                            label = stringResource(R.string.setting_dynamic_color),
                            secondaryLabel = stringResource(R.string.setting_dynamic_color_desc),
                            pref = preferences.dynamicColor,
                            position = groupPosition(2, appearanceCount),
                            icon = { Icon(painterResource(R.drawable.ic_palette), null) },
                            onPrefChange = { preferences.dynamicColor = it },
                        )
                    }

                    SettingsSwitch(
                        label = stringResource(R.string.setting_auto_update_check),
                        secondaryLabel = stringResource(R.string.setting_auto_update_check_desc),
                        pref = preferences.autoUpdateCheck,
                        position = groupPosition(appearanceCount - 1, appearanceCount),
                        icon = { Icon(painterResource(R.drawable.ic_update), null) },
                        onPrefChange = { model.setAutoUpdateCheck(it) },
                    )
                }

                SettingsHeader(stringResource(R.string.settings_header_installation))

                SettingsGroup {
                    SettingsItem(
                        position = GroupPosition.Top,
                        onClick = model::showInstallersDialog,
                        text = { Text(stringResource(R.string.setting_installer)) },
                        secondaryText = { Text(stringResource(R.string.setting_installer_desc)) },
                        icon = { Icon(painterResource(R.drawable.ic_apk_install), null) },
                    ) {
                        RadiantButton(
                            text = preferences.installer.title(),
                            icon = preferences.installer.icon(),
                            onClick = model::showInstallersDialog,
                            size = RadiantButtonSize.Small,
                        )
                    }

                    SettingsSwitch(
                        label = stringResource(R.string.setting_keep_patched_apks),
                        secondaryLabel = stringResource(R.string.setting_keep_patched_apks_desc),
                        icon = { Icon(painterResource(R.drawable.ic_delete_forever), null) },
                        pref = preferences.keepPatchedApks,
                        position = GroupPosition.Bottom,
                        onPrefChange = { model.setKeepPatchedApks(it) },
                    )
                }

                Column(
                    verticalArrangement = Arrangement.spacedBy(10.dp),
                    modifier = Modifier.padding(horizontal = 16.dp, vertical = 16.dp),
                ) {
                    if (preferences.keepPatchedApks) {
                        MainActionButton(
                            text = stringResource(R.string.settings_export_apk),
                            icon = painterResource(R.drawable.ic_save),
                            enabled = model.patchedApkExists,
                            onClick = model::shareApk,
                        )
                    }

                    DangerActionButton(
                        text = stringResource(R.string.settings_clear_cache),
                        icon = painterResource(R.drawable.ic_delete_forever),
                        enabled = !clearedCache,
                        onClick = {
                            clearedCache = true
                            model.clearCache()
                        },
                    )
                }

                SettingsHeader(stringResource(R.string.settings_header_advanced))

                SettingsGroup {
                    SettingsSwitch(
                        label = stringResource(R.string.setting_developer_options),
                        secondaryLabel = stringResource(R.string.setting_developer_options_desc),
                        pref = preferences.devMode,
                        position = GroupPosition.Single,
                        icon = { Icon(painterResource(R.drawable.ic_code), null) },
                        onPrefChange = { preferences.devMode = it },
                    )
                }

                SettingsHeader(stringResource(R.string.settings_header_info))

                SettingsGroup {
                    SettingsItem(
                        position = GroupPosition.Single,
                        onClick = model::copyInstallInfo,
                        icon = { Icon(painterResource(R.drawable.ic_info), null) },
                        text = { Text(stringResource(R.string.settings_header_info)) },
                        secondaryText = { Text(model.installInfo) },
                    ) {
                        RadiantIconButton(
                            icon = painterResource(R.drawable.ic_copy),
                            contentDescription = stringResource(R.string.action_copy),
                            onClick = model::copyInstallInfo,
                        )
                    }
                }

                Spacer(Modifier.height(28.dp))
            }
        }
    }
}
