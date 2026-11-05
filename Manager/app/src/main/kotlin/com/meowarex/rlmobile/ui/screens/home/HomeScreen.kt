package com.meowarex.rlmobile.ui.screens.home

import com.meowarex.rlmobile.manager.PreferencesManager
import org.koin.compose.koinInject
import androidx.compose.ui.unit.Velocity
import androidx.compose.ui.input.nestedscroll.NestedScrollSource
import androidx.compose.ui.input.nestedscroll.NestedScrollConnection
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.rememberScrollState
import com.meowarex.rlmobile.ui.components.LocalNavBarInset
import com.meowarex.rlmobile.ui.components.NavBarHost
import android.os.Build
import android.view.HapticFeedbackConstants
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.animateIntAsState
import androidx.compose.animation.core.spring
import androidx.compose.foundation.BorderStroke
import androidx.compose.material3.pulltorefresh.PullToRefreshBox
import androidx.compose.material3.pulltorefresh.rememberPullToRefreshState
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.layout.positionInRoot
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontVariation
import androidx.paging.compose.LazyPagingItems
import com.meowarex.rlmobile.network.models.RLCommit
import com.meowarex.rlmobile.ui.util.liquidRipple
import android.os.Parcelable
import androidx.activity.ComponentActivity
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Image
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.graphics.painter.BitmapPainter
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.toBitmap
import androidx.lifecycle.compose.LifecycleResumeEffect
import androidx.paging.compose.collectAsLazyPagingItems
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.koin.koinScreenModel
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.radiant.RadiantButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonSize
import com.meowarex.rlmobile.ui.components.radiant.RadiantButtonStyle
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantCard
import com.meowarex.rlmobile.ui.components.Tag
import com.meowarex.rlmobile.ui.theme.radiantStyle
import com.meowarex.rlmobile.ui.screens.about.AboutScreen
import com.meowarex.rlmobile.ui.screens.home.components.CommitList
import com.meowarex.rlmobile.ui.screens.home.components.UpdatedPatchesDialog
import com.meowarex.rlmobile.ui.screens.home.components.iconRes
import com.meowarex.rlmobile.ui.screens.home.components.labelRes
import com.meowarex.rlmobile.ui.screens.patching.PatchingScreen
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.screens.patchopts.PatchUpdateKind
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsScreen
import com.meowarex.rlmobile.ui.screens.settings.SettingsScreen
import com.meowarex.rlmobile.ui.widgets.managerupdate.ManagerUpdateDialog
import com.meowarex.rlmobile.ui.widgets.updater.UpdaterViewModel
import com.meowarex.rlmobile.util.*
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize
import org.koin.androidx.compose.koinViewModel

// Connected group shapes (i'm pretty sure these are the segment control replacements, but i havent worked on this in months so fuck knows)
private val ConnectedLeadingShape = RoundedCornerShape(
    topStart = 20.dp, bottomStart = 20.dp, topEnd = 6.dp, bottomEnd = 6.dp,
)
private val ConnectedTrailingShape = RoundedCornerShape(
    topStart = 6.dp, bottomStart = 6.dp, topEnd = 20.dp, bottomEnd = 20.dp,
)
private val ConnectedPressedShape = RoundedCornerShape(8.dp)

@Parcelize
class HomeScreen : Screen, Parcelable {
    @IgnoredOnParcel
    override val key = "Home"

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        val scope = rememberCoroutineScope()
        val model = koinScreenModel<HomeModel>()
        val activity = LocalContext.current as ComponentActivity
        val updater = koinViewModel<UpdaterViewModel>(viewModelStoreOwner = activity)
        val managerUpdateAvailable = updater.targetVersion != null
        val refreshing = model.refreshing
        // Options for the updated patches dialog
        var updateDialogOptions by rememberSaveable { mutableStateOf<PatchOptions?>(null) }

        LifecycleResumeEffect(Unit) {
            model.refresh(delay = true)
            onPauseOrDispose {}
        }

        val commits = model.commits.collectAsLazyPagingItems()

