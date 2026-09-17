package com.meowarex.rlmobile.pebble

import io.rebble.pebblekit2.common.model.PebbleDictionary
import io.rebble.pebblekit2.common.model.PebbleDictionaryItem
import org.json.JSONArray
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import java.util.UUID
import kotlin.math.roundToLong

// Mirrors rl-pebble main.c and emu_driver.py
object WatchProtocol {
    val APP_UUID: UUID = UUID.fromString("79d7fe6a-b970-483a-b096-16da10af0433")

    // package.json messageKeys order
    const val KEY_CMD = 10000
    const val KEY_TRACK_ID = 10001
    const val KEY_TITLE = 10002
    const val KEY_ARTIST = 10003
    const val KEY_DURATION = 10004
    const val KEY_STATUS = 10005
    const val KEY_LINE_COUNT = 10006
    const val KEY_CHUNK_INDEX = 10007
    const val KEY_CHUNK = 10008
    const val KEY_PLAYING = 10009
    const val KEY_POSITION = 10010
    const val KEY_INBOX_SIZE = 10011
    const val KEY_PHONE_TIME = 10012
    const val KEY_WATCH_TIME = 10013
    const val KEY_PHONE_TIME_2 = 10014
    const val KEY_SET_AUTO_OPEN = 10021

    const val CMD_TRACK = 1
    const val CMD_LINES = 2
    const val CMD_STATE = 3
    const val CMD_STATUS = 4
    const val CMD_SYNC = 5
    const val CMD_HELLO = 20
    const val CMD_PLAY_PAUSE = 21
    const val CMD_NEXT = 22
    const val CMD_PREV = 23
    const val CMD_SYNC_REQ = 24
    const val CMD_SETTINGS = 25

    const val STATUS_IDLE = 0
    const val STATUS_LOADING = 1
    const val STATUS_READY = 2
    const val STATUS_NO_LYRICS = 3
    const val STATUS_ERROR = 4

    private const val SEG_BG = 1 shl 0
    private const val SEG_SPACE = 1 shl 1
    private const val LINE_RIGHT = 1 shl 0

    private val WHITESPACE = Regex("\\s+")
    private const val HOLD_FOREVER = Int.MAX_VALUE.toLong()
    private const val LINE_ONLY_MS = 800L
    private const val MAX_SEGMENTS = 120

    class Segment(val time: Long, val duration: Long, val flags: Int, val text: String)

    // end is when the line stops being lit
    class Line(val start: Long, val end: Long, val segments: List<Segment>, val right: Boolean)

    // Syllable level lines, lit until the next lead line.
    fun shape(body: String): List<Line> {
        val root = JSONObject(body)
        val data = root.optJSONArray("data") ?: return emptyList()
        val sides = singerSides(root, data)

        class Raw(val start: Long, val end: Long, val allBackground: Boolean, val segments: List<Segment>, val right: Boolean)

        val raws = ArrayList<Raw>(data.length())
        for (i in 0 until data.length()) {
            val item = data.optJSONObject(i) ?: continue
            val syllabus = item.optJSONArray("syllabus")?.takeIf { it.length() > 0 }

            val segments = ArrayList<Segment>()
            val start: Long
            val end: Long
            var allBackground = false
            if (syllabus != null) {
                val first = syllabus.optJSONObject(0)
                val last = syllabus.optJSONObject(syllabus.length() - 1)
                start = first?.optLong("time") ?: 0
                end = (last?.optLong("time") ?: 0) + (last?.optLong("duration") ?: 0)
                allBackground = (0 until syllabus.length()).all {
                    syllabus.optJSONObject(it)?.optBoolean("isBackground") == true
                }
                for (j in 0 until syllabus.length()) {
                    val syllable = syllabus.optJSONObject(j) ?: continue
                    val raw = text(syllable)
                    val trimmed = raw.trim()
                    if (trimmed.isEmpty()) continue
                    var flags = if (syllable.optBoolean("isBackground")) SEG_BG else 0
                    if (raw != raw.trimEnd()) flags = flags or SEG_SPACE
                    segments += Segment(syllable.optLong("time"), syllable.optLong("duration"), flags, trimmed)
                }
            } else {
                // Line timed only, one segment per word
                start = (item.optDouble("startTime", 0.0) * 1000).roundToLong()
                end = start + LINE_ONLY_MS
                val words = text(item).split(WHITESPACE).filter { it.isNotEmpty() }
                words.forEachIndexed { index, word ->
                    segments += Segment(start, 0, if (index < words.lastIndex) SEG_SPACE else 0, word)
                }
            }
            if (segments.isEmpty()) continue
            raws += Raw(start, end, allBackground, segments.take(MAX_SEGMENTS), sides?.get(i) == 1)
        }

        return raws.mapIndexed { index, raw ->
            val nextLead = (index + 1 until raws.size).firstOrNull { !raws[it].allBackground }?.let { raws[it].start }
            Line(raw.start, (nextLead ?: HOLD_FOREVER).coerceAtLeast(raw.end), raw.segments, raw.right)
        }
    }

