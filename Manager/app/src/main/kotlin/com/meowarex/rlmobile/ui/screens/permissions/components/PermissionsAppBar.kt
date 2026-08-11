package com.meowarex.rlmobile.ui.screens.permissions.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.navigator.LocalNavigator
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton
import com.meowarex.rlmobile.ui.screens.settings.SettingsScreen

@Composable
fun PermissionsAppBar() {
    LargeFlexibleTopAppBar(
        title = { Text(stringResource(R.string.permissions_title)) },
        subtitle = { Text(stringResource(R.string.permissions_subtitle)) },
        actions = {
            val navigator = LocalNavigator.current

            RadiantIconButton(
                icon = painterResource(R.drawable.ic_settings),
                contentDescription = stringResource(R.string.navigation_settings),
                subtle = true,
                onClick = { navigator?.push(SettingsScreen()) },
            )
        }
    )
}