        // Patches tab in the app nav lands here
        SideEffect {
            NavBarHost.openPatches = { go ->
                if ((model.state as? HomeState.Loaded)?.install == null) {
                    go(PatchOptionsScreen())
                } else {
                    // Metadata's cached, so this is instant
                    model.createRepatchScreen(managerUpdateAvailable)?.let(go)
                }
            }
        }

        val prefs = koinInject<PreferencesManager>()
        val floatingNav = prefs.floatingNav

        Scaffold(
            contentWindowInsets = WindowInsets(0, 0, 0, 0),
            topBar = {
                // Nav bar off, old top bar instead
                if (!floatingNav) TopAppBar(
                    title = { Text(stringResource(R.string.rlmobile)) },
                    actions = {
                        if (managerUpdateAvailable) {
                            RadiantIconButton(
                                icon = painterResource(R.drawable.ic_update),
                                contentDescription = stringResource(R.string.action_update),
                                accent = true,
                                size = 40.dp,
                                onClick = updater::reopenDialog,
                            )
                        }
                        RadiantIconButton(
                            icon = painterResource(R.drawable.ic_favorite),
                            contentDescription = stringResource(R.string.navigation_contributors),
                            subtle = true,
                            onClick = { navigator.push(AboutScreen()) },
                        )
                        RadiantIconButton(
                            icon = painterResource(R.drawable.ic_settings),
                            contentDescription = stringResource(R.string.navigation_settings),
                            subtle = true,
                            onClick = { navigator.push(SettingsScreen()) },
                        )
                    },
                )
            },
        ) { pv ->
            Box(modifier = Modifier.fillMaxSize().padding(top = pv.calculateTopPadding())) {
                when (val state = model.state) {
                    HomeState.Loading -> Box(
                        contentAlignment = Alignment.Center,
                        modifier = Modifier.fillMaxSize(),
                    ) {
                        // Expressive loader (a sequence of morphing polygons rather than a spinner.) [M3E is cool i guess]
                        ContainedLoadingIndicator()
                    }

                    is HomeState.Loaded -> HomeContent(
                        state = state,
                        floatingNav = floatingNav,
                        commits = commits,
                        refreshing = refreshing,
                        onRefresh = {
                            model.refresh(force = true)
                            updater.checkForUpdates(force = true)
                        },
                        managerUpdateAvailable = managerUpdateAvailable,
                        isDevMode = model.isDevMode,
                        onInstall = { navigator.pushOnce(PatchOptionsScreen()) },
                        onRepatch = {
                            scope.launchIO {
                                val screen = model.createRepatchScreen(managerUpdateAvailable) ?: return@launchIO
                                mainThread { navigator.push(screen) }
                            }
                        },
                        onLaunch = model::launchInstall,
                        onInfo = model::openCurrentAppInfo,
                        onManagerUpdate = updater::reopenDialog,
                        onPatchesTag = {
                            scope.launchIO {
                                val options = model.createRepatchOptions() ?: return@launchIO
                                mainThread { updateDialogOptions = options }
                            }
                        },
                    )
                }

                val loaded = model.state as? HomeState.Loaded
                val changes = loaded?.patchChanges
                val dialogOptions = updateDialogOptions
                if (dialogOptions != null && loaded != null && changes != null) {
                    UpdatedPatchesDialog(
                        prefilledOptions = dialogOptions,
                        changes = changes,
                        installEnabled = loaded.canInstall(managerUpdateAvailable),
                        onDismiss = { updateDialogOptions = null },
                        onInstall = { config ->
                            updateDialogOptions = null
                            navigator.push(PatchingScreen(config))
                        },
                    )
                }

                model.managerUpdateDeltas?.let { deltas ->
                    ManagerUpdateDialog(
                        deltas = deltas,
                        onDismiss = model::dismissManagerUpdate,
                    )
                }
            }
        }
    }
}

