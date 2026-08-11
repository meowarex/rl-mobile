package com.meowarex.rlmobile.ui.legacy.screens.patchopts.components.options

import com.meowarex.rlmobile.ui.screens.patchopts.components.options.*

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.legacy.components.Label
import com.meowarex.rlmobile.ui.legacy.components.ResetToDefaultButton

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
        OutlinedTextField(
            value = value,
            onValueChange = onValueChange,
            isError = valueIsError,
            singleLine = true,
            enabled = locked != true,
            colors = OutlinedTextFieldDefaults.colors(
                unfocusedContainerColor = MaterialTheme.colorScheme.surfaceContainerLow,
                focusedContainerColor = MaterialTheme.colorScheme.surfaceContainerLow,
                errorContainerColor = MaterialTheme.colorScheme.surfaceContainerLow,
                disabledContainerColor = MaterialTheme.colorScheme.surfaceContainerLow,
            ),
            trailingIcon = {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    if (locked != true) {
                        ResetToDefaultButton(
                            enabled = !valueIsDefault,
                            onClick = onValueReset,
                        )
                    }
                    if (locked != null) {
                        IconButton(
                            onClick = onLockClick,
                            modifier = Modifier.size(32.dp),
                        ) {
                            Icon(
                                painter = painterResource(
                                    if (locked) R.drawable.ic_lock else R.drawable.ic_lock_open,
                                ),
                                contentDescription = stringResource(
                                    if (locked) R.string.patchopts_field_unlock else R.string.patchopts_field_lock,
                                ),
                                tint = if (locked) MaterialTheme.colorScheme.primary
                                else MaterialTheme.colorScheme.onSurfaceVariant,
                                modifier = Modifier.size(18.dp),
                            )
                        }
                        Spacer(Modifier.width(8.dp))
                    }
                }
            },
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 4.dp),
        )

        extra?.invoke(this)
    }
}
