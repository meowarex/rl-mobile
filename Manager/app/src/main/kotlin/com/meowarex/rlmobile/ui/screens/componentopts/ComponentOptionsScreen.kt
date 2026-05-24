package com.meowarex.rlmobile.ui.screens.componentopts

import android.net.Uri
import android.os.Parcelable
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.koin.koinScreenModel
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import com.meowarex.rlmobile.R
import com.meowarex.rlmobile.ui.screens.componentopts.components.*
import com.meowarex.rlmobile.ui.util.ScreenWithResult
import com.meowarex.rlmobile.ui.util.paddings.*
import com.meowarex.rlmobile.util.back
import kotlinx.collections.immutable.ImmutableList
import kotlinx.collections.immutable.toImmutableList
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize
import org.koin.core.parameter.parametersOf

@Parcelize
class ComponentOptionsScreen(
    /**
     * The type of custom component that this screen will be selecting.
     */
    private val componentType: PatchComponent.Type,
    /**
     * A previously selected custom component that should be pre-selected on this screen.
     */
    private val default: PatchComponent?,
) : ScreenWithResult<PatchComponent?>(), Parcelable {
    @IgnoredOnParcel
    override val key = "ComponentOptions-$componentType"

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        val model = koinScreenModel<ComponentOptionsModel> { parametersOf(this.resultKey) }

        LaunchedEffect(Unit) {
            model.components.clear()
            withContext(Dispatchers.IO) {
                model.refreshComponents(componentType)
            }
            if (default in model.components) {
                model.selectComponent(default)
            }
        }

        ComponentOptionsScreenContent(
            componentType = componentType,
            components = model.components.toImmutableList(),
            selected = model.selected,
            onSelectComponent = model::selectComponent,
            onDeleteComponent = model::deleteComponent,
            onImportFromUri = { uri -> model.importFromUri(uri, componentType) },
            releasesExpanded = model.releasesExpanded,
            releasesState = model.releasesState,
            onToggleReleases = { model.toggleReleasesExpanded(componentType) },
            onImportRelease = { release -> model.importFromRelease(release, componentType) },
            importingReleaseTag = model.importingReleaseTag,
            onBackPressed = { navigator.back(null) },
        )
    }
}

@Composable
fun ComponentOptionsScreenContent(
    componentType: PatchComponent.Type,
    components: ImmutableList<PatchComponent>,
    selected: PatchComponent?,
    onSelectComponent: (PatchComponent?) -> Unit,
    onDeleteComponent: (PatchComponent) -> Unit,
    onImportFromUri: (Uri) -> Unit,
    releasesExpanded: Boolean,
    releasesState: ComponentOptionsModel.ReleasesState,
    onToggleReleases: () -> Unit,
    onImportRelease: (com.meowarex.rlmobile.network.models.GithubRelease) -> Unit,
    importingReleaseTag: String?,
    onBackPressed: () -> Unit,
) {
    val mime = when (componentType) {
        PatchComponent.Type.TidalApk -> "application/vnd.android.package-archive"
        PatchComponent.Type.Patches -> "application/zip"
    }
    val filePicker = rememberLauncherForActivityResult(
        ActivityResultContracts.OpenDocument(),
    ) { uri -> uri?.let(onImportFromUri) }

    Scaffold(
        topBar = { ComponentOptionsAppBar(componentType = componentType) },
    ) { paddingValues ->
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = paddingValues
                .exclude(PaddingValuesSides.Horizontal + PaddingValuesSides.Top)
                .add(PaddingValues(16.dp)),
            modifier = Modifier
                .padding(paddingValues.exclude(PaddingValuesSides.Bottom)),
        ) {
            item(key = "NONE") {
                PatchComponentCardBase(
                    selected = selected == null,
                    onSelect = { onSelectComponent(null) },
                ) {
                    Text(
                        text = stringResource(R.string.componentopts_selected_none),
                        style = MaterialTheme.typography.titleMedium,
                    )
                }
            }

            item(key = "RELEASES_ACCORDION") {
                ReleasesAccordion(
                    expanded = releasesExpanded,
                    state = releasesState,
                    importingTag = importingReleaseTag,
                    onToggle = onToggleReleases,
                    onImport = onImportRelease,
                )
            }

            items(
                items = components,
                contentType = { "COMPONENT" },
                key = { it },
            ) { component ->
                PatchComponentCard(
                    version = component.version,
                    timestamp = component.timestamp,
                    selected = selected == component,
                    onSelect = { onSelectComponent(component) },
                    onDelete = { onDeleteComponent(component) },
                )
            }

            item(key = "BROWSE") {
                BrowseImportCard(onClick = { filePicker.launch(arrayOf(mime)) })
            }

            item("EXIT_BTN") {
                Row(
                    horizontalArrangement = Arrangement.End,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 10.dp),
                ) {
                    FilledTonalButton(
                        onClick = onBackPressed,
                    ) {
                        Text(stringResource(R.string.action_confirm))
                    }
                }
            }
        }
    }
}

