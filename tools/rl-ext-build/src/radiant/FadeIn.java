package radiant;

// First frame callback, AnimatedCoverView's run() is taken
public final class FadeIn implements Runnable {
    private final AnimatedCoverView view;

    FadeIn(AnimatedCoverView view) {
        this.view = view;
    }

    @Override
    public void run() {
        view.onFirstFrame();
    }
}
