package com.meowarex.rlmobile.ui.previews.screens.home

import android.content.res.Configuration
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import com.meowarex.rlmobile.ui.screens.home.HomeScreenFailureContent
import com.meowarex.rlmobile.ui.screens.home.components.HomeAppBar
import com.meowarex.rlmobile.ui.theme.ManagerTheme

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun HomeScreenFailedPreview() {
    ManagerTheme {
        Scaffold(
            topBar = { HomeAppBar() },
        ) { padding ->
            HomeScreenFailureContent(padding = padding)
        }
    }
}
