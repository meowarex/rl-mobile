package com.meowarex.rlmobile.manager

import android.util.Log
import com.github.diamondminer88.zip.ZipReader
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.manager.download.IDownloadManager
import com.meowarex.rlmobile.manager.download.KtorDownloadManager
import com.meowarex.rlmobile.network.models.RLRelease
import com.meowarex.rlmobile.network.services.RLReleasesService
import com.meowarex.rlmobile.network.utils.SemVer
import com.meowarex.rlmobile.network.utils.getOrThrow
import com.meowarex.rlmobile.ui.screens.patchopts.PatchManifest
import com.meowarex.rlmobile.ui.screens.patchopts.PatchSpec
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.serialization.json.Json
import java.io.File

/**
 * Reads manifest.json out of release patches.zip files
 */
class PatchManifestLoader(
    private val paths: PathManager,
    private val json: Json,
    private val releases: RLReleasesService,
    private val downloader: KtorDownloadManager,
) {
    // Home and patch options can grab the same zip
    private val downloadLock = Mutex()

    fun fromZip(file: File): List<PatchSpec>? {
        if (!file.exists()) return null
        return try {
            val bytes = ZipReader(file).use { it.openEntry(MANIFEST_NAME)?.read() } ?: return null
            json.decodeFromString(PatchManifest.serializer(), bytes.decodeToString())
                .patches
                .sortedBy { it.order }   // manifest is authoritative for UI order (not KnownPatch)
                .takeIf { it.isNotEmpty() }
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to parse $MANIFEST_NAME in ${file.name}", t)
            null
        }
    }

    /** Patch list from the latest release */
    suspend fun latestRelease(): List<PatchSpec>? = try {
        releases.getReleases().getOrThrow()
            .latestWith(RLReleasesService.PATCHES_ZIP)
            ?.let { fromRelease(it) }
    } catch (t: Throwable) {
        Log.w(BuildConfig.TAG, "Failed to load latest release manifest", t)
        null
    }

    /** Most recently cached release manifest, for offline */
    fun cachedRelease(): List<PatchSpec>? =
        paths.cacheDownloadDir
            .listFiles { f -> f.name.startsWith("manifest-") && f.name.endsWith(".zip") }
            ?.maxByOrNull { it.lastModified() }
            ?.let(::fromZip)
            ?.also { Log.i(BuildConfig.TAG, "Loaded ${it.size} patches from cached release manifest (offline)") }

    /** Patch list for a version, local first then site */
    suspend fun forPatchesVersion(version: SemVer, online: Boolean): List<PatchSpec>? {
        val local = listOf(
            paths.patchingDownloadDir.resolve("patches/$version.zip"),
            paths.cacheDownloadDir.resolve("patches/$version.zip"),
            paths.cacheDownloadDir.resolve("manifest-v$version.zip"),
            paths.cacheDownloadDir.resolve("manifest-$version.zip"),
        )
        local.firstNotNullOfOrNull(::fromZip)?.let { return it }
        if (!online) return null

        return try {
            val release = releases.getReleases().getOrThrow().find(version.toString())
                ?: return null
            fromRelease(release)
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to load the $version release manifest", t)
            null
        }
    }

    private suspend fun fromRelease(release: RLRelease): List<PatchSpec>? {
        if (!release.has(RLReleasesService.PATCHES_ZIP)) {
            Log.w(BuildConfig.TAG, "Release ${release.version} has no patches.zip")
            return null
        }
        val url = release.url(RLReleasesService.PATCHES_ZIP)

        // Cached per release so it's not redownloaded
        val dest = paths.cacheDownloadDir.resolve("manifest-v${release.version}.zip")
            .apply { parentFile?.mkdirs() }
        val downloaded = downloadLock.withLock {
            dest.exists() || downloader.download(url, dest) is IDownloadManager.Result.Success
        }
        if (!downloaded) return null

        return fromZip(dest).also { loaded ->
            if (loaded != null) {
                Log.i(BuildConfig.TAG, "Loaded ${loaded.size} patches from release ${release.version} manifest")
            } else {
                Log.w(BuildConfig.TAG, "Release ${release.version} ships no manifest.json")
            }
        }
    }

    companion object {
        const val MANIFEST_NAME = "manifest.json"
    }
}
