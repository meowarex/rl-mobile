package com.meowarex.rlmobile.ui.screens.home

import android.os.Parcelable
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.painter.BitmapPainter
import androidx.activity.ComponentActivity
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
import com.meowarex.rlmobile.ui.components.SegmentedButton
import com.meowarex.rlmobile.ui.components.Tag
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
                TopAppBar(
                    title = { Text(stringResource(R.string.navigation_home)) },
                    actions = {
                        IconButton(onClick = { model.refresh() }) {
                            Icon(
                                painterResource(R.drawable.ic_refresh),
                                contentDescription = stringResource(R.string.navigation_refresh),
                            )
                        }
                        if (managerUpdateAvailable) {
                            IconButton(onClick = updater::reopenDialog) {
                                Icon(
                                    painterResource(R.drawable.ic_update),
                                    contentDescription = stringResource(R.string.action_update),
                                )
                            }
                        }
                        IconButton(onClick = { navigator.push(AboutScreen()) }) {
                            Icon(
                                painterResource(R.drawable.ic_info),
                                contentDescription = stringResource(R.string.navigation_about),
                            )
                        }
                        IconButton(onClick = { navigator.push(SettingsScreen()) }) {
                            Icon(
                                painterResource(R.drawable.ic_settings),
                                contentDescription = stringResource(R.string.navigation_settings),
                            )
                        }
                    },
                )
            },
        ) { pv ->
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier
                    .padding(pv)
                    .padding(16.dp)
                    .fillMaxSize(),
            ) {
                val state = model.state
                when (state) {
                    HomeState.Loading -> Box(
                        contentAlignment = Alignment.Center,
                        modifier = Modifier.fillMaxSize(),
                    ) { CircularProgressIndicator() }

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

    val fallbackPainter = if (install?.icon == null) {
        // R.mipmap.ic_launcher is an adaptive-icon XML on API 26+, which painterResource cannot decode.
        val context = LocalContext.current
        remember {
            val drawable = ContextCompat.getDrawable(context, R.mipmap.ic_launcher)
            drawable?.toBitmap()?.asImageBitmap()?.let(::BitmapPainter)
        }
    } else null

    val iconPainter = install?.icon ?: fallbackPainter
    if (iconPainter != null) {
        Image(
            painter = iconPainter,
            contentDescription = null,
            modifier = Modifier
                .size(60.dp)
                .clip(CircleShape),
        )
    }

    Text(
        text = install?.name ?: stringResource(R.string.app_name),
        style = MaterialTheme.typography.titleLarge,
    )

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier.fillMaxWidth(),
    ) {
        AnimatedVisibility(visible = currentVersionName != null) {
            Text(
                text = "Current: ${currentVersionName ?: "-"}",
                style = MaterialTheme.typography.labelLarge,
                color = LocalContentColor.current.copy(alpha = 0.5f),
                textAlign = TextAlign.Center,
            )
        }
        AnimatedVisibility(visible = latestVersionName != null) {
            Text(
                text = "Latest: ${latestVersionName ?: "-"}",
                style = MaterialTheme.typography.labelLarge,
                color = LocalContentColor.current.copy(alpha = 0.5f),
                textAlign = TextAlign.Center,
            )
        }
    }

    val patchesBehind = install != null && install.patchesUpToDate == false
    val tidalBehind = install != null && install.tidalUpToDate == false
    AnimatedVisibility(visible = patchesBehind || tidalBehind) {
        Row(horizontalArrangement = Arrangement.spacedBy(6.dp)) {
            if (patchesBehind) Tag(text = "New Patches!")
            if (tidalBehind) Tag(text = "TIDAL Update!")
        }
    }

    val blockedByManagerUpdate = managerUpdateAvailable && (patchesBehind || tidalBehind)
    Button(
        onClick = if (install == null) onInstall else onRepatch,
        enabled = state.latestTidalVersionCode != null && !blockedByManagerUpdate,
        modifier = Modifier.fillMaxWidth(),
    ) {
        val label = when {
            blockedByManagerUpdate -> "Manager Update Required"
            state.latestTidalVersionCode == null -> "Loading…"
            install == null -> "Install"
            patchesBehind && tidalBehind -> "Update Patches & TIDAL"
            patchesBehind -> "Update Patches"
            tidalBehind -> "Update TIDAL"
            else -> "Repatch"
        }
        Text(
            text = label,
            textAlign = TextAlign.Center,
            maxLines = 1,
            modifier = Modifier
                .basicMarquee()
                .fillMaxWidth(),
        )
    }

    AnimatedVisibility(visible = install != null) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(2.dp),
            modifier = Modifier.clip(RoundedCornerShape(16.dp)),
        ) {
            SegmentedButton(
                icon = painterResource(R.drawable.ic_launch),
                text = stringResource(R.string.action_launch),
                onClick = onLaunch,
            )
            SegmentedButton(
                icon = painterResource(R.drawable.ic_info),
                text = stringResource(R.string.action_open_info),
                onClick = onInfo,
            )
        }
    }

    ElevatedCard(modifier = Modifier.fillMaxSize()) {
        CommitList(commits = commits.collectAsLazyPagingItems())
    }
}
