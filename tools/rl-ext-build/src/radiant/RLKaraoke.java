package radiant;

import androidx.compose.ui.graphics.Brush;
import androidx.compose.ui.graphics.ColorKt;
import androidx.compose.ui.graphics.Shadow;
import androidx.compose.ui.text.AnnotatedString;
import androidx.compose.ui.text.ParagraphStyle;
import androidx.compose.ui.text.SpanStyle;
import androidx.compose.ui.text.TextLayoutResult;
import androidx.compose.ui.text.TextStyle;
import androidx.compose.ui.text.style.BaselineShift;
import androidx.compose.ui.text.style.LineHeightStyle;
import androidx.compose.ui.unit.TextUnitKt;

import org.json.JSONArray;
import org.json.JSONObject;

import java.text.BreakIterator;
import java.util.ArrayList;

// MARKER: Karaoke FX
//   Rising Words, Instrumental Dots, syllable glow <3
public final class RLKaraoke {
    // Breaks this long get dots
    static final long BREAK_MIN_MS = 7000;
    private static final long BREAK_IN_MS = 400;
    private static final long BREAK_OUT_MS = 350;
    private static final String DOTS = "●●●";

    // Lift, share of the ascent (about 0.075em)
    private static final float LIFT = 0.08f;
    // Long note bump on top
    private static final float SWELL_LIFT = 0.04f;
    // Room above lifted words, else the line grows
    private static final float HEADROOM = 0.06f;
    private static final long LIFT_MS = 2000;
    // Line's done, words settle back down
    private static final long FALL_MS = 700;
    private static final long GLOW_FADE_MS = 600;
    private static final long SHINE_FADE_MS = 300;
    private static final double FREQ = Math.sqrt(14);
    private static final double DAMP = 3.5;

    private static final int STILL = 0;
    private static final int SWELL = 1;
    private static final int CLIMB = 2;

    // Per line break times, -1 = a lyric
    private static volatile long[] breakStart;
    private static volatile long[] breakEnd;

    // Last measured font size (px)
    private static float lastEm;
    // TIDAL's lyric line height in em (40sp / 32sp)
    private static float lineRatio = 1.25f;
    private static ParagraphStyle steady;
    private static ParagraphStyle steadyBg;
    private static float steadyRatio;

    private RLKaraoke() {}

    // MARKER: Manager options

    static boolean rising() {
        return RLDefaults.risingWords() != 0;
    }

    static boolean dots() {
        return RLDefaults.dots() != 0;
    }

    // Glow switch first, then strength (default 30)
    static int glow() {
        return RLDefaults.glowOn() != 0 ? RLDefaults.glow() : 0;
    }

    // MARKER: lyrics body

    // Brackets then dots, null = unchanged
    public static JSONArray prepare(JSONArray data) {
        JSONArray out = data;
        if (WordLyrics.ctxOn()) {
            JSONArray m = RLBrackets.apply(out);
            if (m != null) out = m;
        }
        if (dots()) {
            JSONArray d = addBreaks(out);
            if (d != null) out = d;
        }
        return out == data ? null : out;
    }

    private static long startOf(JSONObject line) {
        JSONArray syl = line.optJSONArray("syllabus");
        JSONObject first = syl != null && syl.length() > 0 ? syl.optJSONObject(0) : null;
        if (first != null) return first.optLong("time", -1L);
        double s = line.optDouble("startTime", -1d);
        return s < 0 ? -1L : Math.round(s * 1000d);
    }

    private static long endOf(JSONObject line, long start) {
        JSONArray syl = line.optJSONArray("syllabus");
        long end = start;
        if (syl != null && syl.length() > 0) {
            for (int i = 0; i < syl.length(); i++) {
                JSONObject s = syl.optJSONObject(i);
                if (s != null) end = Math.max(end, s.optLong("time", 0L) + s.optLong("duration", 0L));
            }
            return end;
        }
        double e = line.optDouble("endTime", -1d);
        return e < 0 ? start : Math.max(start, Math.round(e * 1000d));
    }

