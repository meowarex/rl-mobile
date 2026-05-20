package com.meowarex.rlmobile.ui.previews.screens.plugins

import android.content.res.Configuration
import androidx.compose.runtime.*
import androidx.compose.ui.tooling.preview.Preview
import com.meowarex.rlmobile.ui.screens.plugins.PluginsScreenContent
import com.meowarex.rlmobile.ui.theme.ManagerTheme
import com.meowarex.rlmobile.ui.util.emptyImmutableList

// This preview has interactable content that cannot be tested from an IDE preview

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun PluginsScreenFailedPreview() {
    val filterState = remember { mutableStateOf("") }

    ManagerTheme {
        PluginsScreenContent(
            searchText = filterState,
            setSearchText = filterState::value::set,
            isError = true,
            plugins = emptyImmutableList(),
            onPluginUninstall = {},
            onPluginChangelog = {},
            onPluginToggle = { name, enabled -> },
            safeMode = false,
            setSafeMode = {}
        )
    }
}
