package com.meowarex.rlmobile.ui.previews.screens.about

import android.content.res.Configuration
import androidx.compose.runtime.*
import androidx.compose.ui.tooling.preview.Preview
import com.meowarex.rlmobile.ui.screens.about.AboutScreenContent
import com.meowarex.rlmobile.ui.screens.about.AboutScreenState
import com.meowarex.rlmobile.ui.theme.ManagerTheme

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun AboutScreenFailedPreview() {
    ManagerTheme {
        AboutScreenContent(
            state = remember { mutableStateOf(AboutScreenState.Failure) },
        )
    }
}
