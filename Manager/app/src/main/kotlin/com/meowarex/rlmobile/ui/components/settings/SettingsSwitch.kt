package com.meowarex.rlmobile.ui.components.settings

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.meowarex.rlmobile.ui.components.radiant.RadiantSwitch

@Composable
fun SettingsSwitch(
    label: String,
    secondaryLabel: String? = null,
    disabled: Boolean = false,
    icon: @Composable () -> Unit = {},
    pref: Boolean,
    position: GroupPosition = GroupPosition.Single,
    onPrefChange: (Boolean) -> Unit,
    modifier: Modifier = Modifier,
) {
    SettingsItem(
        modifier = modifier,
        position = position,
        onClick = if (disabled) null else ({ onPrefChange(!pref) }),
        text = { Text(text = label, softWrap = true) },
        icon = icon,
        secondaryText = {
            secondaryLabel?.let {
                Text(text = it)
            }
        }
    ) {
        RadiantSwitch(
            checked = pref,
            enabled = !disabled,
            onCheckedChange = { onPrefChange(!pref) }
        )
    }
}
