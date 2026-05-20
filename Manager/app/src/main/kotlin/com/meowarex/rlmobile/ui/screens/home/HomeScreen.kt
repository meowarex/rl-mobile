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
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.LifecycleResumeEffect
import androidx.paging.compose.collectAsLazyPagingItems
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.koin.koinScreenModel
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.SegmentedButton
import com.meowarex.rlmobile.ui.screens.about.AboutScreen
import com.meowarex.rlmobile.ui.screens.home.components.CommitList
import com.meowarex.rlmobile.ui.screens.logs.LogsListScreen
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsScreen
import com.meowarex.rlmobile.ui.screens.settings.SettingsScreen
import com.meowarex.rlmobile.util.*
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize

@Parcelize
class HomeScreen : Screen, Parcelable {
    @IgnoredOnParcel
    override val key = "Home"

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        val scope = rememberCoroutineScope()
        val model = koinScreenModel<HomeModel>()

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
                            Icon(painterResource(R.drawable.ic_refresh), contentDescription = null)
                        }
                        IconButton(onClick = { navigator.push(AboutScreen()) }) {
                            Icon(painterResource(R.drawable.ic_info), contentDescription = null)
                        }
                        IconButton(onClick = { navigator.push(LogsListScreen()) }) {
                            Icon(painterResource(R.drawable.ic_receipt), contentDescription = null)
                        }
                        IconButton(onClick = { navigator.push(SettingsScreen()) }) {
                            Icon(painterResource(R.drawable.ic_settings), contentDescription = null)
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
                        onInstall = { navigator.pushOnce(PatchOptionsScreen()) },
                        onReinstall = {
                            scope.launchIO {
                                val screen = model.createReinstallScreen() ?: return@launchIO
                                mainThread { navigator.push(screen) }
                            }
                        },
                        onLaunch = model::launchInstall,
                        onInfo = model::openCurrentAppInfo,
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
    onInstall: () -> Unit,
    onReinstall: () -> Unit,
    onLaunch: () -> Unit,
    onInfo: () -> Unit,
) {
    val install = state.install
    val currentVersionName = install?.version?.let { "v${it.toString()}" }
    val latestVersionName = state.latestTidalVersionCode?.let { "build $it" }

    if (install?.icon != null) {
        Image(
            painter = install.icon,
            contentDescription = null,
            modifier = Modifier
                .size(60.dp)
                .clip(CircleShape),
        )
    } else {
        Image(
            painter = painterResource(R.mipmap.ic_launcher),
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

    Button(
        onClick = if (install == null) onInstall else onReinstall,
        enabled = state.latestTidalVersionCode != null,
        modifier = Modifier.fillMaxWidth(),
    ) {
        val label = when {
            state.latestTidalVersionCode == null -> "Loading…"
            install == null -> "Install"
            install.isUpToDate == false -> "Update"
            else -> "Reinstall"
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