@Composable
private fun HomeContent(
    state: HomeState.Loaded,
    floatingNav: Boolean,
    commits: LazyPagingItems<RLCommit>,
    refreshing: Boolean,
    onRefresh: () -> Unit,
    managerUpdateAvailable: Boolean,
    isDevMode: Boolean,
    onInstall: () -> Unit,
    onRepatch: () -> Unit,
    onManagerUpdate: () -> Unit,
    onLaunch: () -> Unit,
    onInfo: () -> Unit,
    onPatchesTag: () -> Unit,
) {
    val install = state.install
    val currentVersionName = (install?.version as? com.meowarex.rlmobile.ui.util.TidalVersion.Existing)
        ?.let { "v${it.name} (build ${it.code})" }
    val latestVersionName = state.latestTidalVersionCode?.let { "build $it" }

    val patchesBehind = state.patchesBehind
    val tidalBehind = state.tidalBehind

    val view = LocalView.current
    val pullState = rememberPullToRefreshState()
    var rippleTrigger by remember { mutableIntStateOf(0) }
    var textCenter by remember { mutableStateOf(Offset.Zero) }

    // Ticks while pulling, ripple at the threshold <3
    var lastHapticBucket by remember { mutableIntStateOf(0) }
    // Only the finger counts, not the card's animation
    var released by remember { mutableStateOf(false) }
    LaunchedEffect(pullState.distanceFraction, refreshing) {
        val fraction = pullState.distanceFraction
        if (released || refreshing) {
            if (!refreshing && fraction == 0f) {
                released = false
                lastHapticBucket = 0
            }
            return@LaunchedEffect
        }
        val bucket = (fraction * 10).toInt()
        if (fraction >= 1f && lastHapticBucket < 10) {
            view.performHapticFeedback(HapticFeedbackConstants.KEYBOARD_TAP)
            rippleTrigger++
            lastHapticBucket = 10
        } else if (fraction < 1f && bucket != lastHapticBucket) {
            if (bucket > lastHapticBucket) sliderHaptic(view)
            lastHapticBucket = bucket
        }
        if (fraction == 0f) lastHapticBucket = 0
    }

    val navBarBottom = WindowInsets.navigationBars.asPaddingValues().calculateBottomPadding()

    PullToRefreshBox(
        isRefreshing = refreshing,
        onRefresh = {
            released = true
            view.performHapticFeedback(HapticFeedbackConstants.KEYBOARD_TAP)
            onRefresh()
        },
        state = pullState,
        indicator = {},
        modifier = Modifier
            .fillMaxSize()
            .liquidRipple(
                trigger = rippleTrigger,
                origin = textCenter,
                durationMillis = 2800,
                amplitudeDp = 34f,
                frequency = 12f,
                decay = 4.5f,
                speedDp = 1400f,
            ),
    ) {
        val pullFraction = if (refreshing) 1f else pullState.distanceFraction

        // Commits scroll inside their own card
        Column(modifier = Modifier.fillMaxSize()) {
            // Only the top part pulls, never scrolls
            Column(modifier = Modifier.verticalScroll(rememberScrollState())) {
            PullCard(
                title = stringResource(R.string.navigation_refresh),
                // Top bar already covers the status bar
                underStatusBar = floatingNav,
                fraction = pullFraction,
                onTitlePositioned = { textCenter = it },
                onClick = {
                    // Tap gets its one ripple straight away
                    released = true
                    rippleTrigger++
                    view.performHapticFeedback(HapticFeedbackConstants.KEYBOARD_TAP)
                    onRefresh()
                },
            )

            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp)
                    .padding(top = 16.dp, bottom = 16.dp),
            ) {
                InstallHeroCard(
                    install = install,
                    currentVersionName = currentVersionName,
                    latestVersionName = latestVersionName,
                    patchUpdate = state.patchChanges?.takeIf { patchesBehind }?.kind,
                    tidalBehind = tidalBehind,
                    onLaunch = onLaunch,
                    onInfo = onInfo,
                    onPatchesTag = onPatchesTag,
                )

                HomeActions(
                    state = state,
                    managerUpdateAvailable = managerUpdateAvailable,
                    isDevMode = isDevMode,
                    onInstall = onInstall,
                    onRepatch = onRepatch,
                    onManagerUpdate = onManagerUpdate,
                )
            }

            }

            RadiantCard(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp)
                    // No nav bar, keep the old edge gap
                    .padding(bottom = if (floatingNav) 0.dp else navBarBottom + 16.dp)
                    .weight(1f)
                    // Scrolling the box never moves the page
                    .nestedScroll(KeepScrollInside),
            ) {
                CommitList(
                    commits = commits,
                    contentPadding = PaddingValues(bottom = if (floatingNav) navBarBottom + LocalNavBarInset.current else 0.dp),
                )
            }
        }
    }
}