    // Dots line for long breaks (and long intros)
    static JSONArray addBreaks(JSONArray data) {
        try {
            JSONArray out = new JSONArray();
            boolean changed = false;
            long lastEnd = -1L;
            for (int i = 0; i < data.length(); i++) {
                JSONObject line = data.optJSONObject(i);
                if (line == null) continue;
                long s = startOf(line);
                if (s >= 0) {
                    long from = lastEnd < 0 ? 0L : lastEnd;
                    if (s - from >= BREAK_MIN_MS) {
                        out.put(breakLine(from, s));
                        changed = true;
                    }
                    lastEnd = Math.max(lastEnd, endOf(line, s));
                }
                out.put(line);
            }
            return changed ? out : null;
        } catch (Throwable t) {
            RLAPILyricsHook.dlog("instrumental dots failed: " + t);
            return null;
        }
    }

    // Empty text so ColorOS / Pebble skip it
    private static JSONObject breakLine(long from, long to) throws Exception {
        JSONObject syl = new JSONObject();
        syl.put("text", "");
        syl.put("time", from);
        syl.put("duration", to - from);
        syl.put("isBackground", false);
        JSONObject line = new JSONObject();
        line.put("text", "");
        line.put("startTime", from / 1000d);
        line.put("endTime", to / 1000d);
        line.put("duration", (to - from) / 1000d);
        line.put("syllabus", new JSONArray().put(syl));
        line.put("_rlBreak", true);
        line.put("_rlFrom", from);
        line.put("_rlTo", to);
        return line;
    }

    // Published lyrics, remember the break lines
    static void load(JSONArray data) {
        if (data == null) {
            clear();
            return;
        }
        int n = data.length();
        long[] s = new long[n];
        long[] e = new long[n];
        boolean any = false;
        for (int i = 0; i < n; i++) {
            JSONObject line = data.optJSONObject(i);
            s[i] = -1L;
            e[i] = -1L;
            if (line == null || !line.optBoolean("_rlBreak", false)) continue;
            s[i] = line.optLong("_rlFrom", -1L);
            e[i] = line.optLong("_rlTo", -1L);
            any = s[i] >= 0 && e[i] > s[i] || any;
        }
        breakStart = any ? s : null;
        breakEnd = any ? e : null;
    }

    static void clear() {
        breakStart = null;
        breakEnd = null;
    }

    // MARKER: Instrumental Dots
    //   Dots fade in, fill up, fade out <3

    // Null = not a break line
    public static AnnotatedString renderBreak(int idx, long sung) {
        long[] bs = breakStart;
        long[] be = breakEnd;
        if (!RLAPILyricsHook.isRlState || bs == null || be == null || idx < 0 || idx >= bs.length || bs[idx] < 0) {
            return null;
        }
        WordLyrics.lineState().getValue();    // recompose on line change
        long now = WordLyrics.computeNow();
        long s = bs[idx];
        long e = be[idx];
        long leave = e - BREAK_OUT_MS;
        if (now >= s - 100 && now < e + 100) WordLyrics.state().getValue();    // tick while showing
        float show = 0f;
        if (now >= s && now < leave) show = bezier(clamp((now - s) / (float) BREAK_IN_MS), 0.25f, 0.1f, 0.25f, 1f);
        else if (now >= leave && now < e) show = 1f - bezier(clamp((now - leave) / (float) BREAK_OUT_MS), 0.25f, 0.1f, 0.25f, 1f);
        float filled = clamp((now - s) / (float) Math.max(1L, leave - s));
        AnnotatedString.Builder b = new AnnotatedString.Builder(DOTS);
        b.addStyle(dotSize(), 0, DOTS.length());
        for (int i = 0; i < 3; i++) {
            float a = show * (0.25f + 0.75f * clamp(filled * 3f - i));
            b.addStyle(WordLyrics.makeSpan(withAlpha(sung, a)), i, i + 1);
        }
        return b.toAnnotatedString();
    }

    // MARKER: Rising Words (Syllable)
    //   Words lift as sung, long notes grow and glow <3

