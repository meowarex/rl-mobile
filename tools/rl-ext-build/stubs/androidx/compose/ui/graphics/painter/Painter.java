package androidx.compose.ui.graphics.painter;

import androidx.compose.ui.graphics.ColorFilter;
import androidx.compose.ui.graphics.drawscope.DrawScope;

// build.sh fixes the mangled names
public abstract class Painter {
    public Painter() {}
    public boolean applyAlpha(float alpha) { return false; }
    public boolean applyColorFilter(ColorFilter colorFilter) { return false; }
    public final void drawxKDEd0(DrawScope scope, long size, float alpha, ColorFilter colorFilter) {}
    public abstract long getIntrinsicSizeNHjbRc();
    public abstract void onDraw(DrawScope scope);
}
