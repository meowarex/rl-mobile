package com.meowarex.rlmobile.pebble

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.screens.patchopts.CompanionAppSpec
import com.meowarex.rlmobile.util.showToast
import io.rebble.pebblekit2.client.DefaultPebbleSender
import io.rebble.pebblekit2.common.model.TimelineResult

// Watchapp install state and store links
object PebbleWatchapp {
    private const val PROBE_PIN_ID = "rl-install-probe"
    private const val STORE_WEB = "https://apps.repebble.com/"
    private const val APPS_TAB = "pebble://navbar/index"

    enum class InstallState { Installed, NotInstalled, Unknown }

    // Deleting a missing pin reveals install state
    suspend fun installState(context: Context): InstallState = runCatching {
        DefaultPebbleSender(context.applicationContext).use { sender ->
            when (sender.deleteTimelinePin(WatchProtocol.APP_UUID, PROBE_PIN_ID)) {
                TimelineResult.FailedUnknownPin, TimelineResult.Success -> InstallState.Installed
                TimelineResult.FailedNoPermissions -> InstallState.NotInstalled
                else -> InstallState.Unknown
            }
        }
    }.getOrDefault(InstallState.Unknown)

    fun canInstall(app: CompanionAppSpec): Boolean = !app.storeId.isNullOrBlank()

    fun install(context: Context, app: CompanionAppSpec) = openStorePage(context, app)

    // Apps tab, My Apps holds the settings
    fun openSettings(context: Context) {
        if (!start(context, Intent(Intent.ACTION_VIEW, Uri.parse(APPS_TAB)))) {
            context.showToast(R.string.pebble_app_missing)
        }
    }

    // Pebble app store page, else the web listing
    private fun openStorePage(context: Context, app: CompanionAppSpec) {
        val storeId = app.storeId?.takeIf { it.isNotBlank() } ?: return
        val deepLink = Uri.Builder().scheme("pebble").authority("appstore").appendPath(storeId)
            .apply { app.storeSource?.let { appendQueryParameter("source", it) } }
            .build()
        if (start(context, Intent(Intent.ACTION_VIEW, deepLink))) return
        if (!start(context, Intent(Intent.ACTION_VIEW, Uri.parse(STORE_WEB + storeId)))) {
            context.showToast(R.string.pebble_app_missing)
        }
    }

    private fun start(context: Context, intent: Intent): Boolean = try {
        context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
        true
    } catch (_: ActivityNotFoundException) {
        false
    }
}