    public static AnnotatedString renderSyl(int idx, int active, String text, long sung, long unsung) {
        boolean rise = rising();
        int glow = glow();
        if (!rise && glow <= 0) return WordLyrics.renderSyl(idx, active, text, sung, unsung);
        WordLyrics.tmpSung = sung;
        WordLyrics.tmpUnsung = unsung;
        String[][] allText = WordLyrics.lineSylText;
        long[][] allStart = WordLyrics.lineSylStart;
        long[][] allDur = WordLyrics.lineSylDur;
        if (!RLAPILyricsHook.isRlState || allText == null || allStart == null || allDur == null || idx < 0
                || idx >= allText.length || idx >= allStart.length || idx >= allDur.length) {
            return plain(text);
        }
        String[] syl = allText[idx];
        long[] st = allStart[idx];
        long[] du = allDur[idx];
        if (syl == null || st == null || du == null || syl.length == 0 || st.length < syl.length || du.length < syl.length) {
            return plain(text);
        }
        int n = syl.length;
        boolean[] bg = WordLyrics.bgFlags(WordLyrics.lineSylBg, idx, n);

        // Lead vocal first, adlibs after (like emitLine)
        StringBuilder sb = new StringBuilder();
        int[] beg = new int[n];
        int[] fin = new int[n];
        int[] vis = new int[n];
        int bgStart = -1;
        for (int g = 0; g < 2; g++) {
            boolean bgGroup = g == 1;
            if (bgGroup && bg == null) break;
            for (int i = 0; i < n; i++) {
                if (!inGroup(bg, i, bgGroup)) continue;
                if (bgGroup && bgStart < 0) bgStart = sb.length();
                String s = bgGroup ? WordLyrics.stripBrackets(syl[i]) : syl[i];
                beg[i] = sb.length();
                sb.append(s);
                fin[i] = sb.length();
                vis[i] = beg[i] + trimEndLen(s);
            }
        }
        String line = sb.toString();
        int total = line.length();
        AnnotatedString.Builder b = new AnnotatedString.Builder(line);
        if (rise) measure(idx);
        paragraphs(b, idx, bgStart, total, rise);

        WordLyrics.lineState().getValue();    // recompose on line change
        long now = WordLyrics.computeNow();
        boolean activeLine = WordLyrics.isActiveLine(idx);
        boolean past = !activeLine && WordLyrics.isPastLine(idx);
        long[] eff = WordLyrics.lineEff;
        long endAt = eff != null && idx < eff.length ? eff[idx] : now - FALL_MS;
        boolean settling = past && now >= endAt && now - endAt < Math.max(FALL_MS, GLOW_FADE_MS);

        if (past) {
            b.addStyle(WordLyrics.sungStyle(), 0, total);
        } else {
            b.addStyle(WordLyrics.unsungStyle(), 0, total);
        }
        if (activeLine || settling) {
            WordLyrics.state().getValue();    // re-render every tick
            if (activeLine) {
                paint(b, idx, 0, false, bg, st, du, beg, fin, vis, n, total, now);
                if (bgStart >= 0) paint(b, idx, bgStart, true, bg, st, du, beg, fin, vis, n, total, now);
            }
            fx(b, idx, line, syl, st, du, bg, beg, vis, n, now, activeLine, endAt, rise, glow, sung);
        }
        return b.toAnnotatedString();
    }

    private static AnnotatedString plain(String text) {
        return new AnnotatedString.Builder(text == null ? "" : text).toAnnotatedString();
    }

    private static boolean inGroup(boolean[] bg, int i, boolean bgGroup) {
        return bg == null ? !bgGroup : bg[i] == bgGroup;
    }

    // Singer side + adlib size (steady lines when words lift)
    private static void paragraphs(AnnotatedString.Builder b, int idx, int bgStart, int total, boolean steadyLines) {
        int side = WordLyrics.ctxSingers() && WordLyrics.dualSide ? WordLyrics.sideOf(idx) : -1;
        int leadEnd = bgStart >= 0 ? bgStart : total;
        if ((side >= 0 || steadyLines) && leadEnd > 0) {
            ParagraphStyle p = WordLyrics.paraStyle(side, false);
            if (steadyLines) p = p.merge(steady());
            b.addStyle(p, 0, leadEnd);
        }
        if (bgStart >= 0) {
            ParagraphStyle p = WordLyrics.paraStyle(side, true);
            if (steadyLines) {
                steady();
                p = p.merge(steadyBg);
            }
            b.addStyle(p, bgStart, total);
            b.addStyle(WordLyrics.emSpan(0.55f), bgStart, total);
        }
    }

