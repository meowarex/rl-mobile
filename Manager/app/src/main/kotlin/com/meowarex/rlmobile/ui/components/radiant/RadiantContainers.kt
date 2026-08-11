package com.meowarex.rlmobile.ui.components.radiant

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import com.meowarex.rlmobile.ui.theme.*

/**
 * The house card. (idk what a house card is, GPT 5.6 said it and i thought it was funny so i left it in everywhere)
 */
@Composable
fun RadiantCard(
    modifier: Modifier = Modifier,
    shape: Shape = RoundedCornerShape(24.dp),
    base: Color = MaterialTheme.colorScheme.surfaceContainerLow,
    active: Boolean = false,
    onClick: (() -> Unit)? = null,
    content: @Composable ColumnScope.() -> Unit,
) {
    if (radiantStyle.legacy) {
        // Material's own elevated card.
        ElevatedCard(
            shape = shape,
            modifier = modifier
                .then(if (onClick != null) Modifier.clickable(onClick = onClick) else Modifier),
            content = content,
        )
        return
    }

    Column(
        modifier = modifier
            .radiantSurface(shape = shape, base = base, active = active)
            .clip(shape)
            .then(if (onClick != null) Modifier.clickable(onClick = onClick) else Modifier),
        content = content,
    )
}

/**
 * Dialog shell.
 */
@Composable
fun RadiantDialog(
    onDismissRequest: () -> Unit,
    title: String,
    modifier: Modifier = Modifier,
    icon: @Composable (() -> Unit)? = null,
    confirmText: String? = null,
    onConfirm: (() -> Unit)? = null,
    confirmEnabled: Boolean = true,
    dismissText: String? = null,
    onDismissAction: (() -> Unit)? = null,
    destructive: Boolean = false,
    content: @Composable ColumnScope.() -> Unit,
) {
    val shape = RoundedCornerShape(30.dp)

    if (radiantStyle.legacy) {
        AlertDialog(
            onDismissRequest = onDismissRequest,
            icon = icon,
            title = { Text(title) },
            text = { Column(content = content) },
            confirmButton = {
                if (confirmText != null) {
                    TextButton(
                        onClick = onConfirm ?: onDismissRequest,
                        enabled = confirmEnabled,
                    ) { Text(confirmText) }
                }
            },
            dismissButton = dismissText?.let {
                {
                    TextButton(onClick = onDismissAction ?: onDismissRequest) { Text(it) }
                }
            },
            modifier = modifier,
        )
        return
    }

    Dialog(onDismissRequest = onDismissRequest) {
        Column(
            modifier = modifier
                .fillMaxWidth()
                .radiantSurface(
                    shape = shape,
                    base = MaterialTheme.colorScheme.surfaceContainer,
                )
                .clip(shape)
                .padding(24.dp),
        ) {
            if (icon != null) {
                Box(
                    contentAlignment = Alignment.Center,
                    modifier = Modifier
                        .padding(bottom = 14.dp)
                        .size(44.dp)
                        .clip(RoundedCornerShape(15.dp))
                        .glassSurface(RoundedCornerShape(15.dp)),
                ) {
                    CompositionLocalProvider(
                        LocalContentColor provides MaterialTheme.colorScheme.primary,
                    ) { icon() }
                }
            }

            Text(
                text = title,
                style = MaterialTheme.typography.headlineSmall,
                color = MaterialTheme.colorScheme.onSurface,
                modifier = Modifier.padding(bottom = 10.dp),
            )

            CompositionLocalProvider(
                LocalContentColor provides MaterialTheme.colorScheme.onSurfaceVariant,
            ) {
                ProvideTextStyle(MaterialTheme.typography.bodyMedium) {
                    content()
                }
            }

            if (confirmText != null || dismissText != null) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(10.dp, Alignment.End),
                    verticalAlignment = Alignment.CenterVertically,
                    modifier = Modifier
                        .padding(top = 22.dp)
                        .fillMaxWidth(),
                ) {
                    if (dismissText != null) {
                        RadiantButton(
                            text = dismissText,
                            onClick = onDismissAction ?: onDismissRequest,
                            style = RadiantButtonStyle.Ghost,
                            size = RadiantButtonSize.Small,
                        )
                    }
                    if (confirmText != null) {
                        RadiantButton(
                            text = confirmText,
                            onClick = onConfirm ?: onDismissRequest,
                            enabled = confirmEnabled,
                            style = if (destructive) {
                                RadiantButtonStyle.Danger
                            } else {
                                RadiantButtonStyle.Accent
                            },
                            size = RadiantButtonSize.Small,
                        )
                    }
                }
            }
        }
    }
}

/**
 * Section rule. (short accent segment fading into a hairline)
 */
@Composable
fun RadiantDivider(
    modifier: Modifier = Modifier,
) {
    HorizontalDivider(
        thickness = RadiantDesign.Hairline,
        color = MaterialTheme.colorScheme.onSurface.copy(alpha = RadiantDesign.BORDER_ALPHA * 1.4f),
        modifier = modifier,
    )
}
