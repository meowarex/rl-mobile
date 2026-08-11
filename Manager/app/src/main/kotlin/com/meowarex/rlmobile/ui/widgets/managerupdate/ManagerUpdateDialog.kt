package com.meowarex.rlmobile.ui.widgets.managerupdate

import androidx.annotation.DrawableRes
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.DialogProperties
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantDialog
import com.meowarex.rlmobile.ui.components.Tag

data class VersionDelta(
    val label: String,
    @DrawableRes val iconRes: Int,
    val from: String?,
    val to: String,
    val tag: String? = null,
)

@Composable
fun ManagerUpdateDialog(
    deltas: List<VersionDelta>,
    onDismiss: () -> Unit,
) {
    RadiantDialog(
        onDismissRequest = onDismiss,
        title = stringResource(R.string.manager_update_title),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_update),
                contentDescription = null,
                modifier = Modifier.size(26.dp),
            )
        },
        confirmText = stringResource(R.string.action_continue),
        onConfirm = onDismiss,
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text(stringResource(R.string.manager_update_subtitle))

            Column(
                verticalArrangement = Arrangement.spacedBy(8.dp),
                modifier = Modifier.fillMaxWidth(),
            ) {
                deltas.forEach { delta ->
                    DeltaCard(delta = delta)
                }
            }
        }
    }
}

@Composable
private fun DeltaCard(delta: VersionDelta) {
    val changed = delta.from != null && delta.from != delta.to
    val subtitle = when {
        delta.from == null || delta.from == delta.to -> delta.to
        else -> "${delta.from} → ${delta.to}"
    }

    Surface(
        color = MaterialTheme.colorScheme.surfaceContainerHigh,
        shape = RoundedCornerShape(16.dp),
        modifier = Modifier.fillMaxWidth(),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(14.dp),
            modifier = Modifier.padding(horizontal = 14.dp, vertical = 12.dp),
        ) {
            DeltaIcon(delta)
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = delta.label,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold,
                )
                Text(
                    text = subtitle,
                    style = MaterialTheme.typography.bodyMedium,
                    color = if (changed) MaterialTheme.colorScheme.primary
                    else LocalContentColor.current.copy(alpha = 0.65f),
                    fontWeight = if (changed) FontWeight.SemiBold else FontWeight.Normal,
                )
            }
            delta.tag?.let { Tag(text = it) }
        }
    }
}

@Composable
private fun DeltaIcon(delta: VersionDelta) {
    Surface(
        shape = CircleShape,
        color = MaterialTheme.colorScheme.secondaryContainer,
        modifier = Modifier.size(40.dp),
    ) {
        Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
            Icon(
                painter = painterResource(delta.iconRes),
                contentDescription = null,
                tint = MaterialTheme.colorScheme.onSecondaryContainer,
                modifier = Modifier.size(22.dp),
            )
        }
    }
}
