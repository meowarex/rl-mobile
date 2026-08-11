package com.meowarex.rlmobile.ui.components.settings

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.ui.theme.accentBrush
import com.meowarex.rlmobile.ui.theme.glow
import com.meowarex.rlmobile.ui.theme.radiantStyle
import com.meowarex.rlmobile.ui.theme.radiantSurface

/**
 * A settings row rendered as a tile on the house surface.
 */
@Composable
fun SettingsItem(
    text: @Composable () -> Unit,
    secondaryText: @Composable (() -> Unit) = { },
    icon: @Composable (() -> Unit) = { },
    position: GroupPosition = GroupPosition.Single,
    onClick: (() -> Unit)? = null,
    modifier: Modifier = Modifier,
    trailing: @Composable (() -> Unit) = { },
) {
    val ui = radiantStyle
    val iconShape = RoundedCornerShape(12.dp)

    Row(
        modifier = modifier
            .fillMaxWidth()
            // Legacy rows are flat and full bleed with no tile background or grouping. (because i'm lazy)
            .then(
                if (ui.groupedSettings) {
                    Modifier
                        .radiantSurface(shape = position.shape)
                        .clip(position.shape)
                } else Modifier
            )
            .then(if (onClick != null) Modifier.clickable(onClick = onClick) else Modifier)
            .heightIn(min = 64.dp)
            .padding(
                horizontal = if (ui.groupedSettings) 16.dp else 32.dp,
                vertical = if (ui.groupedSettings) 14.dp else 12.dp,
            ),
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        if (ui.groupedSettings) {
            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier
                    .glow(radius = 10.dp, shape = iconShape, alpha = 0.35f)
                    .size(36.dp)
                    .clip(iconShape)
                    .background(accentBrush, iconShape),
            ) {
                CompositionLocalProvider(
                    LocalContentColor provides MaterialTheme.colorScheme.onPrimary,
                ) {
                    Box(Modifier.size(20.dp)) { icon() }
                }
            }
        } else {
            Box(Modifier.size(20.dp)) { icon() }
        }

        Column(
            verticalArrangement = Arrangement.spacedBy(3.dp),
            modifier = Modifier.weight(1f),
        ) {
            ProvideTextStyle(MaterialTheme.typography.titleSmall) {
                text()
            }

            ProvideTextStyle(
                MaterialTheme.typography.bodySmall.copy(
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                )
            ) {
                secondaryText()
            }
        }

        trailing()
    }
}
