package radiant;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.RuntimeShader;
import android.graphics.Shader;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.view.Choreographer;
import android.widget.ImageView;

import java.util.WeakHashMap;

import androidx.compose.runtime.MutableIntState;
import androidx.compose.runtime.SnapshotIntStateKt;
import androidx.compose.ui.Modifier;
import androidx.compose.ui.draw.DrawModifierKt;
import androidx.compose.ui.geometry.Size;
import androidx.compose.ui.graphics.AndroidCanvas_androidKt;
import androidx.compose.ui.graphics.drawscope.ContentDrawScope;

import com.tidal.android.image.coil.base.CoilImageLoader;
import com.tidal.android.image.core.b;    // MARKER: R8 core.b

// Covers ripple into each other on song change <3
public final class CoverWave implements yl0.l, Runnable, Choreographer.FrameCallback, c0.c {    // MARKER: R8 yl0.l c0.c
    // Old cover waits this long for the new one
    private static final long LOAD_TIMEOUT_MS = 2500L;
    private static final long ABORT_FADE_MS = 250L;
    // then fades out over this
    private static final long FADE_OUT_MS = 350L;
    // Shortest crossfade ripple
    private static final long MIN_CROSSFADE_MS = 300L;
    // Swiped this recently, the pager did it
    private static final long USER_MS = 2500L;
    private static final long IDLE_STOP_MS = 500L;
    // Crossfade done, wait this long for TIDAL
    private static final long XF_HOLD_MS = 2500L;
    // TIDAL redraws a frame after the switch
    private static final long LAND_GRACE_MS = 400L;
    // Big enough for 2x screens
    private static final int COVER_PX = 1280;

