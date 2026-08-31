package com.meowarex.rlmobile.ui.screens.patchopts

import android.content.Context
import android.os.Build
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.Stable
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlin.math.roundToInt

@Serializable
data class PatchManifest(
    val version: Int = 1,
    val patches: List<PatchSpec> = emptyList(),
)

@Immutable
@Serializable
data class PatchSpec(
    val id: String,
    val order: Int = 0,
    val fileNames: List<String> = emptyList(),
    val extensionFiles: List<String> = emptyList(),
    val title: String,
    val description: String = "",
    @SerialName("default") val defaultEnabled: Boolean = false,
    /** ids of patches that get force-enabled when this one is enabled. */
    val requires: List<String> = emptyList(),
    /** ids of patches that get force-disabled when this one is enabled. */
    val disables: List<String> = emptyList(),
    val variants: List<VariantSpec> = emptyList(),
    val defaultVariantIndex: Int = 0,
    val advancedOptions: List<OptionSpec> = emptyList(),
    val category: String = CATEGORY_PATCH,
    val pathLocked: Boolean = false,
) {
    val isIntegration: Boolean get() = category == CATEGORY_INTEGRATION

    companion object {
        const val CATEGORY_PATCH = "patch"
        const val CATEGORY_INTEGRATION = "integration"
    }
}

@Immutable
@Serializable
data class VariantSpec(
    val title: String,
    val fileNames: List<String> = emptyList(),
    val extensionFiles: List<String> = emptyList(),
    val enabled: Boolean = true,
    /**
     * Hidden from the picker on devices below this API level (AGSL needs 33)
     */
    val minSdk: Int = 0,
) {
    val supportedHere: Boolean get() = Build.VERSION.SDK_INT >= minSdk
}

/** A single advanced option. Discriminated by `"type"` in JSON. */
@Serializable
sealed interface OptionSpec {
    val key: String
    val title: String
    val description: String

    @Immutable
    @Serializable
    @SerialName("toggle")
    data class Toggle(
        override val key: String,
        override val title: String,
        override val description: String = "",
        val default: Boolean = false,
        /** Patch files applied only while this toggle is on (and its patch is enabled). */
        val fileNames: List<String> = emptyList(),
        /** Helper smali extracted only while this toggle is on. */
        val extensionFiles: List<String> = emptyList(),
        /** Render inline beneath the variant selector instead of inside the advanced sheet. */
        val inline: Boolean = false,
        /** Greyed out (with the lock dialog) unless this variant index is the selected one. */
        val requiresVariant: Int? = null,
        /** Greyed out unless the sibling option with this key is currently on. */
        val requiresOption: String? = null,
        /** Variant indices hidden from the picker while this toggle is on. */
        val hidesVariants: List<Int> = emptyList(),
        /** Variant title overrides (index -> title) applied while this toggle is on. */
        val relabelVariants: Map<Int, String> = emptyMap(),
        /** Placeholder name (without the surrounding `__`) baked into the `.patch` files. */
        val token: String? = null,
    ) : OptionSpec

    @Immutable
    @Serializable
    @SerialName("slider")
    data class Slider(
        override val key: String,
        override val title: String,
        override val description: String = "",
        val default: Float = 0f,
        val min: Float = 0f,
        val max: Float = 100f,
        val steps: Int = 0,
        val displayAsPercent: Boolean = false,
        val unit: String? = null,
        /** Placeholder name (without the surrounding `__`) baked into the `.patch` files. */
        val token: String? = null,
        /** How the chosen value becomes the smali literal that replaces the token. */
        val encode: SmaliEncode? = null,
        /** Hidden unless this variant index is the selected one. */
        val requiresVariant: Int? = null,
    ) : OptionSpec {
        val valueRange: ClosedFloatingPointRange<Float> get() = min..max
    }

