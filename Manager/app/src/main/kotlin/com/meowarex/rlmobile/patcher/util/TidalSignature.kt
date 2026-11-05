package com.meowarex.rlmobile.patcher.util

import com.android.apksig.ApkVerifier
import java.io.File
import java.security.MessageDigest
import java.security.cert.X509Certificate

// Only TIDAL's own keys, mirrors repackage stuff
object TidalSignature {
    private val TRUSTED_CERT_SHA256 = setOf(
        // CN=Aspiro AS (original key)
        "2e8a4794a95418367e36c84303feb43774919d6a351129d23d0fcf1b0b729454",
        // Rotated Play key (v3.1, API 33+)
        "2e74cf21cde153a6e6abdb2c9a3fb5f26fc5c4c6bcdb635152b967459487ea96",
    )

    fun verify(apk: File) {
        val result = ApkVerifier.Builder(apk).build().verify()
        if (!result.isVerified) {
            val errors = result.allErrors.joinToString { it.toString() }
            throw SecurityException("${apk.name} has an invalid signature: $errors")
        }

        val certs = buildList<X509Certificate> {
            result.v1SchemeSigners.forEach { add(it.certificate) }
            result.v2SchemeSigners.forEach { add(it.certificate) }
            result.v3SchemeSigners.forEach { add(it.certificate) }
            result.v31SchemeSigners.forEach { add(it.certificate) }
        }
        if (certs.isEmpty()) throw SecurityException("${apk.name} has no signers")

        val untrusted = certs.map { sha256(it) }.filter { it !in TRUSTED_CERT_SHA256 }
        if (untrusted.isNotEmpty())
            throw SecurityException("${apk.name} is not signed by TIDAL (cert ${untrusted.first()})")
    }

    private fun sha256(cert: X509Certificate): String =
        MessageDigest.getInstance("SHA-256").digest(cert.encoded).joinToString("") { "%02x".format(it) }
}
