package radiant;

import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.os.SystemClock;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowInsets;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import androidx.compose.foundation.ClickableKt;
import androidx.compose.runtime.Composer;
import androidx.compose.ui.Modifier;
import androidx.compose.ui.platform.AndroidCompositionLocals_androidKt;

import com.aspiro.wamp.contextmenu.presentation.header.track.BottomSheetTrackHeader;
import com.aspiro.wamp.model.Track;
import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.bottomsheet.BottomSheetDialog;

// Quick Menu, long press the sparkle for lyrics options
public final class RLMenu implements yl0.a, View.OnClickListener, View.OnApplyWindowInsetsListener {
    private static final String TAG = "RLMenu";

    private static final int OPEN = 0;
    private static final int NOOP = 1;
    private static final int ROMANIZE = 10;
    private static final int TRANSLATE = 11;
    private static final int LANGUAGES = 12;
    private static final int PICK_LANGUAGE = 13;
    private static final int BACK = 14;
    private static final int RADIANT_AI = 15;
    private static final int SYNC = 16;
    private static final int FLUSH = 17;

    private static final RLMenu OPEN_FN = new RLMenu(OPEN, 0);
    private static final RLMenu NOOP_FN = new RLMenu(NOOP, 0);
    private static final RLMenu INSETS = new RLMenu(NOOP, 0);

    // Same colours as the AI sparkle
    private static final int[] RAINBOW = {0xFFFF6B9D, 0xFFFFD166, 0xFF5EE7FF, 0xFFA78BFA};

    // Compose view, to find the Activity
    private static View hostView;
    private static BottomSheetDialog dialog;
    private static LinearLayout list;
    private static boolean languagePage;
    private static long lastOpenMs;

    private final int action;
    private final int arg;

    private RLMenu(int action, int arg) {
        this.action = action;
        this.arg = arg;
    }

    // MARKER: sparkle button hooks (SparkleButton.smali)

    // Sparkle onLongClick, null without the RL API
    public static yl0.a longClick(Composer composer) {
        if (!RLSettings.rlActive || !RLSettings.quickMenu()) return null;
        try {
            Object v = composer.consume(AndroidCompositionLocals_androidKt.getLocalView());
            if (v instanceof View) hostView = (View) v;
        } catch (Throwable t) {
            Log.w(TAG, "no LocalView", t);
        }
        return OPEN_FN;
    }

    // Disabled button drops long presses, catch them outside
    public static Modifier wrap(Modifier modifier, boolean enabled) {
        if (enabled || !RLSettings.rlActive || !RLSettings.quickMenu()) return modifier;
        return ClickableKt.combinedClickableauXiCPI(modifier, null, null, true, null, null, null, OPEN_FN, null, true, NOOP_FN);
    }

    @Override
    public Object invoke() {
        if (action == OPEN) open();
        return kotlin.u.a;
    }

    private static void open() {
        if (!RLSettings.rlActive || !RLSettings.quickMenu()) return;
        long now = SystemClock.uptimeMillis();
        if (now - lastOpenMs < 600L) return;
        lastOpenMs = now;
        if (dialog != null && dialog.isShowing()) return;
        Activity a = activity(hostView);
        if (a == null || a.isFinishing()) return;
        try {
            show(a);
        } catch (Throwable t) {
            Log.e(TAG, "menu failed", t);
        }
    }

    // TIDAL's Lyrics button was held, buzz and open
    static void openFromButton() {
        View v = hostView;
        if (v != null) v.performHapticFeedback(android.view.HapticFeedbackConstants.LONG_PRESS);
        open();
    }

    private static Activity activity(View v) {
        Context c = v == null ? null : v.getContext();
        while (c instanceof ContextWrapper) {
            if (c instanceof Activity) return (Activity) c;
            c = ((ContextWrapper) c).getBaseContext();
        }
        return null;
    }

    // MARKER: sheet (same look as the player 3 dot menu)