    // Bottom aligned line box, lifted words don't push the line
    private static ParagraphStyle steady() {
        if (steady == null || steadyRatio != lineRatio) {
            // Alignment.Bottom = 1f, Trim.LastLineBottom = 0x10, Mode.Fixed = 0
            LineHeightStyle lhs = new LineHeightStyle(1f, 0x10, 0, null);
            steady = new ParagraphStyle(0, 0, TextUnitKt.getEm(lineRatio + HEADROOM), null, null, lhs, 0, 0, null, 0x1db, null);
            // Adlibs are 0.7em lines
            steadyBg = new ParagraphStyle(0, 0, TextUnitKt.getEm(0.7f + HEADROOM), null, null, lhs, 0, 0, null, 0x1db, null);
            steadyRatio = lineRatio;
        }
        return steady;
    }

    // Line height / font size of TIDAL's lyric style
    private static void measure(int idx) {
        TextLayoutResult lay = SylLayout.get(idx);
        if (lay == null) return;
        TextStyle st = lay.getLayoutInput().getStyle();
        long lh = st.getLineHeightXSAIIZE();
        long fs = st.getFontSizeXSAIIZE();
        float lv = Float.intBitsToFloat((int) lh);
        float fv = Float.intBitsToFloat((int) fs);
        // TextUnit type bits: 1 = sp, 2 = em
        long lt = lh & 0xff00000000L;
        float r = lt == 0x200000000L ? lv
                : lt == 0x100000000L && (fs & 0xff00000000L) == 0x100000000L && fv > 0f ? lv / fv : 0f;
        if (r > 0.8f && r < 3f) lineRatio = Math.round(r * 100f) / 100f;
    }

    // Wipes one group's active syllable (like paintGroup)
    private static void paint(AnnotatedString.Builder b, int idx, int from, boolean bgGroup, boolean[] bg, long[] st, long[] du,
                              int[] beg, int[] fin, int[] vis, int n, int total, long now) {
        int k = -1;
        for (int i = 0; i < n; i++) {
            if (!inGroup(bg, i, bgGroup)) continue;
            if (st[i] > now) break;
            k = i;
        }
        if (k < 0) return;
        if (beg[k] > from) b.addStyle(WordLyrics.sungStyle(), from, beg[k]);
        long d = Math.max(1L, du[k]);
        long el = now - st[k];
        if (el >= d) {
            b.addStyle(WordLyrics.sungStyle(), beg[k], fin[k]);
            return;
        }
        float f = clamp(el / (float) d);
        Brush w = WordLyrics.sylWipe(idx, beg[k], vis[k], f, total);
        if (w != null) {
            b.addStyle(WordLyrics.brushSpan(w), beg[k], fin[k]);
        } else {
            b.addStyle(WordLyrics.makeSpan(ColorKt.lerpjxsXWHM(WordLyrics.tmpUnsung, WordLyrics.tmpSung, f)), beg[k], fin[k]);
        }
    }

