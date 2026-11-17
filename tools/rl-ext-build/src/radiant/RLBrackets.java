package radiant;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

// MARKER: Bracket marks
//   (text) / [text] = adlibs, {text} = second singer <3
public final class RLBrackets {
    private static final String OPEN = "([{";
    private static final String CLOSE = ")]}";

    private RLBrackets() {}

    private static boolean isMark(char c) {
        return OPEN.indexOf(c) >= 0 || CLOSE.indexOf(c) >= 0;
    }

    private static boolean hasMark(String s) {
        for (int i = 0; i < s.length(); i++) if (isMark(s.charAt(i))) return true;
        return false;
    }

    static String strip(String s) {
        StringBuilder b = new StringBuilder(s.length());
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (!isMark(c)) b.append(c);
        }
        return b.toString();
    }

    private static int count(String s, String chars) {
        int n = 0;
        for (int i = 0; i < s.length(); i++) if (chars.indexOf(s.charAt(i)) >= 0) n++;
        return n;
    }

    private static boolean endsSpace(String s) {
        return s.length() > 0 && Character.isWhitespace(s.charAt(s.length() - 1));
    }

    // Cut a string so marks only sit at piece edges
    static ArrayList<String> cut(String text) {
        ArrayList<String> pieces = new ArrayList<String>();
        int from = 0;
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (OPEN.indexOf(c) >= 0 && i > from) {
                pieces.add(text.substring(from, i));
                from = i;
            }
            if (CLOSE.indexOf(c) >= 0) {
                // Spaces after a close stay with it
                int end = i + 1;
                while (end < text.length() && text.charAt(end) == ' ') end++;
                if (end < text.length()) {
                    pieces.add(text.substring(from, end));
                    from = end;
                    i = end - 1;
                }
            }
        }
        pieces.add(text.substring(from));
        ArrayList<String> out = new ArrayList<String>();
        for (String p : pieces) if (p.length() > 0) out.add(p);
        return out;
    }

    // Split a syllable at its marks (time shared by length)
    private static ArrayList<JSONObject> split(JSONObject syl) throws Exception {
        ArrayList<JSONObject> out = new ArrayList<JSONObject>();
        String text = syl.optString("text", "");
        ArrayList<String> pieces = cut(text);
        if (pieces.size() < 2) {
            out.add(new JSONObject(syl.toString()));
            return out;
        }
        // Romanized only kept if it cuts the same way
        String rom = syl.optString("romanized", "");
        ArrayList<String> rc = rom.length() > 0 ? cut(rom) : null;
        if (rc != null && rc.size() != pieces.size()) rc = null;
        int total = 0;
        for (String p : pieces) total += p.length();
        long time = syl.optLong("time", 0L);
        long dur = syl.optLong("duration", 0L);
        long at = time;
        for (int i = 0; i < pieces.size(); i++) {
            String p = pieces.get(i);
            long d = i == pieces.size() - 1 ? time + dur - at : Math.round((double) dur * p.length() / total);
            JSONObject o = new JSONObject(syl.toString());
            o.put("text", p);
            o.put("time", at);
            o.put("duration", Math.max(1L, d));
            if (rc != null) o.put("romanized", rc.get(i));
            else o.remove("romanized");
            out.add(o);
            at += d;
        }
        return out;
    }

    // Walk the line, flag bracket bits, drop the marks
    private static ArrayList<Object[]> mark(JSONArray syllabus) throws Exception {
        ArrayList<Object[]> out = new ArrayList<Object[]>();
        int paren = 0;
        int brace = 0;
        for (int si = 0; si < syllabus.length(); si++) {
            JSONObject raw = syllabus.optJSONObject(si);
            if (raw == null) continue;
            for (JSONObject syl : split(raw)) {
                String t = syl.optString("text", "");
                int opensP = count(t, "([");
                int closesP = count(t, ")]");
                int opensB = count(t, "{");
                int closesB = count(t, "}");
                boolean bg = syl.optBoolean("isBackground", false) || paren > 0 || opensP > 0;
                boolean braced = brace > 0 || opensB > 0;
                paren = Math.max(0, paren + opensP - closesP);
                brace = Math.max(0, brace + opensB - closesB);

                String text = strip(t);
                if (text.trim().length() == 0) {
                    // Just a mark: keep its word gap on the last bit
                    if (out.size() > 0 && endsSpace(t)) {
                        JSONObject last = (JSONObject) out.get(out.size() - 1)[0];
                        String lt = last.optString("text", "");
                        if (!endsSpace(lt)) last.put("text", lt + " ");
                    }
                    continue;
                }
                syl.put("text", text);
                syl.put("isBackground", bg);
                String rom = syl.optString("romanized", "");
                if (rom.length() > 0) syl.put("romanized", strip(rom));
                out.add(new Object[]{syl, Boolean.valueOf(braced)});
            }
        }
        return out;
    }

    private static JSONObject lineFrom(JSONObject base, ArrayList<JSONObject> syls, String key, boolean second, boolean keepTrans)
            throws Exception {
        long start = Long.MAX_VALUE;
        long end = Long.MIN_VALUE;
        StringBuilder text = new StringBuilder();
        StringBuilder rom = new StringBuilder();
        boolean allRom = true;
        JSONArray arr = new JSONArray();
        for (JSONObject s : syls) {
            long t = s.optLong("time", 0L);
            start = Math.min(start, t);
            end = Math.max(end, t + s.optLong("duration", 0L));
            text.append(s.optString("text", ""));
            String r = s.optString("romanized", "");
            if (r.length() == 0) allRom = false;
            rom.append(r);
            arr.put(s);
        }
        JSONObject line = new JSONObject(base.toString());
        line.put("text", text.toString().trim());
        String baseRom = base.optString("romanized", "");
        if (allRom) line.put("romanized", rom.toString().trim());
        else if (baseRom.length() > 0) line.put("romanized", strip(baseRom).trim());
        else line.remove("romanized");
        line.put("startTime", start / 1000d);
        line.put("endTime", end / 1000d);
        line.put("duration", (end - start) / 1000d);
        line.put("syllabus", arr);
        JSONObject el = base.optJSONObject("element");
        el = el == null ? new JSONObject() : new JSONObject(el.toString());
        if (key != null) el.put("key", key);
        line.put("element", el);
        if (!keepTrans) {
            line.remove("translation");
            line.remove("translationSyllabus");
        }
        if (second) line.put("secondSinger", true);
        else line.remove("secondSinger");
        return line;
    }

    // New lines, null = nothing to do
    public static JSONArray apply(JSONArray data) {
        try {
            JSONArray out = new JSONArray();
            boolean changed = false;
            for (int li = 0; li < data.length(); li++) {
                JSONObject line = data.optJSONObject(li);
                JSONArray syl = line == null ? null : line.optJSONArray("syllabus");
                StringBuilder joined = new StringBuilder();
                if (syl != null) {
                    for (int i = 0; i < syl.length(); i++) {
                        JSONObject s = syl.optJSONObject(i);
                        if (s != null) joined.append(s.optString("text", ""));
                    }
                }
                if (syl == null || !hasMark(joined.toString())) {
                    out.put(line == null ? JSONObject.NULL : line);
                    continue;
                }
                changed = true;
                ArrayList<Object[]> marked = mark(syl);
                if (marked.isEmpty()) continue;

                // Braces split the line into runs (each its own line)
                ArrayList<ArrayList<JSONObject>> runs = new ArrayList<ArrayList<JSONObject>>();
                ArrayList<Boolean> runBraced = new ArrayList<Boolean>();
                for (Object[] m : marked) {
                    boolean br = (Boolean) m[1];
                    int last = runs.size() - 1;
                    if (last >= 0 && runBraced.get(last) == br) {
                        runs.get(last).add((JSONObject) m[0]);
                    } else {
                        ArrayList<JSONObject> r = new ArrayList<JSONObject>();
                        r.add((JSONObject) m[0]);
                        runs.add(r);
                        runBraced.add(br);
                    }
                }
                // Translation stays on the main run
                int main = Math.max(0, runBraced.indexOf(Boolean.FALSE));
                JSONObject el = line.optJSONObject("element");
                String key = el == null ? null : el.optString("key", null);
                for (int i = 0; i < runs.size(); i++) {
                    String k = runs.size() > 1 && key != null ? key + "-" + i : key;
                    out.put(lineFrom(line, runs.get(i), k, runBraced.get(i), i == main));
                }
            }
            return changed ? out : null;
        } catch (Throwable t) {
            RLAPILyricsHook.dlog("bracket marks failed: " + t);
            return null;
        }
    }

    // MARKER: Second singer
    // {braced} lines always go right
    public static void pin(JSONArray data, int[] sides) {
        if (data == null || sides == null) return;
        for (int i = 0; i < data.length() && i < sides.length; i++) {
            JSONObject line = data.optJSONObject(i);
            if (line != null && line.optBoolean("secondSinger", false)) sides[i] = 1;
        }
    }
}
