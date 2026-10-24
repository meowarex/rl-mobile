package com.meowarex.rlmobile.patcher

import com.meowarex.rlmobile.network.utils.SemVer
import com.meowarex.rlmobile.ui.screens.patchopts.PatchCatalog
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import kotlinx.serialization.Serializable

@Serializable
data class InstallMetadata(
    val customManager: Boolean,
    val managerVersion: SemVer,
    val patchesVersion: SemVer,
    val options: PatchOptions,
    /** Patches + option keys at install, null on old installs */
    val patchCatalog: PatchCatalog? = null,
)