    private static void show(Activity a) {
        BottomSheetDialog d = new BottomSheetDialog(a, res(a, "BottomSheetDialogTheme", "style"));
        Context c = d.getContext();
        ViewGroup root = (ViewGroup) LayoutInflater.from(c).inflate(res(c, "bottom_sheet_context_menu_dialog", "layout"), null);
        int headerId = res(c, "headerContainer", "id");
        FrameLayout header = (FrameLayout) root.findViewById(headerId);
        View rv = root.findViewById(res(c, "recyclerView", "id"));
        Track t = RLLyrics.track;
        if (t != null && header != null) {
            try {
                header.addView(new BottomSheetTrackHeader(c, t));
            } catch (Throwable e) {
                // Header is optional, it needs album artwork
                Log.w(TAG, "no track header", e);
            }
        }

        // Plain list instead of TIDAL's adapter
        ScrollView scroll = new ScrollView(c);
        scroll.setNestedScrollingEnabled(true);
        scroll.setClipToPadding(false);
        Drawable bg = rv == null ? null : rv.getBackground();
        if (bg != null && bg.getConstantState() != null) scroll.setBackground(bg.getConstantState().newDrawable());
        if (rv != null) rv.setVisibility(View.GONE);
        LinearLayout rows = new LinearLayout(c);
        rows.setOrientation(LinearLayout.VERTICAL);
        scroll.addView(rows, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp.addRule(RelativeLayout.BELOW, headerId);
        root.addView(scroll, lp);
        scroll.setOnApplyWindowInsetsListener(INSETS);

        d.setContentView(root);
        if (root.getParent() instanceof View) ((View) root.getParent()).setBackgroundColor(c.getColor(android.R.color.transparent));
        try {
            BottomSheetBehavior b = d.getBehavior();
            b.setSkipCollapsed(true);
            b.setState(3);    // STATE_EXPANDED
        } catch (Throwable e) {
            Log.w(TAG, "behavior", e);
        }

        dialog = d;
        list = rows;
        languagePage = false;
        refresh();
        d.show();
        scroll.requestApplyInsets();
    }

    // Keep the last row above the nav bar
    @Override
    public WindowInsets onApplyWindowInsets(View v, WindowInsets insets) {
        int bottom = android.os.Build.VERSION.SDK_INT >= 30
                ? insets.getInsets(WindowInsets.Type.navigationBars()).bottom
                : insets.getSystemWindowInsetBottom();
        v.setPadding(v.getPaddingLeft(), v.getPaddingTop(), v.getPaddingRight(), bottom);
        return insets;
    }

    // Rebuild rows from current settings
    private static void refresh() {
        LinearLayout l = list;
        if (l == null) return;
        l.removeAllViews();
        Context c = l.getContext();
        if (languagePage) {
            l.addView(item(l, "ic_arrows_left_medium", "Translation Language", true, BACK, 0));
            int cur = RLSettings.languageIndex();
            for (int i = 0; i < RLSettings.LANG_LABELS.length; i++) {
                View row = item(l, "ic_social_globe_large", RLSettings.LANG_LABELS[i], true, PICK_LANGUAGE, i);
                if (i == cur) row = withEnd(l, row, icon(c, "ic_arrows_checkmark_large", true));
                l.addView(row);
            }
            return;
        }

        l.addView(syncRow(l));
        l.addView(toggle(l, "ic_text_formatting_alphabetical_large", "Romanization", RLSettings.romanize(), ROMANIZE));
        l.addView(toggle(l, "ic_social_globe_large", "Translation", RLSettings.translate(), TRANSLATE));
        if (RLSettings.translate()) {
            View row = item(l, "ic_text_formatting_list_large", "Translation Language", true, LANGUAGES, 0);
            TextView value = new TextView(c);
            value.setText(RLSettings.LANG_LABELS[RLSettings.languageIndex()] + "  ›");
            value.setTextColor(0x99FFFFFF);
            value.setTextSize(14f);
            l.addView(withEnd(l, row, value));
        }
        boolean ai = RLSettings.allowAI();
        if (ai) {
            l.addView(toggle(l, "ic_sparkle", "Radiant AI", RLSettings.radiantAI(), RADIANT_AI));
        }

        boolean busy = RLLyrics.busy;
        String key = RLLyrics.trackKey;
        boolean retime = ai && key != null && key.equals(RLLyrics.retimeTrack);
        View flush = retime
                ? item(l, "ic_media_lyric_sync_medium", "Retime Lyrics using Sylla!", !busy, FLUSH, 0)
                : item(l, "ic_media_lyric_sync_medium", "Flush Lyrics", !busy, FLUSH, 0);
        if (retime && !busy) rainbow(flush);
        l.addView(flush);
    }

    // TIDAL's context_menu_item row
    private static View item(ViewGroup parent, String iconName, CharSequence title, boolean enabled, int action, int arg) {
        Context c = parent.getContext();
        View v = LayoutInflater.from(c).inflate(res(c, "context_menu_item", "layout"), parent, false);
        ImageView icon = (ImageView) v.findViewById(res(c, "icon", "id"));
        TextView tv = (TextView) v.findViewById(res(c, "title", "id"));
        int color = color(c, enabled);
        if (icon != null) {
            Drawable d = drawable(c, iconName);
            if (d != null) {
                d = d.mutate();
                d.setTint(color);
                icon.setImageDrawable(d);
                int px = dp(c, 24);
                ViewGroup.LayoutParams ip = icon.getLayoutParams();
                if (ip != null) {
                    ip.width = px;
                    ip.height = px;
                    icon.setLayoutParams(ip);
                }
            }
        }
        if (tv != null) {
            tv.setText(title);
            tv.setTextColor(color);
        }
        v.setEnabled(enabled);
        v.setOnClickListener(enabled ? new RLMenu(action, arg) : null);
        return v;
    }

    private static View toggle(ViewGroup parent, String iconName, String title, boolean on, int action) {
        View row = item(parent, iconName, title, true, action, 0);
        ImageView sw = new ImageView(parent.getContext());
        sw.setImageDrawable(new RLSwitch(on, true, parent.getContext().getResources().getDisplayMetrics().density));
        return withEnd(parent, row, sw);
    }

    // Row with a switch, value or check at the end
    private static View withEnd(ViewGroup parent, View row, View end) {
        Context c = parent.getContext();
        FrameLayout f = new FrameLayout(c);
        ViewGroup.LayoutParams rp = row.getLayoutParams();
        int h = rp != null && rp.height > 0 ? rp.height : dp(c, 56);
        f.addView(row, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, h));
        FrameLayout.LayoutParams ep = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT,
                Gravity.END | Gravity.CENTER_VERTICAL);
        ep.setMarginEnd(dp(c, 16));
        end.setClickable(false);
        end.setImportantForAccessibility(View.IMPORTANT_FOR_ACCESSIBILITY_NO);
        f.addView(end, ep);
        f.setLayoutParams(new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, h));
        return f;
    }

    // Line | Word | Syllable segmented control
    private static View syncRow(ViewGroup parent) {
        Context c = parent.getContext();
        View row = item(parent, "ic_media_lyrics_large", "", true, NOOP, 0);
        row.setOnClickListener(null);
        row.setClickable(false);
        FrameLayout f = new FrameLayout(c);
        ViewGroup.LayoutParams rp = row.getLayoutParams();
        int h = rp != null && rp.height > 0 ? rp.height : dp(c, 56);
        f.addView(row, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, h));

        LinearLayout seg = new LinearLayout(c);
        seg.setOrientation(LinearLayout.HORIZONTAL);
        GradientDrawable track = new GradientDrawable();
        track.setCornerRadius(dp(c, 10));
        track.setColor(0x1FFFFFFF);
        seg.setBackground(track);
        int pad = dp(c, 3);
        seg.setPadding(pad, pad, pad, pad);
        int cur = RLSettings.sync();
        for (int i = 0; i < RLSettings.SYNC_LABELS.length; i++) {
            TextView b = new TextView(c);
            b.setText(RLSettings.SYNC_LABELS[i]);
            b.setGravity(Gravity.CENTER);
            b.setTextSize(13f);
            b.setTypeface(Typeface.DEFAULT_BOLD);
            if (i == cur) {
                GradientDrawable sel = new GradientDrawable();
                sel.setCornerRadius(dp(c, 8));
                sel.setColor(0xFFFFFFFF);
                b.setBackground(sel);
                b.setTextColor(0xFF000000);
            } else {
                b.setTextColor(0xB3FFFFFF);
            }
            b.setOnClickListener(new RLMenu(SYNC, i));
            seg.addView(b, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.MATCH_PARENT, 1f));
        }
        FrameLayout.LayoutParams sp = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, dp(c, 36), Gravity.CENTER_VERTICAL);
        sp.setMarginStart(dp(c, 72));
        sp.setMarginEnd(dp(c, 16));
        f.addView(seg, sp);
        f.setLayoutParams(new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, h));
        return f;
    }

    // Rainbow icon for the Sylla retime
    private static void rainbow(View row) {
        ImageView icon = (ImageView) row.findViewById(res(row.getContext(), "icon", "id"));
        if (icon == null || icon.getDrawable() == null) return;
        int px = dp(row.getContext(), 24);
        Bitmap b = Bitmap.createBitmap(px, px, Bitmap.Config.ARGB_8888);
        Canvas cv = new Canvas(b);
        Drawable d = icon.getDrawable();
        d.setTint(0xFFFFFFFF);
        d.setBounds(0, 0, px, px);
        d.draw(cv);
        // Gradient only where the icon is
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
        p.setShader(new LinearGradient(0f, 0f, px, 0f, RAINBOW, null, Shader.TileMode.CLAMP));
        p.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
        cv.drawRect(0f, 0f, px, px, p);
        icon.setImageBitmap(b);
    }

    @Override
    public void onClick(View v) {
        try {
            switch (action) {
                case ROMANIZE:
                    RLSettings.setRomanize(!RLSettings.romanize());
                    break;
                case TRANSLATE:
                    RLSettings.setTranslate(!RLSettings.translate());
                    break;
                case LANGUAGES:
                    languagePage = true;
                    break;
                case PICK_LANGUAGE:
                    languagePage = false;
                    if (arg != RLSettings.languageIndex()) RLSettings.setLanguage(arg);
                    break;
                case BACK:
                    languagePage = false;
                    break;
                case RADIANT_AI:
                    RLSettings.setRadiantAI(!RLSettings.radiantAI());
                    break;
                case SYNC:
                    if (arg != RLSettings.sync()) RLSettings.setSync(arg);
                    break;
                case FLUSH:
                    dismiss();
                    RLLyrics.flush();
                    return;
                default:
                    return;
            }
            refresh();
        } catch (Throwable t) {
            Log.e(TAG, "action " + action + " failed", t);
        }
    }

    private static void dismiss() {
        BottomSheetDialog d = dialog;
        dialog = null;
        list = null;
        if (d != null && d.isShowing()) d.dismiss();
    }

    // MARKER: resources by name (R fields change between builds)

    private static int res(Context c, String name, String type) {
        Resources r = c.getResources();
        String pkg;
        try {
            pkg = r.getResourcePackageName(com.aspiro.wamp.R.drawable.ic_music_note);
        } catch (Throwable t) {
            pkg = c.getPackageName();
        }
        return r.getIdentifier(name, type, pkg);
    }

    private static Drawable drawable(Context c, String name) {
        int id = res(c, name, "drawable");
        if (id == 0) id = res(c, "ic_sparkle", "drawable");
        try {
            return id == 0 ? null : c.getDrawable(id);
        } catch (Throwable t) {
            return null;
        }
    }

    private static ImageView icon(Context c, String name, boolean enabled) {
        ImageView iv = new ImageView(c);
        Drawable d = drawable(c, name);
        if (d != null) {
            d = d.mutate();
            d.setTint(color(c, enabled));
            iv.setImageDrawable(d);
        }
        return iv;
    }

    // Same colours as TIDAL's menu rows
    private static int color(Context c, boolean enabled) {
        int id = res(c, enabled ? "white" : "glass_darken_20", "color");
        try {
            return id == 0 ? (enabled ? 0xFFFFFFFF : 0x33FFFFFF) : c.getColor(id);
        } catch (Throwable t) {
            return enabled ? 0xFFFFFFFF : 0x33FFFFFF;
        }
    }

    private static int dp(Context c, int v) {
        return Math.round(v * c.getResources().getDisplayMetrics().density);
    }
}
