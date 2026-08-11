package com.meowarex.rlmobile.ui.screens.settings.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog
import com.meowarex.rlmobile.ui.components.radiant.RadiantRadio
import com.meowarex.rlmobile.ui.theme.Theme
import com.meowarex.rlmobile.ui.theme.radiantSurface

@Composable
fun ThemeDialog(
    currentTheme: Theme,
    onDismiss: () -> Unit,
    onConfirm: (Theme) -> Unit,
) {
    var selectedTheme by rememberSaveable { mutableStateOf(currentTheme) }

    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.setting_theme),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_brush),
                contentDescription = null,
                modifier = Modifier.size(26.dp),
            )
        },
        confirmText = stringResource(R.string.action_apply),
        onConfirm = {
            onConfirm(selectedTheme)
            onDismiss()
        },
        dismissText = stringResource(R.string.action_cancel),
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
            for (theme in Theme.entries) key(theme) {
                val interactionSource = remember(::MutableInteractionSource)
                val selected = theme == selectedTheme
                val shape = RoundedCornerShape(16.dp)

                // The whole row is the target and lights up when chosen (accessibility.. yayy)
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(14.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .radiantSurface(shape = shape, active = selected)
                        .clip(shape)
                        .clickable(
                            indication = null,
                            interactionSource = interactionSource,
                            onClick = { selectedTheme = theme },
                        )
                        .padding(horizontal = 14.dp, vertical = 12.dp),
                ) {
                    Icon(
                        painter = theme.toPainter(),
                        contentDescription = null,
                        tint = if (selected) {
                            MaterialTheme.colorScheme.primary
                        } else {
                            MaterialTheme.colorScheme.onSurfaceVariant
                        },
                        modifier = Modifier.size(24.dp),
                    )

                    Text(
                        text = theme.toDisplayName(),
                        style = MaterialTheme.typography.titleSmall,
                        color = MaterialTheme.colorScheme.onSurface,
                        modifier = Modifier.weight(1f),
                    )

                    RadiantRadio(
                        selected = selected,
                        onClick = { selectedTheme = theme },
                        interactionSource = interactionSource,
                    )
                }
            }
        }
    }
}
