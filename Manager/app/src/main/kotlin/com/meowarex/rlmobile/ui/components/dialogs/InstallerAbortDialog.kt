package com.meowarex.rlmobile.ui.components.dialogs

import androidx.compose.foundation.layout.size
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog

@Composable
fun InstallerAbortDialog(
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
) {
    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.installer_abort_title),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_warning),
                contentDescription = null,
                modifier = Modifier.size(26.dp),
            )
        },
        confirmText = stringResource(R.string.action_exit_anyways),
        onConfirm = onConfirm,
        destructive = true,
        dismissText = stringResource(R.string.action_cancel),
        onDismissAction = onDismiss,
    ) {
        Text(stringResource(R.string.installer_abort_body))
    }
}
