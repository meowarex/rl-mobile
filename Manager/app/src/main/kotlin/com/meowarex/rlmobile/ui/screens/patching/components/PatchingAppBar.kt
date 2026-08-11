package com.meowarex.rlmobile.ui.screens.patching.components

import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton

@Composable
fun PatchingAppBar(
    onBack: () -> Unit,
) {
    TopAppBar(
        title = { Text(stringResource(R.string.installer)) },
        navigationIcon = {
            RadiantIconButton(
                icon = painterResource(R.drawable.ic_back),
                contentDescription = stringResource(R.string.navigation_back),
                subtle = true,
                onClick = onBack,
            )
        }
    )
}
