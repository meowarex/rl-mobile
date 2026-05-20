package com.meowarex.rlmobile.di

import android.content.Context
import com.meowarex.rlmobile.manager.PreferencesManager
import org.koin.core.scope.Scope

fun Scope.providePreferences(): PreferencesManager {
    val ctx: Context = get()
    return PreferencesManager(ctx.getSharedPreferences("preferences", Context.MODE_PRIVATE))
}
