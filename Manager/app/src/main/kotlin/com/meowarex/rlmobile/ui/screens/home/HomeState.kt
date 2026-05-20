package com.meowarex.rlmobile.ui.screens.home

import androidx.compose.runtime.Immutable

@Immutable
sealed interface HomeState {
    data object Loading : HomeState
    data class Loaded(
        val install: InstallData?,
        val latestTidalVersionCode: Int?,
    ) : HomeState
}
