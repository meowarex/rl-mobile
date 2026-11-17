// Ported from sameerasw/essentials (MIT) <3

package com.meowarex.rlmobile.ui.components

import android.os.Build
import android.view.HapticFeedbackConstants
import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.CubicBezierEasing
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateOffsetAsState
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.SizeTransform
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.gestures.awaitEachGesture
import androidx.compose.foundation.gestures.awaitFirstDown
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
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.TransformOrigin
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.graphics.lerp
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.input.pointer.PointerEventPass
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.Layout
import androidx.compose.ui.layout.LayoutCoordinates
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.util.fluidPull
import com.meowarex.rlmobile.ui.util.fluidStretch
import kotlinx.coroutines.launch
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.drawscope.DrawScope
import androidx.compose.ui.layout.layoutId
import androidx.compose.ui.text.font.FontWeight
import com.meowarex.rlmobile.ui.util.buzz
import kotlinx.coroutines.coroutineScope
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.withFrameNanos
import androidx.compose.ui.platform.LocalContext
import kotlinx.coroutines.delay
import kotlin.math.PI
import kotlin.math.abs
import kotlin.math.acos
import kotlin.math.atan2
import kotlin.math.cos
import kotlin.math.min
import kotlin.math.roundToInt
import kotlin.math.sin