    // Keep hash numbers small, phone GPUs leave seams
    private static final String AGSL =
        "uniform shader uOld;\n" +
        "uniform shader uNew;\n" +
        "uniform float2 uSize;\n" +
        "uniform float2 uOldPx;\n" +
        "uniform float2 uNewPx;\n" +
        "uniform float2 uFitOld;\n" +
        "uniform float2 uFitNew;\n" +
        "uniform float uMix;\n" +
        "uniform float uClock;\n" +
        "uniform float uPulse;\n" +
        "uniform float uPulseAge;\n" +
        "uniform float uJitter;\n" +
        "uniform float uFade;\n" +
        "uniform float3 uHue;\n" +
        "\n" +
        "float rnd2(float2 q) {\n" +
        "  float3 p = fract(float3(mod(q, 256.0).xyx) * 0.1031);\n" +
        "  p += dot(p, p.yzx + 33.33);\n" +
        "  return fract((p.x + p.y) * p.z);\n" +
        "}\n" +
        "float vnoise(float2 q) {\n" +
        "  float2 k = floor(q);\n" +
        "  float2 w = fract(q);\n" +
        "  w = w * w * (3.0 - 2.0 * w);\n" +
        "  return mix(mix(rnd2(k), rnd2(k + float2(1.0, 0.0)), w.x), mix(rnd2(k + float2(0.0, 1.0)), rnd2(k + float2(1.0, 1.0)), w.x), w.y);\n" +
        "}\n" +
        "float octaves(float2 q) {\n" +
        "  float acc = 0.0;\n" +
        "  float amp = 0.5;\n" +
        "  for (int k = 0; k < 4; k++) {\n" +
        "    acc += amp * vnoise(q);\n" +
        "    q = q * 2.03 + 17.1;\n" +
        "    amp *= 0.5;\n" +
        "  }\n" +
        "  return acc;\n" +
        "}\n" +
        "float2 mirrorUv(float2 uv) { return 1.0 - abs(1.0 - mod(uv, 2.0)); }\n" +
        "float3 oldAt(float2 uv) { return uOld.eval(((mirrorUv(uv) - 0.5) * uFitOld + 0.5) * uOldPx).rgb; }\n" +
        "float3 newAt(float2 uv) { return uNew.eval(((mirrorUv(uv) - 0.5) * uFitNew + 0.5) * uNewPx).rgb; }\n" +
        "float3 oldFringe(float2 uv, float2 off) { return float3(oldAt(uv + off).r, oldAt(uv).g, oldAt(uv - off).b); }\n" +
        "float3 newFringe(float2 uv, float2 off) { return float3(newAt(uv + off).r, newAt(uv).g, newAt(uv - off).b); }\n" +
        "\n" +
        "half4 main(float2 fragCoord) {\n" +
        "  float2 uv = fragCoord / uSize;\n" +
        "  float2 fromMid = uv - 0.5;\n" +
        "  float radial = length(fromMid);\n" +
        "  float swell = uPulseAge > 0.0 ? exp(-abs(radial - uPulseAge * 0.85) * 13.0) * uPulse : 0.0;\n" +
        "  float2 bentUv = 0.5 + fromMid + normalize(fromMid + 1e-5) * swell * 0.04;\n" +
        "  float2 aberr = fromMid * (0.05 * swell);\n" +
        "  float busy = step(0.002, uMix) * step(uMix, 0.998);\n" +
        "  float w = uv.x * 0.74 + uv.y * 0.26 + sin(uv.y * 7.0 + uClock * 1.7) * 0.045 + (octaves(uv * 3.0 + uJitter + float2(0.0, uClock * 0.08)) - 0.47) * 0.16;\n" +
        "  float gap = w - mix(-0.2, 1.2, uMix);\n" +
        "  float side = smoothstep(-0.01, 0.01, gap);\n" +
        "  float bulge = exp(-abs(gap) * 9.0) * busy;\n" +
        "  float wiggle = sin(gap * 70.0 - uClock * 5.0) * exp(-abs(gap) * 7.0) * busy;\n" +
        "  float2 shove = float2(0.74, 0.26) * (bulge * 0.07 + wiggle * 0.018);\n" +
        "  float3 shade = mix(newFringe(bentUv - shove, aberr + float2(0.01 * bulge, 0.0)), oldFringe(bentUv + shove, aberr + float2(0.02 * bulge, 0.0)), side);\n" +
        "  shade *= 1.0 + wiggle * 0.18;\n" +
        "  float shine = (exp(-abs(gap) * 45.0) * 1.4 + exp(-abs(gap) * 8.0) * 0.25) * busy;\n" +
        "  float3 hueLight = mix(uHue, float3(1.0), 0.55);\n" +
        "  float headroom = 1.0 - 0.65 * dot(shade, float3(0.3, 0.6, 0.1));\n" +
        "  shade += shine * 0.3 * hueLight * headroom;\n" +
        "  shade += swell * 0.1 * headroom;\n" +
        "  return half4(half3(clamp(shade * uFade, 0.0, 1.0)), half(uFade));\n" +
        "}\n";

    private static final int NODE = 0;
    private static final int TRACK = 1;
    private static final int PARK = 2;
    private static final int SWAP = 3;
    private static final int CLOCK = 4;
    private static final int XFADE = 5;
    private static final int PREFETCH = 6;

    // Bumped per frame so cover nodes redraw
    private static final MutableIntState frameState = SnapshotIntStateKt.mutableIntStateOf(0);
    // Bumped when the backdrop cover changes early
    private static final MutableIntState xfState = SnapshotIntStateKt.mutableIntStateOf(0);
    private static final CoverWave FRAMES = new CoverWave(CLOCK, 0, null, 0);
    private static final Paint paint = new Paint(Paint.FILTER_BITMAP_FLAG);
    private static final Rect src = new Rect();
    private static final RectF dst = new RectF();

    private static Handler main;
    private static Object queue;
    private static coil.e loader;    // MARKER: R8 coil.e
    private static Context app;