// Eats leftover scroll so the list can't pull
private object KeepScrollInside : NestedScrollConnection {
    override fun onPostScroll(consumed: Offset, available: Offset, source: NestedScrollSource) = available
    override suspend fun onPostFling(consumed: Velocity, available: Velocity) = available
}

// Pull down to refresh, like Essentials' device card <3
@Composable
private fun PullCard(
    title: String,
    underStatusBar: Boolean,
    fraction: Float,
    onTitlePositioned: (Offset) -> Unit,
    onClick: () -> Unit,
) {
    val thresholdPassed = fraction >= 1f
    val statusBarTop = if (underStatusBar) WindowInsets.statusBars.asPaddingValues().calculateTopPadding() else 0.dp

    val cardExpansion by animateDpAsState(
        targetValue = 120.dp * fraction.coerceIn(0f, 1f),
        animationSpec = spring(stiffness = Spring.StiffnessMediumLow),
        label = "cardExpansion",
    )
    val containerColor by animateColorAsState(
        targetValue = if (thresholdPassed) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surfaceContainerLow,
        animationSpec = tween(durationMillis = 300),
        label = "containerColor",
    )
    val contentColor by animateColorAsState(
        targetValue = if (thresholdPassed) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.primary,
        animationSpec = tween(durationMillis = 300),
        label = "contentColor",
    )
    val borderColor by animateColorAsState(
        targetValue = if (thresholdPassed) Color.Transparent else MaterialTheme.colorScheme.outlineVariant,
        animationSpec = tween(durationMillis = 300),
        label = "borderColor",
    )
    val chevronAlpha by animateFloatAsState(
        targetValue = if (thresholdPassed) 0f else 1f,
        animationSpec = tween(durationMillis = 300),
        label = "chevronAlpha",
    )
    val chevronWidth by animateDpAsState(
        targetValue = if (thresholdPassed) 0.dp else 24.dp + 8.dp,
        animationSpec = tween(durationMillis = 300),
        label = "chevronWidth",
    )
    val fontWeight by animateIntAsState(
        targetValue = if (thresholdPassed) 700 else 500,
        animationSpec = tween(durationMillis = 100),
        label = "fontWeight",
    )
    val textScale by animateFloatAsState(
        targetValue = if (thresholdPassed) 1.5f else 1f,
        animationSpec = tween(durationMillis = 300),
        label = "textScale",
    )
    // Wider as you pull
    val fontWidth = remember(fraction) { (100f + (fraction.coerceIn(0f, 1f) * 50f)).toInt().toFloat() }
    val fontFamily = remember(fontWidth, fontWeight) {
        FontFamily(
            Font(
                R.font.google_sans_flex,
                variationSettings = FontVariation.Settings(
                    FontVariation.width(fontWidth),
                    FontVariation.weight(fontWeight),
                    FontVariation.Setting("ROND", 100f),
                ),
            ),
        )
    }

    OutlinedCard(
        onClick = onClick,
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp)
            .height(64.dp + statusBarTop + cardExpansion),
        // Flat top only when hugging the screen edge
        shape = RoundedCornerShape(
            topStart = if (underStatusBar) 0.dp else 28.dp,
            topEnd = if (underStatusBar) 0.dp else 28.dp,
            bottomStart = 28.dp,
            bottomEnd = 28.dp,
        ),
        colors = CardDefaults.outlinedCardColors(
            containerColor = containerColor,
            contentColor = if (thresholdPassed) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface,
        ),
        border = BorderStroke(1.dp, borderColor),
    ) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center,
            ) {
                Spacer(modifier = Modifier.height(statusBarTop))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(
                        modifier = Modifier
                            .width(chevronWidth)
                            .graphicsLayer { alpha = chevronAlpha },
                    ) {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Icon(
                                painter = painterResource(R.drawable.ic_arrow_down_small),
                                contentDescription = null,
                                modifier = Modifier
                                    .size(24.dp)
                                    .graphicsLayer { rotationZ = (fraction * 180f).coerceIn(0f, 180f) },
                                tint = contentColor,
                            )
                            Spacer(modifier = Modifier.width(8.dp))
                        }
                    }
                    Text(
                        text = title,
                        style = MaterialTheme.typography.titleMedium.copy(fontFamily = fontFamily),
                        color = if (thresholdPassed) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface,
                        modifier = Modifier
                            .onGloballyPositioned { coords ->
                                val pos = coords.positionInRoot()
                                onTitlePositioned(Offset(pos.x + coords.size.width / 2f, pos.y + coords.size.height / 2f))
                            }
                            .graphicsLayer {
                                scaleX = textScale
                                scaleY = textScale
                            },
                    )
                }
            }
        }
    }
}

