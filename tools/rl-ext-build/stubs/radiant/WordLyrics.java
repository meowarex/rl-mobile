package radiant;
import androidx.compose.runtime.MutableState;
import androidx.compose.ui.graphics.Brush;
import androidx.compose.ui.text.AnnotatedString;
import androidx.compose.ui.text.ParagraphStyle;
import androidx.compose.ui.text.SpanStyle;
// Handwritten smali (patches/extension/radiant/WordLyrics.smali)
public final class WordLyrics {
    public static boolean dualSide;
    public static long tmpSung, tmpUnsung;
    public static AnnotatedString render(int i, int a, String t, long s, long u) { return null; }
    public static AnnotatedString renderSyl(int i, int a, String t, long s, long u) { return null; }
    public static boolean isActiveLine(int i) { return false; }
    public static boolean isPastLine(int i) { return false; }
    static long computeNow() { return 0L; }
    static SpanStyle makeSpan(long c) { return null; }
    static SpanStyle emSpan(float f) { return null; }
    static SpanStyle brushSpan(Brush b) { return null; }
    static ParagraphStyle paraStyle(int side, boolean small) { return null; }
    static Brush sylWipe(int line, int beg, int end, float p, int total) { return null; }
    static float bump(long s, long e, long now) { return 0f; }
    static boolean ctxSingers() { return false; }
    static int sideOf(int i) { return -1; }
    public static MutableState state() { return null; }
    public static MutableState lineState() { return null; }
    public static void ingest(String body) {}
    public static void clear() {}
}
