package com.meowarex.rlmobile.updatechecker

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.content.getSystemService
import androidx.work.*
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PreferencesManager
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
import com.meowarex.rlmobile.network.utils.SemVer
import com.meowarex.rlmobile.network.utils.fold
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import java.util.concurrent.TimeUnit

private const val CHANNEL_ID = "rl_updates"
private const val NOTIFICATION_ID = 4242
private const val WORK_NAME = "rl_update_check"

class UpdateCheckWorker(
    appContext: Context,
    params: WorkerParameters,
) : CoroutineWorker(appContext, params), KoinComponent {

    private val github: RadiantLyricsGithubService by inject()
    private val prefs: PreferencesManager by inject()

    override suspend fun doWork(): Result {
        if (!prefs.autoUpdateCheck) return Result.success()

        val current = SemVer.parseOrNull(BuildConfig.VERSION_NAME) ?: return Result.success()

        val releases = github.getManagerReleases().fold(
            success = { it },
            fail = { return Result.retry() },
        )

        val latestVersion = releases
            .mapNotNull { r -> SemVer.parseOrNull((r.name ?: "").removePrefix("v"))?.let { v -> v to r } }
            .maxByOrNull { it.first }
            ?: return Result.success()

        val (version, release) = latestVersion
        if (current >= version) return Result.success()

        Log.i(BuildConfig.TAG, "Update available: $version (installed $current)")
        postUpdateNotification(version.toString(), release.htmlUrl)
        return Result.success()
    }

    private fun postUpdateNotification(version: String, releaseUrl: String) {
        val nm = applicationContext.getSystemService<NotificationManager>() ?: return

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                applicationContext.getString(R.string.notif_channel_updates),
                NotificationManager.IMPORTANCE_DEFAULT,
            )
            nm.createNotificationChannel(channel)
        }

        if (Build.VERSION.SDK_INT >= 33 &&
            ActivityCompat.checkSelfPermission(applicationContext, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.w(BuildConfig.TAG, "Notification permission not granted; skipping update notification")
            return
        }

        val pendingIntent = PendingIntent.getActivity(
            applicationContext,
            0,
            Intent(Intent.ACTION_VIEW, Uri.parse(releaseUrl)).apply { addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) },
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )

        val notif = NotificationCompat.Builder(applicationContext, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_launcher_monochrome)
            .setContentTitle(applicationContext.getString(R.string.notif_update_title))
            .setContentText(applicationContext.getString(R.string.notif_update_text, version))
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .build()

        nm.notify(NOTIFICATION_ID, notif)
    }

    companion object {
        fun schedule(context: Context) {
            val request = PeriodicWorkRequestBuilder<UpdateCheckWorker>(6, TimeUnit.HOURS)
                .setConstraints(Constraints.Builder().setRequiredNetworkType(NetworkType.CONNECTED).build())
                .build()
            WorkManager.getInstance(context).enqueueUniquePeriodicWork(
                WORK_NAME, ExistingPeriodicWorkPolicy.UPDATE, request,
            )
        }

        fun cancel(context: Context) {
            WorkManager.getInstance(context).cancelUniqueWork(WORK_NAME)
        }
    }
}
