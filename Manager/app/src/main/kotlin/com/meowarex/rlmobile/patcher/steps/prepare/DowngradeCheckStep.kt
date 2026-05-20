package com.meowarex.rlmobile.patcher.steps.prepare

import android.app.Application
import android.content.pm.PackageManager.NameNotFoundException
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.installers.InstallerResult
import com.meowarex.rlmobile.manager.InstallerManager
import com.meowarex.rlmobile.patcher.StepRunner
import com.meowarex.rlmobile.patcher.steps.StepGroup
import com.meowarex.rlmobile.patcher.steps.base.Step
import com.meowarex.rlmobile.patcher.steps.base.StepState
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptions
import com.meowarex.rlmobile.util.*
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

/**
 * Prompt the user to uninstall a previous version of Radiant Lyrics if it has a larger version code.
 * (Prevent conflicts from downgrading)
 */
class DowngradeCheckStep(private val options: PatchOptions) : Step(), KoinComponent {
    private val context: Application by inject()
    private val installers: InstallerManager by inject()

    override val group = StepGroup.Prepare
    override val localizedName = R.string.patch_step_downgrade_check

    override suspend fun execute(container: StepRunner) {
        container.log("Fetching version of package ${options.packageName}")
        val (_, currentVersion) = try {
            context.getPackageVersion(options.packageName)
        }
        // Package is not installed
        catch (_: NameNotFoundException) {
            state = StepState.Skipped
            container.log("Package not uninstalled, skipping check")
            return
        }
        container.log("Version of installed TIDAL app: $currentVersion")

        val targetVersion = container
            .getStep<FetchInfoStep>()
            .data.tidalVersionCode

        container.log("Target TIDAL version: $targetVersion")

        if (currentVersion > targetVersion) {
            container.log("Current installed version is greater than target, forcing uninstallation")
            mainThread { context.showToast(R.string.installer_uninstall_new) }

            when (val result = installers.getActiveInstaller().waitUninstall(options.packageName)) {
                is InstallerResult.Error -> throw Error("Failed to uninstall app: ${result.getDebugReason()}")
                is InstallerResult.Cancelled -> {
                    mainThread { context.showToast(R.string.installer_uninstall_new) }
                    throw Error("Newer versions of TIDAL must be uninstalled prior to installing an older version")
                }

                else -> {}
            }
        }
    }
}