    // What TIDAL shows now
    private static String tidalKey;
    private static int tidalAlbum;
    // Cover on screen, next swap starts from it
    private static Bitmap shown;
    private static String shownKey;

    // Swap state, main thread only
    private static boolean swapping;
    private static Bitmap from;
    private static Bitmap to;
    private static String fromKey;
    private static String toKey;
    // Covers shrunk to draw size so they stay sharp
    private static final Bitmap[] fitSrc = new Bitmap[8];
    private static final Bitmap[] fitOut = new Bitmap[8];
    private static final BitmapShader[] fitShader = new BitmapShader[8];
    private static final int[] fitW = new int[8];
    private static final int[] fitH = new int[8];
    private static int fitNext;
    // Pill overlays, gone when their image is
    private static final WeakHashMap<ImageView, CoverWaveView> viewWaves = new WeakHashMap<>();
    private static float hueR, hueG, hueB;
    private static float jitter;
    private static long heldSince, start, end, abortAt, span;
    private static boolean crossfade;
    private static long landedAt;
    private static int token;
    // Crossfade target till TIDAL switches
    private static String xfKey;
    private static int xfAlbum;
    private static int xfTick;

    // TIDAL crossfade length, 0 is off
    private static volatile long crossfadeMs;
    private static volatile long swipeAt;

    private static RuntimeShader shader;
    private static boolean shaderFailed;
    private static long lastDraw;
    private static boolean frameQueued;
    private static int tick;

    private final int mode;
    private final int albumId;
    private final String cover;
    private final int job;

    private CoverWave(int mode, int albumId, String cover, int job) {
        this.mode = mode;
        this.albumId = albumId;
        this.cover = cover;
        this.job = job;
    }

    // Hooks

    // Ripple on the cover under this modifier
    public static Modifier wrap(Modifier modifier, int albumId, String cover) {
        if (cover == null || cover.length() == 0) return modifier;
        return DrawModifierKt.drawWithContent(modifier, new CoverWave(NODE, albumId, cover, 0));
    }

    // Lyrics pill ripple, it's a View not Compose
    public static void attachView(ImageView image, int albumId, String cover) {
        if (image == null || cover == null || cover.length() == 0) return;
        try {
            CoverWaveView o = viewWaves.get(image);
            if (o == null) {
                o = new CoverWaveView();
                o.setBounds(0, 0, image.getWidth(), image.getHeight());
                image.getOverlay().add(o);
                image.addOnLayoutChangeListener(o);
                viewWaves.put(image, o);
            }
            o.cover = cover;
            o.invalidateSelf();
        } catch (Throwable t) {
            // no ripple on this one
        }
    }

    // Draws the pill ripple, same rules as Compose
    static void drawView(Canvas canvas, String cover, float w, float h) {
        if (!showsSwap(cover)) return;
        lastDraw = SystemClock.uptimeMillis();
        schedule();
        draw(canvas, w, h);
    }

    // Mini player state, every track change
    public static void onTrack(int albumId, String cover) {
        if (cover == null || cover.length() == 0) return;
        post(new CoverWave(TRACK, albumId, cover, 0));
    }

    // Play queue, for the next cover
    public static void setQueue(Object playQueue) {
        queue = playQueue;
    }

    // Next song's getting ready, grab its cover
    public static void onCrossfadePrepare() {
        post(new CoverWave(PREFETCH, 0, null, 0));
    }

    // Crossfade started, ripple right along with it <3
    public static void onCrossfadeStart(long leftMs) {
        post(new CoverWave(XFADE, (int) Math.min(Integer.MAX_VALUE, Math.max(0L, leftMs)), null, 0));
    }

    // Kawarp's album, next one once crossfading
    public static int backdropAlbum(int albumId) {
        return xfKey != null ? xfAlbum : albumId;
    }

    // Kawarp's cover, next one once crossfading
    public static String backdropCover(String cover) {
        // Reading this redraws the backdrop when it flips
        xfState.getIntValue();
        String k = xfKey;
        return k != null ? k : cover;
    }

