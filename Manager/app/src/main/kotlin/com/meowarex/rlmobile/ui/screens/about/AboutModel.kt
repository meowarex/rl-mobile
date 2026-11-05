package com.meowarex.rlmobile.ui.screens.about

import android.util.Log
import cafe.adriel.voyager.core.model.StateScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.network.services.RLReleasesService
import com.meowarex.rlmobile.network.utils.ApiResponse
import com.meowarex.rlmobile.ui.util.toUnsafeImmutable
import com.meowarex.rlmobile.util.launchIO

class AboutModel(
    private val releases: RLReleasesService,
) : StateScreenModel<AboutScreenState>(AboutScreenState.Loading) {

    init {
        fetchContributors()
    }

    fun fetchContributors() = screenModelScope.launchIO {
        mutableState.value = AboutScreenState.Loading

        when (val result = releases.getContributors()) {
            is ApiResponse.Success ->
                mutableState.value = AboutScreenState.Loaded(result.data.toUnsafeImmutable())

            is ApiResponse.Error,
            is ApiResponse.Failure -> {
                Log.w(BuildConfig.TAG, "Failed to fetch contributors: $result")
                mutableState.value = AboutScreenState.Failure
            }
        }
    }
}
