package radiant;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.compose.foundation.layout.SizeKt;
import androidx.compose.runtime.Composer;
import androidx.compose.runtime.MutableState;
import androidx.compose.runtime.SnapshotStateKt;
import androidx.compose.ui.Modifier;
import androidx.compose.ui.graphics.ColorFilter;
import androidx.compose.ui.layout.ContentScale;

import com.tidal.android.core.compose.components.l;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.LinkedHashMap;

// Animated covers, played with TIDAL's own AnimatedCover
public final class AnimatedCovers implements Runnable, yl0.p {    // MARKER: R8 yl0.p
    private static final String TAG = "RLAnimatedCovers";
    private static final String SEARCH = "https://ama.trainswift.net/api/v1/artwork/search?";
    private static final int TARGET_PX = 700;
    private static final int CACHE_MAX = 200;

    // Animated cover URL for the playing track
    static final MutableState urlState = SnapshotStateKt.mutableStateOf$default(null, null, 2, null);
    // Album the URL belongs to
    static final MutableState albumState = SnapshotStateKt.mutableStateOf$default(Integer.valueOf(-1), null, 2, null);

    private static final LinkedHashMap<String, String> cache = new LinkedHashMap<String, String>(64, 0.75f, true);
    private static volatile String currentKey;
    // Play queue, for the album name
    private static volatile Object queue;

    private static final int MODE_LOOKUP = 0;
    private static final int MODE_PUBLISH = 1;
    private static final int MODE_PLACEHOLDER = 2;
    private final int mode;

    // lookup
    private String key, title, artist, album, url;
    private int albumId;

    // normal cover under the video
    private yl0.l request;    // MARKER: R8 yl0.l
    private String description;
    private ColorFilter colorFilter;
    private ContentScale contentScale;
    private Object placeholder;
    private yl0.a onError;    // MARKER: R8 yl0.a
    private int defaults;

    private AnimatedCovers(int mode) {
        this.mode = mode;
    }

    // Keep the play queue
    public static void setQueue(Object playQueue) {
        queue = playQueue;
    }

    // Track changed, look it up
    public static void onMediaState(String title, String artist, int albumId, String cover) {
        if (title == null || artist == null || title.isEmpty()) return;
        String key = artist + "\u0000" + title;
        if (key.equals(currentKey)) return;
        currentKey = key;
        publish(key, null, albumId);
        String hit;
        synchronized (cache) {
            hit = cache.get(key);
        }
        if (hit != null) {
            publish(key, hit.isEmpty() ? null : hit, albumId);
            return;
        }
        AnimatedCovers job = new AnimatedCovers(MODE_LOOKUP);
        job.key = key;
        job.title = title;
        job.artist = artist;
        job.album = currentAlbum(title);
        job.albumId = albumId;
        Thread t = new Thread(job, "RL-AnimatedCovers");
        t.setDaemon(true);
        t.start();
    }

    // Animated cover if we have one, else TIDAL's image
    public static void cover(yl0.l request, String description, Modifier modifier, ColorFilter colorFilter,    // MARKER: R8 yl0.l
                             ContentScale contentScale, Object placeholder, yl0.a onError,    // MARKER: R8 yl0.a
                             Composer composer, int changed, int defaults, int albumId) {
        String u = (String) urlState.getValue();
        int playing = ((Integer) albumState.getValue()).intValue();
        if (u != null && playing == albumId) {
            composer.startReplaceGroup(0x52414143);
            AnimatedCovers ph = new AnimatedCovers(MODE_PLACEHOLDER);
            ph.request = request;
            ph.description = description;
            ph.colorFilter = colorFilter;
            ph.contentScale = contentScale;
            ph.placeholder = placeholder;
            ph.onError = onError;
            ph.defaults = defaults;
            l.a(u, modifier, ph, composer, 0);
            composer.endReplaceGroup();
        } else {
            composer.startReplaceGroup(0x52414144);
            sd0.f.a(request, description, modifier, colorFilter, contentScale, placeholder, onError, composer, changed, defaults);
            composer.endReplaceGroup();
        }
    }

    // URL if it's for this album
    static String urlFor(int albumId) {
        String u = (String) urlState.getValue();
        return u != null && ((Integer) albumState.getValue()).intValue() == albumId ? u : null;
    }

    // Normal cover as the placeholder
    @Override
    public Object invoke(Object composer, Object changed) {
        Modifier fill = SizeKt.fillMaxSize(Modifier.Companion, 1f);
        sd0.f.a(request, description, fill, colorFilter, contentScale, placeholder, onError, (Composer) composer, 0, defaults);
        return kotlin.u.a;    // MARKER: R8 kotlin.u
    }

