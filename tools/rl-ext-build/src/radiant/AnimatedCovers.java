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
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.LinkedHashMap;

// Animated covers, works exactly like the desktop plugin
public final class AnimatedCovers implements Runnable, yl0.p {    // MARKER: R8 yl0.p
    private static final String TAG = "RLAnimatedCovers";
    private static final String API = "https://animated-cover.appwrite.network?";
    private static final int CACHE_MAX = 200;
    private static final long FETCH_TIMEOUT_MS = 10000L;

    // Square HLS url, null if none
    static final MutableState urlState = SnapshotStateKt.mutableStateOf$default(null, null, 2, null);
    // Album the art belongs to, other albums stay static
    static final MutableState albumState = SnapshotStateKt.mutableStateOf$default(Integer.valueOf(-1), null, 2, null);

    // Hits + misses, album key for album matches
    private static final LinkedHashMap<String, String[]> cache = new LinkedHashMap<String, String[]>();

    // Play queue, for the full track info
    private static volatile Object queue;
    private static volatile String lastState;

    // Layer state, main thread only
    private static String trackId;
    // Album key if album matched, else title key
    private static String artworkKey;
    private static volatile int loadToken;
    private static String artworkUrl;
    // Tall stream for portrait covers
    private static volatile String artworkTall;
    // Errored stream, skipped until the art changes
    private static String failedSrc;

    private static Handler main;

    private static final int RESOLVE = 0;
    private static final int SET_TRACK = 1;
    private static final int FETCH = 2;
    private static final int APPLY = 3;
    private static final int FAILED = 4;
    private static final int PLACEHOLDER = 5;
    private final int mode;

    // track
    private String id, title, artist, album, isrc, url, tall, key;
    private int albumId, token;

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

    // Mini player state changed
    public static void onMediaState(String title, String artist, int albumId, String cover) {
        if (title == null || artist == null || title.isEmpty()) return;
        String state = artist + "\u0000" + title + "\u0000" + albumId;
        if (state.equals(lastState)) return;
        lastState = state;
        AnimatedCovers job = new AnimatedCovers(RESOLVE);
        job.title = title;
        job.artist = artist;
        job.albumId = albumId;
        background(job);
    }

