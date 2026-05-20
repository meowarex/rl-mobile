package com.meowarex.rlmobile.ui.screens.patchopts

import android.os.Parcelable
import androidx.compose.foundation.*
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.koin.koinScreenModel
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.*
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import com.meowarex.rlmobile.ui.screens.patching.PatchingScreen
import com.meowarex.rlmobile.ui.screens.patchopts.components.PackageNameStateLabel
import com.meowarex.rlmobile.ui.screens.patchopts.components.PatchOptionsAppBar
import com.meowarex.rlmobile.ui.screens.patchopts.components.options.*
import com.meowarex.rlmobile.ui.util.spacedByLastAtBottom
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize
import org.koin.core.parameter.parametersOf

@Parcelize
class PatchOptionsScreen(
    private val prefilledOptions: PatchOptions? = null,
) : Screen, Parcelable {
    @IgnoredOnParcel
    override val key = "PatchOptions"

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        val model = koinScreenModel<PatchOptionsModel> { parametersOf(prefilledOptions ?: PatchOptions.Default) }

        PatchOptionsScreenContent(
            isUpdate = prefilledOptions != null,
            isDevMode = model.isDevMode,

            debuggable = model.debuggable,
            setDebuggable = model::changeDebuggable,

            appName = model.appName,
            appNameIsError = model.appNameIsError,
            setAppName = model::changeAppName,

            packageName = model.packageName,
            packageNameState = model.packageNameState,
            setPackageName = model::changePackageName,

            customInjector = model.customInjector,
            customPatches = model.customPatches,
            onSelectCustomInjector = { model.selectCustomInjector(navigator) },
            onSelectCustomPatches = { model.selectCustomPatches(navigator) },

            isConfigValid = model.isConfigValid,
            onInstall = {
                navigator.push(PatchingScreen(model.generateConfig()))
            },
        )
    }
}

@Composable
fun PatchOptionsScreenContent(
    isUpdate: Boolean,
    isDevMode: Boolean,

    debuggable: Boolean,
    setDebuggable: (Boolean) -> Unit,

    appName: String,
    appNameIsError: Boolean,
    setAppName: (String) -> Unit,

    packageName: String,
    packageNameState: PackageNameState,
    setPackageName: (String) -> Unit,

    customInjector: PatchComponent?,
    onSelectCustomInjector: () -> Unit,
    customPatches: PatchComponent?,
    onSelectCustomPatches: () -> Unit,

    isConfigValid: Boolean,
    onInstall: () -> Unit,
) {
    Scaffold(
        topBar = { PatchOptionsAppBar(isUpdate = isUpdate) },
    ) { paddingValues ->
        Column(
            verticalArrangement = Arrangement.spacedByLastAtBottom(20.dp),
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
                .padding(paddingValues)
                .padding(horizontal = 20.dp, vertical = 10.dp)
        ) {
            Text(
                text = stringResource(R.string.patchopts_title),
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                textAlign = TextAlign.Center,
            )

            TextDivider(text = stringResource(R.string.patchopts_divider_basic))

            val appNameIsDefault by remember {
                derivedStateOf {
                    appName == PatchOptions.Default.appName
                }
            }
            TextPatchOption(
                name = stringResource(R.string.patchopts_appname_title),
                description = stringResource(R.string.patchopts_appname_desc),
                value = appName,
                valueIsError = appNameIsError,
                valueIsDefault = appNameIsDefault,
                onValueChange = setAppName,
                onValueReset = { setAppName(PatchOptions.Default.appName) },
            )

            if (!isUpdate) {
                val packageNameIsDefault by remember {
                    derivedStateOf {
                        packageName == PatchOptions.Default.packageName
                    }
                }
                TextPatchOption(
                    name = stringResource(R.string.patchopts_pkgname_title),
                    description = stringResource(R.string.patchopts_pkgname_desc),
                    value = packageName,
                    valueIsError = packageNameState == PackageNameState.Invalid,
                    valueIsDefault = packageNameIsDefault,
                    onValueChange = setPackageName,
                    onValueReset = { setPackageName(PatchOptions.Default.packageName) },
                ) {
                    PackageNameStateLabel(
                        state = packageNameState,
                        modifier = Modifier.padding(start = 4.dp),
                    )
                }
            }

            if (isDevMode) {
                TextDivider(
                    text = stringResource(R.string.patchopts_divider_advanced),
                    modifier = Modifier.padding(top = 12.dp),
                )

                SwitchPatchOption(
                    icon = painterResource(R.drawable.ic_bug),
                    name = stringResource(R.string.patchopts_debuggable_title),
                    description = stringResource(R.string.patchopts_debuggable_desc),
                    value = debuggable,
                    onValueChange = setDebuggable,
                )

                IconPatchOption(
                    icon = painterResource(R.drawable.ic_extension),
                    name = stringResource(R.string.patchopts_custom_injector_title),
                    description = stringResource(R.string.patchopts_custom_injector_desc),
                    modifier = Modifier.clickable(onClick = onSelectCustomInjector),
                ) {
                    FilledTonalButton(onClick = onSelectCustomInjector) {
                        Text(
                            text = customInjector?.version?.toString()
                                ?: stringResource(R.string.componentopts_selected_none)
                        )
                    }
                }

                IconPatchOption(
                    icon = painterResource(R.drawable.ic_extension),
                    name = stringResource(R.string.patchopts_custom_patches_title),
                    description = stringResource(R.string.patchopts_custom_patches_desc),
                    modifier = Modifier.clickable(onClick = onSelectCustomPatches),
                ) {
                    FilledTonalButton(onClick = onSelectCustomPatches) {
                        Text(
                            text = customPatches?.version?.toString()
                                ?: stringResource(R.string.componentopts_selected_none)
                        )
                    }
                }
            }

            Spacer(Modifier.weight(1f))

            FilledTonalButton(
                enabled = isConfigValid,
                onClick = onInstall,
                colors = ButtonDefaults.filledTonalButtonColors(
                    contentColor = MaterialTheme.colorScheme.primary,
                ),
                modifier = Modifier
                    .padding(bottom = 10.dp)
                    .align(Alignment.End),
            ) {
                Text(stringResource(R.string.action_install))
            }
        }
    }
}
