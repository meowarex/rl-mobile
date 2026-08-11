package com.meowarex.rlmobile.ui.screens.patching.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.ui.screens.patching.PatchingScreenState
import com.meowarex.rlmobile.ui.screens.patching.isFinished
import com.meowarex.rlmobile.ui.theme.customColors
import kotlinx.collections.immutable.ImmutableList
import kotlinx.collections.immutable.ImmutableMap
import kotlin.math.roundToInt

/**
 * Whole install progress
 */
@Composable
fun OverallProgressBar(
    steps: ImmutableMap<StepGroup, ImmutableList<Step>>?,
    state: PatchingScreenState,
    modifier: Modifier = Modifier,
) {
    val allSteps = remember(steps) { steps?.values?.flatten().orEmpty() }
    if (allSteps.isEmpty()) return

    val completed = allSteps.count { it.state.isFinished }
    val fraction = completed.toFloat() / allSteps.size
    val animatedFraction by animateFloatAsState(
        targetValue = fraction,
        label = "OverallProgress",
    )

    val failed = state is PatchingScreenState.Failed
    val succeeded = state is PatchingScreenState.Success

    val trackColor = MaterialTheme.colorScheme.surfaceContainerHighest
    val indicatorColor = when {
        failed -> MaterialTheme.colorScheme.error
        succeeded -> MaterialTheme.customColors.success
        else -> MaterialTheme.colorScheme.primary
    }

    Column(
        verticalArrangement = Arrangement.spacedBy(8.dp),
        modifier = modifier.padding(bottom = 4.dp),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.fillMaxWidth(),
        ) {
            Text(
                text = stringResource(
                    R.string.installer_progress_summary,
                    completed,
                    allSteps.size,
                ),
                style = MaterialTheme.typography.labelMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
            )

            Spacer(Modifier.weight(1f))

            Text(
                text = "${(animatedFraction * 100).roundToInt()}%",
                style = MaterialTheme.typography.labelLarge,
                color = indicatorColor,
            )
        }

        // finished run gets the flat determinate bar a live one keeps its wave (M3E)
        if (state.isFinished) {
            LinearProgressIndicator(
                progress = { animatedFraction },
                color = indicatorColor,
                trackColor = trackColor,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(10.dp),
            )
        } else {
            LinearWavyProgressIndicator(
                progress = { animatedFraction },
                color = indicatorColor,
                trackColor = trackColor,
                modifier = Modifier.fillMaxWidth(),
            )
        }
    }
}
