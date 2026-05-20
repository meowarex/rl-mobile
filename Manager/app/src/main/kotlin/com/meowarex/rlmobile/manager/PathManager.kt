package com.meowarex.rlmobile.manager

import android.app.Application
import android.os.Environment
import com.meowarex.rlmobile.network.utils.SemVer
import java.io.File

class PathManager(
    private val context: Application,
) {
    val rlMobileDir = Environment.getExternalStorageDirectory().resolve("RadiantLyrics")

    val pluginsDir = rlMobileDir.resolve("plugins")

    val coreSettingsFile = rlMobileDir.resolve("settings/RadiantLyrics.json")

    val legacyKeystoreFile = rlMobileDir.resolve("ks.keystore")

    val keystoreFile = context.filesDir.resolve("rlmobile.keystore")

    val patchingDir = context.filesDir.resolve("patching")

    val patchingDownloadDir = patchingDir.resolve("downloads")

    val cacheDownloadDir = context.cacheDir.resolve("downloads")

    val customComponentsDir = patchingDir.resolve("custom")

    val customInjectorsDir = customComponentsDir.resolve("injector")

    val customPatchesDir = customComponentsDir.resolve("patches")

    val patchingWorkingDir = patchingDir.resolve("patched")

    val patchedApk = patchingWorkingDir.resolve("patched.apk")

    fun clearCache() {
        for (dir in arrayOf(patchingDir, cacheDownloadDir, context.cacheDir))
            dir.deleteRecursively()
    }

    fun cachedTidalApk(version: Int, split: String = "base"): File = patchingDownloadDir
        .resolve("tidal/$version")
        .resolve("$split.apk")

    fun cachedSmaliPatches(version: SemVer) = patchingDownloadDir
        .resolve("patches")
        .resolve("$version.zip")

    fun customInjectors() = customInjectorsDir.listFiles()?.asList() ?: emptyList()

    fun customSmaliPatches() = customPatchesDir.listFiles()?.asList() ?: emptyList()
}
