package radiant;

// Quality Matched Seekbar, mini-player progress in badge colours
public final class QualitySeek {
    // Same as the quality badge text colours
    private static final int LOW_HIGH = 0xFFE2E8F0;
    private static final int LOSSLESS = 0xFFA5F3FC;
    private static final int HI_RES = 0xFFFDE68A;

    // Play queue, knows the current stream quality
    private static volatile Object queue;

    private QualitySeek() {}

    public static void setQueue(Object playQueue) {
        queue = playQueue;
    }

    // Seekbar colour, white until we know the queue
    public static int argb() {
        Object q = queue;
        if (!(q instanceof zh.e)) return 0xFFFFFFFF;    // MARKER: R8 zh.e
        try {
            zh.e e = (zh.e) q;
            if (e.isCurrentStreamHiResLosslessQuality()) return HI_RES;
            if (e.isCurrentStreamLossless()) return LOSSLESS;
            return LOW_HIGH;
        } catch (Throwable t) {
            return 0xFFFFFFFF;
        }
    }
}
