package com.meowarex.rlmobile.ui.screens.about

import com.meowarex.rlmobile.network.models.Contributor
import kotlinx.collections.immutable.ImmutableList

sealed interface AboutScreenState {
    data object Loading : AboutScreenState
    data object Failure : AboutScreenState
    data class Loaded(val contributors: ImmutableList<Contributor>) : AboutScreenState
}