    // Animated cover for the playing album, else TIDAL's image
    public static void cover(yl0.l request, String description, Modifier modifier, ColorFilter colorFilter,    // MARKER: R8 yl0.l
                             ContentScale contentScale, Object placeholder, yl0.a onError,    // MARKER: R8 yl0.a
                             Composer composer, int changed, int defaults, int albumId) {
        String u = urlFor(albumId);
        if (u != null) {
            composer.startReplaceGroup(0x52414143);
            AnimatedCovers ph = new AnimatedCovers(PLACEHOLDER);
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

    // Stream if it's for this album
    static String urlFor(int albumId) {
        String u = (String) urlState.getValue();
        return u != null && ((Integer) albumState.getValue()).intValue() == albumId ? u : null;
    }

    // Tall stream on portrait covers, null if broken
    static String srcFor(String url, int w, int h) {
        String tall = artworkTall;
        String src = url != null && url.equals(artworkUrl) && tall != null && w > 0 && h > w ? tall : url;
        return src != null && src.equals(failedSrc) ? null : src;
    }

    // Stream errored, hide it until the art changes
    static void onPlaybackFailed(String src) {
        AnimatedCovers f = new AnimatedCovers(FAILED);
        f.url = src;
        post(f);
    }

    // Static cover under the video
    @Override
    public Object invoke(Object composer, Object changed) {
        Modifier fill = SizeKt.fillMaxSize(Modifier.Companion, 1f);
        sd0.f.a(request, description, fill, colorFilter, contentScale, placeholder, onError, (Composer) composer, 0, defaults);
        return kotlin.u.a;    // MARKER: R8 kotlin.u
    }

    @Override
    public void run() {
        try {
            switch (mode) {
                case RESOLVE:
                    resolve();
                    break;
                case SET_TRACK:
                    setTrack();
                    break;
                case FETCH:
                    fetch();
                    break;
                case APPLY:
                    if (token == loadToken) apply(url, tall, key, albumId);
                    break;
                case FAILED:
                    if (url != null && (url.equals(artworkUrl) || url.equals(artworkTall))) {
                        Log.i(TAG, "hiding video (src: " + url + ")");
                        failedSrc = url;
                        publish();
                    }
                    break;
            }
        } catch (Throwable t) {
            Log.w(TAG, "job " + mode + " failed: " + t);
        }
    }

    // MARKER: track info (same as desktop getTrackInfo)

    // Give the queue and ISRC a moment to catch up
    private void resolve() throws InterruptedException {
        com.aspiro.wamp.model.MediaItem media = null;
        for (int i = 0; i < 15 && media == null; i++) {
            media = currentMedia(title);
            if (media == null) Thread.sleep(100L);
        }
        AnimatedCovers t = new AnimatedCovers(SET_TRACK);
        t.albumId = albumId;
        if (media == null) {
            // Queue never caught up, use the mini player's info
            t.id = "m:" + artist + "\u0000" + title + "\u0000" + albumId;
            t.title = title;
            t.artist = artist;
        } else {
            t.id = String.valueOf(media.getId());
            String base = media.getTitle() == null ? title : media.getTitle();
            String version = media instanceof com.aspiro.wamp.model.Track ? ((com.aspiro.wamp.model.Track) media).getVersion() : null;
            t.title = version != null && !version.trim().isEmpty() ? base + " (" + version + ")" : base;
            String primary = media.getArtist() != null ? media.getArtist().getName() : null;
            t.artist = primary != null && !primary.isEmpty() ? primary : artist;
            if (media.getAlbum() != null) {
                String a = media.getAlbum().getTitle();
                t.album = a == null || a.trim().isEmpty() ? null : a.trim();
            }
            // ISRC shows up a bit later, give it a moment
            for (int i = 0; i < 20 && t.isrc == null; i++) {
                t.isrc = isrcOf(t.id);
                if (t.isrc == null) Thread.sleep(100L);
            }
        }
        post(t);
    }

    // Like desktop setTrack, runs on main
    private void setTrack() {
        // Same track, keep playing
        if (id.equals(trackId)) return;
        trackId = id;
        int token = ++loadToken;
        String albumKey = album != null ? artist + "\u0000" + album : titleKey(artist, title);
        // Same album art, nothing to fetch
        if (artworkKey != null && (albumKey.equals(artworkKey) || titleKey(artist, title).equals(artworkKey))) {
            if (artworkUrl != null) {
                albumState.setValue(Integer.valueOf(albumId));
                AnimatedCoverView.refreshAll();
            }
            return;
        }
        // New art, drop the old video now
        apply(null, null, null, albumId);
        AnimatedCovers f = new AnimatedCovers(FETCH);
        f.token = token;
        f.id = id;
        f.title = title;
        f.artist = artist;
        f.album = album;
        f.isrc = isrc;
        f.albumId = albumId;
        background(f);
    }

    private static void apply(String url, String tall, String key, int albumId) {
        artworkKey = key;
        if (url == null || !url.equals(artworkUrl)) failedSrc = null;
        artworkUrl = url;
        artworkTall = tall;
        albumState.setValue(Integer.valueOf(albumId));
        publish();
    }

    private static void publish() {
        String u = artworkUrl != null && !artworkUrl.equals(failedSrc) ? artworkUrl : null;
        Object cur = urlState.getValue();
        if (u == null ? cur != null : !u.equals(cur)) urlState.setValue(u);
        AnimatedCoverView.refreshAll();
    }

    // MARKER: lookup (api.ts fetchAnimatedArtwork)

    private void fetch() {
        long deadline = System.currentTimeMillis() + FETCH_TIMEOUT_MS;
        String albumName = album == null ? "" : album.trim();
        boolean albumPresent = !albumName.isEmpty();
        // Album key, or title key without an album
        String cacheKey = albumPresent ? artist + "\u0000" + albumName : titleKey(artist, title);
        synchronized (cache) {
            if (cache.containsKey(cacheKey)) {
                String[] hit = cache.get(cacheKey);
                done(hit == null ? null : hit[0], hit == null ? null : hit[1], cacheKey);
                return;
            }
        }
        // One request, 404 means no animated art
        boolean[] timedOut = new boolean[1];
        String[] artwork = tryFetch(searchUrl(title, artist, album, isrc), deadline, timedOut);
        // Cancelled attempts don't count as misses
        if (!timedOut[0] && token == loadToken) remember(cacheKey, artwork);
        if (artwork == null) Log.i(TAG, "no animated art for \"" + title + "\"");
        done(artwork == null ? null : artwork[0], artwork == null ? null : artwork[1], cacheKey);
    }

    private void done(String found, String foundTall, String key) {
        AnimatedCovers a = new AnimatedCovers(APPLY);
        a.token = token;
        a.url = found;
        a.tall = foundTall;
        a.key = key;
        a.albumId = albumId;
        post(a);
    }

    private static void remember(String key, String[] artwork) {
        synchronized (cache) {
            if (cache.size() >= CACHE_MAX) {
                Iterator<String> it = cache.keySet().iterator();
                if (it.hasNext()) {
                    it.next();
                    it.remove();
                }
            }
            cache.put(key, artwork);
        }
    }

    // {square, tall}, either alone works
    private static String[] tryFetch(String url, long deadline, boolean[] timedOut) {
        long left = deadline - System.currentTimeMillis();
        if (left <= 0) {
            timedOut[0] = true;
            return null;
        }
        HttpURLConnection c = null;
        try {
            Log.i(TAG, "fetching " + url);
            c = (HttpURLConnection) new URL(url).openConnection();
            c.setConnectTimeout((int) left);
            c.setReadTimeout((int) left);
            int status = c.getResponseCode();
            if (status < 200 || status > 299) {
                Log.i(TAG, "fetch failed " + status + " | " + url);
                return null;
            }
            BufferedReader r = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            char[] buf = new char[4096];
            int n;
            while ((n = r.read(buf)) > 0) sb.append(buf, 0, n);
            r.close();
            JSONObject cover = new JSONObject(sb.toString()).optJSONObject("animatedCover");
            String square = cover == null ? "" : cover.optString("square", "");
            String tall = cover == null ? "" : cover.optString("tall", "");
            if (square.length() > 0) return new String[]{square, tall.length() > 0 ? tall : square};
            if (tall.length() > 0) return new String[]{tall, tall};
            Log.i(TAG, "none found | " + url);
            return null;
        } catch (SocketTimeoutException e) {
            timedOut[0] = true;
            Log.i(TAG, "request timed out | " + url);
            return null;
        } catch (Throwable t) {
            Log.i(TAG, "request error | " + url + " | " + t);
            return null;
        } finally {
            if (c != null) c.disconnect();
        }
    }

    // URLSearchParams order, title as album breaks search
    private static String searchUrl(String title, String artist, String album, String isrc) {
        String q = API + "title=" + enc(title) + "&artist=" + enc(artist);
        if (album != null && !album.trim().isEmpty()) q += "&album=" + enc(album.trim());
        if (isrc != null && !isrc.isEmpty()) q += "&isrc=" + enc(isrc);
        return q;
    }

    // Key for this exact track only
    private static String titleKey(String artist, String title) {
        return artist + "\u0000\u0000" + title;
    }

    // MARKER: helpers

    // Playing track, once the queue catches up
    private static com.aspiro.wamp.model.MediaItem currentMedia(String title) {
        try {
            Object q = queue;
            if (q == null) return null;
            com.aspiro.wamp.playqueue.q0 item = ((zh.e) q).getCurrentItem();    // MARKER: R8 zh.e q0
            if (item == null) return null;
            com.aspiro.wamp.model.MediaItem media = item.getMediaItem();
            if (media == null || media.getTitle() == null || !title.startsWith(media.getTitle())) return null;
            return media;
        } catch (Throwable t) {
            return null;
        }
    }

    private static String isrcOf(String id) {
        try {
            String i = IsrcCache.get(id);
            return i == null || i.trim().isEmpty() ? null : i.trim();
        } catch (Throwable t) {
            return null;
        }
    }

    // Same encoding as URLSearchParams
    private static String enc(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (Throwable t) {
            return s;
        }
    }

    private static void background(Runnable r) {
        Thread t = new Thread(r, "RL-AnimatedCovers");
        t.setDaemon(true);
        t.start();
    }

    private static void post(Runnable r) {
        Handler h = main;
        if (h == null) main = h = new Handler(Looper.getMainLooper());
        h.post(r);
    }
}
