package com.meowarex.rlmobile.ui.previews.screens

import android.content.res.Configuration
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import com.meowarex.rlmobile.manager.InstallerSetting
import com.meowarex.rlmobile.ui.screens.permissions.PermissionsScreenContent
import com.meowarex.rlmobile.ui.theme.ManagerTheme

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
fun PermissionsScreenPreview() {
    ManagerTheme {
        PermissionsScreenContent(
            installer = InstallerSetting.PackageInstaller,
            openInstallersDialog = {},
            storagePermsGranted = true,
            onGrantStoragePerms = {},
            unknownSourcesPermsGranted = true,
            onGrantUnknownSourcesPerms = {},
            notificationsPermsGranted = false,
            onGrantNotificationsPerms = {},
            batteryPermsGranted = false,
            onGrantBatteryPerms = {},
            canContinue = true,
            onContinue = {},
        )
    }
}