    @Immutable
    @Serializable
    @SerialName("choice")
    data class Choice(
        override val key: String,
        override val title: String = "",
        override val description: String = "",
        val entries: List<String> = emptyList(),
        val defaultIndex: Int = 0,
        val values: List<String> = emptyList(),
        val requiresOption: String? = null,
        val forceDropdown: Boolean = false,
        val distinctFrom: String? = null,
        val token: String? = null,
    ) : OptionSpec

    @Immutable
    @Serializable
    @SerialName("color")
    data class Color(
        override val key: String,
        override val title: String = "",
        override val description: String = "",
        val default: Int = 0,
        /** Placeholder name (without the surrounding `__`) baked into the `.patch`/extension files. */
        val token: String? = null,
    ) : OptionSpec
}

@Serializable
enum class EncodeKind {
    @SerialName("floatBits")
    FloatBits,

    @SerialName("argbAlpha")
    ArgbAlpha,

    @SerialName("int")
    IntValue,
}

@Immutable
@Serializable
data class SmaliEncode(
    val kind: EncodeKind,
    val scale: Float = 1f,
) {
    fun encode(value: Float): String = when (kind) {
        // Float dp bit-pattern: const vX, <bits>; Dp.constructor-impl(F)F
        EncodeKind.FloatBits -> (value * scale).toRawBits().toString()
        // ARGB int with black RGB and a percentage-derived alpha: const vX, <argb>
        EncodeKind.ArgbAlpha -> ((value / 100f * 255f).roundToInt() shl 24).toString()
        // Plain (optionally scaled) integer literal.
        EncodeKind.IntValue -> (value * scale).roundToInt().toString()
    }
}

/** Asset filename of the bundled fallback manifest snapshot (a copy of the release manifest.json). */
const val BUNDLED_MANIFEST_ASSET = "patches-manifest.json"

// Fallback patch list (snapshot of the release manifest bundled in the app's assets)
fun builtinPatchSpecs(context: Context, json: Json): List<PatchSpec> = try {
    context.assets.open(BUNDLED_MANIFEST_ASSET).use { it.readBytes() }
        .let { json.decodeFromString(PatchManifest.serializer(), it.decodeToString()) }
        .patches
        .sortedBy { it.order }
} catch (t: Throwable) {
    emptyList()
}

@Immutable
data class EffectiveVariant(val originalIndex: Int, val title: String, val enabled: Boolean = true)

fun PatchSpec.effectiveVariants(isOptionOn: (OptionSpec.Toggle) -> Boolean): List<EffectiveVariant> {
    if (variants.isEmpty()) return emptyList()
    val hidden = mutableSetOf<Int>()
    val relabel = mutableMapOf<Int, String>()
    for (option in advancedOptions) {
        if (option is OptionSpec.Toggle && isOptionOn(option)) {
            hidden += option.hidesVariants
            relabel += option.relabelVariants
        }
    }
    return variants.mapIndexedNotNull { index, variant ->
        // Everything downstream (variantIndex -> resolveVariantIndex) picks from this list, so
        // dropping an unsupported variant here also keeps the patcher from ever applying it.
        if (index in hidden || !variant.supportedHere) null
        else EffectiveVariant(index, relabel[index] ?: variant.title, variant.enabled)
    }
}

fun PatchSpec.resolveVariantIndex(stored: Int, isOptionOn: (OptionSpec.Toggle) -> Boolean): Int {
    val visible = effectiveVariants(isOptionOn)
    // never resolve onto a greyed/disabled variant
    if (visible.isEmpty() || visible.any { it.originalIndex == stored && it.enabled }) return stored
    val relabelKeys = buildSet {
        for (option in advancedOptions) {
            if (option is OptionSpec.Toggle && isOptionOn(option)) addAll(option.relabelVariants.keys)
        }
    }
    return visible.firstOrNull { it.originalIndex in relabelKeys && it.enabled }?.originalIndex
        ?: visible.firstOrNull { it.enabled }?.originalIndex
        ?: visible.first().originalIndex
}

/**
 * The variant this option belongs to
 */
