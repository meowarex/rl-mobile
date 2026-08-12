package com.meowarex.rlmobile.ui.theme

import androidx.compose.material3.ColorScheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.ui.graphics.Color

/** (claude built this cause i'm literally colorblind)
 * Radiant's own colour system.
 *
 * Deliberately *not* a Monet/Material-You tonal extraction: the ramps below are hand-tuned at a
 * much higher chroma than a wallpaper-derived scheme ever produces, so the app keeps one identity
 * on every device instead of turning into whatever pastel the launcher wallpaper happens to be.
 *
 * The hues come from the product itself — the launcher background (#B91D6F) is tone 40 of the
 * magenta ramp, and the sparkle foreground (#FFE0EC) sits at tone 90.
 *
 *  - primary   magenta/rose  — the brand
 *  - secondary violet        — the cool half of the "radiant" spectrum
 *  - tertiary  aqua          — the pop accent, used sparingly for success/highlight states
 *  - neutrals  rose-tinted ink, never flat grey
 */

// ── Magenta / rose (primary) ─────────────────────────────────────────────────
private val Rose10 = Color(0xFF3F0022)
private val Rose20 = Color(0xFF650036)
private val Rose30 = Color(0xFF8D004C)
private val Rose40 = Color(0xFFB91D6F) // brand seed — matches ic_launcher_background
private val Rose50 = Color(0xFFDB3B88)
private val Rose60 = Color(0xFFF55A9F)
private val Rose70 = Color(0xFFFF83B6)
private val Rose80 = Color(0xFFFFAFCC)
private val Rose90 = Color(0xFFFFD9E4)
private val Rose95 = Color(0xFFFFECF1)

// ── Dusty rose (secondary) ───────────────────────────────────────────────────
private val DustyRose10 = Color(0xFF2B0D18)
private val DustyRose20 = Color(0xFF43202B)
private val DustyRose30 = Color(0xFF5C3541)
private val DustyRose40 = Color(0xFF774C58)
private val DustyRose80 = Color(0xFFE4BCC8)
private val DustyRose90 = Color(0xFFF5DCE4)

// ── Aqua (tertiary) ──────────────────────────────────────────────────────────
private val Aqua10 = Color(0xFF00201F)
private val Aqua20 = Color(0xFF003736)
private val Aqua30 = Color(0xFF00504E)
private val Aqua40 = Color(0xFF006A67)
private val Aqua80 = Color(0xFF4FDCD8)
private val Aqua90 = Color(0xFF70F9F4)

// ── Neutrals — rose-tinted ink (chroma ~4, never a flat grey) ────────────────
private val Neutral4 = Color(0xFF0F0B0D)
private val Neutral6 = Color(0xFF151012)
private val Neutral10 = Color(0xFF1D171A)
private val Neutral12 = Color(0xFF211B1E)
private val Neutral17 = Color(0xFF2C2529)
private val Neutral20 = Color(0xFF332C30)
private val Neutral22 = Color(0xFF373034)
private val Neutral24 = Color(0xFF3C3438)
private val Neutral80 = Color(0xFFCDC0C5)
private val Neutral87 = Color(0xFFE1D4D9)
private val Neutral90 = Color(0xFFEADCE1)
private val Neutral92 = Color(0xFFF0E2E7)
private val Neutral94 = Color(0xFFF5E8ED)
private val Neutral96 = Color(0xFFFBEEF3)
private val Neutral98 = Color(0xFFFFF7FA)
private val Neutral100 = Color(0xFFFFFFFF)

// ── Neutral variant — a touch more chroma, for outlines & variant surfaces ───
private val NeutralVariant30 = Color(0xFF514049)
private val NeutralVariant50 = Color(0xFF846E7A)
private val NeutralVariant60 = Color(0xFF9F8794)
private val NeutralVariant80 = Color(0xFFD8BFCC)
private val NeutralVariant90 = Color(0xFFF5DBE8)

// ── Error ────────────────────────────────────────────────────────────────────
private val Error10 = Color(0xFF410002)
private val Error20 = Color(0xFF690005)
private val Error30 = Color(0xFF93000A)
private val Error40 = Color(0xFFBA1A1A)
private val Error80 = Color(0xFFFFB4AB)
private val Error90 = Color(0xFFFFDAD6)

val RadiantDarkColorScheme: ColorScheme = darkColorScheme(
    primary = Rose80,
    onPrimary = Rose20,
    primaryContainer = Rose30,
    onPrimaryContainer = Rose90,
    inversePrimary = Rose40,

    secondary = DustyRose80,
    onSecondary = DustyRose20,
    secondaryContainer = DustyRose30,
    onSecondaryContainer = DustyRose90,

    tertiary = Aqua80,
    onTertiary = Aqua20,
    tertiaryContainer = Aqua30,
    onTertiaryContainer = Aqua90,

    error = Error80,
    onError = Error20,
    errorContainer = Error30,
    onErrorContainer = Error90,

    background = Neutral6,
    onBackground = Neutral90,
    surface = Neutral6,
    onSurface = Neutral90,
    surfaceVariant = NeutralVariant30,
    onSurfaceVariant = NeutralVariant80,
    surfaceTint = Rose80,
    inverseSurface = Neutral90,
    inverseOnSurface = Neutral20,

    surfaceDim = Neutral6,
    surfaceBright = Neutral24,
    surfaceContainerLowest = Neutral4,
    surfaceContainerLow = Neutral10,
    surfaceContainer = Neutral12,
    surfaceContainerHigh = Neutral17,
    surfaceContainerHighest = Neutral22,

    outline = NeutralVariant60,
    outlineVariant = NeutralVariant30,
    scrim = Color.Black,
)

val RadiantLightColorScheme: ColorScheme = lightColorScheme(
    primary = Rose40,
    onPrimary = Neutral100,
    primaryContainer = Rose90,
    onPrimaryContainer = Rose10,
    inversePrimary = Rose80,

    secondary = DustyRose40,
    onSecondary = Neutral100,
    secondaryContainer = DustyRose90,
    onSecondaryContainer = DustyRose10,

    tertiary = Aqua40,
    onTertiary = Neutral100,
    tertiaryContainer = Aqua90,
    onTertiaryContainer = Aqua10,

    error = Error40,
    onError = Neutral100,
    errorContainer = Error90,
    onErrorContainer = Error10,

    background = Neutral98,
    onBackground = Neutral10,
    surface = Neutral98,
    onSurface = Neutral10,
    surfaceVariant = NeutralVariant90,
    onSurfaceVariant = NeutralVariant30,
    surfaceTint = Rose40,
    inverseSurface = Neutral20,
    inverseOnSurface = Neutral96,

    surfaceDim = Neutral87,
    surfaceBright = Neutral98,
    surfaceContainerLowest = Neutral100,
    surfaceContainerLow = Neutral96,
    surfaceContainer = Neutral94,
    surfaceContainerHigh = Neutral92,
    surfaceContainerHighest = Neutral90,

    outline = NeutralVariant50,
    outlineVariant = NeutralVariant80,
    scrim = Color.Black,
)

/**
 * AMOLED variant. Only the true backdrop layers go black — the container ramp keeps its tint so
 * cards still read as distinct planes instead of collapsing into one void.
 */
fun ColorScheme.toPitchBlack(): ColorScheme = copy(
    background = Color.Black,
    surface = Color.Black,
    surfaceDim = Color.Black,
    surfaceContainerLowest = Color.Black,
    surfaceContainerLow = Neutral6,
    surfaceContainer = Neutral10,
    surfaceContainerHigh = Neutral12,
    surfaceContainerHighest = Neutral17,
)
