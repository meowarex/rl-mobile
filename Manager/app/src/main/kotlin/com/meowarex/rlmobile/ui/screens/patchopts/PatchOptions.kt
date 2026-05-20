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

    /**
     * A custom build of injector that was used rather than the latest.
     */
    val customInjector: PatchComponent? = null,

    /**
     * A custom smali patches bundle that was used rather than the latest.
     */
    val customPatches: PatchComponent? = null,
) : Parcelable {
    companion object {
        val Default = PatchOptions(
            appName = "TIDAL",
            packageName = "com.tidal.music",
            debuggable = false,
            customInjector = null,
            customPatches = null,
        )
    }
}
