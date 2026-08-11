package com.meowarex.rlmobile.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.*
import androidx.compose.ui.graphics.Color

@Suppress("UnusedReceiverParameter")
val MaterialTheme.customColors: CustomColors
    @Composable
    inline get() = LocalCustomColors.current

val LocalCustomColors = staticCompositionLocalOf<CustomColors> {
    error("No LocalCustomColors provided!")
}

@Immutable
data class CustomColors(
    val warning: Color,
    val onWarning: Color,
    val warningContainer: Color,
    val onWarningContainer: Color,
    val success: Color,
    val onSuccess: Color,
    val successContainer: Color,
    val onSuccessContainer: Color,
)

private val YellowAlt1 = Color(0xFFE9C414)
private val Shandy = Color(0xFFFFE172)
private val DarkBrown = Color(0xFF3B2F00)
private val DarkerBrown = Color(0xFF221B00)
private val DarkBronze = Color(0xFF554600)

// Success leans mint rather than a stock green so it sits with the aqua tertiary ramp. (yet again claude cause colorblind)
private val Mint40 = Color(0xFF1E7D52)
private val Mint80 = Color(0xFF6EDBA4)
private val Mint90 = Color(0xFFB6F5D2)
private val MintDark10 = Color(0xFF00210F)
private val MintDark30 = Color(0xFF00623A)

val DarkCustomColors = CustomColors(
    warning = YellowAlt1,
    onWarning = DarkBrown,
    warningContainer = DarkBronze,
    onWarningContainer = Shandy,
    success = Mint80,
    onSuccess = MintDark10,
    successContainer = MintDark30,
    onSuccessContainer = Mint90,
)

val LightCustomColors = CustomColors(
    warning = YellowAlt1,
    onWarning = Color.White,
    warningContainer = Shandy,
    onWarningContainer = DarkerBrown,
    success = Mint40,
    onSuccess = Color.White,
    successContainer = Mint90,
    onSuccessContainer = MintDark10,
)
