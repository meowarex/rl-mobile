package com.meowarex.rlmobile.ui.screens.patching.components

import androidx.compose.animation.Crossfade
import androidx.compose.animation.core.*
import androidx.compose.foundation.layout.size
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.Dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.patcher.steps.base.StepState
import com.meowarex.rlmobile.ui.theme.customColors
import kotlin.math.roundToInt

@Composable
fun StepStateIcon(
    state: StepState,
    size: Dp,
    stepProgress: Float = -1f,
) {
    val animatedProgress by animateFloatAsState(
        targetValue = stepProgress,
        animationSpec = spring(stiffness = Spring.StiffnessVeryLow),
        label = "Progress",
    )

    Crossfade(targetState = state, label = "State CrossFade") { animatedState ->
        when (animatedState) {
            StepState.Pending -> Icon(
                painter = painterResource(R.drawable.ic_circle),
                contentDescription = stringResource(R.string.status_queued),
                tint = MaterialTheme.colorScheme.onSurface.copy(.2f),
                modifier = Modifier.size(size)
            )

            StepState.Running -> {
                if (stepProgress > .05f) {
                    // Determinate work gets the wavy indicator — the amplitude of the wave is
                    // what distinguishes "actively moving" from a stalled determinate arc. (claudes idea)
                    CircularWavyProgressIndicator(
                        progress = { animatedProgress },
                        modifier = Modifier
                            .size(size)
                            .semantics { contentDescription = "${(stepProgress * 100).roundToInt()}%" },
                    )
                } else {
                    val description = stringResource(R.string.status_ongoing)

                    CircularWavyProgressIndicator(
                        modifier = Modifier
                            .size(size)
                            .semantics { contentDescription = description },
                    )
                }
            }

            StepState.Success -> Icon(
                painter = painterResource(R.drawable.ic_check_circle),
                contentDescription = stringResource(R.string.status_success),
                tint = MaterialTheme.customColors.success,
                modifier = Modifier.size(size)
            )

            StepState.Error -> Icon(
                painter = painterResource(R.drawable.ic_canceled),
                contentDescription = stringResource(R.string.status_failed),
                tint = MaterialTheme.colorScheme.error,
                modifier = Modifier.size(size)
            )

            StepState.Skipped -> Icon(
                painter = painterResource(R.drawable.ic_check_circle),
                contentDescription = stringResource(R.string.status_skipped),
                tint = MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier.size(size)
            )
        }
    }
}
