package radiant;

import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.support.v4.media.MediaMetadataCompat;
import android.support.v4.media.RatingCompat;
import android.support.v4.media.session.MediaControllerCompat;
import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.media.session.PlaybackStateCompat;
import android.util.Log;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

// RL lyrics + heart to ColorOS <3
public final class OplusBridge implements Runnable {
    private static final String TAG = "RLOplus";
    private static final String KEY_LYRIC = "lyricInfo";
    private static final String KEY_CONFIG = "oplus.media.config";
    private static final String KEY_FAVORITE = "isFavorite";
    private static final String KEY_RATING = "android.media.metadata.USER_RATING";
    private static final String KEY_MEDIA_ID = "android.media.metadata.MEDIA_ID";
    private static final String KEY_TITLE = "android.media.metadata.TITLE";
    private static final String KEY_ARTIST = "android.media.metadata.ARTIST";
    private static final String FAVORITE_ACTION = "TOGGLE_FAVORITE";

    private static final Object LOCK = new Object();
    private static final Handler MAIN = new Handler(Looper.getMainLooper());

    // Let the player fetch first
    private static final long FETCH_DELAY_MS = 1500L;

    private static MediaSessionCompat session;
    // TIDAL's metadata, before we touch it
    private static MediaMetadataCompat raw;
    private static String lyricsKey;
    private static String lyricsTitle;
    private static String lyricsLines;
    private static String fetchKey;
    private static boolean ratingType;

    // Manager toggles, swapped in by build.sh
    private static int lyricsFlag() {
        return 0x0C010001;
    }

    private static int heartFlag() {
        return 0x0C010002;
    }

    // No id means republish
    private final String id;
    private final String title;
    private final String artist;

    private OplusBridge(String id, String title, String artist) {
        this.id = id;
        this.title = title;
        this.artist = artist;
    }

    // MediaSessionCompat.setMetadata
    public static MediaMetadataCompat decorate(MediaSessionCompat s, MediaMetadataCompat m) {
        // Skip the Cast session
        if (s == null || m == null || !m.containsKey(KEY_MEDIA_ID)) return m;
        try {
            String id = m.getString(KEY_MEDIA_ID);
            boolean fetch = false;
            synchronized (LOCK) {
                session = s;
                raw = m;
                // Player sleeps when locked, fetch ourselves
                if (lyricsFlag() != 0 && id != null && !id.equals(lyricsKey) && !id.equals(fetchKey)) {
                    fetchKey = id;
                    fetch = true;
                }
            }
            if (fetch) {
                Thread t = new Thread(new OplusBridge(id, m.getString(KEY_TITLE), m.getString(KEY_ARTIST)), "RLOplus");
                t.setDaemon(true);
                t.start();
            }
            boolean heart = heartFlag() != 0;
            if (heart && !ratingType) {
                ratingType = true;
                s.setRatingType(RatingCompat.RATING_HEART);
            }
            MediaMetadataCompat.Builder b = new MediaMetadataCompat.Builder(m);
            b.putString(KEY_CONFIG, "1");
            if (heart && m.containsKey(KEY_FAVORITE)) {
                b.putRating(KEY_RATING, RatingCompat.newHeartRating(m.getLong(KEY_FAVORITE) != 0L));
            }
            String info = lyricInfo(m);
            if (info != null) b.putString(KEY_LYRIC, info);
            return b.build();
        } catch (Throwable t) {
            Log.w(TAG, "decorate failed", t);
            return m;
        }
    }

    // RLAPILyricsWorker.publish
    public static void onLyrics(String key, String title, String body) {
        if (lyricsFlag() == 0) return;
        String lines = null;
        try {
            lines = toLines(body);
        } catch (Throwable t) {
            Log.w(TAG, "lyrics parse failed", t);
        }
        synchronized (LOCK) {
            lyricsKey = key;
            lyricsTitle = title;
            lyricsLines = lines;
        }
        MAIN.post(new OplusBridge(null, null, null));
    }

    @Override
    public void run() {
        if (id != null) {
            fetch();
            return;
        }
        republish();
    }

