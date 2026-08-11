package com.meowarex.rlmobile.ui.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R
import com.google.accompanist.systemuicontroller.rememberSystemUiController

@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun ManagerTheme(
    theme: Theme = Theme.System,
    uiStyle: UiStyle = UiStyle.Radiant,
    dynamicColor: Boolean = false,
    content: @Composable () -> Unit,
) {
    val context = LocalContext.current
    val useDynamicColor = dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S
    val legacy = uiStyle == UiStyle.Legacy

    val isBlack = theme == Theme.Black
    val isDark = when (theme) {
        Theme.System -> isSystemInDarkTheme()
        Theme.Light -> false
        Theme.Dark, Theme.Black -> true
    }

    // Dynamic colour is opt-in, not the default. Radiant ships its own palette so the app looks
    // like itself on every device instead of inheriting the wallpaper's tonal scheme.
    // Legacy falls back to Material's own baseline schemes, which is what the app used before. (this is just a note to self cause subject to change)
    val baseScheme = when {
        useDynamicColor && isDark -> dynamicDarkColorScheme(context)
        useDynamicColor -> dynamicLightColorScheme(context)
        legacy && isDark -> darkColorScheme()
        legacy -> lightColorScheme()
        isDark -> RadiantDarkColorScheme
        else -> RadiantLightColorScheme
    }
    val colorScheme = when {
        !isBlack -> baseScheme
        legacy -> baseScheme.toLegacyPitchBlack()
        else -> baseScheme.toPitchBlack()
    }
    val customColors = when (isDark) {
        true -> DarkCustomColors
        false -> LightCustomColors
    }

    // As usual, Google deprecates accompanist libraries and replaces them with an incomplete and shitty replacement in androidx
    // enableEdgeToEdge() does not work for our use case.
    @Suppress("DEPRECATION")
    val systemUiController = rememberSystemUiController()

    SideEffect {
        systemUiController.setSystemBarsColor(
            color = if (legacy) colorScheme.background else Color.Transparent,
            darkIcons = !isDark,
        )
        systemUiController.setNavigationBarColor(
            color = Color.Transparent,
        )
    }

    CompositionLocalProvider(
        LocalCustomColors provides customColors,
        LocalRadiantStyle provides if (legacy) RadiantStyle.Legacy else RadiantStyle.Radiant,
    ) {
        if (legacy) {
            // Plain MaterialTheme with stock shapes and the original type scale
            MaterialTheme(
                colorScheme = colorScheme,
                shapes = Shapes(),
                typography = LegacyTypography,
                content = content,
            )
        } else {
            MaterialExpressiveTheme(
                colorScheme = colorScheme,
                // Makes things springy and bouncy instead of shit
                motionScheme = MotionScheme.expressive(),
                shapes = ThemeShapes,
                typography = ThemeTypography,
                content = content,
            )
        }
    }
}

enum class Theme {
    System,
    Light,
    Dark,
    Black;

    @Composable
    fun toDisplayName() = stringResource(
        when (this) {
            System -> R.string.theme_system
            Light -> R.string.theme_light
            Dark -> R.string.theme_dark
            Black -> R.string.theme_black
        }
    )

    @Composable
    fun toPainter() = painterResource(
        when (this) {
            System -> R.drawable.ic_sync
            Light -> R.drawable.ic_light
            Dark -> R.drawable.ic_night
            Black -> R.drawable.ic_brightness_empty
        }
    )
}

/** The original AMOLED treatment left alone cause [UiStyle.Legacy]. */
private fun ColorScheme.toLegacyPitchBlack(): ColorScheme = copy(
    background = Color.Black,
    surface = Color.Black,
    surfaceVariant = Color.Black,
    onBackground = Color.White,
    onSurface = Color.White,
)
