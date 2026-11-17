package radiant;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.PixelFormat;
import android.graphics.drawable.Drawable;
import android.view.View;

// Ripple for the lyrics pill cover <3
public final class CoverWaveView extends Drawable implements View.OnLayoutChangeListener {
    // Cover the view shows now
    String cover;

    @Override
    public void draw(Canvas canvas) {
        int w = getBounds().width();
        int h = getBounds().height();
        if (w > 1 && h > 1) CoverWave.drawView(canvas, cover, w, h);
    }

    @Override
    public void onLayoutChange(View v, int l, int t, int r, int b, int ol, int ot, int or, int ob) {
        setBounds(0, 0, r - l, b - t);
    }

    @Override
    public void setAlpha(int alpha) {}

    @Override
    public void setColorFilter(ColorFilter filter) {}

    @Override
    public int getOpacity() {
        return PixelFormat.TRANSLUCENT;
    }
}
