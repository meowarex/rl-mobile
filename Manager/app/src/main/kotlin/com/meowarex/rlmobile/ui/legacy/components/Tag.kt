package com.meowarex.rlmobile.ui.legacy.components

import com.meowarex.rlmobile.ui.components.*

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun Tag(text: String, onClick: (() -> Unit)? = null) {
    val color = MaterialTheme.colorScheme.primaryContainer
    val shape = RoundedCornerShape(6.dp)
    val content: @Composable () -> Unit = {
        Text(
            text = text,
            style = MaterialTheme.typography.labelMedium,
            color = MaterialTheme.colorScheme.onPrimaryContainer,
            modifier = Modifier.padding(horizontal = 8.dp, vertical = 3.dp),
        )
    }
    if (onClick != null) {
        Surface(onClick = onClick, color = color, shape = shape, content = content)
    } else {
        Surface(color = color, shape = shape, content = content)
    }
}
