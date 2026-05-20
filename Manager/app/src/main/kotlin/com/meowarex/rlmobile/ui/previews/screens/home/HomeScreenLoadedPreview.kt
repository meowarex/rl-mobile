package com.meowarex.rlmobile.ui.previews.screens.home

import android.content.res.Configuration
import android.graphics.BitmapFactory
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.painter.BitmapPainter
import androidx.compose.ui.tooling.preview.*
import com.meowarex.rlmobile.ui.screens.home.*
import com.meowarex.rlmobile.ui.screens.home.components.HomeAppBar
import com.meowarex.rlmobile.ui.theme.ManagerTheme
import com.meowarex.rlmobile.ui.util.TidalVersion
import kotlinx.collections.immutable.persistentListOf
import kotlin.io.encoding.Base64

// This preview has animations that cannot be properly viewed from an IDE preview

@Composable
@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)
@Preview(uiMode = Configuration.UI_MODE_NIGHT_NO)
private fun HomeScreenLoadedPreview(
    @PreviewParameter(HomeScreenParametersProvider::class)
    state: InstallsState.Fetched,
) {
    ManagerTheme {
        Scaffold(
            topBar = { HomeAppBar() },
        ) { padding ->
            HomeScreenLoadedContent(
                state = state,
                padding = padding,
                onClickInstall = {},
                onUpdate = {},
                onOpenApp = {},
                onOpenAppInfo = {},
                onOpenPlugins = {},
            )
        }
    }
}

private class HomeScreenParametersProvider : PreviewParameterProvider<InstallsState.Fetched> {
    private val stableVersion = TidalVersion.Existing(TidalVersion.Type.STABLE, "126.21", 126021)
    private val radiantIconBytes = Base64.decode(
        "/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAKBueIx4ZKCMgoy0qqC+8P//8Nzc8P//////////////////////////////////////////////////////////2wBDAaq0tPDS8P//////////////////////////////////////////////////////////////////////////////wAARCAC9AL0DASIAAhEBAxEB/8QAFwABAQEBAAAAAAAAAAAAAAAAAAIDAf/EACIQAQEAAgEFAAIDAAAAAAAAAAABAhEhAxIxQVETMiJhcf/EABcBAQEBAQAAAAAAAAAAAAAAAAABAgP/xAAZEQEBAQEBAQAAAAAAAAAAAAAAARECEjH/2gAMAwEAAhEDEQA/AMsce7/Gkkngk1NOoxboAIAAAAAAAAAAAAAAAAAAm4ys7NXVbJyx2LKoAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHZLfRcbJug4AABJugDtxs9OAAAAAAAAAAAAAA7jN0HccN81cxk9OityBZuaAVP459OyKBMifxwxw1dqAyBrYCpuEvhFmq1TnNwZsZgIyAAAAAAAANcJqM8ZutRrkAVoAAAAAAAAABnnNVLTObjNGKACAAAAAAL6c9rcxmsY6rcALdTYrlyk8kzlZeRGPTYThdzSlbC2TyMsruiW4vvimK+nedIkqwFaGN4rZnnP5DPSQEZAAAAAJ5BtPACug5n+tdAYi8sL6cmFqOeO9P2sk1NCtwYtk5Yb5gljNWH7Odt+NMce2IkjoCtiOp6WjqeIJfiAEYAAAACeYANgllnAroA5lbJxAdEzOe+FblDQAAAAcuUntyZW3iCaoAUT1PEUjOy8CX4gBGAAAAAACWzw0mf1mBLjYZS2eFTqfVa9O9TWv7Zu27u3EZtd7r9O/L64Brvdfrm79AHZ55asVY56mhZWjlykRc7Ui3pWWdqQGQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHMbuOsZbLw0xy2LYoAQAAAAAAAAAAAAAAAAAARnlzqGWdnEQNSP/2Q=="
    )
    private val radiantIcon = BitmapFactory
        .decodeByteArray(radiantIconBytes, 0, radiantIconBytes.size)
        .asImageBitmap()
        .let(::BitmapPainter)

    override val values = sequenceOf(
        InstallsState.Fetched(
            persistentListOf(
                InstallData(
                    name = "Radiant Lyrics",
                    packageName = "com.radiantLyrics",
                    version = stableVersion,
                    icon = radiantIcon,
                    isUpToDate = true,
                )
            )
        ),
        InstallsState.Fetched(
            persistentListOf(
                InstallData(
                    name = "Tidal",
                    packageName = "com.tidal",
                    version = stableVersion,
                    icon = radiantIcon,
                    isUpToDate = false,
                )
            )
        ),
    )
}
