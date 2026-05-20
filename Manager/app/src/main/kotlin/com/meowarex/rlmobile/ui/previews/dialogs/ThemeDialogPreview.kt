package com.meowarex.rlmobile.ui.previews.dialogs

import android.content.res.Configuration
import androidx.compose.runtime.*
import androidx.compose.ui.tooling.preview.Preview
import com.meowarex.rlmobile.ui.screens.settings.components.ThemeDialog
import com.meowarex.rlmobile.ui.theme.ManagerTheme
import com.meowarex.rlmobile.ui.theme.Theme

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun ThemeDialogPreview() {
    val (theme, setTheme) = remember { mutableStateOf(Theme.System) }

    ManagerTheme {
        ThemeDialog(
            currentTheme = theme,
            onDismiss = {},
            onConfirm = setTheme,
        )
    }
}
