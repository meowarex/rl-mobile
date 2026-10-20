package radiant;

import android.content.Context;
import android.media.MediaPlayer;
import android.view.Surface;

// Fake MediaPlayer for HLS covers, ExoPlayer does the playing
public final class CoverPlayer extends MediaPlayer implements Runnable {
    private static volatile int nextW;
    private static volatile int nextH;

    private final yl0.a onFirstFrame;    // MARKER: R8 yl0.a
    private ArtPlayer art;

    private CoverPlayer(yl0.a onFirstFrame) {
        this.onFirstFrame = onFirstFrame;
    }

    // Size of the next cover, for the resolution cap
    public static void nextSize(int w, int h) {
        nextW = w;
        nextH = h;
    }

    // Null when it's not HLS, TIDAL handles it then
    public static MediaPlayer create(String url, Surface surface, yl0.a onFirstFrame) {
        if (!ArtPlayer.isStream(url)) return null;
        Context c = RLSettings.app();
        if (c == null) return null;
        CoverPlayer cp = new CoverPlayer(onFirstFrame);
        cp.art = ArtPlayer.start(c, url, surface, nextW, nextH, cp);
        return cp;
    }

    // First frame, TIDAL fades the video in
    @Override
    public void run() {
        if (onFirstFrame != null) onFirstFrame.invoke();
    }

    @Override
    public void release() {
        ArtPlayer a = art;
        art = null;
        if (a != null) a.release();
        super.release();
    }
}
