package radiant;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.PixelFormat;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;

// Pill toggle for the sparkle menu rows
public final class RLSwitch extends Drawable {
    private final boolean on;
    private final boolean enabled;
    private final int w;
    private final int h;
    private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final RectF rect = new RectF();

    RLSwitch(boolean on, boolean enabled, float density) {
        this.on = on;
        this.enabled = enabled;
        this.w = Math.round(40f * density);
        this.h = Math.round(24f * density);
    }

    @Override
    public void draw(Canvas canvas) {
        android.graphics.Rect b = getBounds();
        float bw = b.width(), bh = b.height();
        float r = bh / 2f;
        int alpha = enabled ? 0xFF : 0x66;
        rect.set(b.left, b.top, b.left + bw, b.top + bh);
        paint.setColor(on ? 0xFFFFFFFF : 0x33FFFFFF);
        paint.setAlpha(on ? alpha : Math.min(alpha, 0x33));
        canvas.drawRoundRect(rect, r, r, paint);
        float inset = bh * 0.15f;
        float kr = r - inset;
        float cx = on ? b.left + bw - r : b.left + r;
        paint.setColor(on ? 0xFF000000 : 0xFFFFFFFF);
        paint.setAlpha(on ? alpha : (enabled ? 0xCC : 0x55));
        canvas.drawCircle(cx, b.top + r, kr, paint);
    }

    @Override
    public int getIntrinsicWidth() {
        return w;
    }

    @Override
    public int getIntrinsicHeight() {
        return h;
    }

    @Override
    public void setAlpha(int alpha) {}

    @Override
    public void setColorFilter(ColorFilter colorFilter) {}

    @Override
    public int getOpacity() {
        return PixelFormat.TRANSLUCENT;
    }
}
