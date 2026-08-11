package com.meowarex.rlmobile.ui.screens.patching

import com.meowarex.rlmobile.ui.screens.patching.PatchingScreenState.CloseScreen

sealed interface PatchingScreenState {
    data object Working : PatchingScreenState
    data object Success : PatchingScreenState
    data class Failed(val installId: String) : PatchingScreenState
    data object CloseScreen : PatchingScreenState
}

val PatchingScreenState.isProgressChange: Boolean
    inline get() = this != CloseScreen

val PatchingScreenState.isFinished: Boolean
    // Was `isProgressChange || this == CloseScreen`, which expands to `x != CloseScreen ||
    // x == CloseScreen` — a tautology, so this was unconditionally true and the battery
    // optimisation banner it gates could never appear. (thx claude)
    inline get() = this is PatchingScreenState.Success || this is PatchingScreenState.Failed
