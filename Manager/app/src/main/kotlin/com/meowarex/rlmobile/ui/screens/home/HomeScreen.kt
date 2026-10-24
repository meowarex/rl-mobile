package com.meowarex.rlmobile.ui.screens.home

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
        val refreshAngle = rememberRefreshAngle()
        // Options for the updated patches dialog
        var updateDialogOptions by rememberSaveable { mutableStateOf<PatchOptions?>(null) }

        LifecycleResumeEffect(Unit) {
            model.refresh(delay = true)
            onPauseOrDispose {}
        }

        Scaffold(
            topBar = {
                // Compact bar
                TopAppBar(
                    title = { Text(stringResource(R.string.rlmobile)) },
                    actions = {
                        RadiantIconButton(
                            icon = painterResource(R.drawable.ic_refresh),
                            contentDescription = stringResource(R.string.navigation_refresh),
                            subtle = true,
                            enabled = !refreshing,
                            onClick = {
                                model.refresh(force = true)
                                updater.checkForUpdates(force = true)
                            },
                            modifier = Modifier.graphicsLayer {
                                rotationZ = if (refreshing) refreshAngle() else 0f
                            },
                        )
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
                            icon = painterResource(R.drawable.ic_info),
                            contentDescription = stringResource(R.string.navigation_about),
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
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier
                    .padding(pv)
                    .padding(horizontal = 16.dp)
                    .fillMaxSize(),
            ) {
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
                        commits = model.commits,
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
private fun ColumnScope.HomeContent(
    state: HomeState.Loaded,
    commits: kotlinx.coroutines.flow.Flow<androidx.paging.PagingData<com.meowarex.rlmobile.network.models.GithubCommit>>,
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

    RadiantCard(
        modifier = Modifier
            .fillMaxWidth()
            .weight(1f),
    ) {
        CommitList(commits = commits.collectAsLazyPagingItems())
    }

    Spacer(Modifier.height(4.dp))
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

            Text(
                text = install?.name ?: stringResource(R.string.app_name),
                style = MaterialTheme.typography.titleLarge,
                textAlign = TextAlign.Center,
            )

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
