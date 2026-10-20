package radiant;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.view.MotionEvent;
import android.view.ViewConfiguration;

import androidx.compose.runtime.Composer;
import androidx.compose.ui.Modifier;
import androidx.compose.ui.input.pointer.PointerInteropFilter_androidKt;

// Hold TIDAL's own Lyrics button for the Quick Menu
public final class RLTopButton implements yl0.l, Runnable {    // MARKER: R8 yl0.l
    private static final int TOUCH = 1;
    private static final int LONG = 2;

    private static final RLTopButton TOUCH_FN = new RLTopButton(TOUCH);
    private static final RLTopButton LONG_FN = new RLTopButton(LONG);

    // One gesture at a time on this button
    private static yl0.a click;    // MARKER: R8 yl0.a
    private static float downX, downY;
    private static boolean pending;
    private static Handler main;

    private final int mode;

    private RLTopButton(int mode) {
        this.mode = mode;
    }

    // Take its touches, its own click eats long presses
    public static Modifier wrap(Modifier modifier, yl0.a onClick, Composer composer) {
        click = onClick;
        if (RLMenu.longClick(composer) == null) return modifier;
        return PointerInteropFilter_androidKt.pointerInteropFilter$default(modifier, null, TOUCH_FN, 1, null);
    }

    @Override
    public Object invoke(Object arg) {
        return Boolean.valueOf(onTouch((MotionEvent) arg));
    }

    private static boolean onTouch(MotionEvent e) {
        Handler h = handler();
        switch (e.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
                downX = e.getX();
                downY = e.getY();
                pending = true;
                h.removeCallbacks(LONG_FN);
                h.postDelayed(LONG_FN, ViewConfiguration.getLongPressTimeout());
                return true;
            case MotionEvent.ACTION_MOVE:
                if (pending) {
                    Context c = RLSettings.app();
                    int slop = c == null ? 24 : ViewConfiguration.get(c).getScaledTouchSlop();
                    float dx = e.getX() - downX, dy = e.getY() - downY;
                    if (dx * dx + dy * dy > (float) slop * slop) {
                        pending = false;
                        h.removeCallbacks(LONG_FN);
                    }
                }
                return true;
            case MotionEvent.ACTION_UP:
                h.removeCallbacks(LONG_FN);
                // Short tap, open lyrics like normal
                if (pending && click != null) click.invoke();
                pending = false;
                return true;
            case MotionEvent.ACTION_CANCEL:
                h.removeCallbacks(LONG_FN);
                pending = false;
                return true;
            default:
                return true;
        }
    }

    // Held long enough, open the menu instead
    @Override
    public void run() {
        if (!pending) return;
        pending = false;
        RLMenu.openFromButton();
    }

    private static Handler handler() {
        Handler h = main;
        if (h == null) main = h = new Handler(Looper.getMainLooper());
        return h;
    }
}
