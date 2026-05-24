package com.meowarex.rlmobile.ui.screens.patchopts

import android.os.Parcelable
import androidx.compose.runtime.Immutable
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import kotlinx.parcelize.Parcelize
import kotlinx.serialization.Serializable

@Immutable
@Parcelize
@Serializable
data class PatchOptions(
    /**
     * The app name that's user-facing in launchers.
     */
    val appName: String,

    /**
     * Changes the installation package name.
     */
    val packageName: String,

    /**
     * Adding the debuggable APK flag.
     */
    val debuggable: Boolean,

    val customTidalApk: PatchComponent? = null,

    /**
     * A custom smali patches bundle that was used rather than the latest.
     */
    val customPatches: PatchComponent? = null,

    val disabledPatches: Set<String> = emptySet(),
) : Parcelable {
    companion object {
        val Default = PatchOptions(
            appName = "TIDAL",
            packageName = "com.aspiro.tidal",
            debuggable = false,
            customTidalApk = null,
            customPatches = null,
            disabledPatches = (KnownPatch.DebugMenuUnlock.fileNames + KnownPatch.EnableLegacyUi.fileNames).toSet(),
        )
    }
}
