package com.meowarex.rlmobile.ui.theme

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R

/**
 * Which visual language the app renders in (UI Style not Theme)
 */
enum class UiStyle {
    /** The current design */
    Radiant,

    /** Compose replica of the pre-redesign stock Material 3 look */
    Legacy;

    @Composable
    fun toDisplayName() = stringResource(
        when (this) {
            Radiant -> R.string.ui_style_radiant
            Legacy -> R.string.ui_style_legacy
        }
    )

    @Composable
    fun toPainter() = painterResource(
        when (this) {
            Radiant -> R.drawable.ic_sparkle
            Legacy -> R.drawable.ic_history
        }
    )
}

/**
 * controls that separate the styles (claude)
 */
@Immutable
data class RadiantStyle(
    /** Raised surfaces get a vertical light-to-dark falloff. */
    val surfaceGradient: Boolean,
    /** Raised surfaces get a hairline border. */
    val hairline: Boolean,
    /** Accented controls cast a coloured outer glow. */
    val glow: Boolean,
    /** Scale factor applied while a control is held. 1f disables the effect. */
    val pressScale: Float,
    /** Use Material's ripple indication instead of the scale animation. */
    val ripple: Boolean,
    /** Delegate switches/radios/checkboxes/fields to the stock Material widgets. */
    val native: Boolean,
    /** Settings rows render as grouped tiles rather than flat full-bleed rows. */
    val groupedSettings: Boolean,
    /** The home screen leads with a raised identity card rather than a flat centred stack. */
    val heroCard: Boolean,
) {
    val legacy: Boolean get() = native

    companion object {
        val Radiant = RadiantStyle(
            surfaceGradient = true,
            hairline = true,
            glow = true,
            pressScale = 0.965f,
            ripple = false,
            native = false,
            groupedSettings = true,
            heroCard = true,
        )

        val Legacy = RadiantStyle(
            surfaceGradient = false,
            hairline = false,
            glow = false,
            pressScale = 1f,
            ripple = true,
            native = true,
            groupedSettings = false,
            heroCard = false,
        )
    }
}

val LocalRadiantStyle = staticCompositionLocalOf { RadiantStyle.Radiant }

/** Shorthand for `LocalRadiantStyle.current`. */
val radiantStyle: RadiantStyle
    @Composable get() = LocalRadiantStyle.current