    private static void post(Runnable r) {
        Handler h = main;
        if (h == null) {
            h = new Handler(Looper.getMainLooper());
            main = h;
        }
        h.post(r);
    }

    // TIDAL's effective crossfade length
    public static void onCrossfade(long ms) {
        crossfadeMs = ms < 0L ? 0L : ms;
    }

    // User swiped the cover pager
    public static void onSwipe() {
        swipeAt = SystemClock.uptimeMillis();
    }

    // Kawarp's crossfade length for the next cover
    public static int backdropMs() {
        long now = SystemClock.uptimeMillis();
        if (swapping && crossfade && end > now) return (int) Math.max(MIN_CROSSFADE_MS, end - now);
        return transitionMs();
    }

    private static int transitionMs() {
        return Math.max(500, CoverDefaults.ms());
    }

    // Track change

    private static void track(int albumId, String key) {
        if (key.equals(tidalKey)) return;
        boolean first = tidalKey == null;
        tidalKey = key;
        tidalAlbum = albumId;
        long now = SystemClock.uptimeMillis();
        boolean swiped = now - swipeAt < USER_MS;
        swipeAt = 0L;
        // TIDAL caught up with the crossfade
        clearXf();
        // Crossfade landed, already rippling
        if (swapping && key.equals(toKey)) {
            landedAt = now;
            kick();
            return;
        }
        if (!swapping && key.equals(shownKey)) return;
        // Pager already slid it in
        if (swiped) {
            if (swapping) endSwap(false);
            park(albumId, key);
            return;
        }
        if (!first && startSwap(albumId, key, 0L)) return;
        park(albumId, key);
    }

    // Crossfade began, ripple to the next cover now
    private static void crossfadeStart(int leftMs) {
        if (!CoverDefaults.follow()) return;
        com.aspiro.wamp.model.Album next = nextAlbum();
        if (next == null) return;
        String key = next.getCover();
        if (key == null || key.length() == 0 || key.equals(tidalKey)) return;
        if (swapping && key.equals(toKey)) return;
        // Ends when the old track does
        if (!startSwap(next.getId(), key, Math.max(MIN_CROSSFADE_MS, leftMs))) return;
        xfKey = key;
        xfAlbum = next.getId();
        xfState.setIntValue(++xfTick);
    }

    // Load the next cover early so it's ready
    private static void prefetchNext() {
        if (!CoverDefaults.follow() || crossfadeMs <= 0L) return;
        com.aspiro.wamp.model.Album next = nextAlbum();
        if (next == null) return;
        String key = next.getCover();
        if (key == null || key.length() == 0 || key.equals(tidalKey)) return;
        load(PREFETCH, next.getId(), key, 0);
    }

    // Next song's album from the queue
    private static com.aspiro.wamp.model.Album nextAlbum() {
        try {
            Object q = queue;
            if (q == null) return null;
            com.aspiro.wamp.playqueue.q0 item = ((zh.e) q).getPlayQueue().peekNext();    // MARKER: R8 zh.e t q0
            if (item == null || item.getMediaItem() == null) return null;
            return item.getMediaItem().getAlbum();
        } catch (Throwable t) {
            return null;
        }
    }

    private static void clearXf() {
        if (xfKey == null) return;
        xfKey = null;
        xfState.setIntValue(++xfTick);
    }

    // This cover is part of the running swap
    private static boolean showsSwap(String c) {
        if (!swapping || c == null) return false;
        if (c.equals(toKey)) return true;
        // Crossfading, TIDAL still shows the old one
        return crossfade && c.equals(fromKey)
            && (landedAt == 0L || SystemClock.uptimeMillis() - landedAt < LAND_GRACE_MS);
    }

