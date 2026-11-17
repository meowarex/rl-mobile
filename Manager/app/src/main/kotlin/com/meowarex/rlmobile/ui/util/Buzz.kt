package com.meowarex.rlmobile.ui.util

import android.content.Context
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager

// One shot vibration, amplitude 1-255
fun buzz(context: Context, ms: Long, amplitude: Int) {
    val vibrator = if (Build.VERSION.SDK_INT >= 31) {
        context.getSystemService(VibratorManager::class.java)?.defaultVibrator
    } else {
        @Suppress("DEPRECATION")
        context.getSystemService(Context.VIBRATOR_SERVICE) as? Vibrator
    } ?: return
    if (Build.VERSION.SDK_INT >= 26) {
        vibrator.vibrate(VibrationEffect.createOneShot(ms, amplitude.coerceIn(1, 255)))
    } else {
        @Suppress("DEPRECATION")
        vibrator.vibrate(ms)
    }
}