    // Same lookup as RLAPILyricsWorker
    private void fetch() {
        try {
            Thread.sleep(FETCH_DELAY_MS);
            if (!stillWanted()) return;
            if (title == null || title.trim().length() == 0) return;
            String a = artist == null ? "" : artist;
            int comma = a.indexOf(", ");
            if (comma > 0) a = a.substring(0, comma);
            StringBuilder q = new StringBuilder("?title=");
            q.append(RLAPILyricsWorker.uric(title));
            q.append("&artist=").append(RLAPILyricsWorker.uric(a));
            String isrc = IsrcCache.get(id);
            if (isrc != null && isrc.trim().length() > 0) q.append("&isrc=").append(RLAPILyricsWorker.uric(isrc.trim()));
            q.append(RLLyrics.queryExtras());
            q.append("&platform=rl-mobile");
            String body = RLAPILyricsWorker.fetch("https://api.radiant-lyrics.org/rl-api" + q, true);
            if (body == null) body = RLAPILyricsWorker.fetch("https://rl-api.kineticsand.net/lyrics" + q, false);
            if (body == null || !stillWanted()) return;
            onLyrics(id, title, RLLyrics.normalize(body));
        } catch (Throwable t) {
            Log.w(TAG, "fetch failed", t);
        }
    }

    // Still playing and not fetched yet
    private boolean stillWanted() {
        synchronized (LOCK) {
            return id.equals(fetchKey) && !id.equals(lyricsKey);
        }
    }

    // Lyrics land late, push metadata again
    private void republish() {
        MediaSessionCompat s;
        MediaMetadataCompat m;
        synchronized (LOCK) {
            s = session;
            m = raw;
        }
        if (s == null || m == null || !matches(m)) return;
        try {
            s.setMetadata(m);
        } catch (Throwable t) {
            Log.w(TAG, "republish failed", t);
        }
    }

    // Heart taps (MediaSessionCompat onSetRating)
    public static void onSetRating(MediaSessionCompat.Callback cb, RatingCompat r) {
        try {
            if (heartFlag() == 0 || cb == null || r == null || r.getRatingStyle() != RatingCompat.RATING_HEART) return;
            MediaSessionCompat s;
            synchronized (LOCK) {
                s = session;
            }
            if (s == null) return;
            MediaControllerCompat c = s.getController();
            MediaMetadataCompat m = c.getMetadata();
            boolean fav = m != null && m.getLong(KEY_FAVORITE) != 0L;
            if (fav == r.hasHeart()) return;
            PlaybackStateCompat st = c.getPlaybackState();
            List<PlaybackStateCompat.CustomAction> actions = st == null ? null : st.getCustomActions();
            if (actions == null) return;
            for (int i = 0; i < actions.size(); i++) {
                String a = actions.get(i).getAction();
                if (a != null && a.endsWith(FAVORITE_ACTION)) {
                    cb.onCustomAction(a, (Bundle) null);
                    return;
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "rating failed", t);
        }
    }

    private static boolean matches(MediaMetadataCompat m) {
        String key;
        String title;
        synchronized (LOCK) {
            key = lyricsKey;
            title = lyricsTitle;
        }
        if (key == null) return false;
        String id = m.getString(KEY_MEDIA_ID);
        if (id != null) return id.equals(key);
        return title != null && title.equals(m.getString(KEY_TITLE));
    }

    private static String lyricInfo(MediaMetadataCompat m) throws Exception {
        String key;
        String lines;
        synchronized (LOCK) {
            key = lyricsKey;
            lines = lyricsLines;
        }
        if (lines == null || !matches(m)) return null;
        JSONObject o = new JSONObject();
        o.put("songId", key);
        o.put("songName", m.getString(KEY_TITLE));
        o.put("artist", m.getString(KEY_ARTIST));
        o.put("lyric", lines);
        return o.toString();
    }

    // RL API body to ColorOS lines
    private static String toLines(String body) throws Exception {
        if (body == null) return null;
        JSONArray data = new JSONObject(body).optJSONArray("data");
        if (data == null || data.length() == 0) return null;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < data.length(); i++) {
            JSONObject line = data.optJSONObject(i);
            if (line == null) continue;
            String text = WordLyrics.lineText(line);
            if (text == null) continue;
            text = text.replace('\n', ' ').trim();
            if (text.length() == 0) continue;
            long t = (long) (line.optDouble("startTime", 0.0) * 1000.0);
            // Prefer the first syllable time
            JSONArray syl = line.optJSONArray("syllabus");
            if (syl != null && syl.length() > 0) {
                JSONObject first = syl.optJSONObject(0);
                long st = first == null ? -1L : first.optLong("time", -1L);
                if (st >= 0L) t = st;
            }
            JSONObject seg = new JSONObject();
            seg.put("tx", text);
            JSONObject out = new JSONObject();
            out.put("t", t);
            out.put("c", new JSONArray().put(seg));
            if (sb.length() > 0) sb.append('\n');
            sb.append(out.toString());
        }
        if (sb.length() == 0) return null;
        Log.i(TAG, "lyrics ready: " + data.length() + " lines");
        return sb.toString();
    }
}
