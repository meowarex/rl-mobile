package radiant;

import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.RectF;
import android.graphics.Shader;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.util.Log;
import android.view.Choreographer;

import androidx.compose.runtime.Composer;
import androidx.compose.runtime.MutableState;
import androidx.compose.runtime.SnapshotStateKt;
import androidx.compose.ui.geometry.Size;
import androidx.compose.ui.graphics.AndroidCanvas_androidKt;
import androidx.compose.ui.graphics.ColorFilter;
import androidx.compose.ui.graphics.drawscope.DrawScope;
import androidx.compose.ui.graphics.painter.Painter;
import androidx.compose.ui.res.PainterResources_androidKt;

import com.tidal.android.feature.playerscreen.ui.g;

// Sparkle button loading spinner and no lyrics icon
public final class SparkleIcons extends Painter implements Choreographer.FrameCallback, Runnable {
    static final int MODE_SPARKLE = 0;
    static final int MODE_LOADING = 1;
    static final int MODE_NONE = 2;
    // Sylla job running, rainbow spinner
    static final int MODE_SYLLA = 3;

    private static final long SPIN_MS = 900L;
    // AI rainbow, same colours as desktop
    private static final int[] PALETTE = {0xFFFF6B9D, 0xFFFFD166, 0xFF5EE7FF, 0xFFA78BFA};
    static final long CYCLE_MS = 6000L;
    static final float[] STOPS = {0f, 0.35f, 0.65f, 1f};
    // Same size as the lyrics icon
    private static final float NOTE_SCALE = 0.75f;
    // Desktop spinner, a bit smaller
    private static final float RING_R = 7.1f / 20f;
    private static final float RING_STROKE = 1.8f / 20f;
    private static final float ARC_SWEEP = 42f / (float) (2 * Math.PI * 8) * 360f;    // same gap as desktop

    // Mode for the sparkle button
    public static int currentMode = MODE_SPARKLE;
    // Lyrics to open, long press works either way
    public static boolean enabled = true;

    // RL API fetch running
    static final MutableState rlLoading = SnapshotStateKt.mutableStateOf$default(Boolean.FALSE, null, 2, null);
    static final MutableState tick = SnapshotStateKt.mutableStateOf$default(Long.valueOf(0L), null, 2, null);
    // Sylla job or flush running, set from RLLyrics
    static final MutableState syllaState = SnapshotStateKt.mutableStateOf$default(Boolean.FALSE, null, 2, null);
    static final MutableState busyState = SnapshotStateKt.mutableStateOf$default(Boolean.FALSE, null, 2, null);
    private static volatile boolean syllaPending;
    private static volatile boolean busyPending;
    private static final java.util.HashSet<Object> syllaJobs = new java.util.HashSet<Object>();
    private static final java.util.HashSet<Object> busyJobs = new java.util.HashSet<Object>();
    private static final SparkleIcons STATES = new SparkleIcons(-2, null, null);

    private static final SparkleIcons POSTER = new SparkleIcons(MODE_SPARKLE, null, null);
    private static final long LOADING_TIMEOUT_MS = 60000L;    // requests can take ~30s

    private static final Object lock = new Object();
    // Newest fetch and if it's running
    private static Object latestWorker;
    private static boolean latestRunning;
    // Bumped by timers to recompose
    static final MutableState timeoutTick = SnapshotStateKt.mutableStateOf$default(Integer.valueOf(0), null, 2, null);
    private static long loadingSinceMs;
    private static boolean timeoutPosted;
    private static volatile boolean newFetch;
    private static Object lastMedia;
    private static final long NONE_GRACE_MS = 5000L;
    private static final String TAG = "RLSparkle";
    private static long noneSinceMs;
    private static int lastBranch = -1;
    private static long postedAtMs = Long.MAX_VALUE;
    private static final SparkleIcons TIMEOUT = new SparkleIcons(-1, null, null);
    private static SparkleIcons spinner;
    private static SparkleIcons rainbowSpinner;
    private static SparkleIcons noLyrics;
    private static boolean frameScheduled;
    private static long lastSpinDrawMs;

    private final int mode;
    private final Painter inner;
    // Sparkle painter, for sizing
    private final Painter sizeRef;
    private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint clear = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final RectF oval = new RectF();
    private final int[] rainbow = new int[4];

