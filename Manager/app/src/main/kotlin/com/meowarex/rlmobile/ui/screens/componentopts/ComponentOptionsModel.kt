package com.meowarex.rlmobile.ui.screens.componentopts

import android.app.Application
import android.net.Uri
import android.provider.OpenableColumns
import android.util.Log
import androidx.compose.runtime.*
import cafe.adriel.voyager.core.model.screenModelScope
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.manager.TidalApkSource
import com.meowarex.rlmobile.manager.download.KtorDownloadManager
import com.meowarex.rlmobile.network.models.RLRelease
import com.meowarex.rlmobile.network.services.RLReleasesService
import com.meowarex.rlmobile.network.utils.SemVer
import com.meowarex.rlmobile.network.utils.fold
import com.meowarex.rlmobile.ui.util.ScreenModelWithResult
import com.meowarex.rlmobile.ui.util.ScreenResultKey
import com.meowarex.rlmobile.util.*
import kotlinx.coroutines.launch
import java.io.File
import kotlin.time.Instant

class ComponentOptionsModel(
    screenResultKey: ScreenResultKey,
    private val paths: PathManager,
    private val context: Application,
    private val releases: RLReleasesService,
    private val downloader: KtorDownloadManager,
    private val tidalSource: TidalApkSource,
) : ScreenModelWithResult<PatchComponent?>(screenResultKey) {
    val components = mutableStateListOf<PatchComponent>()
    var selected by mutableStateOf<PatchComponent?>(null)
        private set

    var releasesExpanded by mutableStateOf(false)
        private set
    var releasesState by mutableStateOf<ReleasesState>(ReleasesState.Idle)
        private set
    var importingReleaseTag by mutableStateOf<String?>(null)
        private set

    private var siteReleases = emptyMap<String, RLRelease>()

    fun selectComponent(component: PatchComponent?) {
        selected = component
    }

    fun deleteComponent(component: PatchComponent) = screenModelScope.launchIO {
        component.getFile(paths).delete()

        mainThread {
            components.remove(component)
            context.showToast(R.string.componentopts_deleted)
        }
    }

    /**
     * Loads the available imported custom components for a specified type.
     */
    suspend fun refreshComponents(type: PatchComponent.Type) {
        val files = when (type) {
            PatchComponent.Type.TidalApk -> paths.customTidalApks()
            PatchComponent.Type.Patches -> paths.customSmaliPatches()
        }

        // ${timestamp}_${componentVersion}.${componentFile.extension}
        val componentNameRegex = """^(\d+)_(\d+\.\d+.\d+)\.\w+$""".toRegex()

        val newComponents = files.mapNotNull { file ->
            val match = componentNameRegex.find(file.name)
                ?: return@mapNotNull null
            val (_, timestamp, version) = match.groupValues

            PatchComponent(
                type = type,
                version = SemVer.parse(version),
                timestamp = Instant.fromEpochMilliseconds(timestamp.toLong()),
            )
        }.sortedByDescending { it.timestamp }

        mainThread {
            components.clear()
            components.addAll(newComponents)
        }
    }

    fun importFromUri(uri: Uri, type: PatchComponent.Type) = screenModelScope.launchIO {
        try {
            val targetDir = when (type) {
                PatchComponent.Type.TidalApk -> paths.customTidalApksDir
                PatchComponent.Type.Patches -> paths.customPatchesDir
            }
            val ext = when (type) {
                PatchComponent.Type.TidalApk -> "apk"
                PatchComponent.Type.Patches -> "zip"
            }
            targetDir.mkdirs()

            val tempFile = targetDir.resolve("import-${System.currentTimeMillis()}.tmp")
            context.contentResolver.openInputStream(uri)?.use { input ->
                tempFile.outputStream().use { output -> input.copyTo(output) }
            } ?: throw IllegalStateException("Could not open input stream for $uri")

            val sourceDisplayName = queryDisplayName(uri)
            val version = when (type) {
                PatchComponent.Type.TidalApk -> readApkVersion(tempFile)
                    ?: extractVersionFromName(sourceDisplayName)
                    ?: FALLBACK_VERSION
                PatchComponent.Type.Patches -> extractVersionFromName(sourceDisplayName)
                    ?: FALLBACK_VERSION
            }

            val finalName = "${System.currentTimeMillis()}_$version.$ext"
            val finalFile = targetDir.resolve(finalName)
            if (!tempFile.renameTo(finalFile)) {
                tempFile.copyTo(finalFile, overwrite = true)
                tempFile.delete()
            }

            refreshComponents(type)
            mainThread { context.showToast(R.string.intent_import_component_success, finalName) }
        } catch (t: Throwable) {
            Log.e(BuildConfig.TAG, "Failed to import custom component from $uri", t)
            mainThread { context.showToast(R.string.intent_import_component_failure) }
        }
    }

    private fun queryDisplayName(uri: Uri): String? = try {
        context.contentResolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
            ?.use { cursor ->
                if (cursor.moveToFirst()) cursor.getString(0) else null
            }
    } catch (_: Throwable) {
        null
    }

    private fun readApkVersion(apkFile: File): String? = try {
        @Suppress("DEPRECATION")
        context.packageManager.getPackageArchiveInfo(apkFile.absolutePath, 0)
            ?.versionName
            ?.let { SemVer.parseOrNull(it) }
            ?.toString()
    } catch (_: Throwable) {
        null
    }

    private fun extractVersionFromName(name: String?): String? {
        if (name == null) return null
        return """(\d+\.\d+\.\d+)""".toRegex().find(name)?.value
    }

    fun toggleReleasesExpanded(type: PatchComponent.Type) {
        releasesExpanded = !releasesExpanded
        if (releasesExpanded && releasesState is ReleasesState.Idle) {
            loadReleases(type)
        }
    }

    private fun loadReleases(type: PatchComponent.Type) = screenModelScope.launchIO {
        releasesState = ReleasesState.Loading
        if (type == PatchComponent.Type.TidalApk) {
            loadTidalVersions()
            return@launchIO
        }
        releases.getReleases().fold(
            success = { all ->
                val assetName = assetNameFor(type)
                val filtered = all.versions
                    .filter { it.has(assetName) }
                    .sortedByDescending { it.semVer }
                siteReleases = filtered.associateBy { it.version }
                releasesState = ReleasesState.Loaded(
                    filtered.map { ReleaseOption(key = it.version, title = "v${it.version}", subtitle = it.date?.substringBefore('T') ?: it.version) }
                )
            },
            fail = {
                Log.w(BuildConfig.TAG, "Failed to load releases", it)
                releasesState = ReleasesState.Failed
            },
        )
    }

    fun importFromRelease(option: ReleaseOption, type: PatchComponent.Type) {
        if (type == PatchComponent.Type.TidalApk) {
            importTidalVersion(option)
            return
        }
        val release = siteReleases[option.key] ?: return
        importFromSiteRelease(release, type)
    }

    // One row per TIDAL version code
    private suspend fun loadTidalVersions() {
        try {
            val options = tidalSource.versions()
                .groupBy { it.versionCode }
                .toSortedMap(compareByDescending { it })
                .map { (code, variants) ->
                    ReleaseOption(
                        key = code.toString(),
                        title = variants.first().versionName,
                        subtitle = context.getString(R.string.componentopts_apkpure_version_desc, code),
                    )
                }
            releasesState = ReleasesState.Loaded(options)
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to load APKPure versions", t)
            releasesState = ReleasesState.Failed
        }
    }

    private fun importTidalVersion(option: ReleaseOption) = screenModelScope.launchIO {
        val versionCode = option.key.toIntOrNull() ?: return@launchIO
        val targetDir = paths.customTidalApksDir.apply { mkdirs() }

        importingReleaseTag = option.key
        val tempFile = targetDir.resolve("apkpure-${System.currentTimeMillis()}.tmp")
        try {
            tidalSource.download(
                versionCode = versionCode,
                out = tempFile,
                log = { Log.i(BuildConfig.TAG, it) },
                onProgress = {},
            )

            val version = SemVer.parseOrNull(option.title)?.toString() ?: FALLBACK_VERSION
            val finalName = "${System.currentTimeMillis()}_$version.apk"
            val finalFile = targetDir.resolve(finalName)
            if (!tempFile.renameTo(finalFile)) {
                tempFile.copyTo(finalFile, overwrite = true)
                tempFile.delete()
            }
            refreshComponents(PatchComponent.Type.TidalApk)
            mainThread { context.showToast(R.string.intent_import_component_success, finalName) }
        } catch (t: Throwable) {
            tempFile.delete()
            Log.e(BuildConfig.TAG, "Failed to import TIDAL $versionCode from APKPure", t)
            mainThread { context.showToast(R.string.intent_import_component_failure) }
        } finally {
            importingReleaseTag = null
        }
    }

    private fun importFromSiteRelease(release: RLRelease, type: PatchComponent.Type) = screenModelScope.launchIO {
        val assetName = assetNameFor(type)
        if (!release.has(assetName)) {
            mainThread { context.showToast(R.string.intent_import_component_failure) }
            return@launchIO
        }

        val targetDir = when (type) {
            PatchComponent.Type.TidalApk -> paths.customTidalApksDir
            PatchComponent.Type.Patches -> paths.customPatchesDir
        }
        targetDir.mkdirs()

        importingReleaseTag = release.version
        try {
            val tempFile = targetDir.resolve("release-${System.currentTimeMillis()}.tmp")
            val result = downloader.download(release.url(assetName), tempFile)
            if (result !is com.meowarex.rlmobile.manager.download.IDownloadManager.Result.Success) {
                tempFile.delete()
                mainThread { context.showToast(R.string.intent_import_component_failure) }
                return@launchIO
            }

            val ext = when (type) {
                PatchComponent.Type.TidalApk -> "apk"
                PatchComponent.Type.Patches -> "zip"
            }
            val version = release.semVer?.toString()
                ?: FALLBACK_VERSION
            val finalName = "${System.currentTimeMillis()}_$version.$ext"
            val finalFile = targetDir.resolve(finalName)
            if (!tempFile.renameTo(finalFile)) {
                tempFile.copyTo(finalFile, overwrite = true)
                tempFile.delete()
            }
            refreshComponents(type)
            mainThread { context.showToast(R.string.intent_import_component_success, finalName) }
        } catch (t: Throwable) {
            Log.e(BuildConfig.TAG, "Failed to import release ${release.version}", t)
            mainThread { context.showToast(R.string.intent_import_component_failure) }
        } finally {
            importingReleaseTag = null
        }
    }

    private fun assetNameFor(type: PatchComponent.Type) = when (type) {
        PatchComponent.Type.TidalApk -> "tidal-stock.apk"
        PatchComponent.Type.Patches -> RLReleasesService.PATCHES_ZIP
    }

    override fun onDispose() {
        screenModelScope.launch { setResult(selected) }
    }

    sealed interface ReleasesState {
        data object Idle : ReleasesState
        data object Loading : ReleasesState
        data class Loaded(val releases: List<ReleaseOption>) : ReleasesState
        data object Failed : ReleasesState
    }

    @Immutable
    data class ReleaseOption(val key: String, val title: String, val subtitle: String)

    companion object {
        private const val FALLBACK_VERSION = "0.0.0"
    }
}
