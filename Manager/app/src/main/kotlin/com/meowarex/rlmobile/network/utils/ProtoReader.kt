package com.meowarex.rlmobile.network.utils

// Tiny protobuf reader, no schema needed
class ProtoField(
    val number: Int,
    val wireType: Int,
    val varint: Long,
    private val buf: ByteArray,
    private val start: Int,
    private val end: Int,
) {
    val isBytes get() = wireType == WIRE_LEN

    fun bytes(): ByteArray = buf.copyOfRange(start, end)

    fun string(): String = String(buf, start, end - start, Charsets.UTF_8)

    // Null if it isn't a valid message
    fun message(): List<ProtoField>? = if (isBytes) ProtoReader.parseOrNull(buf, start, end) else null

    companion object {
        const val WIRE_VARINT = 0
        const val WIRE_I64 = 1
        const val WIRE_LEN = 2
        const val WIRE_I32 = 5
    }
}

object ProtoReader {
    fun parse(buf: ByteArray, start: Int = 0, end: Int = buf.size): List<ProtoField> {
        val fields = ArrayList<ProtoField>()
        var pos = start

        fun readVarint(): Long {
            var result = 0L
            var shift = 0
            while (true) {
                if (pos >= end || shift > 63) throw IllegalArgumentException("Bad varint")
                val b = buf[pos++].toInt() and 0xFF
                result = result or ((b and 0x7F).toLong() shl shift)
                if (b < 0x80) return result
                shift += 7
            }
        }

        while (pos < end) {
            val key = readVarint()
            val number = (key ushr 3).toInt()
            val wireType = (key and 7).toInt()
            if (number <= 0) throw IllegalArgumentException("Bad field number")

            when (wireType) {
                ProtoField.WIRE_VARINT -> fields += ProtoField(number, wireType, readVarint(), buf, pos, pos)
                ProtoField.WIRE_I64 -> {
                    if (pos + 8 > end) throw IllegalArgumentException("Truncated i64")
                    fields += ProtoField(number, wireType, 0, buf, pos, pos + 8)
                    pos += 8
                }

                ProtoField.WIRE_LEN -> {
                    val len = readVarint()
                    if (len < 0 || pos + len > end) throw IllegalArgumentException("Truncated field")
                    fields += ProtoField(number, wireType, 0, buf, pos, pos + len.toInt())
                    pos += len.toInt()
                }

                ProtoField.WIRE_I32 -> {
                    if (pos + 4 > end) throw IllegalArgumentException("Truncated i32")
                    fields += ProtoField(number, wireType, 0, buf, pos, pos + 4)
                    pos += 4
                }

                else -> throw IllegalArgumentException("Unsupported wire type $wireType")
            }
        }
        return fields
    }

    fun parseOrNull(buf: ByteArray, start: Int, end: Int): List<ProtoField>? = try {
        parse(buf, start, end).takeIf { it.isNotEmpty() }
    } catch (_: IllegalArgumentException) {
        null
    }
}

fun List<ProtoField>.first(number: Int): ProtoField? = firstOrNull { it.number == number }
