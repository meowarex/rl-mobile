package com.meowarex.rlmobile.ui.components.settings

import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.ui.components.TextDivider

@Composable
fun SettingsHeader(
    text: String,
) {
    TextDivider(
        text = text,
        modifier = Modifier.padding(start = 20.dp, end = 20.dp, top = 26.dp, bottom = 12.dp),
    )
}
