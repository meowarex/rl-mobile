package androidx.media3.common;
public interface Player {
    int REPEAT_MODE_ALL = 2;
    interface Listener {
        default void onRenderedFirstFrame() {}
        default void onPlayerError(PlaybackException error) {}
        default void onTracksChanged(Tracks tracks) {}
    }
    void setVideoSurface(android.view.Surface surface);
    void setRepeatMode(int mode);
    void setVolume(float volume);
    void prepare();
    void play();
    void pause();
    void release();
    void setPlaybackSpeed(float speed);
    TrackSelectionParameters getTrackSelectionParameters();
    void setTrackSelectionParameters(TrackSelectionParameters parameters);
    void addListener(Listener listener);
}