val OptionSpec.variantGate: Int?
    get() = when (this) {
        is OptionSpec.Toggle -> requiresVariant
        is OptionSpec.Slider -> requiresVariant
        is OptionSpec.Choice -> null
        is OptionSpec.Color -> null
    }

fun OptionSpec.hiddenForVariant(selectedVariant: Int): Boolean =
    variantGate.let { it != null && it != selectedVariant }

fun PatchSpec.conflictingChoices(option: OptionSpec.Choice): List<OptionSpec.Choice> =
    advancedOptions.filterIsInstance<OptionSpec.Choice>().filter { other ->
        other.key != option.key &&
                (option.distinctFrom == other.key || other.distinctFrom == option.key)
    }

internal fun normalizeChoiceSelections(
    specs: List<PatchSpec>,
    values: Map<String, Int>,
    preferredKey: String? = null,
): Map<String, Int> {
    val normalized = values.toMutableMap()
    for (spec in specs) {
        val choices = spec.advancedOptions.filterIsInstance<OptionSpec.Choice>()
        fun fullKey(option: OptionSpec.Choice) = "${spec.id}/${option.key}"
        fun selected(option: OptionSpec.Choice): Int =
            (normalized[fullKey(option)] ?: option.defaultIndex)
                .coerceIn(0, option.entries.lastIndex.coerceAtLeast(0))

        for (leftIndex in choices.indices) {
            val left = choices[leftIndex]
            for (rightIndex in leftIndex + 1 until choices.size) {
                val right = choices[rightIndex]
                if (left.distinctFrom != right.key && right.distinctFrom != left.key) continue
                val selected = selected(left)
                if (selected == 0 || selected != selected(right)) continue

                val loser = if (preferredKey == fullKey(right)) left else right
                normalized[fullKey(loser)] = 0
            }
        }
    }
    return if (normalized == values) values else normalized
}

sealed interface OptionLock {
    data object Free : OptionLock
    data class NeedsVariant(val title: String) : OptionLock
    data class NeedsOption(val title: String) : OptionLock
}

fun PatchSpec.optionLock(
    option: OptionSpec,
    selectedVariant: Int,
    isOptionOn: (OptionSpec.Toggle) -> Boolean,
): OptionLock {
    if (option !is OptionSpec.Toggle) return OptionLock.Free
    option.requiresVariant?.let { required ->
        if (selectedVariant != required) {
            variants.getOrNull(required)?.let { return OptionLock.NeedsVariant(it.title) }
        }
    }
    option.requiresOption?.let { key ->
        val required = advancedOptions.filterIsInstance<OptionSpec.Toggle>().firstOrNull { it.key == key }
        if (required != null && !isOptionOn(required)) return OptionLock.NeedsOption(required.title)
    }
    return OptionLock.Free
}

@Stable
class PatchOptionState(
    val toggle: (PatchSpec, OptionSpec.Toggle) -> Boolean,
    val setToggle: (PatchSpec, OptionSpec.Toggle, Boolean) -> Unit,
    val slider: (PatchSpec, OptionSpec.Slider) -> Float,
    val setSlider: (PatchSpec, OptionSpec.Slider, Float) -> Unit,
    val choice: (PatchSpec, OptionSpec.Choice) -> Int,
    val setChoice: (PatchSpec, OptionSpec.Choice, Int) -> Unit,
    val color: (PatchSpec, OptionSpec.Color) -> Int,
    val setColor: (PatchSpec, OptionSpec.Color, Int) -> Unit,
    val isModified: (PatchSpec) -> Boolean,
    val reset: (PatchSpec) -> Unit,
) {
    companion object {
        /** Read-only stub returning defaults — for Compose previews. */
        val Preview = PatchOptionState(
            toggle = { _, option -> option.default },
            setToggle = { _, _, _ -> },
            slider = { _, option -> option.default },
            setSlider = { _, _, _ -> },
            choice = { _, option -> option.defaultIndex },
            setChoice = { _, _, _ -> },
            color = { _, option -> option.default },
            setColor = { _, _, _ -> },
            isModified = { false },
            reset = {},
        )
    }
}
