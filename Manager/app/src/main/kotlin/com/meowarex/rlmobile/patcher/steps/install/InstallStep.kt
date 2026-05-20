package com.meowarex.rlmobile.patcher.steps.install

import android.content.Context
import androidx.lifecycle.*
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.installers.InstallerResult
import com.meowarex.rlmobile.installers.root.RootInstaller
import com.meowarex.rlmobile.installers.shizuku.ShizukuInstaller
import com.meowarex.rlmobile.manager.*
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.patcher.steps.base.StepState
import com.meowarex.rlmobile.patcher.steps.download.CopyDependenciesStep
import com.meowarex.rlmobile.ui.components.dialogs.PlayProtectDialog
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.ui.util.InstallNotifications
import com.meowarex.rlmobile.util.*
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

/**
 * ID used for showing ready notifications if the activity is currently minimized when having reached this step.
 */
private const val READY_NOTIF_ID = 200001

/**
 * Install the final APK with the system's PackageManager.
 */
class InstallStep(private val options: PatchOptions) : Step(), KoinComponent {
    private val context: Context by inject()
    private val installers: InstallerManager by inject()
    private val prefs: PreferencesManager by inject()
    private val overlays: OverlayManager by inject()

    override val group = StepGroup.Install
    override val localizedName = R.string.patch_step_install

    override suspend fun execute(container: StepRunner) {
        val apk = container.getStep<CopyDependenciesStep>().apk

        // If app backgrounded, show notification
        if (ProcessLifecycleOwner.get().lifecycle.currentState == Lifecycle.State.CREATED) {
            InstallNotifications.createNotification(
                context = context,
                id = READY_NOTIF_ID,
                title = R.string.notif_install_ready_title,
                description = R.string.notif_install_ready_desc,
            )

            container.log("Waiting until manager is resumed to continue installation")
        }

        // Wait until app resumed
        ProcessLifecycleOwner.get().lifecycle.withResumed {}

        // Retrieve configured installer
        container.log("Retrieving configured installer ${prefs.installer}")
        val installer = installers.getActiveInstaller()

        // Show [PlayProtectDialog] and wait until it gets dismissed
        if (installer !is ShizukuInstaller &&
            installer !is RootInstaller
            && prefs.showPlayProtectWarning
            && !prefs.devMode
            && !context.isPackageInstalled(options.packageName)
            && context.isPlayProtectEnabled() == true
        ) {
            container.log("Showing play protect warning dialog")
            val neverShowAgain = overlays.startComposableForResult { onResult ->
                PlayProtectDialog(onDismiss = onResult)
            }
            prefs.showPlayProtectWarning = !neverShowAgain
        }

        container.log("Installing ${apk.absolutePath}, silent: ${!prefs.devMode}")
        var lastProgress = 0f
        val result = installer.waitInstall(
            apks = listOf(apk),
            silent = !prefs.devMode,
            onProgressUpdate = { newProgress ->
                this@InstallStep.progress = newProgress

                if (newProgress > lastProgress + 0.1f) {
                    container.log("Install progress: ${(newProgress * 100.0).toPrecision(0)}% after ${getDuration()}ms")
                }
                @Suppress("AssignedValueIsNeverRead") // incorrect
                lastProgress = newProgress
            },
        )

        when (result) {
            is InstallerResult.Error -> {
                container.log("Installation failed")
                throw Error("Failed to install APKs: ${result.getDebugReason()}")
            }

            is InstallerResult.Cancelled -> {
                // The install screen is automatically closed immediately once cleanup finishes
                state = StepState.Skipped
                container.log("Installation was cancelled by user")
            }

            InstallerResult.Success ->
                container.log("Installation successful")
        }
    }
}