    @Override
    public void run() {
        if (mode == MODE_PUBLISH) {
            // Newer track, drop it
            if (!key.equals(currentKey)) return;
            urlState.setValue(url);
            albumState.setValue(Integer.valueOf(albumId));
            AnimatedCoverView.refreshAll();
            return;
        }
        String found = null;
        try {
            // Queue can lag, try once more
            if (album == null) {
                Thread.sleep(800L);
                album = currentAlbum(title);
            }
            // With album first, then without
            if (album != null) found = lookup(title, artist, album);
            if (found == null) found = lookup(title, artist, null);
        } catch (Throwable t) {
            Log.w(TAG, "lookup failed for " + title + ": " + t);
        }
        synchronized (cache) {
            if (cache.size() >= CACHE_MAX) {
                String eldest = cache.keySet().iterator().next();
                cache.remove(eldest);
            }
            cache.put(key, found == null ? "" : found);
        }
        Log.i(TAG, (found == null ? "no animated cover for " : "animated cover for ") + title);
        publish(key, found, albumId);
    }

    private static void publish(String key, String url, int albumId) {
        AnimatedCovers p = new AnimatedCovers(MODE_PUBLISH);
        p.key = key;
        p.url = url;
        p.albumId = albumId;
        new Handler(Looper.getMainLooper()).post(p);
    }

    // Album name of the playing track
    private static String currentAlbum(String title) {
        try {
            Object q = queue;
            if (q == null) return null;
            com.aspiro.wamp.playqueue.q0 item = ((zh.e) q).getCurrentItem();    // MARKER: R8 zh.e q0
            if (item == null) return null;
            com.aspiro.wamp.model.MediaItem media = item.getMediaItem();
            if (media == null || !title.equals(media.getTitle()) || media.getAlbum() == null) return null;
            String a = media.getAlbum().getTitle();
            return a == null || a.trim().isEmpty() ? null : a.trim();
        } catch (Throwable t) {
            return null;
        }
    }

    private static String lookup(String title, String artist, String album) throws Exception {
        String q = SEARCH + "title=" + enc(title) + "&artist=" + enc(artist);
        if (album != null) q = q + "&album=" + enc(album);
        String body = get(q);
        if (body == null) return null;
        JSONObject o = new JSONObject(body);
        String master = o.optString("url", "");
        if (master.isEmpty()) return null;
        return resolveMp4(master);
    }

    // Find the mp4 behind the playlist
    private static String resolveMp4(String masterUrl) throws Exception {
        String master = get(masterUrl);
        if (master == null) return null;
        String[] lines = master.split("\n");
        String best = null;
        int bestW = -1;
        boolean bestBig = false;
        for (int i = 0; i < lines.length - 1; i++) {
            String line = lines[i].trim();
            if (!line.startsWith("#EXT-X-STREAM-INF:") || line.indexOf("avc1") < 0) continue;
            if (line.indexOf("VIDEO-RANGE=SDR") < 0 && line.indexOf("VIDEO-RANGE") >= 0) continue;
            int w = 0;
            int r = line.indexOf("RESOLUTION=");
            if (r >= 0) {
                int x = line.indexOf('x', r);
                try {
                    w = Integer.parseInt(line.substring(r + 11, x));
                } catch (Throwable ignored) {
                }
            }
            String uri = lines[i + 1].trim();
            if (uri.isEmpty() || uri.startsWith("#")) continue;
            boolean big = w >= TARGET_PX;
            // Smallest one big enough
            if (best == null || (big && (!bestBig || w < bestW)) || (!big && !bestBig && w > bestW)) {
                best = new URL(new URL(masterUrl), uri).toString();
                bestW = w;
                bestBig = big;
            }
        }
        if (best == null) return null;
        String media = get(best);
        if (media == null) return null;
        int m = media.indexOf("#EXT-X-MAP:URI=\"");
        if (m < 0) return null;
        int s = m + 16;
        int e = media.indexOf('"', s);
        if (e < 0) return null;
        return new URL(new URL(best), media.substring(s, e)).toString();
    }

    private static String get(String url) throws Exception {
        HttpURLConnection c = (HttpURLConnection) new URL(url).openConnection();
        c.setConnectTimeout(10000);
        c.setReadTimeout(10000);
        try {
            if (c.getResponseCode() != 200) return null;
            BufferedReader r = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            char[] buf = new char[4096];
            int n;
            while ((n = r.read(buf)) > 0) sb.append(buf, 0, n);
            r.close();
            return sb.toString();
        } finally {
            c.disconnect();
        }
    }

    private static String enc(String s) throws Exception {
        return URLEncoder.encode(s, "UTF-8").replace("+", "%20");
    }
}