    private static boolean attach() {
        if (loader != null) return true;
        try {
            Context c = (Context) Class.forName("android.app.ActivityThread")
                .getMethod("currentApplication").invoke(null);
            if (!(c instanceof ud0.b.a)) return false;    // MARKER: R8 ud0.b.a
            Object tidal = ((ud0.b.a) c).a().a();    // MARKER: R8 ud0.b.a
            if (!(tidal instanceof CoilImageLoader)) return false;
            app = c;
            loader = ((CoilImageLoader) tidal).a;
            return loader != null;
        } catch (Throwable t) {
            return false;
        }
    }

    // TIDAL's own cover request at 1280px
    private static void load(int mode, int albumId, String key, int job) {
        if (!attach()) return;
        CoverWave target = new CoverWave(mode, albumId, key, job);
        try {
            pd0.g req = new pd0.g(app, new b.a(String.valueOf(albumId), key), null, null, false, null,    // MARKER: R8 pd0.g b.a
                new pd0.f(new pd0.h.c(COVER_PX, COVER_PX)), false);    // MARKER: R8 pd0.f pd0.h.c
            coil.request.h.a builder = coil.request.h.a(com.tidal.android.image.coil.c.a(req, null));    // MARKER: R8 h.a coil.c.a
            builder.d = target;    // MARKER: R8 builder.d
            loader.b(builder.a());    // MARKER: R8 loader.b builder.a
        } catch (Throwable t) {
            target.c(null);
        }
    }

    // No swap, just get the cover ready
    private static void park(int albumId, String key) {
        load(PARK, albumId, key, ++token);
    }

    // Start a swap, false when there's nothing to start from
    private static boolean startSwap(int albumId, String key, long xfSpan) {
        if (!attach()) return false;
        // Mid swap: keep whichever cover shows more
        if (swapping) {
            if (to != null) {
                shown = to;
                shownKey = toKey;
            } else {
                shown = from;
                shownKey = fromKey;
            }
            clearSwap();
        }
        if (shown == null) return false;
        long now = SystemClock.uptimeMillis();
        from = shown;
        fromKey = shownKey;
        shown = null;
        shownKey = null;
        to = null;
        toKey = key;
        jitter = jitterFor(key);
        heldSince = now;
        abortAt = 0L;
        landedAt = 0L;
        crossfade = xfSpan > 0L;
        span = crossfade ? xfSpan : transitionMs();
        // Crossfades start now, others once loaded
        start = crossfade ? now : 0L;
        end = crossfade ? now + span : 0L;
        swapping = true;
        load(SWAP, albumId, key, ++token);
        kick();
        return true;
    }

    private void arrive(Bitmap art) {
        if (mode == PREFETCH || job != token) return;
        if (mode == PARK) {
            if (art == null || swapping) return;
            shown = art;
            shownKey = cover;
            return;
        }
        if (!swapping || !cover.equals(toKey)) return;
        long now = SystemClock.uptimeMillis();
        if (art == null) {
            // No new cover, fade the old one out
            if (abortAt == 0L) abortAt = now;
            kick();
            return;
        }
        to = art;
        meanColour(art);
        if (start == 0L) {
            start = now;
            end = now + span;
        }
        kick();
    }

    // Swap over, or dropped
    private static void endSwap(boolean done) {
        boolean landed = done && to != null;
        if (landed) {
            shown = to;
            shownKey = toKey;
        }
        clearSwap();
        // Ready the cover for next time
        if (!landed && tidalKey != null) park(tidalAlbum, tidalKey);
    }

    private static void clearSwap() {
        swapping = false;
        landedAt = 0L;
        clearXf();
        from = null;
        to = null;
        fromKey = null;
        toKey = null;
        for (int i = 0; i < 8; i++) {
            fitSrc[i] = null;
            fitOut[i] = null;
            fitShader[i] = null;
        }
    }

    // Drawing

