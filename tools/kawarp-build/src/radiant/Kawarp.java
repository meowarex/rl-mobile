package radiant;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.SystemClock;
import android.view.Choreographer;

import androidx.compose.foundation.layout.SizeKt;
import androidx.compose.foundation.layout.SpacerKt;
import androidx.compose.runtime.Composer;
import androidx.compose.runtime.MutableIntState;
import androidx.compose.runtime.SnapshotIntStateKt;
import androidx.compose.runtime.MutableState;
import androidx.compose.runtime.SnapshotStateKt;
import androidx.compose.ui.Modifier;
import androidx.compose.ui.draw.DrawModifierKt;
import androidx.compose.ui.geometry.Size;
import androidx.compose.ui.graphics.AndroidCanvas_androidKt;
import androidx.compose.ui.graphics.drawscope.DrawScope;
import androidx.compose.ui.platform.AndroidCompositionLocals_androidKt;

import coil.request.CachePolicy;

import com.tidal.android.feature.playerscreen.ui.composables.p3;
import com.tidal.android.feature.playerscreen.ui.model.PlayerBackgroundStyle;
import com.tidal.android.image.coil.base.CoilImageLoader;
import com.tidal.android.image.core.b;  // MARKER: R8 core.b

import dev.kawarp.KawarpEngine;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * MARKER: Kawarp Backdrop - TIDAL glue over dev.kawarp.KawarpEngine (Kawarp-AGSL library)
 *
 * The engine (shader, blur pipeline, settings, crossfade) lives in the Kawarp-AGSL library
 * (cloned at tools/kawarp-agsl) and is compiled into this bundle by tools/kawarp-build/build.sh;
 * this class only holds what is TIDAL/Compose-specific
 */
public final class Kawarp implements am0.l, Runnable, Choreographer.FrameCallback, b0.c {  // MARKER: R8 am0.l b0.c

    /** Stop the frame loop once nothing has drawn for this long (player left / backgrounded). */
    private static final long IDLE_STOP_MS = 500L;

    /**
     * Patch option plumbing. The 0x5241xxxx literals are sentinels that build.sh rewrites into
     * __RL_*__ placeholders for the Manager to substitute; routing them through tk() stops javac
     * constant-folding them out of existence.
     */
    private static int tk(int v) { return v; }

    private static final ExecutorService LOADER = Executors.newSingleThreadExecutor();

    /**
     * Bumped every frame so the draw lambda's snapshot read invalidates the draw phase.
     * An int state rather than MutableState<Integer>: this ticks at 60 Hz, and boxing here
     * would allocate an Integer per frame for nothing.
     */
    private static final MutableIntState frameState = SnapshotIntStateKt.mutableIntStateOf(0);
    /** Flips true on any shader failure; read during composition so we recompose onto p3.a. */
    private static final MutableState fallbackState =
        SnapshotStateKt.mutableStateOf$default(Boolean.FALSE, null, 2, null);

    /** The shared instance render passes to drawBehind (also serves as the frame callback). */
    private static final Kawarp DRAW = new Kawarp(0, null, 0);

    private static KawarpEngine engine;
    /** TIDAL's application-scoped Coil loader and the context its requests are built with. */
    private static volatile coil.f loader;  // MARKER: R8 coil.f
    private static volatile Context appContext;
    private static volatile String requestedUuid;
    private static volatile int loadToken;

    private static long lastDrawUptime;
    private static boolean frameScheduled;
    private static int frameTick;

    /** Set when this instance is a queued cover load; 0/null/0 on the shared DRAW instance. */
    private final int albumId;
    private final String uuid;
    private final int token;

    private Kawarp(int albumId, String uuid, int token) {
        this.albumId = albumId;
        this.uuid = uuid;
        this.token = token;
    }


    // Composition


    /**
     * Drop-in replacement for TIDAL's PlayerBackground composable (p3.b) - the patch redirects
     * the call site here so the whole backdrop works <3
     */
    public static void b(PlayerBackgroundStyle style, long color, int albumId, String coverUuid,
                         boolean isPlaying, boolean isSeeking, am0.a progress, Modifier modifier,  // MARKER: R8 am0.a
                         Composer composer, int changed) {
        render(albumId, coverUuid, isPlaying, modifier, composer);
    }

    /** Shared by the player screen and by Cover Everywhere (radiant/HomeBackdrop). */
    public static void render(int albumId, String coverUuid, boolean isPlaying,
                              Modifier modifier, Composer composer) {
        composer.startReplaceGroup(0x52415750);
        attach(composer);
        boolean ok = !((Boolean) fallbackState.getValue()).booleanValue() && ensureEngine();
        if (!ok) {
            // No (working) AGSL here - fall back to TIDAL's own blurred backdrop.
            p3.a(albumId, coverUuid, isPlaying, false, null, modifier, composer, 0);  // MARKER: R8 p3.a
        } else {
            engine.setPlaying(isPlaying);
            request(albumId, coverUuid);
            Modifier m = DrawModifierKt.drawBehind(SizeKt.fillMaxSize(modifier, 1.0f), DRAW);
            SpacerKt.Spacer(m, composer, 0);
        }
        composer.endReplaceGroup();
    }