data class NavBarItem(
    val icon: Painter,
    val label: String,
    val onClick: () -> Unit,
    val hasBadge: Boolean = false,
    // Dialog items only fire on release
    val navOnDrag: Boolean = true,
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
    showFab: Boolean = true,
    onFabClick: (() -> Unit)? = null,
    fabContent: (@Composable () -> Unit)? = null,
    fabBubble: Boolean = false,
) {
    val view = LocalView.current
    val density = LocalDensity.current
    val fontScale = density.fontScale
    val screenWidth = LocalConfiguration.current.screenWidthDp
    // No label on big fonts or tiny screens
    val hideLabel = fontScale > 1.25f || (screenWidth < 400 && items.size > 3)

    val latestItems by rememberUpdatedState(items)
    val backMode = onBack != null
    val latestBack by rememberUpdatedState(backMode)
    // Keep title and back alive during the fade
    var lastTitle by remember { mutableStateOf(title.orEmpty()) }
    if (!title.isNullOrEmpty()) lastTitle = title
    var lastBack by remember { mutableStateOf(onBack) }
    if (onBack != null) lastBack = onBack

    // Drag across tabs to navigate
    var dragIndex by remember { mutableStateOf<Int?>(null) }
    var dragging by remember { mutableStateOf(false) }
    var pull by remember { mutableStateOf(Offset.Zero) }
    val pullAnim by animateOffsetAsState(
        targetValue = pull,
        // Follows the finger, wobbles back on release
        animationSpec = if (dragging) spring(dampingRatio = 1f, stiffness = 900f)
        else spring(dampingRatio = 0.32f, stiffness = 420f),
        label = "nav_pull",
    )
    val itemCoords = remember { arrayOfNulls<LayoutCoordinates>(8) }
    val barCoords = remember { arrayOfNulls<LayoutCoordinates>(1) }
    val shownIndex = dragIndex ?: selectedIndex

    // FAB drip in/out of the bar
    val hasFab = fabContent != null && onFabClick != null
    val wantFab = hasFab && showFab
    val pos = remember { Animatable(if (wantFab) 1f else 0f) }
    val dropScale = remember { Animatable(if (wantFab) 1f else DROP_MIN) }
    val slot = remember { Animatable(if (wantFab) 1f else 0f) }
    val wobble = remember { Animatable(0f) }
    val gulp = remember { Animatable(0f) }
    var fabPresent by remember { mutableStateOf(wantFab) }
    var neckOn by remember { mutableStateOf(false) }

    // Long press the FAB for a speech bubble <3
    val context = LocalContext.current
    val scope = rememberCoroutineScope()
    val charge = remember { Animatable(0f) }
    val bubblePos = remember { Animatable(0f) }
    val bubbleScale = remember { Animatable(DROP_MIN) }
    val bubbleWidth = remember { Animatable(0f) }
    val bubbleWobble = remember { Animatable(0f) }
    var bubbleOn by remember { mutableStateOf(false) }
    var bubbleNeck by remember { mutableStateOf(false) }

    suspend fun bubbleOut() {
        bubbleOn = true
        bubbleNeck = true
        bubblePos.snapTo(0f)
        bubbleScale.snapTo(DROP_MIN)
        bubbleWidth.snapTo(0f)
        coroutineScope {
            // Same drip curve as the FAB showing
            launch { bubbleScale.animateTo(1f, tween(400, easing = FastOutSlowInEasing)) }
            bubblePos.animateTo(1f, tween(580, easing = CubicBezierEasing(0.25f, 0f, 0.5f, 1.5f))) {
                if (bubbleNeck && value >= 0.995f) {
                    bubbleNeck = false
                    launch {
                        bubbleWobble.snapTo(1f)
                        bubbleWobble.animateTo(0f, spring(dampingRatio = 0.22f, stiffness = 520f))
                    }
                }
            }
            bubbleNeck = false
            bubbleWidth.animateTo(1f, spring(dampingRatio = 0.6f, stiffness = 320f))
        }
        delay(2000)
        // Shrink back to a blob, then drip in
        bubbleWidth.animateTo(0f, tween(220, easing = FastOutSlowInEasing))
        bubbleNeck = true
        coroutineScope {
            launch { bubbleScale.animateTo(DROP_MIN, tween(400, delayMillis = 180)) }
            bubblePos.animateTo(0f, tween(540, easing = CubicBezierEasing(0.5f, -0.5f, 0.75f, 1f)))
        }
        bubbleOn = false
        bubbleNeck = false
        coroutineScope {
            launch {
                gulp.snapTo(0.035f)
                gulp.animateTo(0f, spring(dampingRatio = 0.3f, stiffness = 500f))
            }
            wobble.snapTo(1f)
            wobble.animateTo(0f, spring(dampingRatio = 0.22f, stiffness = 520f))
        }
    }

    suspend fun chargeUp() {
        val start = withFrameNanos { it }
        var nextBuzz = 0L
        while (true) {
            val ms = (withFrameNanos { it } - start) / 1_000_000L
            val c = (ms / CHARGE_MS).coerceAtMost(1f)
            charge.snapTo(c)
            // Vibrations speed up and get stronger
            if (ms >= nextBuzz) {
                buzz(context, (8 + 8 * c).toLong(), (60 + 195 * c).toInt())
                nextBuzz = ms + (180 - 150 * c).toLong()
            }
            if (c >= 1f) break
        }
    }

    LaunchedEffect(wantFab) {
        val scope = this
        if (wantFab) {
            if (fabPresent && !neckOn && pos.value >= 1f) return@LaunchedEffect
            fabPresent = true
            neckOn = true
            if (pos.value < 0.05f) {
                pos.snapTo(0f)
                dropScale.snapTo(DROP_MIN)
            }
            // Hide curves played in reverse
            launch { slot.animateTo(1f, tween(460, easing = FastOutSlowInEasing)) }
            launch { dropScale.animateTo(1f, tween(400, easing = FastOutSlowInEasing)) }
            launch {
                gulp.snapTo(0.035f)
                gulp.animateTo(0f, spring(dampingRatio = 0.3f, stiffness = 500f))
            }
            // Neck snaps once it overshoots
            pos.animateTo(1f, tween(580, easing = CubicBezierEasing(0.25f, 0f, 0.5f, 1.5f))) {
                if (neckOn && value >= 0.995f) {
                    neckOn = false
                    scope.launch {
                        wobble.snapTo(1f)
                        wobble.animateTo(0f, spring(dampingRatio = 0.22f, stiffness = 520f))
                    }
                }
            }
            neckOn = false
        } else {
            if (!fabPresent) return@LaunchedEffect
            neckOn = true
            launch { slot.animateTo(0f, tween(460, delayMillis = 140, easing = FastOutSlowInEasing)) }
            launch { dropScale.animateTo(DROP_MIN, tween(400, delayMillis = 180)) }
            // Small tug outward before pulling in
            pos.animateTo(0f, tween(540, easing = CubicBezierEasing(0.5f, -0.5f, 0.75f, 1f)))
            fabPresent = false
            neckOn = false
            gulp.snapTo(0.05f)
            gulp.animateTo(0f, spring(dampingRatio = 0.26f, stiffness = 450f))
        }
    }

    val barColor = MaterialTheme.colorScheme.primary
    val fabColor = MaterialTheme.colorScheme.primaryContainer
    val neckPath = remember { Path() }
    val fabSize = 56.dp
    val gap = 8.dp

    // Bar transform, shared with the FAB and neck
    val geo = remember { BarGeo() }

    Layout(
        modifier = modifier
            .windowInsetsPadding(WindowInsets.navigationBars)
            .padding(start = 16.dp, end = 16.dp)
            .drawBehind {
                if (bubbleOn) drawBubble(geo, fabSize.toPx() / 2f, bubblePos.value, bubbleScale.value,
                    bubbleWidth.value, bubbleWobble.value, bubbleNeck, fabColor, neckPath)
                if (!fabPresent || !neckOn) return@drawBehind
                // Redraw the neck while the bar stretches
                if (pullAnim.x.isNaN()) return@drawBehind
                val v = NECK_SPREAD * (1f - smooth(0.55f, 1f, pos.value))
                val r1 = geo.barH * geo.scaleY / 2f
                val c1 = Offset(geo.barRight - r1, geo.barCy)
                val r2 = fabSize.toPx() / 2f * dropScale.value
                val c2 = Offset(geo.fabCx, geo.fabCy)
                if (metaball(neckPath, c1, r1, c2, r2, v)) {
                    drawPath(
                        path = neckPath,
                        brush = Brush.horizontalGradient(
                            colors = listOf(barColor, lerp(barColor, fabColor, detach(pos.value, neckOn))),
                            startX = c1.x,
                            endX = c2.x,
                        ),
                    )
                }
            },
        content = {
            HorizontalFloatingToolbar(
                expanded = true,
                modifier = Modifier
                    .pointerInput(Unit) {
                        awaitEachGesture {
                            val down = awaitFirstDown(requireUnconsumed = false, pass = PointerEventPass.Initial)
                            val slop = viewConfiguration.touchSlop
                            var moved = false
                            var hover = -1
                            while (true) {
                                val event = awaitPointerEvent(PointerEventPass.Initial)
                                val change = event.changes.firstOrNull { it.id == down.id } ?: break
                                if (!change.pressed) break
                                if (!moved && (change.position - down.position).getDistance() > slop) {
                                    moved = true
                                    dragging = true
                                    // Starting tab doesn't navigate
                                    hover = nearestItem(down.position.x, latestItems.size, itemCoords, barCoords[0])
                                }
                                if (!moved) continue
                                // Consume so the tab buttons don't click
                                change.consume()
                                val p = change.position
                                val d = density.density
                                pull = fluidPull(p, size.width.toFloat(), size.height.toFloat(), 24f * d, 32f * d, 16f * d)

                                val list = latestItems
                                if (latestBack || list.isEmpty()) continue
                                val hit = nearestItem(p.x, list.size, itemCoords, barCoords[0])
                                if (hit >= 0 && hit != hover) {
                                    hover = hit
                                    dragIndex = hit
                                    view.performHapticFeedback(tickHaptic())
                                    if (list[hit].navOnDrag) list[hit].onClick()
                                }
                            }
                            if (moved) {
                                val list = latestItems
                                if (hover in list.indices && !list[hover].navOnDrag) {
                                    view.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY)
                                    list[hover].onClick()
                                }
                            }
                            dragging = false
                            dragIndex = null
                            pull = Offset.Zero
                        }
                    }
                    .graphicsLayer {
                        geo.update(size.width, size.height, pullAnim, gulp.value)
                        scaleX = geo.scaleX
                        scaleY = geo.scaleY
                        translationX = geo.tx
                        translationY = geo.ty
                        transformOrigin = TransformOrigin(geo.originX, geo.originY)
                    }
                    .onGloballyPositioned { barCoords[0] = it },
                colors = FloatingToolbarDefaults.vibrantFloatingToolbarColors(
                    toolbarContentColor = MaterialTheme.colorScheme.onSurface,
                    toolbarContainerColor = MaterialTheme.colorScheme.primary,
                ),
            ) {
                AnimatedContent(
                    targetState = backMode,
                    // Resize before fading in, no clipping
                    transitionSpec = {
                        fadeIn(tween(220, delayMillis = 170)) togetherWith fadeOut(tween(110)) using
                            SizeTransform(clip = false) { _, _ -> tween(240, easing = FastOutSlowInEasing) }
                    },
                    label = "nav_bar_mode",
                ) { back ->
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        if (back) {
                            BackContent(lastTitle) { lastBack?.invoke() }
                        } else {
                            TabsContent(items, shownIndex, hideLabel, itemCoords)
                        }
                    }
                }
            }

            if (fabPresent && hasFab) {
                val d = detach(pos.value, neckOn)
                val corner = 28f + (20f - 28f) * d
                FloatingActionButton(
                    onClick = {
                        view.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY)
                        onFabClick?.invoke()
                    },
                    containerColor = lerp(barColor, fabColor, d),
                    contentColor = MaterialTheme.colorScheme.onPrimaryContainer,
                    // Circle while dripping, rounded square after
                    shape = RoundedCornerShape(corner.dp),
                    elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp, 0.dp, 0.dp),
                    modifier = Modifier
                        .pointerInput(fabBubble) {
                            // Only when the heart rolled
                            if (!fabBubble) return@pointerInput
                            awaitEachGesture {
                                val down = awaitFirstDown(requireUnconsumed = false, pass = PointerEventPass.Initial)
                                var held = false
                                val job = scope.launch {
                                    delay(viewConfiguration.longPressTimeoutMillis)
                                    if (bubbleOn) return@launch
                                    held = true
                                    chargeUp()
                                    buzz(context, 40, 255)
                                    // Separate jobs so releasing doesn't cancel them
                                    scope.launch { charge.animateTo(0f, spring(dampingRatio = 0.4f, stiffness = 500f)) }
                                    scope.launch { bubbleOut() }
                                }
                                while (true) {
                                    val event = awaitPointerEvent(PointerEventPass.Initial)
                                    val change = event.changes.firstOrNull { it.id == down.id } ?: break
                                    // Long press shouldn't click, timestamps beat a late timer
                                    val long = change.uptimeMillis - down.uptimeMillis >= viewConfiguration.longPressTimeoutMillis
                                    if (held || long) change.consume()
                                    if (!change.pressed) break
                                    if ((change.position - down.position).getDistance() > viewConfiguration.touchSlop * 3) break
                                }
                                job.cancel()
                                if (held && !bubbleOn) {
                                    scope.launch { charge.animateTo(0f, spring(dampingRatio = 0.3f, stiffness = 400f)) }
                                }
                            }
                        }
                        .fluidStretch()
                        .graphicsLayer {
                            val tension = if (neckOn) smooth(0.5f, 1f, pos.value) else 0f
                            val w = wobble.value
                            // Slight swell while charging
                            val grow = 1f + 0.1f * charge.value
                            scaleX = dropScale.value * grow * (1f + 0.16f * tension + 0.14f * w)
                            scaleY = dropScale.value * grow * (1f - 0.1f * tension - 0.11f * w)
                        },
                ) {
                    Box(Modifier.graphicsLayer { alpha = if (neckOn) smooth(0.45f, 0.9f, pos.value) else 1f }) {
                        fabContent?.invoke()
                    }
                }
            }

            if (bubbleOn) {
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(6.dp),
                    modifier = Modifier
                        .layoutId(BUBBLE_ID)
                        .height(BUBBLE_H)
                        .padding(horizontal = 18.dp)
                        .graphicsLayer { alpha = smooth(0.55f, 1f, bubbleWidth.value) },
                ) {
                    Text(
                        text = stringResource(R.string.love_burst),
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.onPrimaryContainer,
                        maxLines = 1,
                    )
                    Icon(
                        painter = painterResource(R.drawable.ic_favorite),
                        contentDescription = null,
                        tint = MaterialTheme.colorScheme.onPrimaryContainer,
                        modifier = Modifier.size(18.dp),
                    )
                }
            }
        },
    ) { measurables, constraints ->
        val fabPx = fabSize.roundToPx()
        val gapPx = gap.toPx()
        val slotPx = ((gapPx + fabPx) * slot.value).roundToInt().coerceAtLeast(0)
        val bar = measurables[0].measure(
            constraints.copy(minWidth = 0, minHeight = 0, maxWidth = (constraints.maxWidth - slotPx).coerceAtLeast(0)),
        )
        val fab = measurables.drop(1).firstOrNull { it.layoutId != BUBBLE_ID }?.measure(Constraints.fixed(fabPx, fabPx))
        val bubble = measurables.firstOrNull { it.layoutId == BUBBLE_ID }?.measure(Constraints())
        val w = bar.width + slotPx
        val h = maxOf(bar.height, fabPx)
        geo.update(bar.width.toFloat(), bar.height.toFloat(), pullAnim, gulp.value)
        layout(w, h) {
            val barY = (h - bar.height) / 2
            geo.barH = bar.height.toFloat()
            bar.place(0, barY, zIndex = 1f)
            if (fab != null) {
                // FAB slides out from the bar's end
                val start = -bar.height / 2f
                val end = gapPx + fabPx / 2f
                val cx = bar.width + geo.rightShift + start + (end - start) * pos.value
                val cy = h / 2f + geo.ty * 0.6f
                geo.fabCx = cx
                geo.fabCy = cy
                fab.place((cx - fabPx / 2f).roundToInt(), (cy - fabPx / 2f).roundToInt(), zIndex = 0f)
            }
            geo.barRight = bar.width + geo.rightShift
            geo.barCy = barY + bar.height / 2f + geo.cyShift
            if (bubble != null) {
                // Text goes where the bubble ends up
                geo.bubbleW = bubble.width.toFloat()
                geo.bubbleH = bubble.height.toFloat()
                val cap = bubbleCap(geo, 1f, BUBBLE_RISE.toPx(), BUBBLE_SHIFT.toPx())
                val right = cap.x + bubble.height / 2f
                bubble.place((right - bubble.width).roundToInt(), (cap.y - bubble.height / 2f).roundToInt(), zIndex = 2f)
            }
        }
    }
}

