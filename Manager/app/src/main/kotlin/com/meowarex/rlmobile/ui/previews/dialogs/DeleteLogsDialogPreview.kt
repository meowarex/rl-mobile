package com.meowarex.rlmobile.ui.previews.dialogs

import android.content.res.Configuration
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import com.meowarex.rlmobile.ui.screens.logs.components.dialogs.DeleteLogsDialog
import com.meowarex.rlmobile.ui.theme.ManagerTheme

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun DeleteLogsDialogPreview() {
    ManagerTheme {
        DeleteLogsDialog(
            onConfirm = {},
            onDismiss = {},
        )
    }
}
