package com.meowarex.rlmobile.ui.screens.about

import cafe.adriel.voyager.core.model.StateScreenModel
import com.meowarex.rlmobile.network.models.Contributor
import com.meowarex.rlmobile.network.services.HttpService
import com.meowarex.rlmobile.ui.util.toUnsafeImmutable

class AboutModel(
    @Suppress("unused") private val http: HttpService,
) : StateScreenModel<AboutScreenState>(
    AboutScreenState.Loaded(emptyList<Contributor>().toUnsafeImmutable())
) {
    fun fetchContributors() = Unit
}
