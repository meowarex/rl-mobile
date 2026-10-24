package com.meowarex.rlmobile.ui.screens.patchopts

import android.os.Parcelable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.staticCompositionLocalOf
import kotlinx.parcelize.Parcelize

/** Patch id -> option keys an install was patched with */
typealias PatchCatalog = Map<String, List<String>>

fun List<PatchSpec>.toCatalog(): PatchCatalog =
    associate { spec -> spec.id to spec.advancedOptions.map { it.key } }

enum class PatchUpdateKind {
    /** Only changes to patches the install already has */
    Updated,
    NewOptions,
    NewPatches,
}

/**
 * What the latest patches add on top of an install
 */
@Immutable
@Parcelize
data class PatchChanges(
    val newPatches: Set<String> = emptySet(),
    /** Patch id -> new option keys, existing patches only */
    val newOptions: Map<String, Set<String>> = emptyMap(),
) : Parcelable {
    val kind: PatchUpdateKind
        get() = when {
            newPatches.isNotEmpty() -> PatchUpdateKind.NewPatches
            newOptions.isNotEmpty() -> PatchUpdateKind.NewOptions
            else -> PatchUpdateKind.Updated
        }

    val isEmpty: Boolean get() = newPatches.isEmpty() && newOptions.isEmpty()

    fun isNew(spec: PatchSpec): Boolean = spec.id in newPatches

    fun isNew(spec: PatchSpec, option: OptionSpec): Boolean =
        newOptions[spec.id]?.contains(option.key) == true

    /** New itself, or has new options */
    fun hasNew(spec: PatchSpec): Boolean = isNew(spec) || !newOptions[spec.id].isNullOrEmpty()

    /** New options that live in the advanced sheet */
    fun hasNewSheetOptions(spec: PatchSpec): Boolean =
        spec.advancedOptions.any { !it.isInline && isNew(spec, it) }

    companion object {
        val None = PatchChanges()

        fun between(installed: PatchCatalog, latest: List<PatchSpec>): PatchChanges {
            val newPatches = latest.filter { it.id !in installed }.mapTo(mutableSetOf()) { it.id }
            val newOptions = buildMap {
                for (spec in latest) {
                    val known = installed[spec.id] ?: continue
                    val added = spec.advancedOptions.map { it.key }.filterTo(mutableSetOf()) { it !in known }
                    if (added.isNotEmpty()) put(spec.id, added)
                }
            }
            return PatchChanges(newPatches, newOptions)
        }
    }
}

/** Drives the "New" pins in the patch lists */
val LocalPatchChanges = staticCompositionLocalOf { PatchChanges.None }