    // Lift + glow per character, then runs of spans
    private static void fx(AnnotatedString.Builder b, int idx, String line, String[] syl, long[] st, long[] du, boolean[] bg,
                           int[] beg, int[] vis, int n, long now, boolean activeLine, long endAt, boolean rise, int glow,
                           long sung) {
        int len = line.length();
        float[] lift = new float[len];
        float[] ga = new float[len];
        float[] gb = new float[len];
        // Falling lines keep their end pose
        long at = activeLine ? now : endAt;
        float since = activeLine ? 0f : (float) (now - endAt);
        float settle = activeLine ? 1f : 1f - bezier(clamp(since / FALL_MS), 0.22f, 1f, 0.36f, 1f);
        float glowLeft = activeLine ? 1f : 1f - bezier(clamp(since / GLOW_FADE_MS), 0.25f, 0.1f, 0.25f, 1f);
        float shineLeft = activeLine ? 1f : 1f - bezier(clamp(since / SHINE_FADE_MS), 0f, 0f, 0.58f, 1f);

        // Only the lit bits glow, rides the wipe
        if (glow > 0 && glowLeft > 0f) {
            float amount = glow / 20f;
            float alpha = Math.min(1f, 0.45f * amount);
            float blur = 0.3f * Math.min(2.5f, 0.6f + 0.4f * amount);
            for (int i = 0; i < n; i++) {
                long d = Math.max(1L, du[i]);
                float lit = at >= st[i] + d ? 1f : at >= st[i] ? (at - st[i]) / (float) d : 0f;
                if (lit <= 0f) continue;
                for (int c = beg[i]; c < vis[i] && c < len; c++) {
                    ga[c] = alpha * lit * glowLeft;
                    gb[c] = blur;
                }
            }
        }

        if (rise) {
            boolean[][] rawBg = WordLyrics.lineSylBg;
            boolean[] sylBg = rawBg != null && idx < rawBg.length ? rawBg[idx] : null;
            for (int g = 0; g < 2; g++) {
                boolean bgGroup = g == 1;
                if (bgGroup && bg == null) break;
                int[] ids = new int[n];
                int m = 0;
                for (int i = 0; i < n; i++) if (inGroup(bg, i, bgGroup)) ids[m++] = i;
                // Words end at a space or the group's end
                ArrayList<int[]> words = new ArrayList<int[]>();
                int w0 = 0;
                for (int p = 0; p < m; p++) {
                    String s = syl[ids[p]];
                    boolean end = p == m - 1 || (s.length() > 0 && Character.isWhitespace(s.charAt(s.length() - 1)));
                    if (!end) continue;
                    words.add(new int[]{w0, p});
                    w0 = p + 1;
                }
                for (int w = 0; w < words.size(); w++) {
                    int[] wd = words.get(w);
                    long ws = st[ids[wd[0]]];
                    long we = ws + 1;
                    for (int p = wd[0]; p <= wd[1]; p++) we = Math.max(we, st[ids[p]] + du[ids[p]]);
                    // No overlapping words
                    if (w + 1 < words.size()) {
                        long next = st[ids[words.get(w + 1)[0]]];
                        if (next > ws) we = Math.max(ws + 1, Math.min(we, next));
                    }
                    boolean wordBg = sylBg != null && ids[wd[0]] < sylBg.length && sylBg[ids[wd[0]]];
                    lift(ids, wd, beg, vis, line, ws, we, wordBg, at, settle, shineLeft, lift, ga, gb);
                }
            }
        }

        float em = emOf(idx);
        // Lift runs
        int c = 0;
        while (c < len) {
            float q = Math.round(Math.max(0f, lift[c]) * 400f) / 400f;
            int e = c + 1;
            while (e < len && Math.round(Math.max(0f, lift[e]) * 400f) / 400f == q) e++;
            if (q > 0f) b.addStyle(shiftSpan(q), c, e);
            c = e;
        }
        // Glow runs
        if (em <= 0f) return;
        c = 0;
        while (c < len) {
            float qa = Math.round(ga[c] * 64f) / 64f;
            float qb = Math.round(gb[c] * 40f) / 40f;
            int e = c + 1;
            while (e < len && Math.round(ga[e] * 64f) / 64f == qa && Math.round(gb[e] * 40f) / 40f == qb) e++;
            if (qa > 0f && qb > 0f) b.addStyle(glowSpan(sung, qa, qb * em), c, e);
            c = e;
        }
    }

    // One word's lift (letter by letter for long notes)
    private static void lift(int[] ids, int[] wd, int[] beg, int[] vis, String line, long ws, long we, boolean background,
                             long at, float settle, float shineLeft, float[] lift, float[] ga, float[] gb) {
        long since = at - ws;
        if (since < 0) return;
        // Letters in order
        ArrayList<int[]> letters = new ArrayList<int[]>();
        StringBuilder text = new StringBuilder();
        BreakIterator it = BreakIterator.getCharacterInstance();
        for (int p = wd[0]; p <= wd[1]; p++) {
            int i = ids[p];
            int s = beg[i];
            int e = Math.min(vis[i], line.length());
            if (e <= s) continue;
            String part = line.substring(s, e);
            text.append(part);
            it.setText(part);
            int a = it.first();
            for (int z = it.next(); z != BreakIterator.DONE; a = z, z = it.next()) letters.add(new int[]{s + a, s + z});
        }
        int count = letters.size();
        if (count == 0) return;
        long lenMs = Math.max(1L, we - ws);
        int mode = modeOf(text.toString(), count, lenMs, background);

        if (mode == STILL) {
            float r = since >= LIFT_MS ? 1f : (float) (1d - spring(since / 1000d));
            float l = LIFT * Math.max(0f, r) * settle;
            for (int[] lt : letters) for (int c = lt[0]; c < lt[1]; c++) lift[c] = l;
            return;
        }

        boolean cjk = mode == CLIMB;
        double dur = Math.max(0.001d, lenMs / 1000d);
        double stepMs = dur * 1000d / count * (cjk ? 0.4d : 0.35d);
        double spacingMs = cjk ? Math.min(stepMs, Math.min(50d, 200d / count)) : Math.min(stepMs, 350d);
        double holdS = 2d * dur / count;
        double settleS = Math.min(3d, dur);
        double swell = cjk ? 0d : clampD(dur - 1d);
        double shine = cjk ? 0d : 0.45d * clampD((dur - 1d) / 0.5d);
        double runS = Math.max(holdS + settleS * 2d, cjk ? 3d : 0d);
        for (int k = 0; k < count; k++) {
            double t = (since - (k + 1) * spacingMs) / 1000d;
            double r;
            double bump = 0d;
            double sh = 0d;
            if (t < 0d) {
                r = 0d;
            } else if (t >= runS) {
                r = 1d;
            } else {
                r = cjk ? 1d - spring(t) : ramp(t, settleS);
                bump = ramp(t, settleS) * (1d - ramp(t - holdS, settleS));
                sh = shine * shineCurve(t / runS);
            }
            float l = (float) (LIFT * Math.max(0d, r) + SWELL_LIFT * swell * bump) * settle;
            float sa = (float) sh * shineLeft;
            int[] lt = letters.get(k);
            for (int c = lt[0]; c < lt[1]; c++) {
                lift[c] = l;
                // Letter shine, keeps the stronger glow
                if (sa > ga[c]) {
                    ga[c] = sa;
                    gb[c] = 0.3f;
                }
            }
        }
    }

