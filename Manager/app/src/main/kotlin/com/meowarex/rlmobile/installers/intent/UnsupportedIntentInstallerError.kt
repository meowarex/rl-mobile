package com.meowarex.rlmobile.installers.intent

import android.content.Context
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.installers.InstallerResult
import kotlinx.parcelize.Parcelize

@Parcelize
data class UnsupportedIntentInstallerError(private val action: String) : InstallerResult.Error() {
    override fun getDebugReason() = "This Android rom does not support $action!"

    override fun getLocalizedReason(context: Context) =
        context.getString(R.string.install_error_unhandled_intent, action)
}