@Composable
private fun ReleasesAccordion(
    expanded: Boolean,
    state: ComponentOptionsModel.ReleasesState,
    importingTag: String?,
    onToggle: () -> Unit,
    onImport: (com.meowarex.rlmobile.network.models.GithubRelease) -> Unit,
) {
    Surface(
        color = MaterialTheme.colorScheme.surfaceContainerHigh,
        shape = RoundedCornerShape(16.dp),
        modifier = Modifier.fillMaxWidth(),
    ) {
        Column {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(14.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable(onClick = onToggle)
                    .padding(horizontal = 16.dp, vertical = 14.dp),
            ) {
                Icon(
                    painter = painterResource(R.drawable.ic_account_github_white_24dp),
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.primary,
                )
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = stringResource(R.string.componentopts_releases_title),
                        style = MaterialTheme.typography.titleMedium,
                    )
                    Text(
                        text = stringResource(R.string.componentopts_releases_desc),
                        style = MaterialTheme.typography.bodyMedium,
                        color = LocalContentColor.current.copy(alpha = 0.65f),
                    )
                }
                Icon(
                    painter = painterResource(
                        if (expanded) R.drawable.ic_arrow_up_small else R.drawable.ic_arrow_down_small
                    ),
                    contentDescription = null,
                    tint = LocalContentColor.current.copy(alpha = 0.7f),
                )
            }

            if (expanded) {
                HorizontalDivider(
                    color = MaterialTheme.colorScheme.outlineVariant.copy(alpha = 0.35f),
                )
                ReleasesContent(
                    state = state,
                    importingTag = importingTag,
                    onImport = onImport,
                )
            }
        }
    }
}

@Composable
private fun ReleasesContent(
    state: ComponentOptionsModel.ReleasesState,
    importingTag: String?,
    onImport: (com.meowarex.rlmobile.network.models.GithubRelease) -> Unit,
) {
    when (state) {
        is ComponentOptionsModel.ReleasesState.Idle,
        ComponentOptionsModel.ReleasesState.Loading -> Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier
                .fillMaxWidth()
                .padding(20.dp),
        ) { CircularProgressIndicator(modifier = Modifier.size(24.dp)) }

        ComponentOptionsModel.ReleasesState.Failed -> Text(
            text = stringResource(R.string.network_load_fail),
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.error,
            modifier = Modifier
                .fillMaxWidth()
                .padding(20.dp),
        )

        is ComponentOptionsModel.ReleasesState.Loaded -> {
            if (state.releases.isEmpty()) {
                Text(
                    text = stringResource(R.string.componentopts_releases_empty),
                    style = MaterialTheme.typography.bodyMedium,
                    color = LocalContentColor.current.copy(alpha = 0.65f),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(20.dp),
                )
            } else {
                Column {
                    state.releases.forEachIndexed { index, release ->
                        ReleaseRow(
                            release = release,
                            importing = importingTag == release.tagName,
                            anyImporting = importingTag != null,
                            onImport = { onImport(release) },
                        )
                        if (index != state.releases.lastIndex) {
                            HorizontalDivider(
                                color = MaterialTheme.colorScheme.outlineVariant.copy(alpha = 0.2f),
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun ReleaseRow(
    release: com.meowarex.rlmobile.network.models.GithubRelease,
    importing: Boolean,
    anyImporting: Boolean,
    onImport: () -> Unit,
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 12.dp),
    ) {
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = release.tagName,
                style = MaterialTheme.typography.titleSmall,
            )
            Text(
                text = release.name ?: release.tagName,
                style = MaterialTheme.typography.bodySmall,
                color = LocalContentColor.current.copy(alpha = 0.55f),
            )
        }
        FilledTonalButton(
            onClick = onImport,
            enabled = !anyImporting,
        ) {
            if (importing) {
                CircularProgressIndicator(
                    strokeWidth = 2.dp,
                    modifier = Modifier.size(16.dp),
                )
            } else {
                Text(stringResource(R.string.action_install))
            }
        }
    }
}

@Composable
private fun BrowseImportCard(onClick: () -> Unit) {
    Surface(
        color = MaterialTheme.colorScheme.surfaceContainerHigh,
        shape = RoundedCornerShape(16.dp),
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(14.dp),
            modifier = Modifier.padding(horizontal = 16.dp, vertical = 14.dp),
        ) {
            Icon(
                painter = painterResource(R.drawable.ic_add),
                contentDescription = null,
                tint = MaterialTheme.colorScheme.primary,
            )
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = stringResource(R.string.componentopts_browse_title),
                    style = MaterialTheme.typography.titleMedium,
                )
                Text(
                    text = stringResource(R.string.componentopts_browse_desc),
                    style = MaterialTheme.typography.bodyMedium,
                    color = LocalContentColor.current.copy(alpha = 0.65f),
                )
            }
        }
    }
}
