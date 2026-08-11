package com.meowarex.rlmobile.ui.screens.settings.components

import androidx.compose.foundation.*
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.*
import com.meowarex.rlmobile.util.showToast
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog
import com.meowarex.rlmobile.ui.components.radiant.RadiantRadio
import com.meowarex.rlmobile.ui.theme.radiantSurface
import androidx.compose.foundation.shape.RoundedCornerShape
import com.topjohnwu.superuser.Shell
import org.koin.compose.koinInject

@Composable
fun InstallersDialog(
    currentInstaller: InstallerSetting,
    onDismiss: () -> Unit,
    onConfirm: (InstallerSetting) -> Unit,
) {
    val context = LocalContext.current
    val shizuku = koinInject<ShizukuManager>()
    val dhizuku = koinInject<DhizukuManager>()

    var shizukuAvailable by remember { mutableStateOf(false) }
    var dhizukuAvailable by remember { mutableStateOf(false) }
    var selectedInstaller by rememberSaveable { mutableStateOf(currentInstaller) }

    LaunchedEffect(Unit) {
        shizukuAvailable = shizuku.shizukuAvailable()
        dhizukuAvailable = dhizuku.dhizukuAvailable()
    }

    // Check if selected installer is usable and ask for permissions when necessary
    LaunchedEffect(selectedInstaller) {
        when (selectedInstaller) {
            InstallerSetting.PackageInstaller -> {
                // Once the Google sideloading block is in place,
                // check whether it is applicable to the device, and if so then it needs
                // to be inaccessible. (Disable button)
            }

            InstallerSetting.Root -> {
                val shell = Shell.getShell()
                if (!shell.isRoot) {
                    shell.waitAndClose()
                    Shell.getShell()
                }

                if (Shell.isAppGrantedRoot() != true) {
                    context.showToast(R.string.permissions_root_denied)
                    selectedInstaller = InstallerSetting.PackageInstaller
                }
            }

            InstallerSetting.Intent -> {
                // don't know whether this device supports this method
            }

            InstallerSetting.Shizuku -> {
                if (!shizuku.requestPermissions()) {
                    selectedInstaller = InstallerSetting.PackageInstaller
                }
            }

            InstallerSetting.Dhizuku -> {
                if (!dhizuku.requestPermissions()) {
                    selectedInstaller = InstallerSetting.PackageInstaller
                }
            }
        }
    }

    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.setting_installer),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_apk_install),
                contentDescription = null,
                modifier = Modifier.size(26.dp),
            )
        },
        confirmText = stringResource(R.string.action_apply),
        onConfirm = {
            onConfirm(selectedInstaller)
            onDismiss()
        },
        dismissText = stringResource(R.string.action_cancel),
    ) {
        Column(
            verticalArrangement = Arrangement.spacedBy(6.dp),
            modifier = Modifier.verticalScroll(rememberScrollState()),
        ) {
            for (installer in InstallerSetting.entries) key(installer) {
                InstallerItem(
                    installer = installer,
                    selected = installer == selectedInstaller,
                    enabled = when (installer) {
                        InstallerSetting.PackageInstaller -> true
                        InstallerSetting.Root -> true
                        InstallerSetting.Intent -> true
                        InstallerSetting.Shizuku -> shizukuAvailable
                        InstallerSetting.Dhizuku -> dhizukuAvailable
                    },
                    onClick = { selectedInstaller = installer },
                )
            }
        }
    }
}

@Composable
private fun InstallerItem(
    installer: InstallerSetting,
    selected: Boolean,
    enabled: Boolean,
    onClick: () -> Unit,
) {
    val interactionSource = remember(::MutableInteractionSource)
    val shape = RoundedCornerShape(16.dp)

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier
            .fillMaxWidth()
            .radiantSurface(shape = shape, active = selected)
            .clip(shape)
            .clickable(
                indication = null,
                interactionSource = interactionSource,
                enabled = enabled,
                onClick = onClick,
            )
            .alpha(if (enabled) 1f else 0.45f)
            .padding(horizontal = 14.dp, vertical = 12.dp),
    ) {
        Column(
            verticalArrangement = Arrangement.spacedBy(4.dp),
            modifier = Modifier.weight(1f),
        ) {
            Row(
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Icon(
                    painter = installer.icon(),
                    contentDescription = null,
                    tint = if (selected) {
                        MaterialTheme.colorScheme.primary
                    } else {
                        MaterialTheme.colorScheme.onSurfaceVariant
                    },
                    modifier = Modifier.size(20.dp),
                )
                Text(
                    text = installer.title(),
                    style = MaterialTheme.typography.titleSmall,
                    color = MaterialTheme.colorScheme.onSurface,
                )
            }
            Text(
                text = installer.description(),
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
            )
        }

        RadiantRadio(
            selected = selected,
            enabled = enabled,
            onClick = onClick,
            interactionSource = interactionSource,
        )
    }
}
