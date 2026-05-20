package com.meowarex.rlmobile.ui.screens.home.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.paging.LoadState
import androidx.paging.compose.LazyPagingItems
import androidx.paging.compose.itemKey
import coil3.compose.AsyncImage
import com.meowarex.rlmobile.network.models.GithubCommit
import java.text.SimpleDateFormat
import java.time.Instant
import java.util.Date

@Composable
fun CommitList(commits: LazyPagingItems<GithubCommit>) {
    val loading = commits.loadState.refresh is LoadState.Loading || commits.loadState.append is LoadState.Loading
    val failed = commits.loadState.refresh is LoadState.Error || commits.loadState.append is LoadState.Error

    LazyColumn {
        items(
            count = commits.itemCount,
            key = commits.itemKey { it.sha },
        ) { index ->
            val commit = commits[index] ?: return@items
            CommitRow(commit)
            if (index < commits.itemCount - 1) {
                HorizontalDivider(
                    thickness = 0.5.dp,
                    color = MaterialTheme.colorScheme.outline.copy(alpha = 0.3f),
                    modifier = Modifier.padding(horizontal = 16.dp),
                )
            }
        }

        if (loading) item {
            Box(
                contentAlignment = Alignment.TopCenter,
                modifier = Modifier.fillMaxWidth().padding(16.dp),
            ) {
                CircularProgressIndicator(strokeWidth = 3.dp, modifier = Modifier.size(30.dp))
            }
        }

        if (failed) item {
            Column(
                verticalArrangement = Arrangement.spacedBy(12.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.fillMaxWidth().padding(16.dp),
            ) {
                Text("Failed to load commits", style = MaterialTheme.typography.labelLarge, textAlign = TextAlign.Center)
                Button(onClick = { commits.retry() }) { Text("Retry") }
            }
        }
    }
}

@Composable
private fun CommitRow(commit: GithubCommit) {
    val uriHandler = LocalUriHandler.current
    Column(
        verticalArrangement = Arrangement.spacedBy(10.dp),
        modifier = Modifier
            .fillMaxWidth()
            .clickable { uriHandler.openUri(commit.htmlUrl) }
            .padding(16.dp),
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            AsyncImage(
                model = commit.author?.avatarUrl ?: "https://github.com/ghost.png",
                contentDescription = commit.author?.login ?: "ghost",
                modifier = Modifier.size(20.dp).clip(CircleShape),
            )
            Text(
                text = commit.author?.login ?: commit.commit.author.name,
                style = MaterialTheme.typography.labelMedium,
            )
            Text("•", style = MaterialTheme.typography.labelLarge)
            Text(
                text = commit.sha.take(7),
                style = MaterialTheme.typography.labelMedium,
                color = MaterialTheme.colorScheme.primary,
                fontFamily = FontFamily.Monospace,
            )

            Text(
                text = runCatching {
                    SimpleDateFormat.getDateInstance(SimpleDateFormat.SHORT)
                        .format(Date.from(Instant.parse(commit.commit.author.date)))
                }.getOrDefault(""),
                style = MaterialTheme.typography.labelMedium,
                color = LocalContentColor.current.copy(alpha = 0.5f),
                textAlign = TextAlign.End,
                modifier = Modifier.weight(1f),
            )
        }
        Text(
            text = commit.commit.message.lineSequence().first(),
            style = MaterialTheme.typography.labelLarge,
        )
    }
}
