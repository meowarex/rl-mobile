package androidx.media3.exoplayer;
public interface ExoPlayer extends androidx.media3.common.Player {
    void setMediaSource(androidx.media3.exoplayer.source.MediaSource source);
    androidx.media3.common.Format getVideoFormat();
    final class Builder {
        public Builder(android.content.Context context) {}
        public ExoPlayer build() { return null; }
    }
}
