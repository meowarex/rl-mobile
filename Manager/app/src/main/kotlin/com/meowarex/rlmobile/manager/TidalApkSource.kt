package com.meowarex.rlmobile.manager

import android.app.Application
import android.os.Build
import com.meowarex.rlmobile.manager.download.IDownloadManager
import com.meowarex.rlmobile.manager.download.KtorDownloadManager
import com.meowarex.rlmobile.network.models.ApkPureVersion
import com.meowarex.rlmobile.network.services.ApkPureService
import com.meowarex.rlmobile.patcher.util.SplitApkMerger
import com.meowarex.rlmobile.patcher.util.TidalSignature
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.File
import java.io.IOException
import java.security.MessageDigest
import java.util.zip.ZipFile
import kotlin.coroutines.cancellation.CancellationException

// Stock TIDAL from APKPure, merged + signature checked <3
class TidalApkSource(
    private val application: Application,
    private val apkPure: ApkPureService,
    private val downloader: KtorDownloadManager,
) {
    suspend fun versions(): List<ApkPureVersion> = apkPure.getVersions()

    // Downloads versionCode as one merged APK
    suspend fun download(
        versionCode: Int,
        out: File,
        log: (String) -> Unit,
        onProgress: (Float?) -> Unit,
    ) {
        log("Fetching TIDAL versions from APKPure")
        val candidates = apkPure.getVersions().filter { it.versionCode == versionCode }
        if (candidates.isEmpty())
            throw NoSuchElementException("TIDAL $versionCode is not available on APKPure")

        download(pickVariant(candidates, log), out, log, onProgress)
    }

    suspend fun download(
        variant: ApkPureVersion,
        out: File,
        log: (String) -> Unit,
        onProgress: (Float?) -> Unit,
    ) {
        val workDir = out.resolveSibling(out.name + ".work")
        workDir.deleteRecursively()
        workDir.mkdirs()

        try {
            val archive = workDir.resolve(if (variant.isXapk) "tidal.xapk" else "tidal.apk")
            log("Downloading TIDAL ${variant.versionName} (${variant.versionCode}) from ${variant.url.substringBefore('?')}")

            var lastLogged = 0f
            val result = downloader.download(variant.url, archive) { progress ->
                onProgress(progress)
                if (progress != null && progress > lastLogged + 0.1f) {
                    log("Download progress: ${(progress * 100).toInt()}%")
                    lastLogged = progress
                }
            }
            when (result) {
                is IDownloadManager.Result.Success -> {}
                is IDownloadManager.Result.Cancelled -> throw CancellationException("TIDAL download cancelled")
                is IDownloadManager.Result.Error ->
                    throw IOException("APKPure download failed: ${result.getDebugReason()}", result.getError())
            }
            onProgress(null)

            withContext(Dispatchers.IO) {
                variant.sha1?.let { expected ->
                    val actual = sha1(archive)
                    if (!actual.equals(expected, ignoreCase = true))
                        throw SecurityException("APKPure file hash mismatch: expected $expected, got $actual")
                    log("SHA-1 matches APKPure ($actual)")
                }

                val merged = workDir.resolve("merged.apk")
                if (variant.isXapk) {
                    val splitsDir = workDir.resolve("splits").apply { mkdirs() }
                    val splits = extractSplits(archive, splitsDir)
                    archive.delete()
                    log("Extracted ${splits.size} split APKs: ${splits.joinToString { it.name }}")

                    for (split in splits) TidalSignature.verify(split)
                    log("All splits are signed by TIDAL")

                    SplitApkMerger.merge(splitsDir, merged, log)
                    splitsDir.deleteRecursively()
                } else {
                    TidalSignature.verify(archive)
                    log("APK is signed by TIDAL")
                    archive.renameTo(merged)
                }

                checkPackage(merged, variant.versionCode)

                out.parentFile?.mkdirs()
                out.delete()
                if (!merged.renameTo(out)) {
                    merged.copyTo(out, overwrite = true)
                }
                log("Saved TIDAL APK to ${out.absolutePath}")
            }
        } finally {
            workDir.deleteRecursively()
        }
    }

    // Best variant for this device, smallest wins ties
    private suspend fun pickVariant(candidates: List<ApkPureVersion>, log: (String) -> Unit): ApkPureVersion {
        val abis = Build.SUPPORTED_ABIS.toList()
        log("Device ABIs: $abis, ${candidates.size} APKPure variant(s)")

        var best: ApkPureVersion? = null
        var bestRank = Int.MAX_VALUE
        for (candidate in candidates.sortedBy { it.size }) {
            val entries = try {
                apkPure.listZipEntries(candidate.url)
            } catch (e: CancellationException) {
                throw e
            } catch (t: Throwable) {
                log("Failed to inspect variant: $t")
                null
            }

            val rank = if (entries == null) abis.size else abiRank(entries, candidate.isXapk, abis)
            log("Variant ${candidate.size} bytes: ${describe(entries, candidate.isXapk)}, rank ${rank ?: "incompatible"}")

            if (rank != null && rank < bestRank) {
                best = candidate
                bestRank = rank
                if (rank == 0) break
            }
        }

        return best ?: throw IllegalStateException(
            "No APKPure build of TIDAL ${candidates.first().versionName} supports this device ($abis)"
        )
    }

    private fun describe(entries: List<String>?, isXapk: Boolean): String = when {
        entries == null -> "unknown contents"
        isXapk -> entries.filter { it.endsWith(".apk") && '/' !in it }.joinToString()
        else -> "abis " + entries.mapNotNull(::libAbi).distinct()
    }

    // Preferred ABI index, null if nothing fits
    private fun abiRank(entries: List<String>, isXapk: Boolean, abis: List<String>): Int? {
        val shipped = if (isXapk) {
            KNOWN_ABIS.filter { abi ->
                val token = abi.replace('-', '_')
                entries.any { it == "config.$token.apk" || it == "split_config.$token.apk" }
            }
        } else {
            entries.mapNotNull(::libAbi).distinct()
        }

        // No native split, libs in base
        if (shipped.isEmpty()) return abis.size

        return abis.indexOfFirst { it in shipped }.takeIf { it >= 0 }
    }

    private fun libAbi(path: String): String? =
        path.takeIf { it.startsWith("lib/") && it.endsWith(".so") }?.split('/')?.getOrNull(1)

    private fun extractSplits(xapk: File, dir: File): List<File> = ZipFile(xapk).use { zip ->
        val splits = zip.entries().asSequence()
            .filter { !it.isDirectory && it.name.endsWith(".apk") && '/' !in it.name && '\\' !in it.name }
            .map { entry ->
                val file = dir.resolve(entry.name)
                zip.getInputStream(entry).use { input -> file.outputStream().use { input.copyTo(it) } }
                file
            }
            .toList()

        if (splits.isEmpty()) throw IOException("XAPK contains no APKs")
        splits
    }

    private fun checkPackage(apk: File, versionCode: Int) {
        @Suppress("DEPRECATION")
        val info = application.packageManager.getPackageArchiveInfo(apk.absolutePath, 0)
            ?: throw IOException("Merged TIDAL APK could not be parsed")
        if (info.packageName != ApkPureService.TIDAL_PACKAGE)
            throw SecurityException("Unexpected package ${info.packageName}")
        @Suppress("DEPRECATION")
        if (info.versionCode != versionCode)
            throw IOException("Expected TIDAL $versionCode but got ${info.versionCode}")
    }

    private fun sha1(file: File): String {
        val digest = MessageDigest.getInstance("SHA-1")
        file.inputStream().use { input ->
            val buf = ByteArray(1 shl 20)
            while (true) {
                val read = input.read(buf)
                if (read < 0) break
                digest.update(buf, 0, read)
            }
        }
        return digest.digest().joinToString("") { "%02x".format(it) }
    }

    private companion object {
        val KNOWN_ABIS = listOf("arm64-v8a", "armeabi-v7a", "armeabi", "x86_64", "x86")
    }
}
