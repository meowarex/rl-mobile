package com.meowarex.rlmobile.ui.components

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.*
import com.meowarex.rlmobile.ui.util.TidalVersion

@Composable
fun VersionDisplay(
    version: TidalVersion,
    prefix: (@Composable AnnotatedString.Builder.() -> Unit)? = null,
    style: TextStyle = MaterialTheme.typography.labelLarge,
    modifier: Modifier = Modifier,
) {
    Text(
        text = buildAnnotatedString {
            prefix?.invoke(this)

            if (version is TidalVersion.Existing) {
                append(version.name)
                append(" - ")
            }
            append(version.toDisplayName())
        },
        style = style,
        modifier = modifier,
    )
}
