package com.meowarex.rlmobile

import android.app.Application
import coil3.ImageLoader
import coil3.SingletonImageLoader
import coil3.annotation.DelicateCoilApi
import com.meowarex.rlmobile.di.*
import com.meowarex.rlmobile.installers.dhizuku.DhizukuInstaller
import com.meowarex.rlmobile.installers.intent.IntentInstaller
import com.meowarex.rlmobile.installers.pm.PMInstaller
import com.meowarex.rlmobile.installers.root.RootInstaller
import com.meowarex.rlmobile.installers.shizuku.ShizukuInstaller
import com.meowarex.rlmobile.manager.*
import com.meowarex.rlmobile.manager.download.AndroidDownloadManager
import com.meowarex.rlmobile.manager.download.KtorDownloadManager
import com.meowarex.rlmobile.network.services.*
import com.meowarex.rlmobile.ui.screens.about.AboutModel
import com.meowarex.rlmobile.ui.screens.componentopts.ComponentOptionsModel
import com.meowarex.rlmobile.ui.screens.home.HomeModel
import com.meowarex.rlmobile.ui.screens.log.LogScreenModel
import com.meowarex.rlmobile.ui.screens.logs.LogsListScreenModel
import com.meowarex.rlmobile.ui.screens.patching.PatchingScreenModel
import com.meowarex.rlmobile.ui.screens.patchopts.PatchOptionsModel
import com.meowarex.rlmobile.ui.screens.permissions.PermissionsModel
import com.meowarex.rlmobile.ui.screens.settings.SettingsModel
import com.meowarex.rlmobile.ui.widgets.updater.UpdaterViewModel
import com.meowarex.rlmobile.updatechecker.UpdateCheckWorker
import kotlinx.coroutines.Dispatchers
import org.koin.android.ext.android.get
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin
import org.koin.core.module.dsl.*
import org.koin.dsl.module

class ManagerApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        startKoin {
            // Android activities & context
            androidContext(this@ManagerApplication)
            modules(module(createdAtStart = true) {
                singleOf(::ActivityProvider)
            })

            // HTTP
            modules(module {
                single { provideJson() }
                single { provideHttpClient() }
            })

            // Services
            modules(module {
                singleOf(::HttpService)
                singleOf(::RadiantLyricsGithubService)
            })

            // UI Models
            modules(module {
                factoryOf(::HomeModel)
                factoryOf(::AboutModel)
                factoryOf(::PatchingScreenModel)
                factoryOf(::SettingsModel)
                factoryOf(::PatchOptionsModel)
                factoryOf(::ComponentOptionsModel)
                factoryOf(::LogScreenModel)
                factoryOf(::LogsListScreenModel)
                factoryOf(::PermissionsModel)
                viewModelOf(::UpdaterViewModel)
            })

            // Managers
            modules(module {
                single { providePreferences() }
                singleOf(::PathManager)
                singleOf(::InstallerManager)
                singleOf(::OverlayManager)
                singleOf(::InstallLogManager)

                singleOf(::ShizukuManager)
                singleOf(::DhizukuManager)

                singleOf(::AndroidDownloadManager)
                singleOf(::KtorDownloadManager)
            })

            // Installers
            modules(module {
                singleOf(::PMInstaller)
                singleOf(::RootInstaller)
                singleOf(::IntentInstaller)
                singleOf(::ShizukuInstaller)
                singleOf(::DhizukuInstaller)
            })
        }

        // Limit parallel fetching of images using Coil
        @OptIn(DelicateCoilApi::class)
        SingletonImageLoader.setUnsafe { context ->
            ImageLoader.Builder(context)
                .fetcherCoroutineContext(Dispatchers.IO.limitedParallelism(5))
                .build()
        }

        // Schedule periodic update check only when the user has opted in,
        // so the disabled state survives app restarts instead of being re-enqueued.
        if (get<PreferencesManager>().autoUpdateCheck) {
            UpdateCheckWorker.schedule(this)
        } else {
            UpdateCheckWorker.cancel(this)
        }
    }
}