// Main install/repatch/update buttons
@Composable
private fun HomeActions(
    state: HomeState.Loaded,
    managerUpdateAvailable: Boolean,
    isDevMode: Boolean,
    onInstall: () -> Unit,
    onRepatch: () -> Unit,
    onManagerUpdate: () -> Unit,
) {
    val install = state.install
    val patchesBehind = state.patchesBehind
    val tidalBehind = state.tidalBehind

    val blockedByManagerUpdate = managerUpdateAvailable && (patchesBehind || tidalBehind)
    val buttonEnabled = state.canInstall(managerUpdateAvailable)

    val label = when {
        state.offline && install != null -> "Local Repatch"
        state.offline -> "No Network"
        install == null && state.latestTidalVersionCode == null -> "Loading…"
        install == null -> "Install"
        patchesBehind && tidalBehind -> "Update Patches & TIDAL"
        patchesBehind -> "Update Patches"
        tidalBehind -> "Update TIDAL"
        else -> "Repatch"
    }

    // Repatch still works, updating needs the new Manager
    if (blockedByManagerUpdate) Row(
        horizontalArrangement = Arrangement.spacedBy(10.dp),
        modifier = Modifier.fillMaxWidth(),
    ) {
        RadiantButton(
            text = "Repatch",
            icon = painterResource(R.drawable.ic_sparkle),
            onClick = onRepatch,
            enabled = state.canInstall(managerUpdateAvailable = false),
            style = RadiantButtonStyle.Accent,
            size = RadiantButtonSize.Large,
            fillWidth = true,
            modifier = Modifier.weight(1f),
        )
        ManagerUpdateButton(onClick = onManagerUpdate, modifier = Modifier.weight(1f))
    } else if (install == null && managerUpdateAvailable && !isDevMode) {
        // Fresh installs need the new Manager too
        ManagerUpdateButton(onClick = onManagerUpdate, modifier = Modifier.fillMaxWidth())
    } else {
        // The main button (repatch or update button)
        RadiantButton(
            text = label,
            icon = painterResource(
                if (install == null) R.drawable.ic_download else R.drawable.ic_sparkle
            ),
            onClick = if (install == null) onInstall else onRepatch,
            enabled = buttonEnabled,
            style = RadiantButtonStyle.Accent,
            size = RadiantButtonSize.Large,
            fillWidth = true,
        )
    }

    if (state.offline && install != null) {
        Text(
            text = "No Network Connection",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            textAlign = TextAlign.Center,
            modifier = Modifier.fillMaxWidth(),
        )
    }
}

// Same tick Essentials uses on sliders
private fun sliderHaptic(view: android.view.View) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
        view.performHapticFeedback(HapticFeedbackConstants.SEGMENT_FREQUENT_TICK)
    } else {
        view.performHapticFeedback(HapticFeedbackConstants.CLOCK_TICK)
    }
}

/**
 * Greyed out, but still opens the update modal
 */
@Composable
private fun ManagerUpdateButton(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
) {
    Box(modifier = modifier) {
        RadiantButton(
            text = "Update",
            icon = painterResource(R.drawable.ic_update),
            onClick = onClick,
            enabled = false,
            style = RadiantButtonStyle.Accent,
            size = RadiantButtonSize.Large,
            fillWidth = true,
        )
        Box(
            modifier = Modifier
                .matchParentSize()
                .clip(RoundedCornerShape(RadiantButtonSize.Large.corner))
                .clickable(onClick = onClick),
        )
    }
}

