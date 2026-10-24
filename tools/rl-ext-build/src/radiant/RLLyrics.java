package radiant;

import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.widget.Toast;

import androidx.compose.runtime.MutableState;
import androidx.compose.runtime.SnapshotStateKt;
import androidx.compose.ui.graphics.Brush;
import androidx.compose.ui.graphics.ColorKt;
import androidx.compose.ui.text.AnnotatedString;

import com.aspiro.wamp.model.Track;

import org.json.JSONArray;
import org.json.JSONObject;

// RL API lyrics state, translations, flush and Sylla
public final class RLLyrics {
    private static final String API = "https://api.radiant-lyrics.org/";

    // Current track id + Track for the menu header
    static volatile String trackKey;
    static volatile Track track;

    // Last published body, what Sylla align retimes
    static volatile String body;
    static volatile boolean bodyIsLine;
    // "Align" / "Generate" for Sylla lyrics
    static volatile String aiType;

    // Translation per line, timed words in source order
    private static volatile String[] trans;
    private static volatile String[][] twText;
    private static volatile long[][] twStart;
    private static volatile long[][] twDur;

    // Bump to recompose every line
    static final MutableState version = SnapshotStateKt.mutableStateOf$default(Integer.valueOf(0), null, 2, null);
    private static volatile int versionPending;

    // Sylla actually said no, not a network failure
    private static final ThreadLocal<Boolean> syllaRefused = new ThreadLocal<Boolean>();

    // Body this worker just fetched, for onNoLyrics
    private static final ThreadLocal<String> rawBody = new ThreadLocal<String>();

    // Track changed, in-flight Sylla results get dropped
    static volatile int syllaEpoch;
    // Track that already had its auto Sylla job
    private static volatile String autoSyllaTrack;
    static volatile boolean autoSyllaRunning;
    private static volatile Object autoSyllaJob;
    // Flushed track, next flush retimes with Sylla
    static volatile String retimeTrack;
    // Flush or retime running
    static volatile boolean busy;

    // Sylla waits 5s from song start (skip spam)
    private static final long SYLLA_SETTLE_MS = 5000;
    // Changes this close = skipping
    private static final long SKIP_WINDOW_MS = 5000;
    // Hold the lookup while skipping
    private static final long LYRICS_SETTLE_MS = 1500;
    // When this track started
    private static volatile long trackStartedAt;
    private static volatile boolean skipping;

    private static Handler main;

    private RLLyrics() {}

    // MARKER: hooks (RLAPILyricsHook / RLAPILyricsWorker)

    // New track in the player
    public static void onTrack(Track t, String key) {
        RLSettings.rlActive = true;
        track = t;
        if (key == null || key.equals(trackKey)) return;
        trackKey = key;
        long now = SystemClock.elapsedRealtime();
        skipping = now - trackStartedAt < SKIP_WINDOW_MS;
        trackStartedAt = now;
        synchronized (RLLyrics.class) {
            lastState = null;
            lastStateKey = null;
        }
        syllaEpoch++;
        autoSyllaTrack = null;
        autoSyllaRunning = false;
        retimeTrack = null;
        busy = false;
        body = null;
        bodyIsLine = false;
        aiType = null;
        trans = null;
        twText = null;
        twStart = null;
        twDur = null;
        SparkleIcons.resetWork();
        AiSparkle.set(false);
        bump();
    }

    // Wait out skip spam (false = skipped)
    public static boolean settleLookup(RLAPILyricsWorker w) {
        if (!skipping) return true;
        sleep(LYRICS_SETTLE_MS);
        if (!w.key.equals(trackKey)) return false;
        skipping = false;
        return true;
    }

    // MARKER: player instances (TIDAL runs several per track)

    private static final java.util.WeakHashMap<Object, String> vms = new java.util.WeakHashMap<Object, String>();
    // Last published state, for instances that show up later
    private static Object lastState;
    private static String lastStateKey;

    public static synchronized void registerVm(Object vm, String key) {
        if (vm != null && key != null) vms.put(vm, key);
    }

    // True = new track, caller fetches it
    public static synchronized boolean claimTrack(String key) {
        if (key.equals(RLAPILyricsHook.currentKey)) return false;
        RLAPILyricsHook.currentKey = key;
        return true;
    }

    // Instance is on the current RL track
    public static synchronized boolean ownsVm(Object vm) {
        String k = vm == null ? null : vms.get(vm);
        return k != null && k.equals(RLAPILyricsHook.currentKey);
    }

