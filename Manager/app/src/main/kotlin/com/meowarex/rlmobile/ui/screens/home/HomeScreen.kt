package com.meowarex.rlmobile.ui.screens.home

import android.os.Parcelable
import androidx.activity.ComponentActivity
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.asImageBitmap
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
                            onClick = { model.refresh() },
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
                        onInstall = { navigator.pushOnce(PatchOptionsScreen()) },
                        onRepatch = {
                            scope.launchIO {
                                val screen = model.createRepatchScreen() ?: return@launchIO
                                mainThread { navigator.push(screen) }
                            }
                        },
                        onLaunch = model::launchInstall,
                        onInfo = model::openCurrentAppInfo,
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
    onInstall: () -> Unit,
    onRepatch: () -> Unit,
    onLaunch: () -> Unit,
    onInfo: () -> Unit,
) {
    val install = state.install
    val currentVersionName = (install?.version as? com.meowarex.rlmobile.ui.util.TidalVersion.Existing)
        ?.let { "v${it.name} (build ${it.code})" }
    val latestVersionName = state.latestTidalVersionCode?.let { "build $it" }

    val patchesBehind = install != null && install.patchesUpToDate == false
    val tidalBehind = install != null && install.tidalUpToDate == false

    InstallHeroCard(
        install = install,
        currentVersionName = currentVersionName,
        latestVersionName = latestVersionName,
        patchesBehind = patchesBehind,
        tidalBehind = tidalBehind,
        onLaunch = onLaunch,
        onInfo = onInfo,
    )

    val blockedByManagerUpdate = managerUpdateAvailable && (patchesBehind || tidalBehind)
    val canLocalRepatch = install != null && state.offlineRepatchReady
    val onlineEnabled = state.latestTidalVersionCode != null || install != null
    val buttonEnabled = !blockedByManagerUpdate && (if (state.offline) canLocalRepatch else onlineEnabled)

    val label = when {
        blockedByManagerUpdate -> "Manager Update Required"
        state.offline && install != null -> "Local Repatch"
        state.offline -> "No Network"
        install == null && state.latestTidalVersionCode == null -> "Loading…"
        install == null -> "Install"
        patchesBehind && tidalBehind -> "Update Patches & TIDAL"
        patchesBehind -> "Update Patches"
        tidalBehind -> "Update TIDAL"
        else -> "Repatch"
    }

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
 * The identity block: (what is installed & which build etc etc whatever)
 */
@Composable
private fun InstallHeroCard(
    install: InstallData?,
    currentVersionName: String?,
    latestVersionName: String?,
    patchesBehind: Boolean,
    tidalBehind: Boolean,
    onLaunch: () -> Unit,
    onInfo: () -> Unit,
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

            AnimatedVisibility(visible = patchesBehind || tidalBehind) {
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    if (patchesBehind) Tag(
                        text = "New Patches!",
                        icon = painterResource(R.drawable.ic_sparkle),
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
