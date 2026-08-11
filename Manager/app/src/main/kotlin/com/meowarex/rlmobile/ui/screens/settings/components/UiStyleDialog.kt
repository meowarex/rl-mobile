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
import com.meowarex.rlmobile.ui.theme.UiStyle
import com.meowarex.rlmobile.ui.theme.radiantSurface

@Composable
fun UiStyleDialog(
    current: UiStyle,
    onDismiss: () -> Unit,
    onConfirm: (UiStyle) -> Unit,
) {
    var selected by rememberSaveable { mutableStateOf(current) }

    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.setting_ui_style),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_sparkle),
                contentDescription = null,
                modifier = Modifier.size(26.dp),
            )
        },
        confirmText = stringResource(R.string.action_apply),
        onConfirm = {
            onConfirm(selected)
            onDismiss()
        },
        dismissText = stringResource(R.string.action_cancel),
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
            for (style in UiStyle.entries) key(style) {
                val interactionSource = remember(::MutableInteractionSource)
                val isSelected = style == selected
                val shape = RoundedCornerShape(16.dp)

                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(14.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .radiantSurface(shape = shape, active = isSelected)
                        .clip(shape)
                        .clickable(
                            indication = null,
                            interactionSource = interactionSource,
                            onClick = { selected = style },
                        )
                        .padding(horizontal = 14.dp, vertical = 12.dp),
                ) {
                    Icon(
                        painter = style.toPainter(),
                        contentDescription = null,
                        tint = if (isSelected) {
                            MaterialTheme.colorScheme.primary
                        } else {
                            MaterialTheme.colorScheme.onSurfaceVariant
                        },
                        modifier = Modifier.size(24.dp),
                    )

                    Text(
                        text = style.toDisplayName(),
                        style = MaterialTheme.typography.titleSmall,
                        color = MaterialTheme.colorScheme.onSurface,
                        modifier = Modifier.weight(1f),
                    )

                    RadiantRadio(
                        selected = isSelected,
                        onClick = { selected = style },
                        interactionSource = interactionSource,
                    )
                }
            }
        }
    }
}
