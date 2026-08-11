package com.meowarex.rlmobile.ui.components.settings

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.unit.dp

/**
 * Where a row sits inside a settings group. (decides corner merging)
 */
enum class GroupPosition {
    Top,
    Middle,
    Bottom,
    Single;

    val shape: Shape
        get() = when (this) {
            Top -> RoundedCornerShape(OUTER, OUTER, INNER, INNER)
            Middle -> RoundedCornerShape(INNER)
            Bottom -> RoundedCornerShape(INNER, INNER, OUTER, OUTER)
            Single -> RoundedCornerShape(OUTER)
        }

    private companion object {
        val OUTER = 24.dp
        val INNER = 6.dp
    }
}

/**
 * Resolves the position of index [index] in a group of [count] rows.
 */
fun groupPosition(index: Int, count: Int): GroupPosition = when {
    count <= 1 -> GroupPosition.Single
    index == 0 -> GroupPosition.Top
    index == count - 1 -> GroupPosition.Bottom
    else -> GroupPosition.Middle
}

/**
 * Container for settings rows. (3dp gap separates the tiles)
 */
@Composable
fun SettingsGroup(
    modifier: Modifier = Modifier,
    content: @Composable ColumnScope.() -> Unit,
) {
    Column(
        verticalArrangement = Arrangement.spacedBy(3.dp),
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp),
        content = content,
    )
}
