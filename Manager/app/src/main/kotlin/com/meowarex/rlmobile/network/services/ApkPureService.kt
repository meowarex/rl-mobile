package com.meowarex.rlmobile.network.services

import android.os.Build
import com.meowarex.rlmobile.network.models.ApkPureVersion
import com.meowarex.rlmobile.network.utils.ProtoField
import com.meowarex.rlmobile.network.utils.ProtoReader
import com.meowarex.rlmobile.network.utils.first
import io.ktor.client.HttpClient
import io.ktor.client.request.get
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.client.request.prepareGet
import io.ktor.client.statement.readRawBytes
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import io.ktor.http.isSuccess
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import java.nio.ByteBuffer
import java.nio.ByteOrder

// APKPure's API (same as apkeep), replies are protobuf
class ApkPureService(
    private val http: HttpClient,
) {
    suspend fun getVersions(packageName: String = TIDAL_PACKAGE): List<ApkPureVersion> = withContext(Dispatchers.IO) {
        val response = http.get(VERSIONS_URL) {
            parameter("hl", "en-US")
            parameter("package_name", packageName)
            header("x-cv", "3172501")
            header("x-sv", "29")
            header("x-abis", Build.SUPPORTED_ABIS.joinToString(","))
            header("x-gp", "1")
            header(HttpHeaders.CacheControl, "no-cache, no-store")
        }
        if (!response.status.isSuccess())
            throw IOException("APKPure version list failed: ${response.status}")

        val versions = parseVersions(response.readRawBytes(), packageName)
        if (versions.isEmpty())
            throw IOException("APKPure returned no versions for $packageName")
        versions
    }

    // Remote zip names via range requests, null if unsupported
    suspend fun listZipEntries(url: String): List<String>? = withContext(Dispatchers.IO) {
        val (tail, total) = fetchRange(url, "bytes=-$EOCD_SEARCH") ?: return@withContext null

        val eocd = (tail.size - 22 downTo 0).firstOrNull { i ->
            tail[i] == 0x50.toByte() && tail[i + 1] == 0x4B.toByte() &&
                tail[i + 2] == 0x05.toByte() && tail[i + 3] == 0x06.toByte()
        } ?: throw IOException("No zip end record in $url")

        val le = ByteBuffer.wrap(tail).order(ByteOrder.LITTLE_ENDIAN)
        val cdSize = le.getInt(eocd + 12).toLong() and 0xFFFFFFFFL
        val cdOffset = le.getInt(eocd + 16).toLong() and 0xFFFFFFFFL
        if (cdOffset + cdSize > total) throw IOException("Bad central directory in $url")

        // Central dir is usually already in the tail
        val tailStart = total - tail.size
        val cd = if (cdOffset >= tailStart) {
            tail.copyOfRange((cdOffset - tailStart).toInt(), (cdOffset - tailStart + cdSize).toInt())
        } else {
            fetchRange(url, "bytes=$cdOffset-${cdOffset + cdSize - 1}")?.first ?: return@withContext null
        }

        val buf = ByteBuffer.wrap(cd).order(ByteOrder.LITTLE_ENDIAN)
        val names = ArrayList<String>()
        var pos = 0
        while (pos + 46 <= cd.size && buf.getInt(pos) == 0x02014b50) {
            val nameLen = buf.getShort(pos + 28).toInt() and 0xFFFF
            val extraLen = buf.getShort(pos + 30).toInt() and 0xFFFF
            val commentLen = buf.getShort(pos + 32).toInt() and 0xFFFF
            names += String(cd, pos + 46, nameLen, Charsets.UTF_8)
            pos += 46 + nameLen + extraLen + commentLen
        }
        names
    }

    // Body + full file size
    private suspend fun fetchRange(url: String, range: String): Pair<ByteArray, Long>? =
        http.prepareGet(url) {
            header(HttpHeaders.Range, range)
            header(HttpHeaders.CacheControl, "no-cache, no-store")
            header(HttpHeaders.AcceptEncoding, "identity")
        }.execute { response ->
            // 200 means no ranges, don't pull it all
            if (response.status != HttpStatusCode.PartialContent) return@execute null
            val total = response.headers[HttpHeaders.ContentRange]
                ?.substringAfterLast('/')
                ?.toLongOrNull()
                ?: return@execute null
            response.readRawBytes() to total
        }

    companion object {
        const val TIDAL_PACKAGE = "com.aspiro.tidal"
        private const val VERSIONS_URL = "https://api.pureapk.com/m/v3/cms/app_version"

        // Max zip comment + end record
        private const val EOCD_SEARCH = 65535 + 22

        // App detail fields
        private const val F_PACKAGE = 4
        private const val F_VERSION_CODE = 5
        private const val F_VERSION_NAME = 6
        private const val F_ASSET = 24

        // Asset fields
        private const val F_ASSET_SHA1 = 3
        private const val F_ASSET_SIZE = 4
        private const val F_ASSET_TYPE = 8
        private const val F_ASSET_URL = 9

        fun parseVersions(body: ByteArray, packageName: String): List<ApkPureVersion> {
            val out = ArrayList<ApkPureVersion>()
            walk(ProtoReader.parse(body), packageName, out, depth = 0)
            return out.distinctBy { it.url }
        }

        private fun walk(fields: List<ProtoField>, pkg: String, out: MutableList<ApkPureVersion>, depth: Int) {
            if (depth > 12) return
            for (field in fields) {
                val sub = field.message() ?: continue
                val version = toVersion(sub, pkg)
                if (version != null) out += version else walk(sub, pkg, out, depth + 1)
            }
        }

        private fun toVersion(fields: List<ProtoField>, pkg: String): ApkPureVersion? {
            val pkgField = fields.first(F_PACKAGE)?.takeIf { it.isBytes } ?: return null
            if (pkgField.string() != pkg) return null

            val asset = fields.first(F_ASSET)?.message() ?: return null
            val url = asset.first(F_ASSET_URL)?.takeIf { it.isBytes }?.string() ?: return null
            if (!url.startsWith("https://")) return null

            return ApkPureVersion(
                versionName = fields.first(F_VERSION_NAME)?.string() ?: return null,
                versionCode = fields.first(F_VERSION_CODE)?.string()?.toIntOrNull() ?: return null,
                isXapk = asset.first(F_ASSET_TYPE)?.string().equals("XAPK", ignoreCase = true),
                size = asset.first(F_ASSET_SIZE)?.varint ?: -1,
                sha1 = asset.first(F_ASSET_SHA1)?.string()?.takeIf { it.length == 40 },
                url = url,
            )
        }
    }
}