    // Same state into every other instance on this track
    public static void broadcast(RLAPILyricsWorker w, Object state) {
        java.util.ArrayList<Object> targets = new java.util.ArrayList<Object>();
        synchronized (RLLyrics.class) {
            lastState = state;
            lastStateKey = w.key;
            for (java.util.Map.Entry<Object, String> e : vms.entrySet()) {
                if (e.getKey() != w.vm && w.key.equals(e.getValue())) targets.add(e.getKey());
            }
        }
        for (Object vm : targets) {
            try {
                RLAPILyricsWorker.pushTo((com.tidal.android.feature.playerscreen.ui.PlayerViewModel) vm, state);
            } catch (Throwable t) {
                RLAPILyricsHook.dlog("broadcast failed: " + t);
            }
        }
        if (!targets.isEmpty()) RLAPILyricsHook.dlog("lyrics shared with " + targets.size() + " more player instance(s)");
    }

    // Late instance, give it what we already have
    public static void catchUp(Object vm, String key) {
        Object state;
        synchronized (RLLyrics.class) {
            state = key.equals(lastStateKey) ? lastState : null;
        }
        if (state == null || !RLAPILyricsHook.isRlState) return;
        try {
            RLAPILyricsWorker.pushTo((com.tidal.android.feature.playerscreen.ui.PlayerViewModel) vm, state);
        } catch (Throwable t) {
            RLAPILyricsHook.dlog("catchUp failed: " + t);
        }
    }

    // Extra rl-api query params
    public static String queryExtras() {
        StringBuilder q = new StringBuilder();
        if (RLSettings.romanize()) q.append("&romanize=true");
        q.append("&ai-preference=").append(RLSettings.allowAI());
        if (RLSettings.translate()) {
            q.append("&translate=true&language=").append(RLAPILyricsWorker.uric(RLSettings.language()));
        }
        return q.toString();
    }

    // Lyrics about to be published
    public static void onBody(RLAPILyricsWorker w, String b) {
        JSONObject o;
        try {
            o = new JSONObject(b);
        } catch (Throwable t) {
            return;
        }
        String type = o.optString("type", "");
        body = b;
        bodyIsLine = "Line".equals(type);

        // Sparkle only for Sylla lyrics
        String st = o.optBoolean("_synthesized", false) ? o.optString("_synthesisType", "") : "";
        aiType = "Align".equals(st) || "Generate".equals(st) ? st : null;
        AiSparkle.set(aiType != null && RLSettings.allowAI());
        if (aiType != null) {
            RLAPILyricsHook.dlog("Sylla " + aiType + " lyrics (" + o.optString("_modelVersion", o.optString("_model", "?"))
                    + ", conf " + o.optString("_confidence", "?") + ")");
        }
        if (RLSettings.translate() && o.has("_translated") && !o.optBoolean("_translated", true)) {
            RLAPILyricsHook.dlog("RL API: translation failed | " + o.optString("_translationError", ""));
        }
        readTranslations(o.optJSONArray("data"));
        bump();

        // Line only, Radiant AI aligns it in the background
        if (bodyIsLine) autoSylla(w, "align", b);
    }

    // Nothing from rl-api, true = Sylla gen running
    // True = lyrics kept, worker skips failCurrent
    public static boolean onNoLyrics(RLAPILyricsWorker w) {
        String raw = rawBody.get();
        rawBody.remove();
        if (republish(w)) return true;
        // Untimed lyrics, align the text first, gen if that fails
        if (isUntimed(raw)) autoSylla(w, "untimed", raw);
        else autoSylla(w, "gen", null);
        return false;
    }

    // Plain text lyrics, no timing
    private static boolean isUntimed(String raw) {
        if (raw == null) return false;
        try {
            JSONObject o = new JSONObject(raw);
            JSONArray d = o.optJSONArray("data");
            return "None".equals(o.optString("type")) && d != null && d.length() > 0;
        } catch (Throwable t) {
            return false;
        }
    }

    // Same track came back empty, put the last lyrics back
    static boolean republish(RLAPILyricsWorker w) {
        String b = body;
        if (b == null || w == null || !w.key.equals(trackKey)) return false;
        RLAPILyricsHook.dlog("rl-api empty for " + w.key + ", keeping the last lyrics");
        return w.publish(b);
    }

    // MARKER: translations

