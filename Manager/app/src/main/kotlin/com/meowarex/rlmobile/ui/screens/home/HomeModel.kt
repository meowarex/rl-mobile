package com.meowarex.rlmobile.ui.screens.home

import android.app.Application
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.provider.Settings
import android.util.Log
import androidx.compose.runtime.*
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.painter.BitmapPainter
import androidx.core.graphics.drawable.toBitmap
import androidx.core.net.toUri
import cafe.adriel.voyager.core.model.ScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.github.diamondminer88.zip.ZipReader
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.network.models.RLBuildInfo
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
import com.meowarex.rlmobile.network.utils.fold
import com.meowarex.rlmobile.patcher.InstallMetadata
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsScreen
import com.meowarex.rlmobile.ui.util.TidalVersion
import com.meowarex.rlmobile.ui.util.toUnsafeImmutable
import com.meowarex.rlmobile.util.*
import kotlinx.coroutines.*
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromStream

class HomeModel(
    private val application: Application,
    private val github: RadiantLyricsGithubService,
    private val json: Json,
) : ScreenModel {
    var installsState by mutableStateOf<InstallsState>(InstallsState.Fetching)
        private set

    private val refreshingLock = Mutex()
    private var remoteDataJson: RLBuildInfo? = null

    init {
        refresh()
    }

    fun refresh(delay: Boolean = false) = screenModelScope.launchIO {
        if (refreshingLock.isLocked) return@launchIO

        if (delay) {
            delay(250)

            if (refreshingLock.isLocked)
                return@launchIO
        }

        refreshingLock.withLock {
            val packages = fetchRadiantLyricsPackages()

            val jobs = listOf(
                screenModelScope.launch(Dispatchers.IO) {
                    fetchInstallations(packages)
                },
                screenModelScope.launch(Dispatchers.IO) {
                    if (remoteDataJson == null)
                        fetchRemoteData()
                }
            )

            jobs.joinAll()
            mainThread { refreshInstallationsUpToDate(packages) }
        }
    }

    fun openApp(packageName: String) {
        val launchIntent = application.packageManager
            .getLaunchIntentForPackage(packageName)

        if (launchIntent != null) {
            application.startActivity(launchIntent)
        } else {
            application.showToast(R.string.launch_app_fail)
        }
    }

    fun openAppInfo(packageName: String) {
        val launchIntent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            .setData("package:$packageName".toUri())

        application.startActivity(launchIntent)
    }

    fun createPrefilledPatchOptsScreen(packageName: String): PatchOptionsScreen {
        val metadata = try {
            val applicationInfo = application.packageManager.getApplicationInfo(packageName, 0)
            val metadataFile = ZipReader(applicationInfo.publicSourceDir)
                .use { it.openEntry("rlmobile.json")?.read() }

            metadataFile?.let { json.decodeFromStream<InstallMetadata>(it.inputStream()) }
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to parse Radiant Lyrics install metadata from package $packageName", t)
            null
        }

        val patchOptions = metadata?.options
            ?: PatchOptions.Default.copy(packageName = packageName)

        return PatchOptionsScreen(prefilledOptions = patchOptions)
    }

    private suspend fun fetchInstallations(packages: List<PackageInfo>) {
        mainThread {
            if (installsState !is InstallsState.Fetched)
                installsState = InstallsState.Fetching
        }

        try {
            val packageManager = application.packageManager
            val rlMobileInstallations = packages.mapNotNull { pkg ->
                @Suppress("DEPRECATION")
                val versionCode = pkg.versionCode
                val versionName = pkg.versionName ?: return@mapNotNull null
                val applicationInfo = pkg.applicationInfo ?: return@mapNotNull null

                InstallData(
                    name = packageManager.getApplicationLabel(applicationInfo).toString(),
                    packageName = pkg.packageName,
                    isUpToDate = isInstallationUpToDate(pkg),
                    icon = packageManager
                        .getApplicationIcon(applicationInfo)
                        .toBitmap()
                        .asImageBitmap()
                        .let(::BitmapPainter),
                    version = TidalVersion.Existing(
                        type = TidalVersion.parseVersionType(versionCode),
                        name = versionName.split("-")[0].trim(),
                        code = versionCode,
                    ),
                )
            }

            mainThread {
                installsState = if (rlMobileInstallations.isNotEmpty()) {
                    InstallsState.Fetched(data = rlMobileInstallations.toUnsafeImmutable())
                } else {
                    InstallsState.None
                }
            }
        } catch (t: Throwable) {
            Log.e(BuildConfig.TAG, "Failed to query Radiant Lyrics installations", t)
            mainThread { installsState = InstallsState.Error }
        }
    }

    private suspend fun refreshInstallationsUpToDate(packages: List<PackageInfo>) {
        val installations = mainThread { (installsState as? InstallsState.Fetched)?.data }
            ?: return

        try {
            val newInstallations = installations.map { data ->
                val packageInfo = packages.find { it.packageName == data.packageName }
                    ?: throw IllegalStateException("Checking up-to-date status for package that has not been fetched")

                data.copy(isUpToDate = isInstallationUpToDate(packageInfo))
            }

            mainThread { installsState = InstallsState.Fetched(data = newInstallations.toUnsafeImmutable()) }
        } catch (t: Throwable) {
            Log.e(BuildConfig.TAG, "Failed to check installations up-to-date", t)
            mainThread { installsState = InstallsState.Error }
        }
    }

    private suspend fun fetchRemoteData() {
        val release = try {
            github.getLatestRelease().let { response ->
                response.fold(
                    success = { it },
                    fail = {
                        Log.w(BuildConfig.TAG, "Failed to fetch latest release", it)
                        return
                    },
                )
            }
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to fetch remote data", t)
            mainThread { application.showToast(R.string.home_network_fail) }
            return
        }

        val dataJsonUrl = release.assets
            .find { it.name == RadiantLyricsGithubService.DATA_JSON_ASSET_NAME }
            ?.browserDownloadUrl
            ?: run {
                Log.w(BuildConfig.TAG, "No data.json asset in latest release")
                return
            }

        github.getBuildInfo(dataJsonUrl).fold(
            success = { remoteDataJson = it },
            fail = { Log.w(BuildConfig.TAG, "Failed to fetch remote build info", it) },
        )

        if (remoteDataJson == null) {
            mainThread { application.showToast(R.string.home_network_fail) }
        }
    }

    private fun fetchRadiantLyricsPackages(): List<PackageInfo> {
        return application.packageManager
            .getInstalledPackages(PackageManager.GET_META_DATA)
            .filter {
                it.applicationInfo?.metaData?.containsKey("isRadiantLyrics") == true
            }
    }

    private fun isInstallationUpToDate(pkg: PackageInfo): Boolean? {
        val remoteBuildData = remoteDataJson ?: return null

        @Suppress("DEPRECATION")
        val versionCode = pkg.versionCode

        if (remoteBuildData.tidalVersionCode != versionCode) return false

        val apkPath = pkg.applicationInfo?.publicSourceDir ?: return false
        val installMetadata = try {
            val metadataFile = ZipReader(apkPath).use { it.openEntry("rlmobile.json")?.read() }
                ?: return false

            json.decodeFromStream<InstallMetadata>(metadataFile.inputStream())
        } catch (t: Throwable) {
            Log.d(BuildConfig.TAG, "Failed to parse Radiant Lyrics InstallMetadata from package ${pkg.packageName}", t)
            return false
        }

        if (installMetadata.options.customPatches != null) return true

        return remoteBuildData.patchesVersion == installMetadata.patchesVersion
    }
}
