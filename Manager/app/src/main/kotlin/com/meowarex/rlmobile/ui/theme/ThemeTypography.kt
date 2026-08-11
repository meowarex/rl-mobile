package com.meowarex.rlmobile.ui.theme

import androidx.compose.material3.Typography
import androidx.compose.ui.text.ExperimentalTextApi
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.*
import androidx.compose.ui.text.style.LineHeightStyle
import androidx.compose.ui.unit.sp
import com.meowarex.rlmobile.R

// This uses a variable font variant of Roboto.
// ref: https://medium.com/androiddevelopers/just-your-type-variable-fonts-in-compose-5bf63b357994

@OptIn(ExperimentalTextApi::class)
private val RadiantFontFamily = run {
    val weights = arrayOf(
        FontWeight.Thin,
        FontWeight.ExtraLight,
        FontWeight.Light,
        FontWeight.Normal,
        FontWeight.Medium,
        FontWeight.SemiBold,
        FontWeight.ExtraBold,
        FontWeight.Bold,
        FontWeight.Black,
    )
    val fonts = weights.map { weight ->
        Font(
            resId = R.font.roboto_variable,
            weight = weight,
            variationSettings = FontVariation.Settings(
                FontVariation.weight(weight.weight),
            )
        )
    }
    FontFamily(fonts)
}

/**
 * Expressive type scale
 */
private val Emphasis = LineHeightStyle(
    alignment = LineHeightStyle.Alignment.Center,
    trim = LineHeightStyle.Trim.None,
)

val ThemeTypography = Typography(
    // Display — heavy and tight
    displayLarge = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Black,
        fontSize = 57.sp,
        lineHeight = 60.sp,
        letterSpacing = (-1.5).sp,
        lineHeightStyle = Emphasis,
    ),
    displayMedium = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.ExtraBold,
        fontSize = 45.sp,
        lineHeight = 50.sp,
        letterSpacing = (-1.0).sp,
        lineHeightStyle = Emphasis,
    ),
    displaySmall = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.ExtraBold,
        fontSize = 36.sp,
        lineHeight = 42.sp,
        letterSpacing = (-0.6).sp,
        lineHeightStyle = Emphasis,
    ),

    // Headline
    headlineLarge = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 32.sp,
        lineHeight = 38.sp,
        letterSpacing = (-0.5).sp,
        lineHeightStyle = Emphasis,
    ),
    headlineMedium = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 28.sp,
        lineHeight = 34.sp,
        letterSpacing = (-0.4).sp,
        lineHeightStyle = Emphasis,
    ),
    headlineSmall = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 24.sp,
        lineHeight = 30.sp,
        letterSpacing = (-0.3).sp,
        lineHeightStyle = Emphasis,
    ),

    // Title — card and row headers
    titleLarge = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 22.sp,
        lineHeight = 28.sp,
        letterSpacing = (-0.2).sp,
        lineHeightStyle = Emphasis,
    ),
    titleMedium = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 16.sp,
        lineHeight = 24.sp,
        letterSpacing = 0.sp,
        lineHeightStyle = Emphasis,
    ),
    titleSmall = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 14.sp,
        lineHeight = 20.sp,
        letterSpacing = 0.sp,
        lineHeightStyle = Emphasis,
    ),

    // Body
    bodyLarge = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Normal,
        fontSize = 16.sp,
        lineHeight = 24.sp,
        letterSpacing = 0.1.sp,
        lineHeightStyle = Emphasis,
    ),
    bodyMedium = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Normal,
        fontSize = 14.sp,
        lineHeight = 20.sp,
        letterSpacing = 0.15.sp,
        lineHeightStyle = Emphasis,
    ),
    bodySmall = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Normal,
        fontSize = 12.sp,
        lineHeight = 17.sp,
        letterSpacing = 0.2.sp,
        lineHeightStyle = Emphasis,
    ),

    // Label — buttons, tags, overlines
    labelLarge = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 14.sp,
        lineHeight = 20.sp,
        letterSpacing = 0.05.sp,
        lineHeightStyle = Emphasis,
    ),
    labelMedium = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 12.sp,
        lineHeight = 16.sp,
        letterSpacing = 0.4.sp,
        lineHeightStyle = Emphasis,
    ),
    labelSmall = TextStyle(
        fontFamily = RadiantFontFamily,
        fontWeight = FontWeight.Medium,
        fontSize = 11.sp,
        lineHeight = 16.sp,
        letterSpacing = 0.5.sp,
        lineHeightStyle = Emphasis,
    ),
)