    private static void kick() {
        frameState.setIntValue(++tick);
        for (CoverWaveView v : viewWaves.values()) v.invalidateSelf();
    }

    public void doFrame(long frameTimeNanos) {
        frameQueued = false;
        if (!swapping) return;
        // Nothing drew lately, cover is off screen
        if (SystemClock.uptimeMillis() - lastDraw > IDLE_STOP_MS) return;
        kick();
        schedule();
    }

    private static void schedule() {
        if (frameQueued) return;
        frameQueued = true;
        Choreographer.getInstance().postFrameCallback(FRAMES);
    }

    public Object invoke(Object scope) {
        ContentDrawScope s = (ContentDrawScope) scope;
        // Reading this redraws us every frame
        frameState.getIntValue();
        s.drawContent();
        if (showsSwap(cover)) {
            lastDraw = SystemClock.uptimeMillis();
            schedule();
            long packed = s.getSizeNHjbRc();
            draw(AndroidCanvas_androidKt.getNativeCanvas(s.getDrawContext().getCanvas()),
                Size.getWidthImpl(packed), Size.getHeightImpl(packed));
        }
        return kotlin.u.a;    // MARKER: R8 u.a
    }

    private static void draw(Canvas canvas, float w, float h) {
        if (w < 2f || h < 2f || from == null) return;
        long now = SystemClock.uptimeMillis();
        float mix, clock, pulse, pulseAge, fade;
        if (to == null) {
            // Old cover holds while the new one loads
            if (abortAt == 0L && (now - heldSince > LOAD_TIMEOUT_MS || (end != 0L && now >= end))) abortAt = now;
            fade = abortAt != 0L ? 1f - (now - abortAt) / (float) ABORT_FADE_MS : 1f;
            if (fade <= 0f) {
                endSwap(false);
                return;
            }
            mix = 0f;
            clock = 0f;
            pulse = 0f;
            pulseAge = -1f;
        } else {
            long len = Math.max(1L, end - start);
            pulseAge = (now - (start + len / 2f)) / 1000f;
            fade = 1f;
            // Done, fade the overlay out
            if (now >= end) {
                // Crossfade: hold the new cover till TIDAL switches
                boolean waiting = crossfade && landedAt == 0L;
                long fadeAt = waiting ? end + XF_HOLD_MS : Math.max(end, landedAt);
                fade = now < fadeAt ? 1f : 1f - (now - fadeAt) / (float) FADE_OUT_MS;
                if (fade <= 0f) {
                    // Never switched, crossfade was cancelled
                    endSwap(!waiting);
                    return;
                }
            }
            mix = ease3((now - start) / (float) len);
            clock = Math.max(0f, (now - start) / 1000f);
            pulse = pulseAge >= 0f ? (float) Math.exp(-pulseAge * 2.2f) : 0f;
        }
        Bitmap a = from;
        Bitmap b2 = to != null ? to : from;
        if (Build.VERSION.SDK_INT >= 33 && !shaderFailed
                && wave(canvas, a, b2, w, h, mix, clock, pulse, pulseAge, fade)) return;
        fade(canvas, a, b2, w, h, mix, fade);
    }