    // Which letter animation a word gets
    private static int modeOf(String text, int count, long lenMs, boolean background) {
        boolean han = false;
        for (int i = 0; i < text.length(); i++) {
            char ch = text.charAt(i);
            if (ch >= '֐' && ch <= 'ࣿ') return STILL;
            if ((ch >= '㐀' && ch <= '䶿') || (ch >= '一' && ch <= '鿿') || (ch >= '぀' && ch <= 'ヿ')) {
                han = true;
            }
        }
        if (han) return count > 1 ? CLIMB : STILL;
        return !background && lenMs >= 1000 && count <= 7 ? SWELL : STILL;
    }

    // MARKER: Glow (Word / Line)

    // Active word glows with its fade
    public static AnnotatedString glowWord(int idx, AnnotatedString as) {
        int glow = glow();
        if (glow <= 0 || as == null || !RLAPILyricsHook.isRlState || WordLyrics.pLineIdx != idx) return as;
        int n = WordLyrics.pN;
        long[] st = WordLyrics.pStarts;
        int[] beg = WordLyrics.pBeg;
        int[] vis = WordLyrics.pVis;
        boolean[] bg = WordLyrics.pBg;
        if (st == null || beg == null || vis == null || st.length < n || beg.length < n || vis.length < n
                || as.getLength() != WordLyrics.pTotal || !WordLyrics.isActiveLine(idx)) {
            return as;
        }
        float em = emOf(idx);
        if (em <= 0f) return as;
        long now = WordLyrics.computeNow();
        float amount = glow / 20f;
        float alpha = Math.min(1f, 0.45f * amount);
        float blur = 0.3f * Math.min(2.5f, 0.6f + 0.4f * amount) * em;
        AnnotatedString.Builder b = null;
        for (int g = 0; g < 2; g++) {
            boolean bgGroup = g == 1;
            int k = -1;
            for (int i = 0; i < n; i++) {
                if (!inGroup(bg, i, bgGroup)) continue;
                if (st[i] > now) break;
                k = i;
            }
            if (k < 0) continue;
            long end = st[k] + 800L;
            for (int i = k + 1; i < n; i++) {
                if (!inGroup(bg, i, bgGroup)) continue;
                end = st[i];
                break;
            }
            float f = WordLyrics.bump(st[k], end, now);
            if (f <= 0.01f || vis[k] <= beg[k]) continue;
            if (b == null) b = new AnnotatedString.Builder(as);
            b.addStyle(glowSpan(WordLyrics.tmpSung, alpha * f, blur), beg[k], vis[k]);
        }
        return b == null ? as : b.toAnnotatedString();
    }

