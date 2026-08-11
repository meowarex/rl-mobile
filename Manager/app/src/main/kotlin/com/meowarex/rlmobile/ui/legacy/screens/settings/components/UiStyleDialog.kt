package com.meowarex.rlmobile.ui.legacy.screens.settings.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.theme.UiStyle

/**
 * The Legacy counterpart of the UI style picker
 *
 * Without this you are stuck in legacy style for literally ever, like until the aliens find us. ever..
 */
@Composable
fun UiStyleDialog(
    current: UiStyle,
    onDismiss: () -> Unit,
    onConfirm: (UiStyle) -> Unit,
) {
    var selected by rememberSaveable { mutableStateOf(current) }

    AlertDialog(
        onDismissRequest = onDismiss,
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_sparkle),
                contentDescription = null,
                modifier = Modifier.size(32.dp),
            )
        },
        title = { Text(stringResource(R.string.setting_ui_style)) },
        text = {
            Column {
                for (style in UiStyle.entries) key(style) {
                    val interactionSource = remember(::MutableInteractionSource)

                    Row(
                        verticalAlignment = Alignment.CenterVertically,
                        modifier = Modifier
                            .clickable(
                                indication = null,
                                interactionSource = interactionSource,
                                onClick = { selected = style },
                            )
                            .clip(MaterialTheme.shapes.medium)
                            .padding(horizontal = 6.dp, vertical = 8.dp),
                    ) {
                        Icon(
                            painter = style.toPainter(),
                            contentDescription = null,
                            modifier = Modifier
                                .padding(end = 14.dp)
                                .size(26.dp),
                        )

                        Text(
                            text = style.toDisplayName(),
                            style = MaterialTheme.typography.labelLarge.copy(fontSize = 14.sp),
                        )

                        Spacer(Modifier.weight(1f, true))

                        RadioButton(
                            selected = style == selected,
                            onClick = { selected = style },
                            interactionSource = interactionSource,
                        )
                    }
                }
            }
        },
        confirmButton = {
            Button(
                onClick = {
                    onConfirm(selected)
                    onDismiss()
                },
            ) {
                Text(stringResource(R.string.action_apply))
            }
        },
    )
}