    // AGSL ripple, API 33+
    private static boolean wave(Canvas canvas, Bitmap a, Bitmap b2, float w, float h,
                                float mix, float clock, float pulse, float pulseAge, float fade) {
        try {
            if (shader == null) shader = new RuntimeShader(AGSL);
            int ia = fit(a, w, h);
            Bitmap fa = fitOut[ia];
            BitmapShader sa = fitShader[ia];
            Bitmap fb = fa;
            BitmapShader sb = sa;
            if (b2 != a) {
                int ib = fit(b2, w, h);
                fb = fitOut[ib];
                sb = fitShader[ib];
            }
            RuntimeShader rs = shader;
            rs.setInputShader("uOld", sa);
            rs.setInputShader("uNew", sb);
            rs.setFloatUniform("uSize", w, h);
            rs.setFloatUniform("uOldPx", fa.getWidth(), fa.getHeight());
            rs.setFloatUniform("uNewPx", fb.getWidth(), fb.getHeight());
            float relA = (w / h) / (fa.getWidth() / (float) fa.getHeight());
            float relB = (w / h) / (fb.getWidth() / (float) fb.getHeight());
            rs.setFloatUniform("uFitOld", Math.min(relA, 1f), Math.min(1f / relA, 1f));
            rs.setFloatUniform("uFitNew", Math.min(relB, 1f), Math.min(1f / relB, 1f));
            rs.setFloatUniform("uMix", mix);
            rs.setFloatUniform("uClock", clock);
            rs.setFloatUniform("uPulse", pulse);
            rs.setFloatUniform("uPulseAge", pulseAge);
            rs.setFloatUniform("uJitter", jitter);
            rs.setFloatUniform("uFade", fade);
            rs.setFloatUniform("uHue", hueR, hueG, hueB);
            paint.setAlpha(255);
            paint.setShader(rs);
            canvas.drawRect(0f, 0f, w, h, paint);
            paint.setShader(null);
            return true;
        } catch (Throwable t) {
            // No AGSL, plain crossfade
            shaderFailed = true;
            paint.setShader(null);
            return false;
        }
    }

    // Shrunk copy for this size, cached
    private static int fit(Bitmap bmp, float w, float h) {
        int tw = Math.max(1, Math.round(w));
        int th = Math.max(1, Math.round(h));
        for (int i = 0; i < 8; i++) {
            if (fitSrc[i] == bmp && fitW[i] == tw && fitH[i] == th) return i;
        }
        int i = fitNext;
        fitNext = (i + 1) & 7;
        Bitmap out = shrink(bmp, tw, th);
        fitSrc[i] = bmp;
        fitOut[i] = out;
        fitW[i] = tw;
        fitH[i] = th;
        fitShader[i] = linear(out);
        return i;
    }

    // Halve a few times, then scale, stays crisp
    private static Bitmap shrink(Bitmap bmp, int tw, int th) {
        float s = Math.max(tw / (float) bmp.getWidth(), th / (float) bmp.getHeight());
        if (s >= 0.95f) return bmp;
        Bitmap cur = bmp;
        try {
            while (s <= 0.5f) {
                Bitmap half = Bitmap.createScaledBitmap(cur,
                    Math.max(1, cur.getWidth() / 2), Math.max(1, cur.getHeight() / 2), true);
                if (cur != bmp) cur.recycle();
                cur = half;
                s *= 2f;
            }
            Bitmap out = Bitmap.createScaledBitmap(cur,
                Math.max(1, Math.round(cur.getWidth() * s)), Math.max(1, Math.round(cur.getHeight() * s)), true);
            if (cur != bmp && cur != out) cur.recycle();
            return out;
        } catch (Throwable t) {
            return bmp;
        }
    }

    private static BitmapShader linear(Bitmap bmp) {
        BitmapShader s = new BitmapShader(bmp, Shader.TileMode.CLAMP, Shader.TileMode.CLAMP);
        s.setFilterMode(BitmapShader.FILTER_MODE_LINEAR);
        return s;
    }

    // Plain crossfade below API 33
    private static void fade(Canvas canvas, Bitmap a, Bitmap b2, float w, float h, float mix, float fade) {
        int save = canvas.saveLayerAlpha(0f, 0f, w, h, Math.round(fade * 255f));
        dst.set(0f, 0f, w, h);
        paint.setAlpha(255);
        crop(b2, w, h);
        canvas.drawBitmap(b2, src, dst, paint);
        if (b2 != a && mix < 1f) {
            paint.setAlpha(Math.round((1f - mix) * 255f));
            crop(a, w, h);
            canvas.drawBitmap(a, src, dst, paint);
            paint.setAlpha(255);
        }
        canvas.restoreToCount(save);
    }

