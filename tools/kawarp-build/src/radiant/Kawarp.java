package radiant;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.SystemClock;
import android.util.Log;
import android.view.Choreographer;

import androidx.compose.foundation.layout.SizeKt;
import androidx.compose.foundation.layout.SpacerKt;
import androidx.compose.runtime.Composer;
import androidx.compose.runtime.MutableState;
import androidx.compose.runtime.SnapshotStateKt;
import androidx.compose.ui.Modifier;
import androidx.compose.ui.draw.DrawModifierKt;
import androidx.compose.ui.geometry.Size;
import androidx.compose.ui.graphics.AndroidCanvas_androidKt;
import androidx.compose.ui.graphics.drawscope.DrawScope;

import com.tidal.android.feature.playerscreen.ui.composables.p3;
import com.tidal.android.feature.playerscreen.ui.model.PlayerBackgroundStyle;

import dev.kawarp.KawarpEngine;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * MARKER: Kawarp Backdrop - TIDAL glue over dev.kawarp.KawarpEngine (Kawarp-AGSL library)
 *
 * The engine (shader, blur pipeline, settings, crossfade) lives in the Kawarp-AGSL library
 * (cloned at tools/kawarp-agsl) and is compiled into this bundle by tools/kawarp-build/build.sh;
 * this class only holds what is TIDAL/Compose-specific:
 * the patched-in composable entry points, cover fetching by TIDAL uuid, the Choreographer ->
 * snapshot-state frame clock, the Manager's option tokens, and the fallback to TIDAL's own
 * blurred backdrop.
 *
 * One class on purpose (its own draw lambda, frame callback and loader) - see the engine's
 * class doc for the dex-injection constraints.
 */
public final class Kawarp implements am0.l, Runnable, Choreographer.FrameCallback {

    private static final String TAG = "RLKawarp";
    /** Stop the frame loop once nothing has drawn for this long (player left / backgrounded). */
    private static final long IDLE_STOP_MS = 500L;

    /**
     * Patch option plumbing. The 0x5241xxxx literals are sentinels that build.sh rewrites into
     * __RL_*__ placeholders for the Manager to substitute; routing them through tk() stops javac
     * constant-folding them out of existence.
     */
    private static int tk(int v) { return v; }

    private static final ExecutorService LOADER = Executors.newSingleThreadExecutor();

    /** Bumped every frame so the draw lambda's snapshot read invalidates the draw phase. */
    private static final MutableState frameState =
        SnapshotStateKt.mutableStateOf$default(Integer.valueOf(0), null, 2, null);
    /** Flips true on any shader failure; read during composition so we recompose onto p3.a. */
    private static final MutableState fallbackState =
        SnapshotStateKt.mutableStateOf$default(Boolean.FALSE, null, 2, null);

    /** The shared instance render passes to drawBehind (also serves as the frame callback). */
    private static final Kawarp DRAW = new Kawarp(null, 0);

    private static KawarpEngine engine;
    private static volatile String requestedUuid;
    private static volatile int loadToken;

    private static long lastDrawUptime;
    private static boolean frameScheduled, loggedDraw;
    private static int frameTick;

    /** Set when this instance is a queued cover load; null/0 on the shared DRAW instance. */
    private final String uuid;
    private final int token;

    private Kawarp(String uuid, int token) {
        this.uuid = uuid;
        this.token = token;
    }

    
    // Composition


    /**
     * Drop-in replacement for TIDAL's PlayerBackground composable (p3.b) - the patch redirects
     * the call site here so the whole backdrop works <3
     */
    public static void b(PlayerBackgroundStyle style, long color, int albumId, String coverUuid,
                         boolean isPlaying, boolean isSeeking, am0.a progress, Modifier modifier,
                         Composer composer, int changed) {
        render(albumId, coverUuid, isPlaying, modifier, composer);
    }

    /** Shared by the player screen and by Cover Everywhere (radiant/HomeBackdrop). */
    public static void render(int albumId, String coverUuid, boolean isPlaying,
                              Modifier modifier, Composer composer) {
        composer.startReplaceGroup(0x52415750);
        boolean ok = !((Boolean) fallbackState.getValue()).booleanValue() && ensureEngine();
        if (!ok) {
            // No (working) AGSL here - fall back to TIDAL's own blurred backdrop.
            p3.a(albumId, coverUuid, isPlaying, false, null, modifier, composer, 0);
        } else {
            engine.setPlaying(isPlaying);
            request(coverUuid);
            Modifier m = DrawModifierKt.drawBehind(SizeKt.fillMaxSize(modifier, 1.0f), DRAW);
            SpacerKt.Spacer(m, composer, 0);
        }
        composer.endReplaceGroup();
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
            Log.i(TAG, "AGSL rejected, staying on the native backdrop: " + t);
            fallbackState.setValue(Boolean.TRUE);
            return false;
        }
    }

    
    // Cover loading (Runnable on LOADER)
    

    private static void request(String coverUuid) {
        if (coverUuid == null || coverUuid.length() == 0 || coverUuid.equals(requestedUuid)) return;
        requestedUuid = coverUuid;
        LOADER.execute(new Kawarp(coverUuid, ++loadToken));
    }

    public void run() {
        HttpURLConnection connection = null;
        try {
            // Same URL shape TIDAL itself builds in he0.a; 640 is plenty ahead of a 128 downscale.
            URL url = new URL("https://resources.tidal.com/images/"
                + uuid.replace('-', '/') + "/640x640.jpg");
            connection = (HttpURLConnection) url.openConnection();
            connection.setConnectTimeout(10000);
            connection.setReadTimeout(15000);
            InputStream stream = connection.getInputStream();
            Bitmap source;
            try {
                source = BitmapFactory.decodeStream(stream);
            } finally {
                stream.close();
            }
            if (source == null || token != loadToken) return;
            engine.setCover(source);
            source.recycle();
            Log.i(TAG, "cover submitted: " + uuid);
        } catch (Throwable t) {
            Log.i(TAG, "cover load failed: " + t);
            // Let the next track (or a re-entry into the player) retry this cover.
            if (token == loadToken) requestedUuid = null;
        } finally {
            if (connection != null) connection.disconnect();
        }
    }

   
    // Frame loop


    public void doFrame(long frameTimeNanos) {
        frameScheduled = false;
        // Nothing has drawn for a while: the backdrop is off-screen, so stop burning frames.
        if (SystemClock.uptimeMillis() - lastDrawUptime > IDLE_STOP_MS) return;
        frameState.setValue(Integer.valueOf(++frameTick));
        schedule();
    }

    private static void schedule() {
        if (frameScheduled) return;
        frameScheduled = true;
        Choreographer.getInstance().postFrameCallback(DRAW);
    }

    public Object invoke(Object scope) {
        draw((DrawScope) scope);
        return kotlin.u.a;
    }

    private static void draw(DrawScope scope) {
        // Snapshot read: this is what ties the draw phase to the frame clock.
        frameState.getValue();
        lastDrawUptime = SystemClock.uptimeMillis();
        schedule();

        long packed = scope.getSizeNHjbRc();
        float width = Size.getWidthImpl(packed);
        float height = Size.getHeightImpl(packed);
        if (!loggedDraw) {
            loggedDraw = true;
            Log.i(TAG, "first draw: " + width + "x" + height + " ready=" + engine.isReady());
        }
        try {
            engine.draw(AndroidCanvas_androidKt.getNativeCanvas(scope.getDrawContext().getCanvas()),
                width, height);
        } catch (Throwable t) {
            Log.i(TAG, "AGSL draw failed, falling back: " + t);
            fallbackState.setValue(Boolean.TRUE);
        }
    }
}
