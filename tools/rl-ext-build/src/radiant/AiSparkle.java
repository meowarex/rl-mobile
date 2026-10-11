package radiant;

import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Shader;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.view.Choreographer;

import androidx.compose.runtime.Composer;
import androidx.compose.runtime.MutableState;
import androidx.compose.runtime.SnapshotStateKt;
import androidx.compose.ui.geometry.Size;
import androidx.compose.ui.graphics.AndroidCanvas_androidKt;
import androidx.compose.ui.graphics.ColorFilter;
import androidx.compose.ui.graphics.drawscope.DrawScope;
import androidx.compose.ui.graphics.painter.Painter;

import org.json.JSONObject;

// Rainbow sparkle when syllables are AI generated
public final class AiSparkle extends Painter implements Choreographer.FrameCallback, Runnable {
    private static final String TAG = "RLAiSparkle";

    // Same colours as desktop
    private static final int[] PALETTE = {0xFFFF6B9D, 0xFFFFD166, 0xFF5EE7FF, 0xFFA78BFA};
    private static final long CYCLE_MS = 6000L;
    private static final float[] STOPS = {0f, 0.35f, 0.65f, 1f};

    // Current lyrics are AI generated
    static final MutableState aiState = SnapshotStateKt.mutableStateOf$default(Boolean.FALSE, null, 2, null);
    // Frame tick for the animation
    static final MutableState tick = SnapshotStateKt.mutableStateOf$default(Long.valueOf(0L), null, 2, null);

    private static final AiSparkle POSTER = new AiSparkle(null);
    private static volatile boolean pending;
    private static AiSparkle cached;
    private static boolean frameScheduled;
    private static long lastDrawMs;

    private final Painter base;
    private final Paint fillPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final int[] colors = new int[4];

    private AiSparkle(Painter base) {
        this.base = base;
        fillPaint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
    }

    // Check the API response for AI syllables
    public static void onResponse(String body) {
        boolean ai = false;
        try {
            JSONObject o = new JSONObject(body);
            ai = "Word".equals(o.optString("type", "")) && o.optBoolean("_synthesized", false);
        } catch (Throwable ignored) {
        }
        post(ai);
    }

    // New lookup, clear it
    public static void reset() {
        post(false);
    }

    // Use the rainbow painter while AI
    public static Painter wrap(Painter painter, Composer composer) {
        if (!((Boolean) aiState.getValue()).booleanValue() || painter == null) return painter;
        AiSparkle c = cached;
        if (c == null || c.base != painter) {
            c = new AiSparkle(painter);
            cached = c;
        }
        return c;
    }

    private static void post(boolean ai) {
        pending = ai;
        new Handler(Looper.getMainLooper()).post(POSTER);
    }

    @Override
    public void run() {
        Boolean v = Boolean.valueOf(pending);
        if (!v.equals(aiState.getValue())) aiState.setValue(v);
    }

    @Override
    public long getIntrinsicSizeNHjbRc() {
        return base.getIntrinsicSizeNHjbRc();
    }

    // Ignore the button tint
    @Override
    public boolean applyColorFilter(ColorFilter colorFilter) {
        return true;
    }

    @Override
    public void onDraw(DrawScope scope) {
        tick.getValue();    // redraw every frame
        long now = SystemClock.uptimeMillis();
        lastDrawMs = now;
        if (!frameScheduled) {
            frameScheduled = true;
            Choreographer.getInstance().postFrameCallback(POSTER);
        }

        long size = scope.getSizeNHjbRc();
        float w = Size.getWidthImpl(size);
        float h = Size.getHeightImpl(size);
        if (w <= 0f || h <= 0f) return;
        Canvas canvas = AndroidCanvas_androidKt.getNativeCanvas(scope.getDrawContext().getCanvas());
        float phase = (now % CYCLE_MS) / (float) CYCLE_MS;

        // Paint the gradient into the icon
        int save = canvas.saveLayer(0f, 0f, w, h, null);
        base.drawxKDEd0(scope, size, 1f, null);
        for (int i = 0; i < 4; i++) colors[i] = lerpPalette(phase + i * 0.25f);
        fillPaint.setShader(new LinearGradient(0f, h, w, 0f, colors, STOPS, Shader.TileMode.CLAMP));
        canvas.drawRect(0f, 0f, w, h, fillPaint);
        canvas.restoreToCount(save);
    }

    @Override
    public void doFrame(long frameTimeNanos) {
        long now = SystemClock.uptimeMillis();
        if (((Boolean) aiState.getValue()).booleanValue() && now - lastDrawMs < 500L) {
            tick.setValue(Long.valueOf(now));
            Choreographer.getInstance().postFrameCallback(POSTER);
        } else {
            frameScheduled = false;
        }
    }

    // Blend between palette colours
    private static int lerpPalette(float phase) {
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