    private static void readTranslations(JSONArray data) {
        if (data == null) {
            trans = null;
            twText = null;
            twStart = null;
            twDur = null;
            return;
        }
        int n = data.length();
        String[] t = new String[n];
        String[][] wt = new String[n][];
        long[][] ws = new long[n][];
        long[][] wd = new long[n][];
        boolean any = false;
        for (int i = 0; i < n; i++) {
            JSONObject line = data.optJSONObject(i);
            if (line == null) continue;
            String tr = line.optString("translation", "");
            if (line.isNull("translation") || tr.length() == 0) continue;
            // Same as the line already, skip it
            if (lettersOnly(tr).equals(lettersOnly(line.optString("text", "")))) continue;
            t[i] = tr;
            any = true;
            JSONArray syl = line.optJSONArray("translationSyllabus");
            if (syl == null || syl.length() == 0) continue;
            int m = syl.length();
            wt[i] = new String[m];
            ws[i] = new long[m];
            wd[i] = new long[m];
            for (int j = 0; j < m; j++) {
                JSONObject w = syl.optJSONObject(j);
                wt[i][j] = w == null ? "" : w.optString("text", "");
                ws[i][j] = w == null ? 0L : w.optLong("time", 0L);
                wd[i][j] = w == null ? 0L : w.optLong("duration", 0L);
            }
            // One chunk (CJK), stretch it over the whole line
            long ls = Math.round(line.optDouble("startTime", -1d) * 1000d);
            long le = Math.round(line.optDouble("endTime", -1d) * 1000d);
            if (m == 1 && ls >= 0 && le > ls && le - ls > wd[i][0]) {
                ws[i][0] = ls;
                wd[i][0] = le - ls;
            }
        }
        twText = any ? wt : null;
        twStart = any ? ws : null;
        twDur = any ? wd : null;
        trans = any ? t : null;
    }

    private static String lettersOnly(String s) {
        StringBuilder b = new StringBuilder(s.length());
        String lower = s.toLowerCase();
        for (int i = 0; i < lower.length(); ) {
            int cp = lower.codePointAt(i);
            if (Character.isLetterOrDigit(cp)) b.appendCodePoint(cp);
            i += Character.charCount(cp);
        }
        return b.toString();
    }

    // MARKER: render (patched lyric line composable)

