package android.support.v4.media.session;

import android.os.Bundle;
import android.support.v4.media.MediaMetadataCompat;

public class MediaSessionCompat {
    public MediaControllerCompat getController() { return null; }
    public void setMetadata(MediaMetadataCompat m) {}
    public void setRatingType(int t) {}

    public abstract static class Callback {
        public void onCustomAction(String a, Bundle b) {}
    }
}