/**
 * The identity block: (what is installed & which build etc etc whatever)
 */
@Composable
private fun InstallHeroCard(
    install: InstallData?,
    currentVersionName: String?,
    latestVersionName: String?,
    /** Shown once the update's changes are known */
    patchUpdate: PatchUpdateKind?,
    tidalBehind: Boolean,
    onLaunch: () -> Unit,
    onInfo: () -> Unit,
    onPatchesTag: () -> Unit,
) {
    val fallbackPainter = if (install?.icon == null) {
        // R.mipmap.ic_launcher is an adaptive-icon XML on API 26+, which painterResource cannot decode.
        val context = LocalContext.current
        remember {
            val drawable = ContextCompat.getDrawable(context, R.mipmap.ic_launcher)
            drawable?.toBitmap()?.asImageBitmap()?.let(::BitmapPainter)
        }
    } else null

    val iconPainter = install?.icon ?: fallbackPainter

    val hero = radiantStyle.heroCard

    // Legacy keeps the original flat centred stack rather than wrapping it in a raised card. (thx claude)
    HeroContainer(hero) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(10.dp),
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 18.dp, vertical = 18.dp),
        ) {
            if (iconPainter != null) {
                // Clipped to a 9-sided cookie rather than a circle — the app icon is the one place
                // a non-rectilinear silhouette reads as deliberate instead of noisy. (thx claude again)
                Image(
                    painter = iconPainter,
                    contentDescription = null,
                    modifier = Modifier
                        .size(60.dp)
                        .clip(MaterialShapes.Cookie9Sided.toShape()),
                )
            }

            if (currentVersionName != null || latestVersionName != null) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(2.dp),
                ) {
                    currentVersionName?.let {
                        Text(
                            text = "Current: $it",
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant,
                            textAlign = TextAlign.Center,
                        )
                    }
                    latestVersionName?.let {
                        Text(
                            text = "Latest: $it",
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant,
                            textAlign = TextAlign.Center,
                        )
                    }
                }
            }

            AnimatedVisibility(visible = patchUpdate != null || tidalBehind) {
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    if (patchUpdate != null) Tag(
                        text = stringResource(patchUpdate.labelRes),
                        icon = painterResource(patchUpdate.iconRes),
                        onClick = onPatchesTag,
                    )
                    if (tidalBehind) Tag(
                        text = "TIDAL Update!",
                        icon = painterResource(R.drawable.ic_update),
                        tint = MaterialTheme.colorScheme.tertiary,
                    )
                }
            }

            AnimatedVisibility(visible = install != null) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    modifier = Modifier.fillMaxWidth(),
                ) {
                    RadiantButton(
                        text = stringResource(R.string.action_launch),
                        icon = painterResource(R.drawable.ic_launch),
                        onClick = onLaunch,
                        modifier = Modifier.weight(1f),
                    )
                    RadiantButton(
                        text = stringResource(R.string.action_open_info),
                        icon = painterResource(R.drawable.ic_info),
                        onClick = onInfo,
                        modifier = Modifier.weight(1f),
                    )
                }
            }
        }
    }
}

/**
 * Wraps the home identity block in a raised card for Radiant (renders it inline for Legacy UI)
 */
@Composable
private fun HeroContainer(
    carded: Boolean,
    content: @Composable ColumnScope.() -> Unit,
) {
    if (carded) {
        RadiantCard(modifier = Modifier.fillMaxWidth(), content = content)
    } else {
        Column(modifier = Modifier.fillMaxWidth(), content = content)
    }
}

/**
 * Refresh Spinner thing
 */
@Composable
internal fun rememberRefreshAngle(): () -> Float {
    val transition = rememberInfiniteTransition(label = "RefreshSpin")
    val angle by transition.animateFloat(
        initialValue = 0f,
        targetValue = 360f,
        animationSpec = infiniteRepeatable(tween(900, easing = LinearEasing)),
        label = "RefreshSpinAngle",
    )
    return { angle }
}
