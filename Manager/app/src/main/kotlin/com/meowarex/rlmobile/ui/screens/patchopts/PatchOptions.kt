package com.meowarex.rlmobile.ui.screens.patchopts

import android.os.Parcelable
import androidx.compose.runtime.Immutable
import com.meowarex.rlmobile.ui.screens.componentopts.PatchComponent
import kotlinx.parcelize.Parcelize
import kotlinx.serialization.Serializable

@Immutable
@Parcelize
@Serializable
data class PatchOptions(
    /**
     * The app name that's user-facing in launchers.
     */
    val appName: String,

    /**
     * Changes the installation package name.
     */
    val packageName: String,

    /**
     * Adding the debuggable APK flag.
     */
    val debuggable: Boolean,

    val customTidalApk: PatchComponent? = null,

    /**
     * A custom smali patches bundle that was used rather than the latest.
     */
    val customPatches: PatchComponent? = null,

    val patchStates: Map<String, Boolean> = emptyMap(),

    val selectedVariants: Map<String, Int> = emptyMap(),
    val optionFloats: Map<String, Float> = emptyMap(),
    val optionBools: Map<String, Boolean> = emptyMap(),
    val optionInts: Map<String, Int> = emptyMap(),

    /** Patches release to repatch on while the Manager is outdated */
    @kotlinx.serialization.Transient
    val pinnedPatchesVersion: String? = null,
) : Parcelable {

    fun isEnabled(spec: PatchSpec): Boolean =
        patchStates[spec.id] ?: spec.defaultEnabled

    fun variantIndex(spec: PatchSpec): Int {
        val stored = (selectedVariants[spec.variantStoreKey] ?: spec.defaultVariantIndex)
            .coerceIn(0, spec.variants.lastIndex.coerceAtLeast(0))
        return spec.resolveVariantIndex(stored) { isToggleOn(spec, it) }
    }

    fun sliderValue(spec: PatchSpec, option: OptionSpec.Slider): Float =
        (optionFloats["${spec.id}/${option.key}"] ?: option.default).coerceIn(option.min, option.max)

    fun choiceIndex(spec: PatchSpec, option: OptionSpec.Choice): Int =
        (optionInts["${spec.id}/${option.key}"] ?: option.defaultIndex)
            .coerceIn(0, option.entries.lastIndex.coerceAtLeast(0))

    fun colorValue(spec: PatchSpec, option: OptionSpec.Color): Int =
        optionInts["${spec.id}/${option.key}"] ?: option.default

    private fun rawToggleOn(spec: PatchSpec, option: OptionSpec.Toggle): Boolean =
        optionBools["${spec.id}/${option.key}"] ?: option.default

    fun isToggleOn(spec: PatchSpec, option: OptionSpec.Toggle): Boolean {
        // Pinned while its locking toggle is on
        if (spec.lockingToggle(option) { rawToggleOn(spec, it) } != null) return option.lockedValue ?: option.default
        return rawToggleOn(spec, option)
    }

    fun isToggleActive(spec: PatchSpec, option: OptionSpec.Toggle): Boolean {
        if (!isToggleOn(spec, option)) return false
        option.requiresVariant?.let { if (variantIndex(spec) != it) return false }
        option.requiresOption?.let { key ->
            val required = spec.advancedOptions.filterIsInstance<OptionSpec.Toggle>()
                .firstOrNull { it.key == key }
            if (required != null && !isToggleOn(spec, required)) return false
        }
        return true
    }

    fun disabledPatchFiles(specs: List<PatchSpec>): Set<String> = buildSet {
        for (spec in specs) {
            val enabled = isEnabled(spec)
            if (spec.variants.isEmpty()) {
                if (!enabled) addAll(spec.fileNames)
            } else {
                // base fileNames apply for every variant while enabled; disable them when off
                if (!enabled) addAll(spec.fileNames)
                val selected = variantIndex(spec)
                spec.variants.forEachIndexed { index, variant ->
                    if (!enabled || index != selected) addAll(variant.fileNames)
                }
            }
            // Toggle sub-options that gate patch files.
            for (option in spec.advancedOptions) {
                if (option is OptionSpec.Toggle && option.fileNames.isNotEmpty()) {
                    if (!enabled || !isToggleActive(spec, option)) addAll(option.fileNames)
                }
            }
            // Toggle x variant files, like Floating x Grey/Black
            for (option in spec.advancedOptions) {
                if (option !is OptionSpec.Toggle) continue
                if (option.variantFileNames.isEmpty() && option.offVariantFileNames.isEmpty()) continue
                val active = enabled && isToggleActive(spec, option)
                val selected = variantIndex(spec)
                option.variantFileNames.forEach { (index, files) ->
                    if (!enabled || !active || index != selected) addAll(files)
                }
                option.offVariantFileNames.forEach { (index, files) ->
                    if (!enabled || active || index != selected) addAll(files)
                }
            }
        }
    }

    fun knownExtensionFiles(specs: List<PatchSpec>): Set<String> = buildSet {
        for (spec in specs) {
            addAll(spec.extensionFiles)
            spec.variants.forEach { addAll(it.extensionFiles) }
            spec.advancedOptions.forEach { if (it is OptionSpec.Toggle) addAll(it.extensionFiles) }
        }
    }

    fun enabledExtensionFiles(specs: List<PatchSpec>): Set<String> = buildSet {
        for (spec in specs) {
            if (!isEnabled(spec)) continue
            addAll(spec.extensionFiles)
            if (spec.variants.isNotEmpty()) {
                spec.variants.getOrNull(variantIndex(spec))?.let { addAll(it.extensionFiles) }
            }
            for (option in spec.advancedOptions) {
                if (option is OptionSpec.Toggle && isToggleActive(spec, option)) addAll(option.extensionFiles)
            }
        }
    }

    fun smaliSubstitutions(specs: List<PatchSpec>): Map<String, String> = buildMap {
        for (spec in specs) {
            if (!isEnabled(spec)) continue
            for (option in spec.advancedOptions) {
                when (option) {
                    is OptionSpec.Toggle -> {
                        val token = option.token ?: continue
                        put("__${token}__", if (isToggleActive(spec, option)) "0x1" else "0x0")
                    }
                    is OptionSpec.Slider -> {
                        val token = option.token ?: continue
                        val encode = option.encode ?: continue
                        put("__${token}__", encode.encode(sliderValue(spec, option)))
                    }
                    is OptionSpec.Choice -> {
                        val token = option.token ?: continue
                        val gatedOff = option.requiresOption?.let { key ->
                            spec.advancedOptions.filterIsInstance<OptionSpec.Toggle>()
                                .firstOrNull { it.key == key }
                                ?.let { !isToggleOn(spec, it) }
                        } ?: false
                        val index = if (gatedOff) 0 else choiceIndex(spec, option)
                        put("__${token}__", option.values.getOrNull(index) ?: continue)
                    }
                    is OptionSpec.Color -> {
                        val token = option.token ?: continue
                        put("__${token}__", colorValue(spec, option).toString())
                    }
                }
            }
        }
    }

    /** Old variant choices moved into the new lists */
    fun migrated(specs: List<PatchSpec>): PatchOptions {
        val (variants, bools) = migrateLegacyVariants(specs, selectedVariants, optionBools)
        return if (variants == selectedVariants && bools == optionBools) this
        else copy(selectedVariants = variants, optionBools = bools)
    }

    companion object {
        val Default: PatchOptions = PatchOptions(
            appName = "TIDAL",
            packageName = "com.aspiro.tidal",
            debuggable = false,
        )
    }
}
