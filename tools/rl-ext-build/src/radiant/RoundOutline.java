package radiant;

import android.graphics.Outline;
import android.view.View;
import android.view.ViewOutlineProvider;

// Rounded corners for the cover overlay
public final class RoundOutline extends ViewOutlineProvider {
    private final float radius;

    public RoundOutline(float radius) {
        this.radius = radius;
    }

    @Override
    public void getOutline(View view, Outline outline) {
        outline.setRoundRect(0, 0, view.getWidth(), view.getHeight(), radius);
    }
}
