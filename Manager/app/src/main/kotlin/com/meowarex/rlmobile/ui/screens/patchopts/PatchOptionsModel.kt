package com.meowarex.rlmobile.ui.screens.patchopts

import android.content.Context
import android.content.pm.PackageManager.NameNotFoundException
import android.util.Log
import androidx.compose.runtime.*
import cafe.adriel.voyager.core.model.ScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import cafe.adriel.voyager.navigator.Navigator
import com.meowarex.rlmobile.ui.util.ScreenWithResult
import com.github.diamondminer88.zip.ZipReader
import com.meowarex.rlmobile.BuildConfig
import com.meowarex.rlmobile.manager.PathManager
import com.meowarex.rlmobile.manager.PreferencesManager
import com.meowarex.rlmobile.ui.screens.componentopts.ComponentOptionsScreen
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import com.meowarex.rlmobile.ui.util.pushForResult
import com.meowarex.rlmobile.util.*
import com.meowarex.rlmobile.manager.download.IDownloadManager
import com.meowarex.rlmobile.manager.download.KtorDownloadManager
import com.meowarex.rlmobile.network.services.RadiantLyricsGithubService
import com.meowarex.rlmobile.network.utils.getOrThrow
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import java.io.File

class PatchOptionsModel(
    prefilledOptions: PatchOptions,
    private val context: Context,
    private val prefs: PreferencesManager,
    private val paths: PathManager,
    private val json: Json,
    private val github: RadiantLyricsGithubService,
    private val downloader: KtorDownloadManager,
) : ScreenModel {
    var packageName by mutableStateOf(prefilledOptions.packageName)
        private set

    var packageNameState by mutableStateOf(PackageNameState.Ok)
        private set

    fun changePackageName(newPackageName: String) {
        packageName = newPackageName
        fetchPkgNameStateDebounced()
    }

    /** Patches flagged [PatchSpec.pathLocked] only work under the stock package name. */
    fun isBlockedByPackageName(spec: PatchSpec): Boolean =
        spec.pathLocked && packageName != PatchOptions.Default.packageName && !bypassIncompatible

    /** The package-name field starts locked & editing requires confirming the unlock dialog */
    var packageNameLocked by mutableStateOf(prefilledOptions.packageName == PatchOptions.Default.packageName)
        private set

    fun unlockPackageName() {
        packageNameLocked = false
    }

    /** Re-locking snaps the package name back to the stock default */
    fun lockPackageName() {
        packageNameLocked = true
        changePackageName(PatchOptions.Default.packageName)
    }

    var appName by mutableStateOf(prefilledOptions.appName)
        private set

    var appNameIsError by mutableStateOf(false)
        private set

    fun changeAppName(newAppName: String) {
        appName = newAppName
        appNameIsError = newAppName.length !in (1..150)
    }

    var debuggable by mutableStateOf(prefilledOptions.debuggable)
        private set

    fun changeDebuggable(value: Boolean) {
        debuggable = value
    }

    /** Dev override: force-allow path-gated ("incompatible") patches under a non-stock package name. */
    var bypassIncompatible by mutableStateOf(prefs.bypassIncompatible)
        private set

    fun changeBypassIncompatible(value: Boolean) {
        bypassIncompatible = value
        prefs.bypassIncompatible = value
        validatePatchSelection()
    }

    // The accordion renders from [specs]. It defaults to the compiled-in (localized) list and is
    // rebuilt from a custom zip's manifest.json whenever a custom patch set is selected. (Rminder for others about the new custom patch selection flow)

    private val builtinSpecs: List<PatchSpec> = builtinPatchSpecs(context, json)

    var specs by mutableStateOf(builtinSpecs)
        private set

    var specsLoading by mutableStateOf(false)
        private set

    var patchStates by mutableStateOf(prefilledOptions.patchStates)
        private set

    var selectedVariants by mutableStateOf(prefilledOptions.selectedVariants)
        private set

    fun variantIndex(spec: PatchSpec): Int =
        (selectedVariants[spec.id] ?: spec.defaultVariantIndex)
            .coerceIn(0, spec.variants.lastIndex.coerceAtLeast(0))

    fun isPatchEnabled(spec: PatchSpec): Boolean =
        !isBlockedByPackageName(spec) && (patchStates[spec.id] ?: spec.defaultEnabled)

    fun setPatchEnabled(spec: PatchSpec, enabled: Boolean) {
        val byId = specs.associateBy { it.id }
        fun closure(seed: PatchSpec, step: (PatchSpec) -> List<PatchSpec>): Set<PatchSpec> =
            buildSet {
                fun walk(p: PatchSpec) { if (add(p)) step(p).forEach(::walk) }
                walk(seed)
            }

        val requiresOf = { p: PatchSpec -> p.requires.mapNotNull(byId::get) }
        val dependentsOf = { p: PatchSpec -> specs.filter { p.id in it.requires } }

        val enableUnits: Set<PatchSpec>
        val disableUnits: Set<PatchSpec>
        if (enabled) {
            enableUnits = closure(spec, requiresOf)
            disableUnits = enableUnits.flatMap { it.disables }
                .mapNotNull(byId::get)
                .flatMapTo(mutableSetOf()) { d -> closure(d, dependentsOf) }
        } else {
            enableUnits = emptySet()
            disableUnits = closure(spec, dependentsOf)
        }

        patchStates = patchStates.toMutableMap().apply {
            enableUnits.forEach { this[it.id] = true }
            disableUnits.forEach { this[it.id] = false }
        }
    }

    fun selectVariant(spec: PatchSpec, index: Int) {
        if (spec.variants.isEmpty() || index !in spec.variants.indices) return
        selectedVariants = selectedVariants + (spec.id to index)
    }

    // Advanced (per-patch) options
    // Values are seeded from the prefilled config, edited here, and written back out in
    // generateConfig(). At patch time PatchOptions.smaliSubstitutions() turns slider values into
    // the literals baked into the matching `.patch` files (see SmaliPatchStep). ()

    private var optionBools by mutableStateOf(prefilledOptions.optionBools)
    private var optionFloats by mutableStateOf(prefilledOptions.optionFloats)
    private var optionInts by mutableStateOf(prefilledOptions.optionInts)

    private fun keyOf(spec: PatchSpec, option: OptionSpec): String = "${spec.id}/${option.key}"

    fun toggleValue(spec: PatchSpec, option: OptionSpec.Toggle): Boolean =
        optionBools[keyOf(spec, option)] ?: option.default

    fun setToggleValue(spec: PatchSpec, option: OptionSpec.Toggle, value: Boolean) {
        optionBools = optionBools + (keyOf(spec, option) to value)
    }

    fun sliderValue(spec: PatchSpec, option: OptionSpec.Slider): Float =
        (optionFloats[keyOf(spec, option)] ?: option.default).coerceIn(option.min, option.max)

    fun setSliderValue(spec: PatchSpec, option: OptionSpec.Slider, value: Float) {
        optionFloats = optionFloats + (keyOf(spec, option) to value)
    }

    fun choiceValue(spec: PatchSpec, option: OptionSpec.Choice): Int =
        (optionInts[keyOf(spec, option)] ?: option.defaultIndex)
            .coerceIn(0, option.entries.lastIndex.coerceAtLeast(0))

    fun setChoiceValue(spec: PatchSpec, option: OptionSpec.Choice, index: Int) {
        if (index !in option.entries.indices) return
        val selectedKey = keyOf(spec, option)
        optionInts = normalizeChoiceSelections(
            specs = listOf(spec),
            values = optionInts + (selectedKey to index),
            preferredKey = selectedKey,
        )
    }

    fun colorValue(spec: PatchSpec, option: OptionSpec.Color): Int =
        optionInts[keyOf(spec, option)] ?: option.default

    fun setColorValue(spec: PatchSpec, option: OptionSpec.Color, value: Int) {
        optionInts = optionInts + (keyOf(spec, option) to value)
    }

    fun isAdvancedModified(spec: PatchSpec): Boolean = spec.advancedOptions.any { option ->
        when (option) {
            // inline toggles sit next to the variant picker, not in the sheet, so they
            // must not light up the sheet's "modified" dot
            is OptionSpec.Toggle -> !option.inline && toggleValue(spec, option) != option.default
            is OptionSpec.Slider -> sliderValue(spec, option) != option.default
            is OptionSpec.Choice -> choiceValue(spec, option) != option.defaultIndex
            is OptionSpec.Color -> colorValue(spec, option) != option.default
        }
    }

    fun resetAdvanced(spec: PatchSpec) {
        val prefix = "${spec.id}/"
        optionBools = optionBools.filterKeys { !it.startsWith(prefix) }
        optionFloats = optionFloats.filterKeys { !it.startsWith(prefix) }
        optionInts = normalizeChoiceSelections(
            specs = listOf(spec),
            values = optionInts.filterKeys { !it.startsWith(prefix) },
        )
    }

    private fun normalizeChoiceSelections(specs: List<PatchSpec>) {
        optionInts = normalizeChoiceSelections(specs, optionInts)
    }

    val optionState: PatchOptionState = PatchOptionState(
        toggle = ::toggleValue,
        setToggle = ::setToggleValue,
        slider = ::sliderValue,
        setSlider = ::setSliderValue,
        choice = ::choiceValue,
        setChoice = ::setChoiceValue,
        color = ::colorValue,
        setColor = ::setColorValue,
        isModified = ::isAdvancedModified,
        reset = ::resetAdvanced,
    )

    fun lockState(spec: PatchSpec): PatchLock {
        if (isBlockedByPackageName(spec)) return PatchLock.RequiresDefaultPackage
        if (spec.variants.isNotEmpty()) return PatchLock.Free

        val byId = specs.associateBy { it.id }
        fun closure(seed: PatchSpec, step: (PatchSpec) -> List<PatchSpec>): Set<PatchSpec> =
            buildSet {
                fun walk(p: PatchSpec) { if (add(p)) step(p).forEach(::walk) }
                walk(seed)
            }

        val requiresOf = { p: PatchSpec -> p.requires.mapNotNull(byId::get) }
        val dependentsOf = { p: PatchSpec -> specs.filter { p.id in it.requires } }

        for (other in specs) {
            if (other.id == spec.id || !isPatchEnabled(other)) continue

            val requiresClosure = closure(other, requiresOf)
            if (spec in requiresClosure - other) return PatchLock.LockedOn(other)

            val disablesClosure = requiresClosure.flatMap { it.disables }
                .mapNotNull(byId::get)
                .flatMapTo(mutableSetOf()) { d -> closure(d, dependentsOf) }
            if (spec in disablesClosure) return PatchLock.LockedOff(other)
        }
        return PatchLock.Free
    }

    var customTidalApk by mutableStateOf<PatchComponent?>(null)
        private set
    var customPatches by mutableStateOf<PatchComponent?>(null)
        private set

    // The picker screen is supplied by the caller so the Legacy UI can push its own component
    // screen instead of the Radiant one. Defaults keep every existing call site unchanged. (claudes bug fix)
    fun selectCustomTidalApk(
        navigator: Navigator,
        screen: (PatchComponent?) -> ScreenWithResult<PatchComponent?> = { default ->
            ComponentOptionsScreen(default = default, componentType = PatchComponent.Type.TidalApk)
        },
    ) = screenModelScope.launch {
        customTidalApk = navigator.pushForResult(screen(customTidalApk))
    }

    fun selectCustomPatches(
        navigator: Navigator,
        screen: (PatchComponent?) -> ScreenWithResult<PatchComponent?> = { default ->
            ComponentOptionsScreen(default = default, componentType = PatchComponent.Type.Patches)
        },
    ) = screenModelScope.launch {
        customPatches = navigator.pushForResult(screen(customPatches))
        reloadSpecs(customPatches)
    }

    /**
     * Rebuilds [specs] from the selected patch set
     */
    private fun reloadSpecs(component: PatchComponent?) = screenModelScope.launchIO {
        mainThread { specsLoading = true }
        val loaded = if (component == null) builtinSpecs else loadManifestSpecs(component) ?: builtinSpecs
        mainThread {
            specs = loaded
            normalizeChoiceSelections(loaded)
            validatePatchSelection()
            specsLoading = false
        }
    }

    private fun loadManifestSpecs(component: PatchComponent): List<PatchSpec>? =
        loadManifestSpecs(component.getFile(paths))

    private fun loadManifestSpecs(file: File): List<PatchSpec>? {
        if (!file.exists()) return null
        return try {
            val bytes = ZipReader(file).use { it.openEntry(MANIFEST_NAME)?.read() } ?: return null
            json.decodeFromString(PatchManifest.serializer(), bytes.decodeToString())
                .patches
                .sortedBy { it.order }   // manifest is authoritative for UI order (not KnownPatch)
                .takeIf { it.isNotEmpty() }
        } catch (t: Throwable) {
            Log.w(BuildConfig.TAG, "Failed to parse $MANIFEST_NAME; using built-in list", t)
            null
        }
    }

    /**
     * Pulls the patch list from the latest GitHub release's patches.zip manifest
     */
    private suspend fun loadLatestReleaseSpecs(): List<PatchSpec>? = try {
        val release = github.getLatestRelease().getOrThrow()
        val url = release.assets
            .find { it.name == RadiantLyricsGithubService.PATCHES_ASSET_NAME }
            ?.browserDownloadUrl
        if (url == null) {
            Log.w(BuildConfig.TAG, "Latest release ${release.tagName} has no patches.zip asset; using built-in list")
            null
        } else {
            // Cached per release tag so re-opening the screen doesn't re-download the same zip.
            val dest = paths.cacheDownloadDir.resolve("manifest-${release.tagName}.zip")
                .apply { parentFile?.mkdirs() }
            if (dest.exists() || downloader.download(url, dest) is IDownloadManager.Result.Success) {
                loadManifestSpecs(dest).also { loaded ->
                    if (loaded != null) {
                        Log.i(BuildConfig.TAG, "Loaded ${loaded.size} patches from latest release ${release.tagName} manifest")
                    } else {
                        Log.w(BuildConfig.TAG, "Latest release ${release.tagName} ships no manifest.json; using built-in list")
                    }
                }
            } else {
                null
            }
        }
    } catch (t: Throwable) {
        Log.w(BuildConfig.TAG, "Failed to load latest release manifest; using built-in list", t)
        null
    }

    private fun loadCachedReleaseManifestSpecs(): List<PatchSpec>? =
        paths.cacheDownloadDir
            .listFiles { f -> f.name.startsWith("manifest-") && f.name.endsWith(".zip") }
            ?.maxByOrNull { it.lastModified() }
            ?.let { loadManifestSpecs(it) }
            ?.also { Log.i(BuildConfig.TAG, "Loaded ${it.size} patches from cached release manifest (offline)") }

    /** Default (non-custom) source: latest release manifest → last cached manifest → built-in list. */
    private fun loadDefaultSpecs() = screenModelScope.launchIO {
        mainThread { specsLoading = true }
        // Only hit the network when actually online
        val loaded = (if (context.isOnline()) loadLatestReleaseSpecs() else null)
            ?: loadCachedReleaseManifestSpecs() ?: builtinSpecs
        mainThread {
            specs = loaded
            normalizeChoiceSelections(loaded)
            validatePatchSelection()
            specsLoading = false
        }
    }

    val isConfigValid by derivedStateOf {
        val invalidChecks = arrayOf(
            packageNameState == PackageNameState.Invalid,
            appNameIsError,
        )

        invalidChecks.none { it }
    }

    fun generateConfig(): PatchOptions {
        if (!isConfigValid) error("invalid config state")

        return PatchOptions(
            appName = appName,
            packageName = packageName,
            debuggable = debuggable,
            customTidalApk = customTidalApk,
            customPatches = customPatches,
            // Hard-disable package-name-bound patches so the patcher can't apply
            patchStates = patchStates.toMutableMap().apply {
                specs.filter { isBlockedByPackageName(it) }.forEach { this[it.id] = false }
            },
            selectedVariants = selectedVariants,
            optionFloats = optionFloats,
            optionBools = optionBools,
            optionInts = optionInts,
        )
    }

    val isDevMode: Boolean
        get() = prefs.devMode

    private val fetchPkgNameStateDebounced: () -> Unit =
        screenModelScope.debounce(100L, function = ::fetchPkgNameState)

    private suspend fun fetchPkgNameState() {
        val state = if (packageName.length !in (3..150) || !PACKAGE_REGEX.matches(this.packageName)) {
            PackageNameState.Invalid
        } else {
            try {
                context.packageManager.getPackageInfo(packageName, 0)
                PackageNameState.Taken
            } catch (_: NameNotFoundException) {
                PackageNameState.Ok
            }
        }

        mainThread { packageNameState = state }
    }

    private fun validatePatchSelection() {
        for (spec in specs) {
            if (isPatchEnabled(spec)) {
                setPatchEnabled(spec, true)
            }
        }
    }

    init {
        normalizeChoiceSelections(specs)
        validatePatchSelection()
        screenModelScope.launchBlock { fetchPkgNameState() }
        // Default source is the latest release's manifest; custom selections drive themselves.
        if (customPatches == null) loadDefaultSpecs()
    }

    companion object {
        private const val MANIFEST_NAME = "manifest.json"

        private val PACKAGE_REGEX = """^[a-z]\w*(\.[a-z]\w*)+$"""
            .toRegex(RegexOption.IGNORE_CASE)
    }
}

enum class PackageNameState {
    Ok,
    Invalid,
    Taken,
}

sealed class PatchLock {
    data object Free : PatchLock()
    data class LockedOn(val by: PatchSpec) : PatchLock()
    data class LockedOff(val by: PatchSpec) : PatchLock()

    /** Locked off because the install uses a non-default package name */
    data object RequiresDefaultPackage : PatchLock()
}
