package com.meowarex.rlmobile.ui.components

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.painter.Painter
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonStyle

@Composable
fun MainActionButton(
    text: String,
    icon: Painter,
    onClick: () -> Unit,
    enabled: Boolean = true,
    style: RadiantButtonStyle = RadiantButtonStyle.Accent,
    modifier: Modifier = Modifier,
) = RadiantButton(
    text = text,
    icon = icon,
    onClick = onClick,
    enabled = enabled,
    style = style,
    size = RadiantButtonSize.Large,
    fillWidth = true,
    modifier = modifier,
)

@Composable
fun DangerActionButton(
    text: String,
    icon: Painter,
    onClick: () -> Unit,
    enabled: Boolean = true,
    modifier: Modifier = Modifier,
) = RadiantButton(
    text = text,
    icon = icon,
    onClick = onClick,
    enabled = enabled,
    style = RadiantButtonStyle.Danger,
    size = RadiantButtonSize.Large,
    fillWidth = true,
    modifier = modifier,
)
