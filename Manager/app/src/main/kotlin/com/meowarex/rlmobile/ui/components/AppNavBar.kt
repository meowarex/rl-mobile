package com.meowarex.rlmobile.ui.components

import androidx.activity.ComponentActivity
import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.togetherWith
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.Navigator
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.screens.about.AboutScreen
import com.meowarex.rlmobile.ui.screens.componentopts.ComponentOptionsScreen
import com.meowarex.rlmobile.ui.screens.home.HomeScreen
import com.meowarex.rlmobile.ui.screens.log.LogScreen
import com.meowarex.rlmobile.ui.screens.patching.PatchingScreen
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsScreen
import com.meowarex.rlmobile.ui.screens.permissions.PermissionsScreen
import com.meowarex.rlmobile.ui.screens.settings.SettingsScreen
import com.meowarex.rlmobile.ui.widgets.updater.UpdaterViewModel
import org.koin.androidx.compose.koinViewModel

// No bar mid install or on permissions
fun navBarVisible(screen: Screen?): Boolean =
    screen != null && screen !is PatchingScreen && screen !is PermissionsScreen

// One bar for every screen, like Essentials <3
@Composable
fun AppNavBar(navigator: Navigator, modifier: Modifier = Modifier) {
    val activity = LocalContext.current as ComponentActivity
    val updater = koinViewModel<UpdaterViewModel>(viewModelStoreOwner = activity)
    val screen = navigator.lastItem
    val tab = tabIndexOf(screen)

    val items = listOfNotNull(
        NavBarItem(
            icon = painterResource(R.drawable.ic_sparkle),
            label = stringResource(R.string.navigation_home),
            onClick = { if (navigator.size > 1) navigator.replaceAll(listOf(navigator.items.first())) },
        ),
        NavBarItem(
            icon = painterResource(R.drawable.ic_healing),
            label = stringResource(R.string.navigation_patches),
            onClick = {
                if (tab != 1) NavBarHost.openPatches?.invoke { switchTab(navigator, it) }
            },
        ),
        NavBarItem(
            icon = painterResource(R.drawable.ic_settings),
            label = stringResource(R.string.navigation_settings),
            onClick = {
                if (tab != 2) switchTab(navigator, SettingsScreen())
            },
        ),
        // Last so tab indexes don't shift
        if (updater.targetVersion != null) NavBarItem(
            icon = painterResource(R.drawable.ic_update),
            label = stringResource(R.string.action_update),
            onClick = updater::reopenDialog,
            hasBadge = true,
        ) else null,
    )

    val title = titleFor(screen)

    // Contributors live behind the heart now
    val openContributors = { if (screen !is AboutScreen) navigator.push(AboutScreen()) }
    val heart: @Composable () -> Unit = {
        Icon(
            painter = painterResource(R.drawable.ic_favorite),
            contentDescription = stringResource(R.string.navigation_contributors),
        )
    }

    AnimatedContent(
        targetState = tab >= 0,
        transitionSpec = { fadeIn() togetherWith fadeOut() },
        label = "nav_bar_mode",
        modifier = modifier,
    ) { tabbed ->
        if (tabbed) {
            FloatingNavBar(
                items = items,
                selectedIndex = tab,
                onFabClick = openContributors,
                fabContent = heart,
            )
        } else {
            FloatingNavBar(
                items = emptyList(),
                selectedIndex = -1,
                title = title,
                onBack = { navigator.pop() },
                onFabClick = openContributors,
                fabContent = heart,
            )
        }
    }
}

// One stack swap so it animates once
private fun switchTab(navigator: Navigator, screen: Screen) {
    navigator.replaceAll(listOf(navigator.items.first(), screen))
}

// Tab order, decides which way it slides
fun tabIndexOf(screen: Screen?): Int = when (screen) {
    is HomeScreen -> 0
    is PatchOptionsScreen -> 1
    is SettingsScreen -> 2
    else -> -1
}

@Composable
private fun titleFor(screen: Screen?): String = when (screen) {
    is AboutScreen -> stringResource(R.string.navigation_contributors)
    is ComponentOptionsScreen -> stringResource(R.string.navigation_components)
    is LogScreen -> stringResource(R.string.navigation_log)
    else -> ""
}
