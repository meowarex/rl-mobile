package com.meowarex.rlmobile.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.meowarex.rlmobile.R

@Composable
fun ProjectHeader(modifier: Modifier = Modifier) {
    val uriHandler = LocalUriHandler.current

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(6.dp),
        modifier = modifier,
    ) {
        Text(
            text = stringResource(R.string.rlmobile),
            style = MaterialTheme.typography.titleMedium.copy(fontSize = 26.sp)
        )

        Text(
            text = stringResource(R.string.app_description),
            style = MaterialTheme.typography.titleSmall.copy(
                color = MaterialTheme.colorScheme.onSurface.copy(alpha = .6f)
            ),
            textAlign = TextAlign.Center,
        )

        Row(
            horizontalArrangement = Arrangement.Center,
        ) {
            TextButton(onClick = { uriHandler.openUri("https://github.com/meowarex/rl-mobile") }) {
                Icon(
                    painter = painterResource(R.drawable.ic_account_github_white_24dp),
                    contentDescription = null,
                    modifier = Modifier.padding(end = ButtonDefaults.IconSpacing),
                )
                Text(text = stringResource(R.string.github))
            }
        }
    }
}
