package com.meowarex.rlmobile.ui.screens.permissions.components

import androidx.compose.animation.animateColorAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonStyle
import com.meowarex.rlmobile.ui.theme.radiantSurface
import com.meowarex.rlmobile.ui.theme.customColors

/**
 * permission tiles
 */
@Composable
fun PermissionButton(
    name: String,
    description: String,
    granted: Boolean,
    required: Boolean,
    icon: Painter,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
) {
    val containerColor by animateColorAsState(
        targetValue = if (granted) {
            MaterialTheme.customColors.successContainer
        } else {
            MaterialTheme.colorScheme.surfaceContainerHigh
        },
        label = "PermissionIconContainer",
    )
    val contentColor by animateColorAsState(
        targetValue = if (granted) {
            MaterialTheme.customColors.onSuccessContainer
        } else {
            MaterialTheme.colorScheme.onSurfaceVariant
        },
        label = "PermissionIconContent",
    )

    Surface(
        color = Color.Transparent,
        shape = MaterialTheme.shapes.large,
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 4.dp)
            .radiantSurface(shape = MaterialTheme.shapes.large, active = granted),
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(14.dp),
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.padding(14.dp),
        ) {
            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier
                    .size(38.dp)
                    .clip(RoundedCornerShape(12.dp))
                    .background(containerColor),
            ) {
                Icon(
                    painter = if (granted) painterResource(R.drawable.ic_check_circle) else icon,
                    contentDescription = null,
                    tint = contentColor,
                    modifier = Modifier.size(19.dp),
                )
            }

            Column(
                verticalArrangement = Arrangement.spacedBy(3.dp),
                modifier = Modifier.weight(1f),
            ) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(4.dp),
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text(
                        text = name,
                        style = MaterialTheme.typography.titleSmall,
                    )

                    if (required) {
                        Text(
                            text = "＊",
                            style = MaterialTheme.typography.labelSmall,
                            color = MaterialTheme.colorScheme.error,
                        )
                    }
                }

                Text(
                    text = description,
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                )
            }

            RadiantButton(
                text = stringResource(
                    if (granted) R.string.permissions_granted else R.string.permissions_grant
                ),
                onClick = onClick,
                enabled = !granted,
                style = if (granted) RadiantButtonStyle.Ghost else RadiantButtonStyle.Accent,
                size = RadiantButtonSize.Small,
            )
        }
    }
}
