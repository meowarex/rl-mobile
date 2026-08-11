package com.meowarex.rlmobile.ui.components.settings

import androidx.compose.foundation.layout.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.ui.components.radiant.RadiantTextField

@Composable
fun SettingsTextField(
    label: String,
    disabled: Boolean = false,
    pref: String,
    error: Boolean = false,
    onPrefChange: (String) -> Unit,
) {
    Column(
        verticalArrangement = Arrangement.spacedBy(6.dp),
        modifier = Modifier.padding(horizontal = 18.dp, vertical = 10.dp),
    ) {
        // Label sits above the field rather than notching into its border.
        Text(
            text = label,
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
        )
        RadiantTextField(
            value = pref,
            onValueChange = onPrefChange,
            enabled = !disabled,
            isError = error,
        )
    }
}
