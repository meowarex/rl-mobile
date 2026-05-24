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
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.cachedIn
import cafe.adriel.voyager.core.model.ScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.github.diamondminer88.zip.ZipReader
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PreferencesManager
import com.meowarex.rlmobile.network.models.GithubCommit
import com.meowarex.rlmobile.network.models.RLBuildInfo
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
import com.meowarex.rlmobile.network.utils.CommitsPagingSource
import com.meowarex.rlmobile.network.utils.fold
import com.meowarex.rlmobile.patcher.InstallMetadata
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsScreen
import com.meowarex.rlmobile.ui.util.TidalVersion
import com.meowarex.rlmobile.ui.widgets.managerupdate.VersionDelta
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
    private val prefs: PreferencesManager,
) : ScreenModel {

    var state by mutableStateOf<HomeState>(HomeState.Loading)
        private set

    var managerUpdateDeltas by mutableStateOf<List<VersionDelta>?>(null)
        private set

    val commits = Pager(PagingConfig(pageSize = 30)) {
        CommitsPagingSource(github)
    }.flow.cachedIn(screenModelScope)

    private val refreshingLock = Mutex()
    private var remoteDataJson: RLBuildInfo? = null

    private val initialPrefManagerVersion: String = prefs.lastSeenManagerVersion
    private val initialPrefPatchesVersion: String = prefs.lastSeenPatchesVersion
    private val initialPrefTidalVersionCode: Int = prefs.lastSeenTidalVersionCode

    private var managerUpdateChecked = false

    init {
        refresh()
    }

    fun dismissManagerUpdate() {
        managerUpdateDeltas = null
        commitVersionPrefs()
    }

    private fun commitVersionPrefs() {
        prefs.lastSeenManagerVersion = BuildConfig.VERSION_NAME
        remoteDataJson?.let {
            prefs.lastSeenPatchesVersion = it.patchesVersion.toString()
            prefs.lastSeenTidalVersionCode = it.tidalVersionCode
        }
    }

    private fun maybeCheckManagerUpdate(installedPkg: PackageInfo?) {
        if (managerUpdateChecked) return
        managerUpdateChecked = true

        val installMetadata = installedPkg?.packageName?.let(::loadInstallMetadata)
        val current = BuildConfig.VERSION_NAME

        val previousManager = initialPrefManagerVersion.ifEmpty {
            installMetadata?.managerVersion?.toString().orEmpty()
        }

        when {
            previousManager.isEmpty() -> commitVersionPrefs()
            previousManager == current -> commitVersionPrefs()
            else -> managerUpdateDeltas =
                buildDeltas(previousManager, current, installMetadata, installedPkg)
        }
    }

    private fun buildDeltas(
        previousManager: String,
        currentManager: String,
        installMetadata: InstallMetadata?,
        installedPkg: PackageInfo?,
    ): List<VersionDelta> = buildList {
        add(
            VersionDelta(
                label = application.getString(R.string.manager_update_row_manager),
                iconRes = R.drawable.ic_sparkle,
                from = previousManager,
                to = currentManager,
                tag = application.getString(R.string.manager_update_tag_complete),
            )
        )

        val remote = remoteDataJson
        val currentPatches = remote?.patchesVersion?.toString()
        val previousPatches = initialPrefPatchesVersion.ifEmpty {
            installMetadata?.patchesVersion?.toString().orEmpty()
        }
        val patchesFrom = previousPatches.takeIf { it.isNotEmpty() }
        val patchesTo = currentPatches ?: previousPatches.ifEmpty { "?" }
        add(
            VersionDelta(
                label = application.getString(R.string.manager_update_row_patches),
                iconRes = R.drawable.ic_extension,
                from = patchesFrom,
                to = patchesTo,
                tag = if (patchesFrom != null && patchesFrom != patchesTo)
                    application.getString(R.string.manager_update_tag_available) else null,
            )
        )

        val currentTidal = remote?.tidalVersionCode
        @Suppress("DEPRECATION")
        val installedTidalVersionCode = installedPkg?.versionCode ?: -1
        val previousTidal = if (initialPrefTidalVersionCode > 0) initialPrefTidalVersionCode
        else installedTidalVersionCode
        val tidalFrom = previousTidal.takeIf { it > 0 }?.toString()
        val tidalTo = currentTidal?.toString()
            ?: previousTidal.takeIf { it > 0 }?.toString()
            ?: "?"
        add(
            VersionDelta(
                label = application.getString(R.string.manager_update_row_tidal),
                iconRes = R.drawable.ic_music_note,
                from = tidalFrom,
                to = tidalTo,
                tag = if (tidalFrom != null && tidalFrom != tidalTo)
                    application.getString(R.string.manager_update_tag_available) else null,
            )
        )
    }

    fun refresh(delay: Boolean = false) = screenModelScope.launchIO {
        if (refreshingLock.isLocked) return@launchIO
        if (delay) {
            delay(250)
            if (refreshingLock.isLocked) return@launchIO
        }

        refreshingLock.withLock {
            val pkg = fetchInstalled()
            val remote = async(Dispatchers.IO) { if (remoteDataJson == null) fetchRemoteData() }
            remote.await()

            val install = pkg?.toInstallData()
            val latest = remoteDataJson?.tidalVersionCode

            mainThread {
                state = HomeState.Loaded(
                    install = install,
                    latestTidalVersionCode = latest,
                )
                maybeCheckManagerUpdate(pkg)
            }
        }
    }

    fun launchInstall() {
        val current = (state as? HomeState.Loaded)?.install ?: return
        openApp(current.packageName)
    }

    fun openCurrentAppInfo() {
        val current = (state as? HomeState.Loaded)?.install ?: return
        openAppInfo(current.packageName)
    }

    fun createRepatchScreen(): PatchOptionsScreen? {
        val current = (state as? HomeState.Loaded)?.install ?: return null
        return createPrefilledPatchOptsScreen(current.packageName)
    }

    fun openApp(packageName: String) {
        val launchIntent = application.packageManager.getLaunchIntentForPackage(packageName)
        if (launchIntent != null) {
            launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
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
        val patchOptions = loadInstallMetadata(packageName)?.options
            ?: PatchOptions.Default.copy(packageName = packageName)
        return PatchOptionsScreen(prefilledOptions = patchOptions)
    }

    private fun loadInstallMetadata(packageName: String): InstallMetadata? = try {
        val applicationInfo = application.packageManager.getApplicationInfo(packageName, 0)
        val metadataBytes = ZipReader(applicationInfo.publicSourceDir)
            .use { it.openEntry("rlmobile.json")?.read() }
        metadataBytes?.let { json.decodeFromStream<InstallMetadata>(it.inputStream()) }
    } catch (t: Throwable) {
        Log.w(BuildConfig.TAG, "Failed to parse install metadata for $packageName", t)
        null
    }

    private fun fetchInstalled(): PackageInfo? = application.packageManager
        .getInstalledPackages(PackageManager.GET_META_DATA)
        .firstOrNull { it.applicationInfo?.metaData?.containsKey("isRadiantLyrics") == true }

    private fun PackageInfo.toInstallData(): InstallData {
        val pm = application.packageManager
        @Suppress("DEPRECATION") val versionCode = versionCode
        val versionName = versionName ?: ""
        val info = applicationInfo!!
        return InstallData(
            name = pm.getApplicationLabel(info).toString(),
            packageName = packageName,
            tidalUpToDate = isTidalUpToDate(this),
            patchesUpToDate = isPatchesUpToDate(this),
            icon = pm.getApplicationIcon(info).toBitmap().asImageBitmap().let(::BitmapPainter),
            version = TidalVersion.Existing(
                type = TidalVersion.parseVersionType(versionCode),
                name = versionName.split("-")[0].trim(),
                code = versionCode,
            ),
        )
    }

    private suspend fun fetchRemoteData() {
        val release = try {
            github.getLatestRelease().fold(
                success = { it },
                fail = { Log.w(BuildConfig.TAG, "Failed to fetch latest release", it); return },
            )
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to fetch remote data", t)
            return
        }

        val dataJsonUrl = release.assets
            .find { it.name == RadiantLyricsGithubService.DATA_JSON_ASSET_NAME }
            ?.browserDownloadUrl
            ?: return

        github.getBuildInfo(dataJsonUrl).fold(
            success = { remoteDataJson = it },
            fail = { Log.w(BuildConfig.TAG, "Failed to fetch build info", it) },
        )
    }

    private fun isTidalUpToDate(pkg: PackageInfo): Boolean? {
        val remote = remoteDataJson ?: return null
        @Suppress("DEPRECATION") val versionCode = pkg.versionCode
        return remote.tidalVersionCode == versionCode
    }

    private fun isPatchesUpToDate(pkg: PackageInfo): Boolean? {
        val remote = remoteDataJson ?: return null
        val apkPath = pkg.applicationInfo?.publicSourceDir ?: return false
        val installMetadata = try {
            val mf = ZipReader(apkPath).use { it.openEntry("rlmobile.json")?.read() } ?: return false
            json.decodeFromStream<InstallMetadata>(mf.inputStream())
        } catch (t: Throwable) {
            return false
        }
        return remote.patchesVersion == installMetadata.patchesVersion
    }
}
