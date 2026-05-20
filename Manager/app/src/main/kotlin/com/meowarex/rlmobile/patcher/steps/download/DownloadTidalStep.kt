package com.meowarex.rlmobile.patcher.steps.download

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.runtime.Stable
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.base.DownloadStep
import com.meowarex.rlmobile.patcher.steps.prepare.FetchInfoStep
import com.android.apksig.ApkVerifier
import okio.ByteString.Companion.decodeHex
import okio.ByteString.Companion.toByteString
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import java.io.File

@Stable
class DownloadTidalStep : DownloadStep<Int>(), KoinComponent {
    private val paths: PathManager by inject()

    override val localizedName = R.string.patch_step_dl_tidal_apk

    override fun getVersion(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalVersionCode

    override fun getRemoteUrl(container: StepRunner) =
        container.getStep<FetchInfoStep>().data.tidalApkUrl

    override fun getStoredFile(container: StepRunner) =
        paths.cachedTidalApk(getVersion(container))

    override suspend fun verify(container: StepRunner) {
        super.verify(container)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            container.log("Verifying APK signature")
            verifySignature(getStoredFile(container))
        } else {
            container.log("Skipping APK signature verification, API level too old")
        }
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun verifySignature(apk: File) {
        val verifier = ApkVerifier.Builder(apk).build()
        val result = try {
            verifier.verify()
        } catch (e: Exception) {
            throw IllegalStateException("Failed to verify APK! It may have been corrupted or tampered with.", e)
        }

        if (!result.isVerified)
            throw SignatureVerificationException(result.allErrors)

        if (TIDAL_CERTIFICATE_SHA256 != null) {
            if (result.signerCertificates.singleOrNull()
                    ?.let { it.encoded.toByteString().sha256() == TIDAL_CERTIFICATE_SHA256.decodeHex() } != true
            ) {
                throw VerifyError("Failed to verify TIDAL APK signatures! This is an unoriginal APK that has been tampered with.")
            }
        }
    }

    private companion object {
        // TODO: populate with actual TIDAL signing certificate SHA-256
        // Run: apksigner verify --print-certs tidal.apk
        val TIDAL_CERTIFICATE_SHA256: String? = null

        fun getStoredFilePath(paths: PathManager, version: Int): File =
            paths.cachedTidalApk(version)
    }

    private class SignatureVerificationException(errors: List<ApkVerifier.IssueWithParams>) : Exception(
        "Failed to verify APK signatures! " +
            "This is an unoriginal APK that has been tampered with. " +
            "Verification errors: " + errors.joinToString()
    )
}
