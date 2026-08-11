package com.meowarex.rlmobile.ui.screens.patchopts.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.fromHtml
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions

/**
 * Confirms unlocking the package-name field, warning that a custom name
 * blocks the listed patches/integrations from working.
 */
@Composable
fun PackageNameUnlockDialog(
    blockedTitles: List<String>,
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
) {
    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.patchopts_pkgname_warning_title),
        confirmText = stringResource(R.string.action_continue),
        onConfirm = onConfirm,
        destructive = true,
        dismissText = stringResource(R.string.action_cancel),
        onDismissAction = onDismiss,
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Text(
                text = AnnotatedString.fromHtml(
                    stringResource(
                        R.string.patchopts_pkgname_warning_msg,
                        PatchOptions.Default.packageName,
                    ),
                ),
            )

            if (blockedTitles.isNotEmpty()) {
                Column(
                    verticalArrangement = Arrangement.spacedBy(2.dp),
                    modifier = Modifier.padding(start = 4.dp),
                ) {
                    for (title in blockedTitles) {
                        Text(
                            text = "• $title",
                            color = MaterialTheme.colorScheme.onSurface,
                            fontWeight = FontWeight.Bold,
                        )
                    }
                }
            }

            Text(stringResource(R.string.patchopts_pkgname_warning_permanent))
        }
    }
}
