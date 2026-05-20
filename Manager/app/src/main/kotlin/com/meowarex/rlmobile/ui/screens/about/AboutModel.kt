package com.meowarex.rlmobile.ui.screens.about

import android.util.Log
import cafe.adriel.voyager.core.model.StateScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.network.models.Contributor
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
import com.meowarex.rlmobile.network.utils.ApiResponse
import com.meowarex.rlmobile.ui.util.toUnsafeImmutable
import com.meowarex.rlmobile.util.launchIO
import kotlinx.collections.immutable.persistentListOf

class AboutModel(
    private val github: RadiantLyricsGithubService,
) : StateScreenModel<AboutScreenState>(AboutScreenState.Loading) {

    init {
        fetchContributors()
    }

    fun fetchContributors() = screenModelScope.launchIO {
        mutableState.value = AboutScreenState.Loading

        when (val result = github.getContributors()) {
            is ApiResponse.Success -> {
                val list = result.data
                    .filter { it.type == null || it.type == "User" }
                    .map { c ->
                        Contributor(
                            username = c.login,
                            avatarUrl = c.avatarUrl,
                            commits = c.contributions,
                            repositories = persistentListOf(),
                        )
                    }
                    .toUnsafeImmutable()
                mutableState.value = AboutScreenState.Loaded(list)
            }
            is ApiResponse.Error,
            is ApiResponse.Failure -> {
                Log.w(BuildConfig.TAG, "Failed to fetch contributors: $result")
                mutableState.value = AboutScreenState.Failure
            }
        }
    }
}
