package com.meowarex.rlmobile.ui.screens.log.components

import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton
import com.meowarex.rlmobile.ui.components.BackButton

@Composable
fun LogAppBar(
    onExportLog: () -> Unit,
    onShareLog: () -> Unit,
) {
    TopAppBar(
        title = { Text(stringResource(R.string.log_title)) },
        navigationIcon = { BackButton() },
        actions = {
            RadiantIconButton(
                icon = painterResource(R.drawable.ic_save),
                contentDescription = stringResource(R.string.log_action_export),
                subtle = true,
                onClick = onExportLog,
            )
            RadiantIconButton(
                icon = painterResource(R.drawable.ic_share),
                contentDescription = stringResource(R.string.log_action_share),
                subtle = true,
                onClick = onShareLog,
            )
        },
    )
}