    // RL Mobile duet sides, null for one side.
    private fun singerSides(root: JSONObject, data: JSONArray): IntArray? {
        val agents = root.optJSONObject("metadata")?.optJSONObject("agents")
        fun singerOf(i: Int) = data.optJSONObject(i)?.optJSONObject("element")?.optString("singer")?.takeIf { it.isNotEmpty() }
        fun typeOf(singer: String): String = agents?.optJSONObject(singer)?.optString("type", "person")
            ?: when (singer) {
                "v1000" -> "group"
                "v2000" -> "other"
                else -> "person"
            }

        // Groups left, second person right
        val sideOf = HashMap<String, Int>()
        var persons = 0
        for (i in 0 until data.length()) {
            val singer = singerOf(i) ?: continue
            if (singer in sideOf) continue
            sideOf[singer] = if (typeOf(singer) != "person") 0 else if (++persons == 2) 1 else 0
        }

        val sides = IntArray(data.length()) { i -> singerOf(i)?.let { sideOf[it] ?: 0 } ?: -1 }
        val sided = sides.count { it >= 0 }
        val right = sides.count { it == 1 }
        // Nearly all right, swap
        if (sided > 0 && right * 100 / sided >= 85) {
            for (i in sides.indices) if (sides[i] >= 0) sides[i] = 1 - sides[i]
        }
        return if (sides.any { it == 0 } && sides.any { it == 1 }) sides else null
    }

    private fun text(obj: JSONObject): String =
        obj.optString("romanized").takeIf { it.isNotBlank() } ?: obj.optString("text")

    private fun encodeLine(line: Line): ByteArray {
        val out = ByteArrayOutputStream()
        out.u32(line.start)
        out.u32(line.end)
        out.write(line.segments.size)
        out.write(if (line.right) LINE_RIGHT else 0)
        for (segment in line.segments) {
            val text = utf8Truncate(segment.text, 255)
            out.u16((segment.time - line.start).coerceIn(0, 65535))
            out.u16(segment.duration.coerceIn(0, 65535))
            out.write(segment.flags)
            out.write(text.size)
            out.write(text)
        }
        return out.toByteArray()
    }

    // Whole lines per chunk, keyed by first index.
    fun chunks(lines: List<Line>, budget: Int): List<Pair<Int, ByteArray>> {
        val result = ArrayList<Pair<Int, ByteArray>>()
        val buf = ByteArrayOutputStream()
        var first = 0
        lines.forEachIndexed { index, line ->
            val encoded = encodeLine(line)
            if (buf.size() > 0 && buf.size() + encoded.size > budget) {
                result += first to buf.toByteArray()
                buf.reset()
                first = index
            }
            buf.write(encoded)
        }
        if (buf.size() > 0) result += first to buf.toByteArray()
        return result
    }

    fun track(trackId: Long, title: String, artist: String, durationMs: Long, status: Int, lineCount: Int): PebbleDictionary =
        mapOf(
            key(KEY_CMD) to PebbleDictionaryItem.UInt8(CMD_TRACK),
            key(KEY_TRACK_ID) to PebbleDictionaryItem.UInt32(trackId),
            key(KEY_TITLE) to PebbleDictionaryItem.Text(String(utf8Truncate(title, 60))),
            key(KEY_ARTIST) to PebbleDictionaryItem.Text(String(utf8Truncate(artist, 60))),
            key(KEY_DURATION) to PebbleDictionaryItem.UInt32(durationMs.coerceIn(0, 0xFFFFFFFFL)),
            key(KEY_STATUS) to PebbleDictionaryItem.UInt8(status),
            key(KEY_LINE_COUNT) to PebbleDictionaryItem.UInt16(lineCount),
        )