    // One lyric line, translation replaces it (no room for both)
    public static AnnotatedString render(int idx, int active, String text, long sung, long unsung) {
        version.getValue();    // recompose on setting changes
        int mode = RLSettings.sync();
        String[] t = trans;
        boolean translated = RLAPILyricsHook.isRlState && RLSettings.translate() && t != null && idx >= 0 && idx < t.length && t[idx] != null;
        if (!translated) {
            if (mode == RLSettings.SYNC_SYLLABLE) return WordLyrics.renderSyl(idx, active, text, sung, unsung);
            if (mode == RLSettings.SYNC_WORD) return WordLyrics.render(idx, active, text, sung, unsung);
            return new AnnotatedString.Builder(text).toAnnotatedString();
        }

        // Timed translation only in Word / Syllable
        String[][] wtAll = twText;
        long[][] sAll = twStart;
        long[][] dAll = twDur;
        String[] words = mode != RLSettings.SYNC_LINE && wtAll != null && idx < wtAll.length ? wtAll[idx] : null;
        long[] ws = words != null && sAll != null && idx < sAll.length ? sAll[idx] : null;
        long[] wd = words != null && dAll != null && idx < dAll.length ? dAll[idx] : null;
        if (words == null || ws == null || wd == null || ws.length != words.length || wd.length != words.length) {
            // Untimed, TIDAL colours it like normal
            return new AnnotatedString.Builder(t[idx]).toAnnotatedString();
        }

        StringBuilder sb = new StringBuilder();
        int[] beg = new int[words.length];
        int[] vis = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            String w = words[i];
            int len = trimEndLen(w);
            beg[i] = sb.length();
            sb.append(w, 0, len);
            vis[i] = sb.length();
            if (len != w.length()) sb.append(' ');
        }
        String line = sb.toString();
        WordLyrics.tmpSung = sung;
        WordLyrics.tmpUnsung = unsung;
        AnnotatedString.Builder b = new AnnotatedString.Builder(line);
        int end = line.length();
        // Keep the singer side for duets
        int side = WordLyrics.ctxSingers() && WordLyrics.dualSide ? WordLyrics.sideOf(idx) : -1;
        if (side >= 0) b.addStyle(WordLyrics.paraStyle(side, false), 0, end);
        b.addStyle(WordLyrics.makeSpan(unsung), 0, end);
        WordLyrics.lineState().getValue();    // recompose on line change
        lightWords(b, line, idx, mode, 0, end, beg, vis, ws, wd, sung, unsung);
        return b.toAnnotatedString();
    }

    // Each translated word gets its own timing window
    private static void lightWords(AnnotatedString.Builder b, String text, int idx, int mode, int off, int end,
                                   int[] beg, int[] vis, long[] ws, long[] wd, long sung, long unsung) {
        if (mode == RLSettings.SYNC_SYLLABLE && WordLyrics.isPastLine(idx)) {
            b.addStyle(WordLyrics.makeSpan(sung), off, end);
            return;
        }
        if (!WordLyrics.isActiveLine(idx)) return;
        WordLyrics.state().getValue();    // re-render every tick
        long now = WordLyrics.computeNow();
        for (int i = 0; i < ws.length; i++) {
            int s = off + beg[i];
            int e = off + vis[i];
            if (e <= s) continue;
            long start = ws[i];
            long stop = start + Math.max(1L, wd[i]);
            if (mode == RLSettings.SYNC_WORD) {
                float f = WordLyrics.bump(start, stop, now);
                if (f > 0.01f) b.addStyle(WordLyrics.makeSpan(ColorKt.lerpjxsXWHM(unsung, sung, f)), s, e);
                continue;
            }
            if (now >= stop) {
                b.addStyle(WordLyrics.makeSpan(sung), s, e);
            } else if (now >= start) {
                // Per character, wrapped CJK lit both lines otherwise
                float k = (now - start) / (float) (stop - start) * (e - s);
                int cs = s + Math.min((int) k, e - s - 1);
                int ce = cs + 1;
                if (ce < e && Character.isHighSurrogate(text.charAt(cs))) ce++;
                if (cs > s) b.addStyle(WordLyrics.makeSpan(sung), s, cs);
                float f = Math.max(0f, Math.min(1f, (k - (cs - s)) / (ce - cs)));
                Brush wipe = WordLyrics.sylWipe(idx, cs, ce, f, end);
                b.addStyle(wipe != null ? WordLyrics.brushSpan(wipe) : WordLyrics.makeSpan(ColorKt.lerpjxsXWHM(unsung, sung, f)), cs, ce);
            }
        }
    }

    private static int trimEndLen(String s) {
        int n = s.length();
        while (n > 0 && s.charAt(n - 1) <= ' ') n--;
        return n;
    }

    static void bump() {
        versionPending++;
        post(new RLTask(RLTask.BUMP, null, null, null, 0));
    }

    static void bumpNow() {
        version.setValue(Integer.valueOf(versionPending));
    }

    // MARKER: settings changes (sparkle menu)

    // Changes what the API returns, so refetch
    static void onTextModeChanged() {
        refetch();
    }

    // Off drops the job, on lets it run again
    static void onRadiantAIChanged() {
        cancelAutoSylla();
        autoSyllaTrack = null;
        refetch();
    }

    static void onSyncChanged() {
        bump();
    }

    // Refetch the current track, spinner while it loads
    static void refetch() {
        RLAPILyricsWorker w = currentWorker();
        if (w == null) return;
        background(new RLTask(RLTask.REFETCH, new RLAPILyricsWorker(w.vm, w.title, w.artist, w.key, w.lyricsId), null, null, 0));
    }

    static void runRefetch(RLAPILyricsWorker n) {
        Object job = new Object();
        SparkleIcons.work(job, false, true);
        try {
            n.run();
        } finally {
            SparkleIcons.work(job, false, false);
        }
    }

    // Newest worker if it's still playing
    static RLAPILyricsWorker currentWorker() {
        RLAPILyricsWorker w = RLAPILyricsWorker.last;
        if (w == null || !w.isLive()) return null;
        return w;
    }

    // MARKER: flush

    static void flush() {
        if (busy) return;
        busy = true;
        background(new RLTask(RLTask.FLUSH, null, null, null, 0));
    }

    static void runFlush() {
        RLAPILyricsWorker w = currentWorker();
        if (w == null) {
            busy = false;
            toastErr("Flush: could not get track info");
            return;
        }
        // Second flush, Sylla realigns to the audio
        if (w.key.equals(retimeTrack) && RLSettings.allowAI()) {
            runRetime(w, false);
            return;
        }
        Object job = new Object();
        SparkleIcons.work(job, false, true);
        int epoch = syllaEpoch;
        try {
            StringBuilder q = new StringBuilder(API).append("rl-api?title=").append(RLAPILyricsWorker.uric(w.title))
                    .append("&artist=").append(RLAPILyricsWorker.uric(w.artist));
            String isrc = isrc(w);
            if (isrc.length() > 0) q.append("&isrc=").append(RLAPILyricsWorker.uric(isrc));
            q.append("&flush=true&ai-preference=").append(RLSettings.allowAI());
            if (RLSettings.translate()) {
                q.append("&translate=true&language=").append(RLAPILyricsWorker.uric(RLSettings.language()));
            }
            q.append("&platform=rl-mobile");
            RLHttp r = RLHttp.request("GET", q.toString(), null, 45000);
            if (epoch != syllaEpoch) return;
            if (r.status == 404) {
                // Nothing to flush, Sylla generates them
                if (RLSettings.allowAI()) {
                    toast("No lyrics found for this track\nGenerating them with Sylla…");
                    runRetime(w, true);
                } else {
                    toast("No lyrics found for this track");
                }
                return;
            }
            if (!r.ok()) {
                toastErr(r.status == 0 ? "Flush error: " + r.error : "Flush failed (" + r.status + ")");
                return;
            }
            String note = "";
            String type = "";
            boolean hasData = false;
            try {
                JSONObject o = new JSONObject(r.body);
                note = o.optString("_flush", "");
                type = o.optString("type", "");
                JSONArray d = o.optJSONArray("data");
                hasData = d != null && d.length() > 0;
            } catch (Throwable ignored) {
            }
            boolean changed = note.length() == 0 || note.startsWith("Created") || note.startsWith("Updated");
            boolean syllables = "Word".equals(type) && hasData;
            if (!RLSettings.allowAI() || syllables) {
                // Real syllables, Sylla needs a second tap
                if (syllables && RLSettings.allowAI()) retimeTrack = w.key;
                if (changed) {
                    toast(note.length() > 0 ? note : "Lyrics flushed");
                    refetch();
                } else {
                    toast(note);
                }
                return;
            }
            // Lines or nothing, straight to Sylla
            toast(hasData ? "Only line lyrics found\nRetiming with Sylla…" : "No synced lyrics found\nGenerating them with Sylla…");
            runRetime(w, !hasData, hasData ? r.body : null);
        } finally {
            if (epoch == syllaEpoch) busy = false;
            SparkleIcons.work(job, false, false);
        }
    }

    // MARKER: Sylla

    // Sylla after a flush, align or generate if none
    private static void runRetime(RLAPILyricsWorker w, boolean generate) {
        runRetime(w, generate, null);
    }

    // Aligns the given lyrics, gen if Sylla says no
    private static void runRetime(RLAPILyricsWorker w, boolean generate, String src) {
        String current = src != null ? src : body;
        if (current == null) generate = true;
        Object job = new Object();
        SparkleIcons.work(job, true, true);
        int epoch = syllaEpoch;
        JSONObject r = null;
        String err = null;
        try {
            Object res = generate ? gen(w) : align(w, current);
            // Flushed text didn't match the audio, generate instead
            if (src != null && !generate && !(res instanceof JSONObject) && epoch == syllaEpoch
                    && Boolean.TRUE.equals(syllaRefused.get())) {
                RLAPILyricsHook.dlog("Sylla Align (flush) failed (" + res + "), trying Gen");
                res = gen(w);
                generate = true;
            }
            if (res instanceof JSONObject) r = (JSONObject) res;
            else err = (String) res;
        } finally {
            if (epoch == syllaEpoch) busy = false;
            SparkleIcons.work(job, true, false);
        }
        // Track changed mid request
        if (epoch != syllaEpoch) return;
        if (r == null) {
            if (err.startsWith("!")) toast(err.substring(1));
            else toastErr((generate ? "AI generation failed (" : "AI retime failed (") + err + ")");
            return;
        }
        loadSylla(w, r, generate ? "generated" : "retimed");
    }

    // Auto Sylla job once per track, true = running
    static boolean autoSylla(RLAPILyricsWorker w, String mode, String src) {
        if (w == null || !RLSettings.radiantAI()) return false;
        // Old track came back late, skip it
        if (!w.key.equals(trackKey)) return false;
        if (w.key.equals(autoSyllaTrack)) return autoSyllaRunning;
        autoSyllaTrack = w.key;
        autoSyllaRunning = true;
        Object job = new Object();
        autoSyllaJob = job;
        SparkleIcons.work(job, true, true);
        background(new RLTask(RLTask.AUTO_SYLLA, w, mode, src, syllaEpoch));
        return true;
    }

    static void runAutoSylla(RLAPILyricsWorker w, String mode, String src, int epoch) {
        sleep(trackStartedAt + SYLLA_SETTLE_MS - SystemClock.elapsedRealtime());
        // Skipped, never reaches Sylla
        if (epoch != syllaEpoch) return;
        boolean untimed = "untimed".equals(mode) && src != null;
        boolean align = (untimed || "align".equals(mode)) && src != null;
        Object res = align ? align(w, src) : gen(w);
        // Text didn't match the audio, generate instead
        // Only on a real no, timeouts would fail gen too
        if (untimed && !(res instanceof JSONObject) && epoch == syllaEpoch && Boolean.TRUE.equals(syllaRefused.get())) {
            RLAPILyricsHook.dlog("Sylla Align (untimed) failed (" + res + "), trying Gen");
            res = gen(w);
            align = false;
        }
        if (epoch != syllaEpoch) return;
        autoSyllaRunning = false;
        SparkleIcons.work(autoSyllaJob, true, false);
        if (!(res instanceof JSONObject)) {
            RLAPILyricsHook.dlog("Sylla " + (align ? "Align" : "Gen") + ": kept " + (align ? "line lyrics" : "no lyrics") + " (" + res + ")");
            return;
        }
        loadSylla(w, (JSONObject) res, align ? "retimed" : "generated");
    }

    // Drop the running auto job
    static void cancelAutoSylla() {
        if (!autoSyllaRunning) return;
        syllaEpoch++;
        autoSyllaRunning = false;
        autoSyllaTrack = null;
        busy = false;
        SparkleIcons.work(autoSyllaJob, true, false);
    }

    // Publish Sylla output, already romanized / translated
    private static void loadSylla(RLAPILyricsWorker w, JSONObject res, String kind) {
        try {
            JSONObject ly = res.getJSONObject("lyrics");
            double conf = res.optDouble("confidence", 0d);
            ly.put("_synthesized", true);
            ly.put("_synthesisType", "generated".equals(kind) ? "Generate" : "Align");
            ly.put("_confidence", conf);
            respace(res, ly);
            // Player may have reopened since, use the newest worker
            RLAPILyricsWorker live = currentWorker();
            if (live == null || !live.key.equals(w.key)) live = w.isLive() ? w : null;
            if (live == null) {
                RLAPILyricsHook.dlog("Sylla: track changed, dropped the " + kind + " lyrics");
                return;
            }
            if (live.publish(normalize(ly.toString()))) {
                toast("Lyrics " + kind + " with AI (" + Math.round(conf * 100d) + "% confidence)");
            } else {
                toastErr("Sylla: lyrics could not be shown");
            }
        } catch (Throwable t) {
            toastErr("Sylla: bad response");
        }
    }

    // Copy word breaks onto romanized so words don't glue
    public static String normalize(String b) {
        // Keep it for onNoLyrics in case it's untimed
        rawBody.set(b);
        try {
            JSONObject o = new JSONObject(b);
            if (!"Word".equals(o.optString("type"))) return b;
            JSONArray data = o.optJSONArray("data");
            if (data == null || !syncRomanized(data)) return b;
            return o.toString();
        } catch (Throwable t) {
            return b;
        }
    }

    private static boolean syncRomanized(JSONArray data) throws org.json.JSONException {
        boolean changed = false;
        for (int li = 0; li < data.length(); li++) {
            JSONObject line = data.optJSONObject(li);
            JSONArray syl = line == null ? null : line.optJSONArray("syllabus");
            if (syl == null) continue;
            int n = syl.length();
            boolean any = false;
            StringBuilder joinedRom = new StringBuilder();
            for (int i = 0; i < n; i++) {
                JSONObject s = syl.getJSONObject(i);
                String st = s.optString("text", "");
                String rom = s.optString("romanized", "");
                if (rom.length() > 0) any = true;
                if (i < n - 1 && endsSpace(st) && rom.length() > 0 && !endsSpace(rom)) {
                    s.put("romanized", rom = rom + " ");
                    changed = true;
                }
                joinedRom.append(rom.length() > 0 ? rom : st);
            }
            String lineRom = line.optString("romanized", "");
            if (any && lineRom.length() > 0 && !hasSpace(lineRom) && hasSpace(line.optString("text", ""))) {
                line.put("romanized", joinedRom.toString().trim());
                changed = true;
            }
        }
        return changed;
    }

    // Raw Sylla drops word end spaces, rebuild from text
    static void respace(JSONObject res, JSONObject ly) {
        JSONArray data = ly.optJSONArray("data");
        if (data == null) return;
        JSONObject tr = res.optJSONObject("transcript");
        String transcript = tr == null ? "" : tr.optString("text", "");
        int tpos = hasSpace(transcript) ? 0 : -1;
        JSONArray summary = res.optJSONArray("lines");
        for (int li = 0; li < data.length(); li++) {
            JSONObject line = data.optJSONObject(li);
            JSONArray syl = line == null ? null : line.optJSONArray("syllabus");
            if (syl == null || syl.length() == 0) continue;
            int n = syl.length();
            String text = line.optString("text", "");
            boolean[] wordEnd = new boolean[n];
            boolean known = false;
            // Syllable text already has the spaces
            for (int i = 0; i < n - 1; i++) {
                JSONObject o = syl.optJSONObject(i);
                String st = o == null ? "" : o.optString("text", "");
                if (st.length() > 0 && Character.isWhitespace(st.charAt(st.length() - 1))) {
                    wordEnd[i] = true;
                    known = true;
                }
            }
            if (!known) {
                String ref = hasSpace(text) ? text : summaryText(summary, li);
                if (hasSpace(ref)) known = walk(syl, ref, 0, wordEnd) >= 0;
            }
            if (!known && tpos >= 0) {
                wordEnd = new boolean[n];
                int p = walk(syl, transcript, tpos, wordEnd);
                if (p >= 0) {
                    tpos = p;
                    known = true;
                } else {
                    tpos = -1;
                }
            } else if (tpos >= 0) {
                int p = walk(syl, transcript, tpos, new boolean[n]);
                tpos = p;
            }
            if (!known) continue;
            try {
                StringBuilder joined = new StringBuilder();
                StringBuilder joinedRom = new StringBuilder();
                for (int i = 0; i < n; i++) {
                    JSONObject o = syl.getJSONObject(i);
                    String st = o.optString("text", "");
                    String rom = o.optString("romanized", "");
                    if (wordEnd[i] && i < n - 1) {
                        if (!endsSpace(st)) o.put("text", st = st + " ");
                        if (rom.length() > 0 && !endsSpace(rom)) o.put("romanized", rom = rom + " ");
                    }
                    joined.append(st);
                    joinedRom.append(rom.length() > 0 ? rom : st);
                }
                if (!hasSpace(text)) line.put("text", joined.toString().trim());
                String lineRom = line.optString("romanized", "");
                if (lineRom.length() > 0 && !hasSpace(lineRom)) line.put("romanized", joinedRom.toString().trim());
            } catch (Throwable ignored) {
            }
        }
    }

    // Line text from the align summary
    private static String summaryText(JSONArray summary, int li) {
        if (summary == null) return "";
        for (int i = 0; i < summary.length(); i++) {
            JSONObject o = summary.optJSONObject(i);
            if (o != null && o.optInt("index", -1) == li) return o.optString("text", "");
        }
        JSONObject o = li < summary.length() ? summary.optJSONObject(li) : null;
        return o == null ? "" : o.optString("text", "");
    }

    private static boolean endsSpace(String s) {
        return s.length() > 0 && Character.isWhitespace(s.charAt(s.length() - 1));
    }

    // Mark word-final syllables against ref, -1 = no match
    private static int walk(JSONArray syl, String ref, int pos, boolean[] wordEnd) {
        for (int i = 0; i < syl.length(); i++) {
            JSONObject o = syl.optJSONObject(i);
            String st = o == null ? "" : o.optString("text", "");
            for (int k = 0; k < st.length(); k++) {
                char c = st.charAt(k);
                if (!Character.isLetterOrDigit(c)) continue;
                while (pos < ref.length() && !Character.isLetterOrDigit(ref.charAt(pos))) pos++;
                if (pos >= ref.length() || Character.toLowerCase(ref.charAt(pos)) != Character.toLowerCase(c)) return -1;
                pos++;
            }
            for (int k = pos; k < ref.length(); k++) {
                char c = ref.charAt(k);
                if (Character.isWhitespace(c)) {
                    wordEnd[i] = true;
                    break;
                }
                if (Character.isLetterOrDigit(c)) break;
            }
        }
        return pos;
    }

    private static boolean hasSpace(String s) {
        for (int i = 0; i < s.length(); i++) if (Character.isWhitespace(s.charAt(i))) return true;
        return false;
    }

    // Query flags for sylla-align / sylla-gen
    private static String syllaQs() {
        return "?romanize=" + RLSettings.romanize() + "&translate=" + RLSettings.translate()
                + "&language=" + RLAPILyricsWorker.uric(RLSettings.language())
                + "&ai-preference=" + RLSettings.allowAI();
    }

    // Retime to the audio, String = error, "!" = info
    private static Object align(RLAPILyricsWorker w, String lyricsBody) {
        try {
            JSONObject src = new JSONObject(lyricsBody);
            // Only the rl-api shape, not our flags
            JSONObject ly = new JSONObject();
            ly.put("type", src.opt("type"));
            ly.put("data", src.opt("data"));
            ly.put("metadata", src.opt("metadata"));
            JSONObject req = trackJson(w);
            req.put("lyrics", ly);
            return postSylla("sylla-align" + syllaQs(), "Sylla Align", req);
        } catch (Throwable t) {
            return String.valueOf(t);
        }
    }

    // Generate from the audio alone, same response as align
    private static Object gen(RLAPILyricsWorker w) {
        try {
            return postSylla("sylla-gen" + syllaQs(), "Sylla Gen", trackJson(w));
        } catch (Throwable t) {
            return String.valueOf(t);
        }
    }

    private static JSONObject trackJson(RLAPILyricsWorker w) throws org.json.JSONException {
        JSONObject req = new JSONObject();
        req.put("tidal_id", w.key);
        req.put("isrc", isrc(w));
        req.put("title", w.title);
        req.put("artist", w.artist);
        return req;
    }

    private static Object postSylla(String endpoint, String label, JSONObject req) {
        syllaRefused.set(Boolean.FALSE);
        RLHttp r = RLHttp.request("POST", API + endpoint, req.toString(), 180000);
        if (r.status == 0) {
            RLAPILyricsHook.dlog(label + ": request " + r.error);
            return r.error;
        }
        JSONObject o = null;
        try {
            o = new JSONObject(r.body);
        } catch (Throwable ignored) {
        }
        if (!r.ok()) {
            // 422 has verdict + message, others just detail
            String detail = "";
            String verdict = null;
            if (o != null) {
                Object d = o.opt("detail");
                if (o.opt("message") instanceof String) detail = o.optString("message");
                else if (d instanceof String) detail = (String) d;
                if (o.opt("verdict") instanceof String) verdict = o.optString("verdict");
                // Already Sylla output, not a failure
                if (r.status == 409 && d instanceof JSONObject && "already_aligned".equals(((JSONObject) d).optString("error"))) {
                    JSONObject a = (JSONObject) d;
                    RLAPILyricsHook.dlog(label + ": already aligned (" + a.optString("job") + ", conf " + a.optString("confidence") + ")");
                    return "!Already timed by Sylla" + (a.has("confidence")
                            ? " (" + Math.round(a.optDouble("confidence", 0d) * 100d) + "% confidence)" : "");
                }
            }
            RLAPILyricsHook.dlog(label + ": request failed " + r.status + (verdict != null ? " (" + verdict + ")" : "") + (detail.length() > 0 ? " | " + detail : ""));
            // Sylla said no, not rate limits or server trouble
            if (r.status >= 400 && r.status < 500 && r.status != 409 && r.status != 429) syllaRefused.set(Boolean.TRUE);
            if (detail.length() > 0) return detail;
            return verdict != null ? verdict : String.valueOf(r.status);
        }
        if (o == null) return "invalid response";
        // Different version of the song, nothing to apply
        if ("lyrics_do_not_match_audio".equals(o.optString("verdict"))) {
            RLAPILyricsHook.dlog(label + ": lyrics do not match the audio");
            syllaRefused.set(Boolean.TRUE);
            String m = o.optString("message", "");
            return m.length() > 0 ? m : "lyrics don't match this version of the song";
        }
        JSONObject ly = o.optJSONObject("lyrics");
        if (ly == null || !"Word".equals(ly.optString("type")) || ly.optJSONArray("data") == null) {
            RLAPILyricsHook.dlog(label + ": response had no usable lyrics");
            syllaRefused.set(Boolean.TRUE);
            return "invalid response";
        }
        RLAPILyricsHook.dlog(label + ": " + o.optString("model") + " verdict=" + o.optString("verdict") + " conf=" + o.optString("confidence"));
        return o;
    }

    private static String isrc(RLAPILyricsWorker w) {
        String i = IsrcCache.get(w.key);
        return i == null ? "" : i.trim();
    }

    // MARKER: threads + toasts

    private static void sleep(long ms) {
        if (ms <= 0) return;
        try {
            Thread.sleep(ms);
        } catch (InterruptedException ignored) {
        }
    }

    private static void background(Runnable r) {
        Thread t = new Thread(r);
        t.setDaemon(true);
        t.start();
    }

    static void post(Runnable r) {
        Handler h = main;
        if (h == null) main = h = new Handler(Looper.getMainLooper());
        h.post(r);
    }

    static void toast(String msg) {
        if (RLSettings.toasts() < RLSettings.TOASTS_ALL) return;
        post(new RLTask(RLTask.TOAST, msg, null, null, 0));
    }

    static void toastErr(String msg) {
        RLAPILyricsHook.dlog(msg);
        if (RLSettings.toasts() < RLSettings.TOASTS_ERRORS) return;
        post(new RLTask(RLTask.TOAST, msg, null, null, 1));
    }

    static void showToast(String msg, boolean error) {
        android.content.Context c = RLSettings.app();
        if (c != null) Toast.makeText(c, msg, error ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT).show();
    }
}
