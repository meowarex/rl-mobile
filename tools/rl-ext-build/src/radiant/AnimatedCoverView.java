package radiant;

import android.graphics.SurfaceTexture;
import android.view.Surface;
import android.view.TextureView;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.ImageView;

import java.util.ArrayList;
import java.util.Iterator;
import java.lang.ref.WeakReference;

// Animated cover over the lyrics pill cover
public final class AnimatedCoverView extends TextureView implements TextureView.SurfaceTextureListener,
        View.OnLayoutChangeListener, View.OnAttachStateChangeListener, Runnable {

    private static final ArrayList<WeakReference<AnimatedCoverView>> live = new ArrayList<WeakReference<AnimatedCoverView>>();

    private final ImageView target;
    private final ViewGroup host;
    private int albumId = -1;
    private String url;
    private ArtPlayer player;
    // First frame callback, for the fade in
    private final FadeIn fadeIn = new FadeIn(this);
    private boolean outlined;
    private Surface surface;

    private AnimatedCoverView(ImageView target, ViewGroup host) {
        super(target.getContext());
        this.target = target;
        this.host = host;
        setOpaque(false);
        setAlpha(0f);
        setVisibility(View.INVISIBLE);
        setSurfaceTextureListener(this);
        setImportantForAccessibility(View.IMPORTANT_FOR_ACCESSIBILITY_NO);
    }

    // Pill cover was loaded
    public static void attach(ImageView image, int albumId) {
        try {
            if (image == null) return;
            AnimatedCoverView v = find(image);
            if (v == null) {
                // Use the CardView, ConstraintSet crashes otherwise
                ViewGroup host = frameAncestor(image);
                if (host == null) return;
                v = new AnimatedCoverView(image, host);
                v.setId(View.generateViewId());
                host.addView(v, new ViewGroup.LayoutParams(Math.max(1, image.getWidth()), Math.max(1, image.getHeight())));
                image.addOnLayoutChangeListener(v);
                image.addOnAttachStateChangeListener(v);
                if (image.getParent() instanceof View && image.getParent() != host) {
                    ((View) image.getParent()).addOnLayoutChangeListener(v);
                }
                live.add(new WeakReference<AnimatedCoverView>(v));
                v.sync();
            }
            v.albumId = albumId;
            v.refresh();
        } catch (Throwable ignored) {
        }
    }

    // New cover URL, update every overlay
    static void refreshAll() {
        try {
            Iterator<WeakReference<AnimatedCoverView>> it = live.iterator();
            while (it.hasNext()) {
                AnimatedCoverView v = it.next().get();
                if (v == null) it.remove();
                else v.refresh();
            }
        } catch (Throwable ignored) {
        }
    }

    private static ViewGroup frameAncestor(View view) {
        ViewParent p = view.getParent();
        while (p instanceof ViewGroup) {
            if (p instanceof android.widget.FrameLayout) return (ViewGroup) p;
            p = p.getParent();
        }
        return null;
    }

    private static AnimatedCoverView find(ImageView image) {
        Iterator<WeakReference<AnimatedCoverView>> it = live.iterator();
        while (it.hasNext()) {
            AnimatedCoverView v = it.next().get();
            if (v == null) it.remove();
            else if (v.target == image) return v;
        }
        return null;
    }

    private void refresh() {
        String u = AnimatedCovers.urlFor(albumId);
        if (u == null ? url == null : u.equals(url)) return;
        release();
        url = u;
        if (u == null) {
            setAlpha(0f);
            setVisibility(View.INVISIBLE);
            return;
        }
        setAlpha(0f);
        setVisibility(View.VISIBLE);
        start();
    }

    private void start() {
        if (url == null || surface == null || player != null) return;
        player = ArtPlayer.start(getContext(), url, surface, getWidth(), getHeight(), fadeIn);
    }

    private void release() {
        ArtPlayer p = player;
        player = null;
        if (p != null) p.release();
    }

    // Fade in on the first frame, 300ms like desktop
    void onFirstFrame() {
        animate().alpha(1f).setDuration(300L).start();
    }

    // Line up with the cover
    private void sync() {
        ViewGroup.LayoutParams lp = getLayoutParams();
        int w = Math.max(1, target.getWidth());
        int h = Math.max(1, target.getHeight());
        if (lp != null && (lp.width != w || lp.height != h)) {
            lp.width = w;
            lp.height = h;
            setLayoutParams(lp);
        }
        // Cover position inside the card
        float x = 0f, y = 0f;
        View v = target;
        while (v != null && v != host) {
            x += v.getLeft() + v.getTranslationX();
            y += v.getTop() + v.getTranslationY();
            ViewParent p = v.getParent();
            v = p instanceof View ? (View) p : null;
        }
        if (v == null) return;
        setTranslationX(x - getLeft());
        setTranslationY(y - getTop());
        if (!outlined) {
            // Same corner radius as the cover
            outlined = true;
            float r = 0f;
            try {
                r = getResources().getDimension(com.aspiro.wamp.R.dimen.image_header_corner_radius);
            } catch (Throwable ignored) {
            }
            setOutlineProvider(new RoundOutline(r));
            setClipToOutline(true);
        }
        if (target.getVisibility() != View.VISIBLE && getVisibility() == View.VISIBLE) setVisibility(View.INVISIBLE);
    }

    // Re-align after layout
    @Override
    public void run() {
        try {
            sync();
        } catch (Throwable ignored) {
        }
    }

    @Override
    public void onLayoutChange(View v, int l, int t, int r, int b, int ol, int ot, int or, int ob) {
        post(this);
    }

    @Override
    public void onViewAttachedToWindow(View v) {
        try {
            refresh();
        } catch (Throwable ignored) {
        }
    }

    @Override
    public void onViewDetachedFromWindow(View v) {
        release();
        url = null;
    }

    @Override
    public void onSurfaceTextureAvailable(SurfaceTexture st, int w, int h) {
        surface = new Surface(st);
        start();
    }

    @Override
    public void onSurfaceTextureSizeChanged(SurfaceTexture st, int w, int h) {
    }

    @Override
    public boolean onSurfaceTextureDestroyed(SurfaceTexture st) {
        release();
        url = null;
        if (surface != null) surface.release();
        surface = null;
        return true;
    }

    @Override
    public void onSurfaceTextureUpdated(SurfaceTexture st) {
    }
}
