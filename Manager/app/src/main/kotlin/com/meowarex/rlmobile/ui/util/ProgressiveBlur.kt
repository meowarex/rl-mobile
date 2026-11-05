// Ported from sameerasw/essentials (MIT) <3

package com.meowarex.rlmobile.ui.util

import android.content.Context
import android.os.PowerManager
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.draw.BlurredEdgeTreatment
import androidx.compose.ui.draw.blur
import androidx.compose.ui.draw.drawWithContent
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.blur.BlurRadiusSpec
import androidx.compose.ui.graphics.blur.BlurStop
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp

enum class BlurDirection { TOP, BOTTOM }

// Blurs the edge, fading into sharp content
fun Modifier.progressiveBlur(
    blurRadius: Float,
    height: Float,
    direction: BlurDirection = BlurDirection.TOP,
    showGradientOverlay: Boolean = true,
    edgeTreatment: BlurredEdgeTreatment = BlurredEdgeTreatment.Rectangle,
): Modifier = composed {
    // No bar (floating window etc), no blur
    if (height <= 0f) return@composed this
    val overlayColor = MaterialTheme.colorScheme.background.copy(alpha = 0.65f)
    val context = LocalContext.current
    val density = LocalDensity.current
    val isPowerSave = remember(context) { isPowerSaveMode(context) }
    val blurRadiusDp = with(density) { blurRadius.toDp() }

    val blurModifier = if (blurRadius > 0f && !isPowerSave) {
        Modifier.blur {
            this.edgeTreatment = edgeTreatment
            val sizeHeightPx = size.height.toPx()
            radius = if (sizeHeightPx > 0f) {
                val fraction = (height / sizeHeightPx).coerceIn(0f, 1f)
                when (direction) {
                    BlurDirection.TOP -> BlurRadiusSpec.verticalGradient(
                        listOf(
                            BlurStop(0.0f, blurRadiusDp),
                            BlurStop(fraction, 0.dp),
                            BlurStop(1.0f, 0.dp),
                        ),
                    )
                    BlurDirection.BOTTOM -> BlurRadiusSpec.verticalGradient(
                        listOf(
                            BlurStop(0.0f, 0.dp),
                            BlurStop(1.0f - fraction, 0.dp),
                            BlurStop(1.0f, blurRadiusDp),
                        ),
                    )
                }
            } else {
                when (direction) {
                    BlurDirection.TOP -> BlurRadiusSpec.verticalGradient(startRadius = blurRadiusDp, endRadius = 0.dp)
                    BlurDirection.BOTTOM -> BlurRadiusSpec.verticalGradient(startRadius = 0.dp, endRadius = blurRadiusDp)
                }
            }
        }
    } else {
        Modifier
    }

    // Tint so text under the bar stays readable
    val gradientModifier = if (showGradientOverlay) {
        Modifier.drawWithContent {
            drawContent()
            val brush = when (direction) {
                BlurDirection.TOP -> Brush.verticalGradient(
                    colors = listOf(overlayColor, Color.Transparent),
                    endY = height,
                )
                BlurDirection.BOTTOM -> Brush.verticalGradient(
                    colors = listOf(Color.Transparent, overlayColor),
                    startY = size.height - height,
                )
            }
            drawRect(brush = brush)
        }
    } else {
        Modifier
    }

    this.then(blurModifier).then(gradientModifier)
}

private fun isPowerSaveMode(context: Context): Boolean =
    (context.getSystemService(Context.POWER_SERVICE) as? PowerManager)?.isPowerSaveMode == true
