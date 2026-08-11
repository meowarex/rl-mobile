package com.meowarex.rlmobile.ui.widgets.updater

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.DialogProperties
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonStyle
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog
import org.koin.androidx.compose.koinViewModel

@Composable
fun UpdaterDialog(
    viewModel: UpdaterViewModel = koinViewModel(),
) {
    if (!viewModel.showDialog) return

    val isWorking by viewModel.isWorking.collectAsState()
    val downloadProgress by viewModel.progress.collectAsState()
    val downloadInProgress by remember { derivedStateOf { downloadProgress != null } }

    RadiantDialog(
        onDismissRequest = {},
        title = stringResource(R.string.updater_title, viewModel.targetVersion ?: ""),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_update),
                contentDescription = null,
                modifier = Modifier.size(26.dp),
            )
        },
    ) {
        val uriHandler = LocalUriHandler.current

        Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
            Text(stringResource(R.string.updater_body))

            RadiantButton(
                text = stringResource(R.string.updater_open_github),
                onClick = { uriHandler.openUri(viewModel.targetReleaseUrl!!) },
                style = RadiantButtonStyle.Ghost,
                size = RadiantButtonSize.Small,
            )

            Row(
                horizontalArrangement = Arrangement.spacedBy(10.dp, Alignment.End),
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .padding(top = 10.dp)
                    .fillMaxWidth(),
            ) {
                RadiantButton(
                    text = stringResource(R.string.action_dismiss),
                    onClick = viewModel::dismissDialog,
                    enabled = !isWorking,
                    style = RadiantButtonStyle.Ghost,
                    size = RadiantButtonSize.Small,
                )

                // update is running the confirm button is replaced by the progress readout
                if (isWorking) {
                    if (downloadInProgress) {
                        CircularWavyProgressIndicator(
                            progress = { downloadProgress ?: 1f },
                            modifier = Modifier.size(34.dp),
                        )
                    } else {
                        CircularWavyProgressIndicator(modifier = Modifier.size(34.dp))
                    }
                } else {
                    RadiantButton(
                        text = stringResource(R.string.action_update),
                        onClick = viewModel::triggerUpdate,
                        style = RadiantButtonStyle.Accent,
                        size = RadiantButtonSize.Small,
                    )
                }
            }
        }
    }
}
