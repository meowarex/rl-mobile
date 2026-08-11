package com.meowarex.rlmobile.ui.components

import androidx.compose.animation.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton

@Composable
fun ResetToDefaultButton(
    enabled: Boolean,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
) {
    AnimatedVisibility(
        visible = enabled,
        enter = fadeIn() + slideInHorizontally(),
        exit = fadeOut() + slideOutHorizontally(),
        modifier = modifier,
    ) {
        RadiantIconButton(
            icon = painterResource(R.drawable.ic_refresh),
            contentDescription = stringResource(R.string.action_reset_default),
            tint = MaterialTheme.colorScheme.secondary,
            subtle = true,
            onClick = onClick,
        )
    }
}
