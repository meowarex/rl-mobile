package com.meowarex.rlmobile.patcher.util

import com.reandroid.apk.APKLogger
import com.reandroid.apk.ApkBundle
import com.reandroid.apk.ApkModule
import com.reandroid.apk.ApkUtil
import com.reandroid.app.AndroidManifest
import com.reandroid.arsc.chunk.xml.AndroidManifestBlock
import com.reandroid.arsc.chunk.xml.ResXmlElement
import com.reandroid.arsc.value.ValueType
import java.io.File

// Merges split APKs into one (APKEditor port) <3
object SplitApkMerger {
    fun merge(splitsDir: File, out: File, log: (String) -> Unit) {
        val logger = object : APKLogger {
            override fun logMessage(msg: String) = log(msg)
            override fun logError(msg: String, tr: Throwable?) = log("$msg ${tr?.stackTraceToString().orEmpty()}")
            override fun logVerbose(msg: String) {}
        }

        out.delete()
        ApkBundle().use { bundle ->
            bundle.setAPKLogger(logger)
            bundle.loadApkDirectory(splitsDir, false)
            log("Merging modules: ${bundle.listModuleNames()}")

            bundle.mergeModules(false).use { merged ->
                sanitizeManifest(merged, log)
                merged.refreshTable()
                merged.refreshManifest()
                merged.writeApk(out)
            }
        }
    }

    // Drop split only attrs + Play metadata
    private fun sanitizeManifest(module: ApkModule, log: (String) -> Unit) {
        if (!module.hasAndroidManifest()) return
        val manifest = module.androidManifest
        val root = manifest.manifestElement ?: return

        root.removeAttributesWithId(AndroidManifest.ID_requiredSplitTypes)
        root.removeAttributesWithId(AndroidManifest.ID_splitTypes)
        root.removeAttributesWithName(AndroidManifest.NAME_splitTypes)
        root.removeAttributesWithName(AndroidManifest.NAME_requiredSplitTypes)
        root.removeAttributesWithId(AndroidManifest.ID_isSplitRequired)

        val application = manifest.applicationElement
        if (application != null) {
            application.removeAttributesWithId(AndroidManifest.ID_isSplitRequired)

            var splitsTableRemoved = false
            for (meta in splitMetaElements(application)) {
                if (!splitsTableRemoved) splitsTableRemoved = removeSplitsTableEntry(meta, module, log)
                log("Removed <meta-data> ${AndroidManifestBlock.getAndroidNameValue(meta)}")
                application.remove(meta)
            }
        }
        manifest.refresh()
    }

    private fun splitMetaElements(application: ResXmlElement): List<ResXmlElement> {
        val result = ArrayList<ResXmlElement>()
        val iterator = application.getElements(AndroidManifest.TAG_meta_data)
        while (iterator.hasNext()) {
            val element = iterator.next() as ResXmlElement
            val name = element.searchAttributeByResourceId(AndroidManifest.ID_name)
                ?.takeIf { it.valueType == ValueType.STRING }
                ?.valueAsString
                ?: continue

            val fusedBase = name == "com.android.dynamic.apk.fused.modules" &&
                element.searchAttributeByResourceId(AndroidManifest.ID_value)?.valueAsString == ApkUtil.DEF_MODULE_NAME

            if (fusedBase || name.startsWith("com.android.vending.") || name.startsWith("com.android.stamp."))
                result += element
        }
        return result
    }

    private fun removeSplitsTableEntry(meta: ResXmlElement, module: ApkModule, log: (String) -> Unit): Boolean {
        val name = meta.searchAttributeByResourceId(AndroidManifest.ID_name)?.valueAsString
        if (name != "com.android.vending.splits") return false

        val value = meta.searchAttributeByResourceId(AndroidManifest.ID_value)
            ?: meta.searchAttributeByResourceId(AndroidManifest.ID_resource)
        if (value == null || value.valueType != ValueType.REFERENCE || !module.hasTableBlock()) return false

        val resource = module.tableBlock.getResource(value.data) ?: return false
        val zipEntries = module.zipEntryMap
        for (entry in resource) {
            val path = entry?.resValue?.valueAsString ?: continue
            log("Removed splits table entry $path")
            zipEntries.remove(path)
            // Dex may use the id, null it instead
            entry.setNull(true)
            entry.typeBlock.parentSpecTypePair.removeNullEntries(entry.id)
        }
        return true
    }
}