    /**
     * Grab the app's image loader the same way TIDAL's composables do (yd0.c)
     */
    private static void attach(Composer composer) {
        if (loader != null) return;
        try {
            Object local = composer.consume(AndroidCompositionLocals_androidKt.getLocalContext());
            if (!(local instanceof Context)) return;
            Context app = ((Context) local).getApplicationContext();
            if (!(app instanceof ce0.b.a)) return;  // MARKER: R8 ce0.b.a
            Object tidalLoader = ((ce0.b.a) app).a().a();  // MARKER: R8 ce0.b.a
            if (!(tidalLoader instanceof CoilImageLoader)) return;
            appContext = app;
            loader = ((CoilImageLoader) tidalLoader).a;
        } catch (Throwable t) {
            // No loader -> request() never runs and the backdrop simply stays on the last cover.
        }
    }

    /** Engine construction compiles the AGSL so this doubles as the support probe. */
    private static boolean ensureEngine() {
        if (engine != null) return true;
        if (!KawarpEngine.isSupported()) return false;
        try {
            KawarpEngine e = new KawarpEngine();
            e.setWarpIntensity(Float.intBitsToFloat(tk(0x52410001)));
            e.setAnimationSpeed(Float.intBitsToFloat(tk(0x52410002)));
            e.setScale(Float.intBitsToFloat(tk(0x52410003)));
            e.setDithering(Float.intBitsToFloat(tk(0x52410004)));
            e.setAutoDarken(Float.intBitsToFloat(tk(0x52410005)));
            e.setPlaybackReactive(tk(0x52410006) != 0);
            e.setBlurPasses(tk(0x52410007));
            e.setContrast(Float.intBitsToFloat(tk(0x52410008)));
            e.setSaturation(Float.intBitsToFloat(tk(0x52410009)));
            e.setBrightness(Float.intBitsToFloat(tk(0x5241000a)));
            engine = e;
            return true;
        } catch (Throwable t) {
            fallbackState.setValue(Boolean.TRUE);      // AGSL rejected: stay on the native backdrop
            return false;
        }
    }


    // Cover loading: a queued Kawarp is both the LOADER task and the request's Coil Target


    private static void request(int albumId, String coverUuid) {
        if (coverUuid == null || coverUuid.length() == 0 || coverUuid.equals(requestedUuid)) return;
        if (loader == null) return;             // attach() failed; retried next composition
        requestedUuid = coverUuid;
        LOADER.execute(new Kawarp(albumId, coverUuid, ++loadToken));
    }

    /**
     * TIDAL's own backdrop request (PlayerBackgroundKt.rememberBlurredArtwork)
     */
    public void run() {
        try {
            xd0.g tidal = new xd0.g(appContext, new b.a(String.valueOf(albumId), uuid),  // MARKER: R8 xd0.g b.a
                null, null, false, null, null, false);
            coil.request.h.a req = coil.request.h.a(com.tidal.android.image.coil.c.a(tidal, null));  // MARKER: R8 h.a coil.c.a
            coil.request.b d = req.b;  // MARKER: R8 req.b
            req.b = new coil.request.b(d.a, d.b, d.c, d.d, d.e, d.f, d.g, d.h,  // MARKER: R8 req.b d.a d.b d.c d.d d.e d.f d.g d.h
                d.i, d.j, CachePolicy.DISABLED);  // MARKER: R8 d.i d.j
            req.d = this;  // MARKER: R8 req.d
            loader.b(req.a());  // MARKER: R8 req.a
        } catch (Throwable t) {
            fail();
        }
    }

    /** Target.onSuccess */
    public void a(Drawable drawable) {
        if (token != loadToken) return; // user skipped on
        Bitmap cover = toBitmap(drawable);
        if (cover == null) { fail(); return; }
        // setCover copies, the bitmap stays Coil's (memory cache)
        engine.setCover(cover);
    }

    /** Target.onStart - nothing to show while loading. */
    public void b(Drawable placeholder) {}

    /** Target.onError - not in any of TIDAL's stores. */
    public void d(Drawable error) { fail(); }

    private void fail() {
        if (token == loadToken) requestedUuid = null;
    }

    private static Bitmap toBitmap(Drawable d) {
        if (d == null) return null;
        if (d instanceof BitmapDrawable) return ((BitmapDrawable) d).getBitmap();
        Bitmap out = Bitmap.createBitmap(256, 256, Bitmap.Config.ARGB_8888);
        d.setBounds(0, 0, 256, 256);
        d.draw(new Canvas(out));
        return out;
    }


    // Frame loop


    public void doFrame(long frameTimeNanos) {
        frameScheduled = false;
        // Nothing has drawn for a while: the backdrop is off-screen, so stop burning frames.
        if (SystemClock.uptimeMillis() - lastDrawUptime > IDLE_STOP_MS) return;
        frameState.setIntValue(++frameTick);
        schedule();
    }

    private static void schedule() {
        if (frameScheduled) return;
        frameScheduled = true;
        Choreographer.getInstance().postFrameCallback(DRAW);
    }

    public Object invoke(Object scope) {
        draw((DrawScope) scope);
        return kotlin.u.a;  // MARKER: R8 u.a
    }

    private static void draw(DrawScope scope) {
        // Snapshot read: this is what ties the draw phase to the frame clock.
        frameState.getIntValue();
        lastDrawUptime = SystemClock.uptimeMillis();
        schedule();

        long packed = scope.getSizeNHjbRc();
        float width = Size.getWidthImpl(packed);
        float height = Size.getHeightImpl(packed);
        try {
            engine.draw(AndroidCanvas_androidKt.getNativeCanvas(scope.getDrawContext().getCanvas()),
                width, height);
        } catch (Throwable t) {
            fallbackState.setValue(Boolean.TRUE);      // AGSL draw failed: recompose onto p3.a  // MARKER: R8 p3.a
        }
    }
}
