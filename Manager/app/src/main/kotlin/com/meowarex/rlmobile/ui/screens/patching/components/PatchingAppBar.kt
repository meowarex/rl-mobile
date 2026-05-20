package com.meowarex.rlmobile.ui.screens.patching.components

import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R

@Composable
fun PatchingAppBar(
    onBack: () -> Unit,
) {
    TopAppBar(
        title = { Text(stringResource(R.string.installer)) },
        navigationIcon = {
            IconButton(onClick = onBack) {
                Icon(
                    painter = painterResource(R.drawable.ic_back),
                    contentDescription = stringResource(R.string.navigation_back),
                )
            }
        }
    )
}
