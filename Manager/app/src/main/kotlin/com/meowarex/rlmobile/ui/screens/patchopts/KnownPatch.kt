package com.meowarex.rlmobile.ui.screens.patchopts

import androidx.annotation.StringRes
import com.meowarex.rlmobile.R

enum class KnownPatch(
    /**
     * Numeric display order in the patch options list. Lower = higher up.
     *
     * Convention: main patches use multiples of 10 (10, 20, 30, …). Patches
     * that act as helpers/dependencies of a main patch get offsets adjacent to
     * the requirer (e.g. main at 40, helpers at 41, 42, 43). DebugMenuUnlock
     * is pinned to 100 to keep it at the bottom of the list.
     */
    val order: Int,
    val fileNames: List<String>,
    @StringRes val titleRes: Int,
    @StringRes val descRes: Int,
    val requires: List<KnownPatch> = emptyList(),
    val disables: List<KnownPatch> = emptyList(),
) {
    // Dependency-first order (later refs need backward resolution).
    // The `order` field controls display order; declaration order doesn't matter.
    LyricsDisableCover(
        order = 41,
        fileNames = listOf("lyrics-disable-cover.patch"),
        titleRes = R.string.patch_lyrics_disable_cover_title,
        descRes = R.string.patch_lyrics_disable_cover_desc,
    ),
    LyricsReplaceLyricsButton(
        order = 42,
        fileNames = listOf(
            "lyrics-replace-lyrics-button.patch",
            "lyrics-sparkle-conditional-visibility.patch",
        ),
        titleRes = R.string.patch_lyrics_replace_button_title,
        descRes = R.string.patch_lyrics_replace_button_desc,
    ),
    LyricsReplaceShareButton(
        order = 43,
        fileNames = listOf("lyrics-replace-share-button.patch"),
        titleRes = R.string.patch_lyrics_replace_share_button_title,
        descRes = R.string.patch_lyrics_replace_share_button_desc,
    ),
    LyricsRlApi(
        order = 20,
        fileNames = listOf(
            "lyrics-rl-api.patch",
            "lyrics-rl-api-observer.patch",
        ),
        titleRes = R.string.patch_lyrics_rl_api_title,
        descRes = R.string.patch_lyrics_rl_api_desc,
    ),
    LyricsKeepControlsVisible(
        order = 60,
        fileNames = listOf("lyrics-keep-controls-visible.patch"),
        titleRes = R.string.patch_lyrics_keep_controls_title,
        descRes = R.string.patch_lyrics_keep_controls_desc,
    ),
    PlayerBackdrop(
        order = 30,
        fileNames = listOf("player-backdrop.patch"),
        titleRes = R.string.patch_player_backdrop_title,
        descRes = R.string.patch_player_backdrop_desc,
    ),
    DebugMenuUnlock(
        order = 100,
        fileNames = listOf("debug-menu-unlock.patch"),
        titleRes = R.string.patch_debug_menu_unlock_title,
        descRes = R.string.patch_debug_menu_unlock_desc,
    ),
    LyricsProgressPill(
        order = 40,
        fileNames = listOf(
            "lyrics-progress-pill.patch",
            "lyrics-fade-region.patch",
        ),
        titleRes = R.string.patch_lyrics_progress_pill_title,
        descRes = R.string.patch_lyrics_progress_pill_desc,
        requires = listOf(LyricsDisableCover, LyricsReplaceLyricsButton, LyricsReplaceShareButton),
    ),
    EnableLegacyUi(
        order = 10,
        fileNames = listOf("enable-legacy-ui.patch"),
        titleRes = R.string.patch_enable_legacy_ui_title,
        descRes = R.string.patch_enable_legacy_ui_desc,
        requires = listOf(DebugMenuUnlock),
        disables = listOf(
            LyricsDisableCover,
            LyricsReplaceLyricsButton,
            LyricsReplaceShareButton,
            LyricsRlApi,
            LyricsKeepControlsVisible,
            PlayerBackdrop,
            LyricsProgressPill,
        ),
    );

    companion object {
        /**
         * Sorted by `order` ascending. Tie-breaks fall back to the first filename
         * (alphabetical) so the order is always deterministic.
         */
        val All: List<KnownPatch> = entries.sortedWith(
            compareBy({ it.order }, { it.fileNames.first() })
        )
    }
}
