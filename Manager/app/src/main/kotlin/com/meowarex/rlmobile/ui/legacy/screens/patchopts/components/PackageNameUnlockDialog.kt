package com.meowarex.rlmobile.ui.legacy.screens.patchopts.components

import com.meowarex.rlmobile.ui.screens.patchopts.components.*
import com.meowarex.rlmobile.ui.screens.patchopts.*

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.BasicAlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.fromHtml
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions

/**
 * Confirms unlocking the package name field
 * (warning that a custom name blocks the listed patches/integrations from working)
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PackageNameUnlockDialog(
    blockedTitles: List<String>,
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
) {
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
                    text = stringResource(R.string.patchopts_pkgname_warning_title),
                    style = MaterialTheme.typography.titleLarge,
                )
                Text(
                    text = AnnotatedString.fromHtml(
                        stringResource(R.string.patchopts_pkgname_warning_msg, PatchOptions.Default.packageName),
                    ),
                    style = MaterialTheme.typography.bodyLarge,
                )
                if (blockedTitles.isNotEmpty()) {
                    Column(
                        verticalArrangement = Arrangement.spacedBy(2.dp),
                        modifier = Modifier.padding(start = 4.dp),
                    ) {
                        for (title in blockedTitles) {
                            Text(
                                text = "• $title",
                                style = MaterialTheme.typography.bodyLarge,
                                fontWeight = FontWeight.Bold,
                            )
                        }
                    }
                }
                Text(
                    text = stringResource(R.string.patchopts_pkgname_warning_permanent),
                    style = MaterialTheme.typography.bodyLarge,
                )
                Box(modifier = Modifier.fillMaxWidth()) {
                    Row(modifier = Modifier.align(Alignment.CenterEnd)) {
                        TextButton(onClick = onDismiss) {
                            Text(stringResource(R.string.action_cancel))
                        }
                        TextButton(onClick = onConfirm) {
                            Text(stringResource(R.string.action_continue))
                        }
                    }
                }
            }
        }
    }
}