    // Current line glows (TIDAL colours it)
    public static AnnotatedString glowLine(int idx, int active, String text, long sung) {
        AnnotatedString.Builder b = new AnnotatedString.Builder(text == null ? "" : text);
        int glow = glow();
        int len = text == null ? 0 : text.length();
        if (glow > 0 && idx >= 0 && idx == active && len > 0) {
            float em = emOf(idx);
            if (em > 0f) {
                float amount = glow / 20f;
                float alpha = Math.min(1f, 0.45f * amount);
                float blur = 0.3f * Math.min(2.5f, 0.6f + 0.4f * amount) * em;
                b.addStyle(glowSpan(sung, alpha, blur), 0, len);
            }
        }
        return b.toAnnotatedString();
    }

    // MARKER: spans

    private static float emOf(int idx) {
        TextLayoutResult lay = SylLayout.get(idx);
        if (lay != null) {
            float e = SylLayout.em(lay);
            if (e > 0f) lastEm = e;
            return e;
        }
        return lastEm;
    }

    // CSS blur radius to Android shadow radius
    private static SpanStyle glowSpan(long color, float alpha, float blurPx) {
        Shadow sh = new Shadow(withAlpha(color, alpha), 0L, Math.max(0.5f, blurPx * 0.866f), null);
        return new SpanStyle(0L, 0L, null, null, null, null, null, 0L, null, null, null, 0L, null, sh, null, null, 0xdfff, null);
    }

    private static SpanStyle shiftSpan(float multiplier) {
        BaselineShift s = BaselineShift.boximpl(multiplier);
        return new SpanStyle(0L, 0L, null, null, null, null, null, 0L, s, null, null, 0L, null, null, null, null, 0xfeff, null);
    }

    private static SpanStyle dotSize() {
        long size = TextUnitKt.getEm(0.6f);
        long gap = TextUnitKt.getEm(0.15f);
        return new SpanStyle(0L, size, null, null, null, null, null, gap, null, null, null, 0L, null, null, null, null, 0xff7d, null);
    }

    static long withAlpha(long color, float a) {
        int argb = ColorKt.toArgb8_81llA(color);
        int al = Math.round(((argb >>> 24) & 0xff) * clamp(a));
        return ColorKt.Color((argb & 0xffffff) | (al << 24));
    }

    // MARKER: maths

    private static float clamp(float v) {
        return v < 0f ? 0f : v > 1f ? 1f : v;
    }

    private static double clampD(double v) {
        return v < 0d ? 0d : v > 1d ? 1d : v;
    }

    private static int trimEndLen(String s) {
        int n = s.length();
        while (n > 0 && s.charAt(n - 1) <= ' ') n--;
        return n;
    }

    // Bouncy spring, 1 at rest
    private static double spring(double time) {
        double omega = Math.sqrt(FREQ * FREQ - DAMP * DAMP);
        double decay = Math.exp(-DAMP * time);
        return decay * (Math.cos(omega * time) + (DAMP / omega) * Math.sin(omega * time));
    }

    // Smooth 0 to 1 ramp
    private static double ramp(double time, double settleS) {
        if (time <= 0d) return 0d;
        double phase = 2d * Math.PI * time / Math.max(0.001d, settleS);
        return 1d - (1d + phase) * Math.exp(-phase);
    }

    private static double shineCurve(double p) {
        if (p <= 0d) return 0d;
        if (p < 0.15d) return 0.8d * p / 0.15d;
        if (p < 0.3d) return 0.8d + 0.2d * (p - 0.15d) / 0.15d;
        if (p < 0.6d) return 1d - 0.7d * (p - 0.3d) / 0.3d;
        if (p < 1d) return 0.3d - 0.3d * (p - 0.6d) / 0.4d;
        return 0d;
    }

    // CSS cubic-bezier
    private static float bezier(float u, float x1, float y1, float x2, float y2) {
        float cx = 3f * x1;
        float bx = 3f * (x2 - x1) - cx;
        float ax = 1f - cx - bx;
        float cy = 3f * y1;
        float by = 3f * (y2 - y1) - cy;
        float ay = 1f - cy - by;
        float t = u;
        for (int i = 0; i < 8; i++) {
            float x = ((ax * t + bx) * t + cx) * t - u;
            float dx = (3f * ax * t + 2f * bx) * t + cx;
            if (Math.abs(x) < 1e-5f || Math.abs(dx) < 1e-6f) break;
            t -= x / dx;
        }
        return ((ay * t + by) * t + cy) * t;
    }
}
