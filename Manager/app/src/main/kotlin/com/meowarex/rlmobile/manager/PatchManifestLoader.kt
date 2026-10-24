package com.meowarex.rlmobile.manager

import android.util.Log
import com.github.diamondminer88.zip.ZipReader
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.manager.download.IDownloadManager
import com.meowarex.rlmobile.manager.download.KtorDownloadManager
import com.meowarex.rlmobile.network.models.GithubRelease
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
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
    private val github: RadiantLyricsGithubService,
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

    /**
     * Pulls the patch list from the latest GitHub release's patches.zip manifest
     */
    suspend fun latestRelease(): List<PatchSpec>? = try {
        fromRelease(github.getLatestRelease().getOrThrow())
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

    /**
     * Patch list for a patches version, local first then GitHub
     */
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
            val release = github.getManagerReleases().getOrThrow()
                .firstOrNull { it.tagName.removePrefix("v") == version.toString() }
                ?: return null
            fromRelease(release)
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to load the $version release manifest", t)
            null
        }
    }

    private suspend fun fromRelease(release: GithubRelease): List<PatchSpec>? {
        val url = release.assets
            .find { it.name == RadiantLyricsGithubService.PATCHES_ASSET_NAME }
            ?.browserDownloadUrl
        if (url == null) {
            Log.w(BuildConfig.TAG, "Release ${release.tagName} has no patches.zip asset")
            return null
        }

        // Cached per release tag so re-opening the screen doesn't re-download the same zip.
        val dest = paths.cacheDownloadDir.resolve("manifest-${release.tagName}.zip")
            .apply { parentFile?.mkdirs() }
        val downloaded = downloadLock.withLock {
            dest.exists() || downloader.download(url, dest) is IDownloadManager.Result.Success
        }
        if (!downloaded) return null

        return fromZip(dest).also { loaded ->
            if (loaded != null) {
                Log.i(BuildConfig.TAG, "Loaded ${loaded.size} patches from release ${release.tagName} manifest")
            } else {
                Log.w(BuildConfig.TAG, "Release ${release.tagName} ships no manifest.json")
            }
        }
    }

    companion object {
        const val MANIFEST_NAME = "manifest.json"
    }
}
