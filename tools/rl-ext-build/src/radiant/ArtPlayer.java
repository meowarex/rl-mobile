package radiant;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.Surface;

import androidx.media3.common.Format;
import androidx.media3.common.MediaItem;
import androidx.media3.common.PlaybackException;
import androidx.media3.common.Player;
import androidx.media3.common.TrackSelectionParameters;
import androidx.media3.common.Tracks;
import androidx.media3.datasource.DefaultDataSource;
import androidx.media3.exoplayer.ExoPlayer;
import androidx.media3.exoplayer.hls.HlsMediaSource;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;

// Animated cover playback, same as desktop ArtworkSurface
public final class ArtPlayer implements Player.Listener, Application.ActivityLifecycleCallbacks {
    private static final String TAG = "RLAnimatedCovers";
    static final int NATIVE_FPS = 25;

    private static final ArrayList<WeakReference<ArtPlayer>> live = new ArrayList<WeakReference<ArtPlayer>>();
    private static boolean lifecycleHooked;
    private static int startedActivities = 1;

    private final String src;
    private final Runnable onFirstFrame;
    private ExoPlayer exo;
    private float nativeFps = NATIVE_FPS;
    private boolean released;

    private ArtPlayer(String src, Runnable onFirstFrame) {
        this.src = src;
        this.onFirstFrame = onFirstFrame;
    }

    // HLS playlist from the artwork API
    static boolean isStream(String url) {
        return url != null && url.toLowerCase().contains(".m3u8");
    }

    // Cover size for the cap, 0 if unknown
    static ArtPlayer start(Context context, String src, Surface surface, int widthPx, int heightPx, Runnable onFirstFrame) {
        ArtPlayer p = new ArtPlayer(src, onFirstFrame);
        try {
            p.build(context, surface, widthPx, heightPx);
        } catch (Throwable t) {
            Log.w(TAG, "player failed for " + src + ": " + t);
            p.release();
            AnimatedCovers.onPlaybackFailed(src);
            return null;
        }
        return p;
    }

    private void build(Context context, Surface surface, int widthPx, int heightPx) {
        hookLifecycle(context);
        ExoPlayer player = new ExoPlayer.Builder(context).build();
        exo = player;
        // H.264 only, capped to the cover like hls.js
        float density = context.getResources().getDisplayMetrics().density;
        int w = widthPx > 0 ? Math.max(1, Math.round(widthPx / density)) : 0;
        int h = heightPx > 0 ? Math.max(1, Math.round(heightPx / density)) : 0;
        TrackSelectionParameters.Builder params = player.getTrackSelectionParameters().buildUpon()
                .setPreferredVideoMimeType("video/avc");
        if (w > 0 && h > 0) params.setViewportSize(w, h, false);
        player.setTrackSelectionParameters(params.build());
        player.setVideoSurface(surface);
        player.setVolume(0f);
        player.setRepeatMode(Player.REPEAT_MODE_ALL);
        player.addListener(this);
        MediaItem item = new MediaItem.Builder().setUri(src).setMimeType("application/x-mpegURL").build();
        player.setMediaSource(new HlsMediaSource.Factory(new DefaultDataSource.Factory(context)).createMediaSource(item));
        player.prepare();
        applyRate();
        synchronized (live) {
            live.add(new WeakReference<ArtPlayer>(this));
        }
        ensurePlaying();
    }

    // FPS via playback rate, like desktop
    private void applyRate() {
        ExoPlayer player = exo;
        if (player == null) return;
        int target = ArtDefaults.fps();
        if (target <= 0) target = NATIVE_FPS;
        float rate = Math.min(1f, Math.max(0.05f, target / nativeFps));
        player.setPlaybackSpeed(rate);
    }

    private void ensurePlaying() {
        ExoPlayer player = exo;
        if (player == null || released) return;
        if (startedActivities > 0) player.play();
        else player.pause();
    }

    void release() {
        if (released) return;
        released = true;
        ExoPlayer player = exo;
        exo = null;
        if (player != null) {
            try {
                player.release();
            } catch (Throwable ignored) {
            }
        }
    }

    @Override
    public void onRenderedFirstFrame() {
        if (released) return;
        if (onFirstFrame != null) onFirstFrame.run();
    }

    @Override
    public void onTracksChanged(Tracks tracks) {
        ExoPlayer player = exo;
        if (player == null) return;
        try {
            Format f = player.getVideoFormat();
            if (f != null && f.frameRate > 0f) nativeFps = f.frameRate;
        } catch (Throwable ignored) {
        }
        applyRate();
    }

    @Override
    public void onPlayerError(PlaybackException error) {
        Log.w(TAG, "playback error, hiding video (src: " + src + "): " + error);
        release();
        AnimatedCovers.onPlaybackFailed(src);
    }

    // MARKER: app visibility (desktop pauses on document.hidden)

    private static void hookLifecycle(Context context) {
        if (lifecycleHooked) return;
        Context app = context.getApplicationContext();
        if (!(app instanceof Application)) return;
        lifecycleHooked = true;
        ((Application) app).registerActivityLifecycleCallbacks(new ArtPlayer(null, null));
    }

    private static void syncAll() {
        synchronized (live) {
            Iterator<WeakReference<ArtPlayer>> it = live.iterator();
            while (it.hasNext()) {
                ArtPlayer p = it.next().get();
                if (p == null || p.released) it.remove();
                else p.ensurePlaying();
            }
        }
    }

    @Override
    public void onActivityStarted(Activity a) {
        startedActivities++;
        if (startedActivities == 1) syncAll();
    }

    @Override
    public void onActivityStopped(Activity a) {
        startedActivities = Math.max(0, startedActivities - 1);
        if (startedActivities == 0) syncAll();
    }

    @Override
    public void onActivityCreated(Activity a, Bundle b) {}

    @Override
    public void onActivityResumed(Activity a) {}

    @Override
    public void onActivityPaused(Activity a) {}

    @Override
    public void onActivitySaveInstanceState(Activity a, Bundle b) {}

    @Override
    public void onActivityDestroyed(Activity a) {}
}
