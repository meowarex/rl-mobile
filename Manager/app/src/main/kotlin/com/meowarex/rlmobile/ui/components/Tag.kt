package com.meowarex.rlmobile.ui.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.theme.glassSurface

/**
 * Status pill
 */
@Composable
fun Tag(
    text: String,
    icon: Painter? = null,
    tint: Color = MaterialTheme.colorScheme.primary,
    modifier: Modifier = Modifier,
    onClick: (() -> Unit)? = null,
) {
    Row(
        horizontalArrangement = Arrangement.spacedBy(5.dp),
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier
            .glassSurface(CircleShape, tint = tint)
            .clip(CircleShape)
            .then(if (onClick != null) Modifier.clickable(onClick = onClick) else Modifier)
            .padding(horizontal = 9.dp, vertical = 4.dp),
    ) {
        if (icon != null) {
            Icon(
                painter = icon,
                contentDescription = null,
                tint = tint,
                modifier = Modifier.size(12.dp),
            )
        }

        Text(
            text = text,
            style = MaterialTheme.typography.labelMedium,
            color = tint,
        )
    }
}

/**
 * "New" pin for things the update added
 */
@Composable
fun NewPin(
    modifier: Modifier = Modifier,
    text: String = stringResource(R.string.patchopts_new),
) {
    val tint = MaterialTheme.colorScheme.primary
    Text(
        text = text,
        style = MaterialTheme.typography.labelSmall,
        color = tint,
        maxLines = 1,
        modifier = modifier
            .glassSurface(CircleShape, tint = tint)
            .clip(CircleShape)
            .padding(horizontal = 7.dp, vertical = 2.dp),
    )
}

/**
 * Title with a New pin after it
 */
@Composable
fun TitleWithNewPin(
    title: String,
    isNew: Boolean,
    style: TextStyle,
    modifier: Modifier = Modifier,
    pinText: String = stringResource(R.string.patchopts_new),
) {
    Row(
        horizontalArrangement = Arrangement.spacedBy(6.dp),
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier,
    ) {
        Text(
            text = title,
            style = style,
            modifier = Modifier.weight(1f, fill = false),
        )
        if (isNew) NewPin(text = pinText)
    }
}