    private SparkleIcons(int mode, Painter inner, Painter sizeRef) {
        this.mode = mode;
        this.inner = inner;
        this.sizeRef = sizeRef;
        paint.setColor(0xFFFFFFFF);
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeCap(Paint.Cap.ROUND);
        clear.setStyle(Paint.Style.STROKE);
        clear.setStrokeCap(Paint.Cap.ROUND);
        clear.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.CLEAR));
    }

    // Pick the button mode
    public static int modeFor(Object lyricsState, boolean hasLyrics, Object media) {    // MARKER: R8 g$b g$c g$d
        timeoutTick.getValue();    // recompose on timers
        long now = SystemClock.uptimeMillis();
        // New track, reset timers
        if (media == null ? lastMedia != null : !media.equals(lastMedia)) {
            lastMedia = media;
            loadingSinceMs = 0L;
            lastBranch = -1;
        }
        boolean rl = ((Boolean) rlLoading.getValue()).booleanValue();
        int m;
        int branch;
        if (hasLyrics || lyricsState instanceof g.c || lyricsState instanceof g.d) {
            // Lyrics win
            branch = 0;
            m = MODE_SPARKLE;
            loadingSinceMs = 0L;
        } else if (rl || lyricsState instanceof g.b) {
            branch = 1;
            if (loadingSinceMs == 0L) loadingSinceMs = now;
            if (now - loadingSinceMs >= LOADING_TIMEOUT_MS) {
                m = MODE_NONE;    // don't spin forever
            } else {
                m = MODE_LOADING;
                scheduleRecompose(loadingSinceMs + LOADING_TIMEOUT_MS);
            }
        } else {
            // Wait a bit before saying no lyrics
            branch = 2;
            if (lastBranch != 2) noneSinceMs = now;
            if (now - noneSinceMs < NONE_GRACE_MS) {
                m = MODE_LOADING;
                scheduleRecompose(noneSinceMs + NONE_GRACE_MS);
            } else {
                m = MODE_NONE;
            }
            loadingSinceMs = 0L;
        }
        lastBranch = branch;
        enabled = m == MODE_SPARKLE;
        // Work spinner on top, lyrics still open
        if (((Boolean) syllaState.getValue()).booleanValue()) m = MODE_SYLLA;
        else if (((Boolean) busyState.getValue()).booleanValue()) m = MODE_LOADING;
        if (m != currentMode) {
            Log.i(TAG, "mode " + currentMode + " -> " + m + " (lyricsState="
                    + (lyricsState == null ? "null" : lyricsState.getClass().getName())
                    + " hasLyrics=" + hasLyrics + " rlLoading=" + rl + ")");
        }
        currentMode = m;
        return m;
    }

    // Recompose later
    private static void scheduleRecompose(long atMs) {
        if (timeoutPosted && atMs >= postedAtMs) return;
        timeoutPosted = true;
        postedAtMs = atMs;
        long delay = Math.max(0L, atMs - SystemClock.uptimeMillis()) + 50L;
        new Handler(Looper.getMainLooper()).postDelayed(TIMEOUT, delay);
    }

    // Icon for the mode
    public static Painter forMode(Painter sparkle, int mode, Composer composer) {
        composer.startReplaceGroup(0x52415300 + mode);
        Painter out = sparkle;
        if (mode == MODE_LOADING && sparkle != null) {
            SparkleIcons s = spinner;
            if (s == null || s.inner != sparkle) spinner = s = new SparkleIcons(MODE_LOADING, sparkle, sparkle);
            out = s;
        } else if (mode == MODE_SYLLA && sparkle != null) {
            SparkleIcons s = rainbowSpinner;
            if (s == null || s.inner != sparkle) rainbowSpinner = s = new SparkleIcons(MODE_SYLLA, sparkle, sparkle);
            out = s;
        } else if (mode == MODE_NONE && sparkle != null) {
            Painter note = PainterResources_androidKt.painterResource(com.aspiro.wamp.R.drawable.ic_music_note, composer, 0);
            SparkleIcons s = noLyrics;
            if (s == null || s.inner != note || s.sizeRef != sparkle) noLyrics = s = new SparkleIcons(MODE_NONE, note, sparkle);
            out = s;
        }
        composer.endReplaceGroup();
        return out;
    }

    // Work started or finished, one token per job
    static void work(Object job, boolean sylla, boolean on) {
        synchronized (lock) {
            java.util.HashSet<Object> set = sylla ? syllaJobs : busyJobs;
            if (on) set.add(job);
            else set.remove(job);
            syllaPending = !syllaJobs.isEmpty();
            busyPending = !busyJobs.isEmpty();
        }
        new Handler(Looper.getMainLooper()).post(STATES);
    }

    // New track, forget running work
    static void resetWork() {
        synchronized (lock) {
            syllaJobs.clear();
            busyJobs.clear();
            syllaPending = false;
            busyPending = false;
        }
        new Handler(Looper.getMainLooper()).post(STATES);
    }

    // Fetch started
    public static void rlBegin(Object worker) {
        synchronized (lock) {
            latestWorker = worker;
            latestRunning = true;
        }
        newFetch = true;
        new Handler(Looper.getMainLooper()).post(POSTER);
    }

    // Fetch done, only the newest counts
    public static void rlEnd(Object worker) {
        synchronized (lock) {
            if (worker == latestWorker) latestRunning = false;
        }
        new Handler(Looper.getMainLooper()).post(POSTER);
    }

    @Override
    public void run() {
        if (mode == -2) {
            Boolean sy = Boolean.valueOf(syllaPending);
            if (!sy.equals(syllaState.getValue())) syllaState.setValue(sy);
            Boolean bu = Boolean.valueOf(busyPending);
            if (!bu.equals(busyState.getValue())) busyState.setValue(bu);
            return;
        }
        if (mode == -1) {
            // Timer fired, recompose
            timeoutPosted = false;
            postedAtMs = Long.MAX_VALUE;
            timeoutTick.setValue(Integer.valueOf(((Integer) timeoutTick.getValue()).intValue() + 1));
            return;
        }
        boolean on;
        synchronized (lock) {
            on = latestRunning;
        }
        if (newFetch) {
            // New fetch, reset timeout
            newFetch = false;
            loadingSinceMs = 0L;
            timeoutTick.setValue(Integer.valueOf(((Integer) timeoutTick.getValue()).intValue() + 1));
        }
        Boolean v = Boolean.valueOf(on);
        if (!v.equals(rlLoading.getValue())) rlLoading.setValue(v);
    }

    @Override
    public long getIntrinsicSizeNHjbRc() {
        return sizeRef.getIntrinsicSizeNHjbRc();
    }

    // Rainbow spinner ignores the button tint
    @Override
    public boolean applyColorFilter(ColorFilter colorFilter) {
        return mode == MODE_SYLLA;
    }

    @Override
    public void onDraw(DrawScope scope) {
        long size = scope.getSizeNHjbRc();
        float w = Size.getWidthImpl(size);
        float h = Size.getHeightImpl(size);
        if (w <= 0f || h <= 0f) return;
        Canvas canvas = AndroidCanvas_androidKt.getNativeCanvas(scope.getDrawContext().getCanvas());
        float s = Math.min(w, h);

        if (mode == MODE_LOADING || mode == MODE_SYLLA) {
            tick.getValue();    // redraw every frame
            long now = SystemClock.uptimeMillis();
            lastSpinDrawMs = now;
            if (!frameScheduled) {
                frameScheduled = true;
                Choreographer.getInstance().postFrameCallback(POSTER);
            }
            float r = s * RING_R;
            paint.setStrokeWidth(s * RING_STROKE);
            oval.set(w / 2f - r, h / 2f - r, w / 2f + r, h / 2f + r);
            float angle = (now % SPIN_MS) / (float) SPIN_MS * 360f;
            if (mode == MODE_SYLLA) {
                // Same flowing gradient as the AI sparkle
                float phase = (now % CYCLE_MS) / (float) CYCLE_MS;
                for (int i = 0; i < 4; i++) rainbow[i] = lerpPalette(phase + i * 0.25f);
                paint.setShader(new LinearGradient(0f, h, w, 0f, rainbow, STOPS, Shader.TileMode.CLAMP));
            }
            canvas.drawArc(oval, angle - 90f, ARC_SWEEP, false, paint);
            return;
        }

        // Note with a line through it
        int save = canvas.saveLayer(0f, 0f, w, h, null);
        canvas.save();
        canvas.scale(NOTE_SCALE, NOTE_SCALE, w / 2f, h / 2f);
        inner.drawxKDEd0(scope, size, 1f, null);
        canvas.restore();
        float stroke = s * 0.06f;
        float a = s * 0.2f, b = s * 0.8f;
        clear.setStrokeWidth(stroke * 2.6f);
        canvas.drawLine(a, a, b, b, clear);
        paint.setStrokeWidth(stroke);
        canvas.drawLine(a, a, b, b, paint);
        canvas.restoreToCount(save);
    }

    @Override
    public void doFrame(long frameTimeNanos) {
        long now = SystemClock.uptimeMillis();
        if (now - lastSpinDrawMs < 500L) {
            tick.setValue(Long.valueOf(now));
            Choreographer.getInstance().postFrameCallback(POSTER);
        } else {
            frameScheduled = false;
        }
    }

    // Blend between palette colours
    static int lerpPalette(float phase) {
        float p = phase - (float) Math.floor(phase);
        float x = p * 4f;
        int i = (int) x;
        float f = x - i;
        int a = PALETTE[i & 3];
        int b = PALETTE[(i + 1) & 3];
        int ar = (a >> 16) & 0xFF, ag = (a >> 8) & 0xFF, ab = a & 0xFF;
        int br = (b >> 16) & 0xFF, bg = (b >> 8) & 0xFF, bb = b & 0xFF;
        int rr = (int) (ar + (br - ar) * f);
        int gg = (int) (ag + (bg - ag) * f);
        int bl = (int) (ab + (bb - ab) * f);
        return 0xFF000000 | (rr << 16) | (gg << 8) | bl;
    }
}
