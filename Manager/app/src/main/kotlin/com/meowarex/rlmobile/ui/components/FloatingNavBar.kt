// Ported from sameerasw/essentials (MIT) <3

package com.meowarex.rlmobile.ui.components

import android.view.HapticFeedbackConstants
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.spring
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBars
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.FloatingActionButtonDefaults
import androidx.compose.material3.FloatingToolbarDefaults
import androidx.compose.material3.HorizontalFloatingToolbar
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import com.meowarex.rlmobile.R
import androidx.compose.ui.unit.dp

data class NavBarItem(
    val icon: Painter,
    val label: String,
    val onClick: () -> Unit,
    val hasBadge: Boolean = false,
)

// Floating pill nav, selected tab shows its label
// Back mode shows "<- title" like Essentials
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun FloatingNavBar(
    items: List<NavBarItem>,
    selectedIndex: Int,
    modifier: Modifier = Modifier,
    title: String? = null,
    onBack: (() -> Unit)? = null,
    onFabClick: (() -> Unit)? = null,
    fabContent: (@Composable () -> Unit)? = null,
) {
    val view = LocalView.current
    val fontScale = LocalDensity.current.fontScale
    val screenWidth = LocalConfiguration.current.screenWidthDp
    // No label on big fonts or tiny screens
    val hideLabel = fontScale > 1.25f || (screenWidth < 400 && items.size > 3)

    HorizontalFloatingToolbar(
        modifier = modifier
            .windowInsetsPadding(WindowInsets.navigationBars)
            .padding(start = 16.dp, end = 16.dp),
        expanded = true,
        floatingActionButton = {
            if (fabContent != null && onFabClick != null) {
                FloatingActionButton(
                    onClick = {
                        view.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY)
                        onFabClick()
                    },
                    containerColor = MaterialTheme.colorScheme.primaryContainer,
                    contentColor = MaterialTheme.colorScheme.onPrimaryContainer,
                    // Essentials' large shape, ours is rounder
                    shape = RoundedCornerShape(20.dp),
                    elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp, 0.dp, 0.dp),
                ) {
                    fabContent()
                }
            }
        },
        colors = FloatingToolbarDefaults.vibrantFloatingToolbarColors(
            toolbarContentColor = MaterialTheme.colorScheme.onSurface,
            toolbarContainerColor = MaterialTheme.colorScheme.primary,
        ),
    ) {
        if (onBack != null) {
            // Back pops out like a selected tab
            IconButton(
                onClick = {
                    view.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY)
                    onBack()
                },
                modifier = Modifier.size(48.dp),
                colors = IconButtonDefaults.filledIconButtonColors(
                    contentColor = MaterialTheme.colorScheme.primary,
                    containerColor = MaterialTheme.colorScheme.background,
                ),
            ) {
                Icon(
                    painter = painterResource(R.drawable.ic_back),
                    contentDescription = stringResource(R.string.navigation_back),
                    modifier = Modifier.size(24.dp),
                )
            }
            if (title != null) {
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    text = title,
                    style = MaterialTheme.typography.titleMedium,
                    color = MaterialTheme.colorScheme.background,
                    maxLines = 1,
                    modifier = Modifier
                        .widthIn(min = 100.dp, max = 250.dp)
                        .padding(horizontal = 8.dp)
                        .align(Alignment.CenterVertically)
                        .basicMarquee(),
                )
            }
            return@HorizontalFloatingToolbar
        }
        items.forEachIndexed { index, item ->
            val isSelected = selectedIndex == index
            val bouncy = spring<androidx.compose.ui.unit.Dp>(
                dampingRatio = Spring.DampingRatioMediumBouncy,
                stiffness = Spring.StiffnessLow,
            )
            val labelWidth by animateDpAsState(
                targetValue = if (isSelected && !hideLabel) 80.dp else 0.dp,
                animationSpec = bouncy,
                label = "label_width_$index",
            )

            IconButton(
                onClick = {
                    view.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY)
                    item.onClick()
                },
                modifier = Modifier
                    .width(48.dp + labelWidth)
                    .height(48.dp),
                colors = if (isSelected) {
                    IconButtonDefaults.filledIconButtonColors(
                        contentColor = MaterialTheme.colorScheme.primary,
                        containerColor = MaterialTheme.colorScheme.background,
                    )
                } else {
                    IconButtonDefaults.iconButtonColors(
                        contentColor = MaterialTheme.colorScheme.background,
                        containerColor = MaterialTheme.colorScheme.primary,
                    )
                },
            ) {
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.Center,
                    modifier = Modifier.padding(horizontal = 8.dp),
                ) {
                    Box {
                        Icon(
                            painter = item.icon,
                            contentDescription = item.label,
                            tint = if (isSelected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.background,
                            modifier = Modifier.size(24.dp),
                        )
                        if (item.hasBadge) {
                            Canvas(
                                modifier = Modifier
                                    .size(8.dp)
                                    .align(Alignment.TopEnd),
                            ) { drawCircle(color = Color.Red) }
                        }
                    }
                    if (isSelected && !hideLabel) {
                        Spacer(modifier = Modifier.width(8.dp))
                        Text(
                            text = item.label,
                            style = MaterialTheme.typography.labelLarge,
                            maxLines = 1,
                            color = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.basicMarquee(),
                        )
                    }
                }
            }

            if (index < items.size - 1) Spacer(modifier = Modifier.width(8.dp))
        }
    }
}
