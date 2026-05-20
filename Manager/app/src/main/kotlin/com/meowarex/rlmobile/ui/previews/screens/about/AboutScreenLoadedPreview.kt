package com.meowarex.rlmobile.ui.previews.screens.about

import android.content.res.Configuration
import androidx.compose.runtime.*
import androidx.compose.ui.tooling.preview.*
import com.meowarex.rlmobile.network.models.Contributor
import com.meowarex.rlmobile.ui.screens.about.AboutScreenContent
import com.meowarex.rlmobile.ui.screens.about.AboutScreenState
import com.meowarex.rlmobile.ui.theme.ManagerTheme
import com.meowarex.rlmobile.ui.util.emptyImmutableList
import com.meowarex.rlmobile.util.serialization.ImmutableListSerializer
import kotlinx.collections.immutable.*
import kotlinx.serialization.json.Json

// This preview has scrollable content that cannot be properly viewed from an IDE preview

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun AboutScreenLoadedPreview(
    @PreviewParameter(ContributorsProvider::class)
    contributors: ImmutableList<Contributor>,
) {
    ManagerTheme {
        AboutScreenContent(
            state = remember { mutableStateOf(AboutScreenState.Loaded(contributors)) },
        )
    }
}

private class ContributorsProvider : PreviewParameterProvider<ImmutableList<Contributor>> {
    @Suppress("unused")
    private val realDataRaw =
        "[{\"username\":\"meowarex\",\"avatarUrl\":\"https://avatars.githubusercontent.com/u/0?v=4\",\"commits\":1,\"repositories\":[{\"name\":\"Radiant Lyrics\",\"commits\":1}]}]"
    private val realData = Json.decodeFromString(ImmutableListSerializer(Contributor.serializer()), realDataRaw)

    override val values = sequenceOf(
        emptyImmutableList<Contributor>(),
        persistentListOf(
            Contributor(
                username = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz",
                avatarUrl = "UNUSED",
                commits = Int.MAX_VALUE,
                repositories = (realData[0].repositories + realData[0].repositories).toImmutableList(),
            )
        ),
        realData,
    )
}
