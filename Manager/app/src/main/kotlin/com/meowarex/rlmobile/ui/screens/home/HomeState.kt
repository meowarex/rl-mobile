package com.meowarex.rlmobile.ui.screens.home

import androidx.compose.runtime.Immutable
import com.meowarex.rlmobile.ui.screens.patchopts.PatchChanges

@Immutable
sealed interface HomeState {
    data object Loading : HomeState
    data class Loaded(
        val install: InstallData?,
        val latestTidalVersionCode: Int?,
        val offline: Boolean = false,
        val offlineRepatchReady: Boolean = false,
        /** What the patch update adds, null until known */
        val patchChanges: PatchChanges? = null,
    ) : HomeState {
        val patchesBehind: Boolean get() = install != null && install.patchesUpToDate == false
        val tidalBehind: Boolean get() = install != null && install.tidalUpToDate == false

        /** Same gate as the main install button */
        fun canInstall(managerUpdateAvailable: Boolean): Boolean {
            val blockedByManagerUpdate = managerUpdateAvailable && (patchesBehind || tidalBehind)
            val canLocalRepatch = install != null && offlineRepatchReady
            val onlineEnabled = latestTidalVersionCode != null || install != null
            return !blockedByManagerUpdate && (if (offline) canLocalRepatch else onlineEnabled)
        }
    }
}
