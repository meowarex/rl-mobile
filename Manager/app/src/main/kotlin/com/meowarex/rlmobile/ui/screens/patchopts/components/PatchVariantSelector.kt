package com.meowarex.rlmobile.ui.screens.patchopts.components

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.meowarex.rlmobile.ui.components.radiant.RadiantSegmented
import com.meowarex.rlmobile.ui.screens.patchopts.EffectiveVariant

@Composable
fun PatchVariantSelector(
    variants: List<EffectiveVariant>,
    selectedIndex: Int,
    onSelect: (Int) -> Unit,
    modifier: Modifier = Modifier,
) {
    // Variants are mutually exclusive, so this reads as one recessed track with a floating accent
    // pill rather than Material's row of connected outlined buttons.
    RadiantSegmented(
        options = variants.map { it.title },
        selectedIndex = selectedIndex,
        onSelect = { index ->
            if (variants.getOrNull(index)?.enabled == true) onSelect(index)
        },
        modifier = modifier,
    )
}