@Composable
private fun BackContent(title: String, onBack: () -> Unit) {
    val view = LocalView.current
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
    if (title.isNotEmpty()) {
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = title,
            style = MaterialTheme.typography.titleMedium,
            color = MaterialTheme.colorScheme.background,
            maxLines = 1,
            modifier = Modifier
                .widthIn(min = 100.dp, max = 250.dp)
                .padding(horizontal = 8.dp)
                .basicMarquee(),
        )
    }
}

@Composable
private fun TabsContent(
    items: List<NavBarItem>,
    selectedIndex: Int,
    hideLabel: Boolean,
    itemCoords: Array<LayoutCoordinates?>,
) {
    val view = LocalView.current
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
                .height(48.dp)
                .onGloballyPositioned { if (index < itemCoords.size) itemCoords[index] = it },
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

private const val DROP_MIN = 0.4f
private const val CHARGE_MS = 1100f
private const val BUBBLE_ID = "bubble"
private val BUBBLE_H = 44.dp
private val BUBBLE_RISE = 78.dp
private val BUBBLE_SHIFT = 10.dp

// Bubble's round end, above and left of the FAB
private fun bubbleCap(geo: BarGeo, p: Float, rise: Float, shift: Float): Offset {
    geo.rise = rise
    geo.shift = shift
    return Offset(geo.fabCx - shift * p, geo.fabCy - rise * p)
}

// Speech bubble and its neck to the FAB
private fun DrawScope.drawBubble(
    geo: BarGeo,
    fabR: Float,
    p: Float,
    scale: Float,
    width: Float,
    wobble: Float,
    neck: Boolean,
    color: Color,
    path: Path,
) {
    if (geo.bubbleH <= 0f) return
    val cap = bubbleCap(geo, p, BUBBLE_RISE.toPx(), BUBBLE_SHIFT.toPx())
    val h = geo.bubbleH * scale * (1f - 0.1f * wobble)
    val r = h / 2f
    if (neck) {
        val v = NECK_SPREAD * (1f - smooth(0.55f, 1f, p))
        if (metaball(path, Offset(geo.fabCx, geo.fabCy), fabR, cap, r, v)) drawPath(path, color)
    }
    // Widens to the left
    val w = (h + (geo.bubbleW - h) * width) * (1f + 0.08f * wobble)
    val right = cap.x + r
    drawRoundRect(
        color = color,
        topLeft = Offset(right - w, cap.y - r),
        size = Size(w, h),
        cornerRadius = CornerRadius(r),
    )
}
private const val NECK_SPREAD = 0.5f

// Bar stretch transform
private class BarGeo {
    var scaleX = 1f
    var scaleY = 1f
    var originX = 0f
    var originY = 0f
    var tx = 0f
    var ty = 0f
    var rightShift = 0f
    var cyShift = 0f
    var barH = 0f
    var barRight = 0f
    var barCy = 0f
    var fabCx = 0f
    var fabCy = 0f
    var bubbleW = 0f
    var bubbleH = 0f
    var rise = 0f
    var shift = 0f

    fun update(w: Float, h: Float, pull: Offset, gulp: Float) {
        if (w <= 0f || h <= 0f) return
        val sx = 0.75f * abs(pull.x) / w
        val sy = 0.5f * abs(pull.y) / h
        // Stretch one axis, squash the other
        scaleX = 1f + sx - 0.3f * sy + gulp
        scaleY = 1f + sy - 1.2f * sx - 0.6f * gulp
        originX = if (pull.x >= 0f) 0f else 1f
        originY = if (pull.y >= 0f) 0f else 1f
        tx = pull.x * 0.25f
        ty = pull.y * 0.5f
        rightShift = tx + if (originX == 0f) (scaleX - 1f) * w else 0f
        cyShift = ty + (scaleY - 1f) * h * (0.5f - originY)
    }
}

// Tab closest to the finger
private fun nearestItem(x: Float, count: Int, coords: Array<LayoutCoordinates?>, bar: LayoutCoordinates?): Int {
    if (bar == null || !bar.isAttached) return -1
    var best = -1
    var bestDist = Float.MAX_VALUE
    for (i in 0 until min(count, coords.size)) {
        val c = coords[i] ?: continue
        if (!c.isAttached) continue
        val mid = bar.localPositionOf(c, Offset(c.size.width / 2f, c.size.height / 2f)).x
        val dist = abs(mid - x)
        if (dist < bestDist) {
            bestDist = dist
            best = i
        }
    }
    return best
}

private fun tickHaptic(): Int =
    if (Build.VERSION.SDK_INT >= 34) HapticFeedbackConstants.SEGMENT_TICK
    else HapticFeedbackConstants.CLOCK_TICK

private fun smooth(a: Float, b: Float, x: Float): Float {
    val t = ((x - a) / (b - a)).coerceIn(0f, 1f)
    return t * t * (3f - 2f * t)
}

// How detached the FAB is from the bar
private fun detach(pos: Float, neckOn: Boolean): Float = if (neckOn) smooth(0.6f, 1f, pos) else 1f

private fun polar(c: Offset, angle: Float, r: Float) = Offset(c.x + cos(angle) * r, c.y + sin(angle) * r)

// Metaball neck between two circles
private fun metaball(path: Path, c1: Offset, r1: Float, c2: Offset, r2: Float, v: Float): Boolean {
    val d = (c2 - c1).getDistance()
    if (r1 <= 0f || r2 <= 0f || v <= 0.002f || d <= abs(r1 - r2)) return false
    val pi = PI.toFloat()
    val u1: Float
    val u2: Float
    if (d < r1 + r2) {
        u1 = acos(((r1 * r1 + d * d - r2 * r2) / (2 * r1 * d)).coerceIn(-1f, 1f))
        u2 = acos(((r2 * r2 + d * d - r1 * r1) / (2 * r2 * d)).coerceIn(-1f, 1f))
    } else {
        u1 = 0f
        u2 = 0f
    }
    val ang = atan2(c2.y - c1.y, c2.x - c1.x)
    val spread = acos(((r1 - r2) / d).coerceIn(-1f, 1f))
    val a1 = ang + u1 + (spread - u1) * v
    val a2 = ang - u1 - (spread - u1) * v
    val a3 = ang + pi - u2 - (pi - u2 - spread) * v
    val a4 = ang - pi + u2 + (pi - u2 - spread) * v
    val p1 = polar(c1, a1, r1)
    val p2 = polar(c1, a2, r1)
    val p3 = polar(c2, a3, r2)
    val p4 = polar(c2, a4, r2)
    val total = r1 + r2
    val k = min(v * 2.4f, (p1 - p3).getDistance() / total) * min(1f, d * 2f / total)
    val h1 = polar(p1, a1 - pi / 2f, r1 * k)
    val h2 = polar(p2, a2 + pi / 2f, r1 * k)
    val h3 = polar(p3, a3 + pi / 2f, r2 * k)
    val h4 = polar(p4, a4 - pi / 2f, r2 * k)
    path.reset()
    path.moveTo(p1.x, p1.y)
    path.cubicTo(h1.x, h1.y, h3.x, h3.y, p3.x, p3.y)
    path.lineTo(p4.x, p4.y)
    path.cubicTo(h4.x, h4.y, h2.x, h2.y, p2.x, p2.y)
    path.close()
    return true
}