    // object-fit: cover
    private static void crop(Bitmap bmp, float w, float h) {
        float bw = bmp.getWidth();
        float bh = bmp.getHeight();
        float rel = (w / h) / (bw / bh);
        float fx = Math.min(rel, 1f) * bw;
        float fy = Math.min(1f / rel, 1f) * bh;
        int l = Math.round((bw - fx) / 2f);
        int t = Math.round((bh - fy) / 2f);
        src.set(l, t, l + Math.round(fx), t + Math.round(fy));
    }

    // Helpers

    private static float ease3(float x) {
        float t = Math.min(1f, Math.max(0f, x));
        return t * t * (3f - 2f * t);
    }

    // FNV-1a, same jitter as desktop
    private static float jitterFor(String key) {
        int h = 0x811c9dc5;
        for (int i = 0; i < key.length(); i++) h = (h ^ key.charAt(i)) * 16777619;
        return ((h & 0xffffffffL) % 1000L) / 37f;
    }

    // Punchier average colour, reads better as light
    private static void meanColour(Bitmap art) {
        float r = 1f, g = 1f, b = 1f;
        try {
            Bitmap small = Bitmap.createScaledBitmap(art, 16, 16, true);
            int[] px = new int[256];
            small.getPixels(px, 0, 16, 0, 0, 16, 16);
            float sr = 0f, sg = 0f, sb = 0f;
            for (int i = 0; i < 256; i++) {
                sr += (px[i] >> 16) & 0xFF;
                sg += (px[i] >> 8) & 0xFF;
                sb += px[i] & 0xFF;
            }
            float n = 256f * 255f;
            r = sr / n;
            g = sg / n;
            b = sb / n;
            float mean = (r + g + b) / 3f;
            r = clamp01(mean + (r - mean) * 1.6f + 0.12f);
            g = clamp01(mean + (g - mean) * 1.6f + 0.12f);
            b = clamp01(mean + (b - mean) * 1.6f + 0.12f);
        } catch (Throwable t) {
            // keep white
        }
        hueR = r;
        hueG = g;
        hueB = b;
    }

    private static float clamp01(float v) {
        return v < 0f ? 0f : v > 1f ? 1f : v;
    }

    private static Bitmap toBitmap(Drawable d) {
        if (d == null) return null;
        Bitmap bmp = null;
        if (d instanceof BitmapDrawable) bmp = ((BitmapDrawable) d).getBitmap();
        if (bmp != null && (Build.VERSION.SDK_INT < 26 || bmp.getConfig() != Bitmap.Config.HARDWARE)) return bmp;
        int w = Math.max(1, d.getIntrinsicWidth() > 0 ? d.getIntrinsicWidth() : COVER_PX);
        int h = Math.max(1, d.getIntrinsicHeight() > 0 ? d.getIntrinsicHeight() : COVER_PX);
        Bitmap out = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        d.setBounds(0, 0, w, h);
        d.draw(new Canvas(out));
        return out;
    }

    // Runs on main, track and crossfade stuff
    public void run() {
        if (mode == TRACK) track(albumId, cover);
        else if (mode == XFADE) crossfadeStart(albumId);
        else if (mode == PREFETCH) prefetchNext();
    }

    // Target.onSuccess
    public void a(Drawable drawable) {
        arrive(toBitmap(drawable));
    }

    // Target.onStart
    public void b(Drawable placeholder) {}

    // Target.onError
    public void c(Drawable error) {
        arrive(null);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CoverWave)) return false;
        CoverWave w = (CoverWave) o;
        return mode == w.mode && albumId == w.albumId && job == w.job
            && (cover == null ? w.cover == null : cover.equals(w.cover));
    }

    @Override
    public int hashCode() {
        return (mode * 31 + albumId) * 31 + (cover == null ? 0 : cover.hashCode());
    }
}
