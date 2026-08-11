package com.meowarex.rlmobile.manager

import android.content.SharedPreferences
import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.manager.base.BasePreferenceManager
import com.meowarex.rlmobile.ui.theme.Theme
import com.meowarex.rlmobile.ui.theme.UiStyle

@Stable
class PreferencesManager(preferences: SharedPreferences) : BasePreferenceManager(preferences) {
    var theme by enumPreference("theme", Theme.System)
    var uiStyle by enumPreference("ui_style", UiStyle.Radiant)
    // Off by default — Radiant ships its own palette. Opting in hands theming back to Monet.
    var dynamicColor by booleanPreference("dynamic_color", false)
    var devMode by booleanPreference("dev_mode", false)
    var installer by enumPreference<InstallerSetting>("installer", InstallerSetting.PackageInstaller)
    var keepPatchedApks by booleanPreference("keep_patched_apks", false)
    // Dev: force-apply path-gated ("incompatible") patches even under a non-stock package name
    var bypassIncompatible by booleanPreference("bypass_incompatible", false)
    var showPlayProtectWarning by booleanPreference("show_play_protect_warning", true)
    var autoUpdateCheck by booleanPreference("auto_update_check", true)

    var lastSeenManagerVersion by stringPreference("last_seen_manager_version", "")
    var lastSeenPatchesVersion by stringPreference("last_seen_patches_version", "")
    var lastSeenTidalVersionCode by intPreference("last_seen_tidal_version_code", -1)
}
