package com.meowarex.rlmobile.ui.previews.screens

import android.content.res.Configuration
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.*
import com.meowarex.rlmobile.network.utils.SemVer
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import com.meowarex.rlmobile.ui.screens.patchopts.*
import com.meowarex.rlmobile.ui.theme.ManagerTheme
import kotlin.time.Clock

// This preview has scrollable/interactable content that cannot be tested from an IDE preview

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun PatchOptionsScreenPreview(
    @PreviewParameter(PatchOptionsParametersProvider::class)
    parameters: PatchOptionsParameters,
) {
    ManagerTheme {
        PatchOptionsScreenContent(
            isUpdate = parameters.isUpdate,
            isDevMode = parameters.isDevMode,
            debuggable = parameters.debuggable,
            setDebuggable = {},
            appName = parameters.appName,
            appNameIsError = parameters.appNameIsError,
            setAppName = {},
            packageName = parameters.packageName,
            packageNameState = parameters.packageNameState,
            setPackageName = {},
            customTidalApk = parameters.customTidalApk,
            onSelectCustomTidalApk = {},
            customPatches = parameters.customPatches,
            onSelectCustomPatches = {},
            enabledPatchCount = KnownPatch.All.size,
            isPatchEnabled = { true },
            onTogglePatch = { _, _ -> },
            isConfigValid = parameters.isConfigValid,
            onInstall = {},
        )
    }
}

private data class PatchOptionsParameters(
    val isUpdate: Boolean,
    val isDevMode: Boolean,
    val debuggable: Boolean,
    val appName: String,
    val appNameIsError: Boolean,
    val packageName: String,
    val packageNameState: PackageNameState,
    val customTidalApk: PatchComponent?,
    val customPatches: PatchComponent?,
    val isConfigValid: Boolean,
)

private class PatchOptionsParametersProvider : PreviewParameterProvider<PatchOptionsParameters> {
    override val values = sequenceOf(
        PatchOptionsParameters(
            isUpdate = false,
            isDevMode = false,
            debuggable = false,
            appName = PatchOptions.Default.appName,
            appNameIsError = false,
            packageName = PatchOptions.Default.packageName,
            packageNameState = PackageNameState.Ok,
            customTidalApk = null,
            customPatches = null,
            isConfigValid = true,
        ),
        PatchOptionsParameters(
            isUpdate = true,
            isDevMode = false,
            debuggable = false,
            appName = "an invalid app name.",
            appNameIsError = true,
            packageName = "a b",
            packageNameState = PackageNameState.Invalid,
            customTidalApk = null,
            customPatches = null,
            isConfigValid = false,
        ),
        PatchOptionsParameters(
            isUpdate = false,
            isDevMode = true,
            debuggable = true,
            appName = PatchOptions.Default.appName,
            appNameIsError = false,
            packageName = PatchOptions.Default.packageName,
            packageNameState = PackageNameState.Taken,
            customTidalApk = PatchComponent(
                type = PatchComponent.Type.TidalApk,
                version = SemVer(1, 2, 3),
                timestamp = Clock.System.now(),
            ),
            customPatches = null,
            isConfigValid = true,
        ),
    )
}