    fun lines(trackId: Long, firstIndex: Int, blob: ByteArray): PebbleDictionary = mapOf(
        key(KEY_CMD) to PebbleDictionaryItem.UInt8(CMD_LINES),
        key(KEY_TRACK_ID) to PebbleDictionaryItem.UInt32(trackId),
        key(KEY_CHUNK_INDEX) to PebbleDictionaryItem.UInt16(firstIndex),
        key(KEY_CHUNK) to PebbleDictionaryItem.Bytes(blob),
    )

    // Position at a phone elapsedRealtime.
    fun state(trackId: Long, playing: Boolean, positionMs: Long, phoneTimeMs: Long): PebbleDictionary = mapOf(
        key(KEY_CMD) to PebbleDictionaryItem.UInt8(CMD_STATE),
        key(KEY_TRACK_ID) to PebbleDictionaryItem.UInt32(trackId),
        key(KEY_PLAYING) to PebbleDictionaryItem.UInt8(if (playing) 1 else 0),
        key(KEY_POSITION) to PebbleDictionaryItem.Int32(positionMs.coerceIn(0, Int.MAX_VALUE.toLong()).toInt()),
        key(KEY_PHONE_TIME) to PebbleDictionaryItem.UInt32(phoneTimeMs and 0xFFFFFFFFL),
    )

    fun sync(watchTime: Long, receivedAt: Long, sentAt: Long): PebbleDictionary = mapOf(
        key(KEY_CMD) to PebbleDictionaryItem.UInt8(CMD_SYNC),
        key(KEY_WATCH_TIME) to PebbleDictionaryItem.UInt32(watchTime and 0xFFFFFFFFL),
        key(KEY_PHONE_TIME) to PebbleDictionaryItem.UInt32(receivedAt and 0xFFFFFFFFL),
        key(KEY_PHONE_TIME_2) to PebbleDictionaryItem.UInt32(sentAt and 0xFFFFFFFFL),
    )

    fun status(trackId: Long, status: Int): PebbleDictionary = mapOf(
        key(KEY_CMD) to PebbleDictionaryItem.UInt8(CMD_STATUS),
        key(KEY_TRACK_ID) to PebbleDictionaryItem.UInt32(trackId),
        key(KEY_STATUS) to PebbleDictionaryItem.UInt8(status),
    )

    // Integer tuples from the watch.
    fun ints(data: PebbleDictionary): Map<Int, Long> = buildMap {
        for ((k, item) in data) {
            val value = when (item) {
                is PebbleDictionaryItem.UInt32 -> item.value.toLong()
                is PebbleDictionaryItem.Int32 -> item.value.toLong()
                is PebbleDictionaryItem.UInt16 -> item.value.toLong()
                is PebbleDictionaryItem.Int16 -> item.value.toLong()
                is PebbleDictionaryItem.UInt8 -> item.value.toLong()
                is PebbleDictionaryItem.Int8 -> item.value.toLong()
                else -> continue
            }
            put(k.toInt(), value)
        }
    }

    private fun key(key: Int) = key.toUInt()

    private fun utf8Truncate(text: String, limit: Int): ByteArray {
        val raw = text.toByteArray(Charsets.UTF_8)
        if (raw.size <= limit) return raw
        var end = limit
        // Don't split a code point
        while (end > 0 && (raw[end].toInt() and 0xC0) == 0x80) end--
        return raw.copyOf(end)
    }

    private fun ByteArrayOutputStream.u16(value: Long) {
        write((value and 0xFF).toInt())
        write(((value shr 8) and 0xFF).toInt())
    }

    private fun ByteArrayOutputStream.u32(value: Long) {
        val v = value.coerceIn(0, 0xFFFFFFFFL)
        write((v and 0xFF).toInt())
        write(((v shr 8) and 0xFF).toInt())
        write(((v shr 16) and 0xFF).toInt())
        write(((v shr 24) and 0xFF).toInt())
    }
}
