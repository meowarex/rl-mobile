package android.support.v4.media;

public final class MediaMetadataCompat {
    public boolean containsKey(String k) { return false; }
    public long getLong(String k) { return 0L; }
    public String getString(String k) { return null; }

    public static final class Builder {
        public Builder(MediaMetadataCompat m) {}
        public Builder putString(String k, String v) { return this; }
        public Builder putRating(String k, RatingCompat v) { return this; }
        public MediaMetadataCompat build() { return null; }
    }
}
