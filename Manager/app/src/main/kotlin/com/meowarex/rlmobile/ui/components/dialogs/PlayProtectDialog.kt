package com.meowarex.rlmobile.ui.components.dialogs

import android.app.Activity
import android.content.Intent
import androidx.activity.compose.LocalActivity
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.navigator.currentOrThrow
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.*
import com.meowarex.rlmobile.ui.theme.customColors

@Composable
fun PlayProtectDialog(
    onDismiss: (neverShow: Boolean) -> Unit,
) {
    val activity = LocalActivity.currentOrThrow
    val interactionSource = remember(::MutableInteractionSource)
    var neverShow by rememberSaveable { mutableStateOf(false) }
    val rememberedNeverShow by rememberUpdatedState(neverShow)

    RadiantDialog(
        onDismissRequest = { onDismiss(rememberedNeverShow) },
        title = stringResource(R.string.play_protect_warning_title),
        icon = {
            Icon(
                painter = painterResource(R.drawable.ic_protect_warning),
                tint = MaterialTheme.customColors.warning,
                contentDescription = null,
                modifier = Modifier.size(28.dp),
            )
        },
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
            Text(stringResource(R.string.play_protect_warning_desc))

            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(12.dp),
                modifier = Modifier.clickable(
                    interactionSource = interactionSource,
                    indication = null,
                    onClick = { neverShow = !rememberedNeverShow },
                ),
            ) {
                RadiantCheckbox(
                    checked = neverShow,
                    onCheckedChange = { neverShow = it },
                )

                Text(stringResource(R.string.play_protect_warning_disable))
            }

            // Both actions are equal, they share a row
            Row(
                horizontalArrangement = Arrangement.spacedBy(10.dp, Alignment.End),
                modifier = Modifier.fillMaxWidth(),
            ) {
                RadiantButton(
                    text = stringResource(R.string.play_protect_warning_open_gpp),
                    onClick = activity::launchPlayProtect,
                    style = RadiantButtonStyle.Glass,
                    size = RadiantButtonSize.Small,
                )
                RadiantButton(
                    text = stringResource(R.string.play_protect_warning_ok),
                    onClick = { onDismiss(rememberedNeverShow) },
                    style = RadiantButtonStyle.Accent,
                    size = RadiantButtonSize.Small,
                )
            }
        }
    }
}

private fun Activity.launchPlayProtect() {
    Intent("com.google.android.gms.settings.VERIFY_APPS_SETTINGS")
        .setPackage("com.google.android.gms")
        .addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
        .also(::startActivity)
}
