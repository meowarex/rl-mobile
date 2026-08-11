package com.meowarex.rlmobile.ui.screens.patchopts.components.options

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.components.Label
import com.meowarex.rlmobile.ui.components.ResetToDefaultButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantIconButton
import com.meowarex.rlmobile.ui.components.radiant.RadiantTextField

@Composable
fun TextPatchOption(
    name: String,
    description: String,
    value: String,
    valueIsError: Boolean,
    valueIsDefault: Boolean,
    onValueChange: (String) -> Unit,
    onValueReset: () -> Unit,
    modifier: Modifier = Modifier,
    locked: Boolean? = null,
    onLockClick: () -> Unit = {},
    extra: (@Composable ColumnScope.() -> Unit)? = null,
) {
    Label(
        name = name,
        description = description,
        modifier = modifier,
    ) {
        RadiantTextField(
            value = value,
            onValueChange = onValueChange,
            isError = valueIsError,
            enabled = locked != true,
            modifier = Modifier.padding(vertical = 4.dp),
            trailing = {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    if (locked != true) {
                        ResetToDefaultButton(
                            enabled = !valueIsDefault,
                            onClick = onValueReset,
                        )
                    }
                    if (locked != null) {
                        RadiantIconButton(
                            icon = painterResource(
                                if (locked) R.drawable.ic_lock else R.drawable.ic_lock_open,
                            ),
                            contentDescription = stringResource(
                                if (locked) R.string.patchopts_field_unlock else R.string.patchopts_field_lock,
                            ),
                            tint = if (locked) MaterialTheme.colorScheme.primary
                            else MaterialTheme.colorScheme.onSurfaceVariant,
                            subtle = true,
                            size = 34.dp,
                            onClick = onLockClick,
                        )
                    }
                }
            },
        )

        extra?.invoke(this)
    }
}
