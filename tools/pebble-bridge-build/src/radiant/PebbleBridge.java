package radiant;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.media.MediaMetadata;
import android.media.session.MediaController;
import android.media.session.MediaSession;
import android.media.session.PlaybackState;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.SystemClock;
import android.support.v4.media.session.MediaSessionCompat;
import android.util.Log;

// Sends TIDAL playback and lyrics to the Manager relay
public final class PebbleBridge implements ServiceConnection {
    private static final String TAG = "RLPebble";
    private static final String MANAGER_PACKAGE = "com.meowarex.rlmobile";
    private static final String RELAY_SERVICE = "com.meowarex.rlmobile.pebble.PebbleRelayService";

    // Keep in sync with PebbleRelayService
    private static final int MSG_SESSION = 1;
    private static final int MSG_POSITION = 2;
    private static final int MSG_LYRICS = 3;

    // Resend when drift exceeds this
    private static final long TOLERANCE_MS = 15L;
    private static final long KEEPALIVE_MS = 5000L;

    private static final Handler MAIN = new Handler(Looper.getMainLooper());
    private static final Object LOCK = new Object();

    private static PebbleBridge instance;

    // Written by the player thread
    private static long rawPosition = -1L;
    private static long rawAt;

    // Written by the lyrics worker
    private static String lyricsKey;
    private static String lyricsTitle;
    private static String lyricsBody;
    private static boolean lyricsFailed;

    private final Context context;
    private MediaSession.Token token;
    private MediaController controller;
    private Messenger relay;
    private boolean bound;
    private long retryBindAt;

    private boolean playing;
    private String mediaId;
    private long sentPosition = -1L;
    private long sentAt;
    private boolean sentPlaying;
    private long lastSendAt;

    private PebbleBridge(Context context) {
        this.context = context;
    }

    public static void onState(Context service, MediaSessionCompat session) {
        try {
            if (instance == null) {
                Context app = service.getApplicationContext();
                instance = new PebbleBridge(app != null ? app : service);
            }
            instance.update(session);
        } catch (Throwable t) {
            Log.w(TAG, "onState failed", t);
        }
    }

    public static void onDestroy() {
        try {
            if (instance != null) {
                instance.release();
                instance = null;
            }
        } catch (Throwable t) {
            Log.w(TAG, "onDestroy failed", t);
        }
    }

    // Player thread, after getCurrentPosition
    public static void onPosition(long position) {
        final long at = SystemClock.elapsedRealtime();
        synchronized (LOCK) {
            rawPosition = position;
            rawAt = at;
        }
        if (instance == null) return;
        if (Looper.myLooper() == Looper.getMainLooper()) {
            onSample(position, at);
        } else {
            MAIN.post(new Runnable() {
                @Override
                public void run() {
                    onSample(position, at);
                }
            });
        }
    }

    // Lyrics worker thread, null body means failed
    public static void onLyrics(String key, String title, String body) {
        synchronized (LOCK) {
            if (body == null && key != null && key.equals(lyricsKey) && lyricsBody != null) {
                // Keep a body that had no lines
                return;
            }
            lyricsKey = key;
            lyricsTitle = title;
            lyricsBody = body;
            lyricsFailed = body == null;
        }
        MAIN.post(new Runnable() {
            @Override
            public void run() {
                if (instance != null) instance.sendLyrics();
            }
        });
    }

    private static void onSample(long position, long at) {
        PebbleBridge bridge = instance;
        if (bridge != null) bridge.consider(position, at, false);
    }

    private void update(MediaSessionCompat session) {
        if (session == null) return;
        MediaSessionCompat.Token compat = session.getSessionToken();
        Object raw = compat != null ? compat.getToken() : null;
        if (!(raw instanceof MediaSession.Token)) return;

        if (!raw.equals(token)) {
            token = (MediaSession.Token) raw;
            controller = new MediaController(context, token);
            sendSession();
        }

        if (!bound && SystemClock.elapsedRealtime() >= retryBindAt) {
            Intent intent = new Intent().setComponent(new ComponentName(MANAGER_PACKAGE, RELAY_SERVICE));
            try {
                bound = context.bindService(intent, this, Context.BIND_AUTO_CREATE);
            } catch (Throwable t) {
                bound = false;
            }
            if (!bound) {
                // Manager missing, retry in a minute
                retryBindAt = SystemClock.elapsedRealtime() + 60000L;
                try {
                    context.unbindService(this);
                } catch (Throwable ignored) {
                }
                Log.i(TAG, "RL Manager relay not available");
            }
        }

        boolean wasPlaying = playing;
        playing = readPlaying();
        MediaMetadata metadata = controller != null ? controller.getMetadata() : null;
        String id = metadata != null ? metadata.getString(MediaMetadata.METADATA_KEY_MEDIA_ID) : null;
        boolean trackChanged = id != null && !id.equals(mediaId);
        mediaId = id;

        if (trackChanged) {
            // Next poll sends the new track
            sentPosition = -1L;
        } else if (wasPlaying != playing) {
            // Don't wait for the next poll
            sendLatest(wasPlaying);
        }
    }

    // Extrapolates the last reading to now
    private void sendLatest(boolean advance) {
        long position;
        long at;
        synchronized (LOCK) {
            position = rawPosition;
            at = rawAt;
        }
        if (position < 0) return;
        long now = SystemClock.elapsedRealtime();
        consider(advance ? position + (now - at) : position, now, true);
    }

    private boolean readPlaying() {
        PlaybackState state = controller != null ? controller.getPlaybackState() : null;
        return state != null && state.getState() == PlaybackState.STATE_PLAYING;
    }

    private void consider(long position, long at, boolean force) {
        long predicted = sentPlaying ? sentPosition + (at - sentAt) : sentPosition;
        boolean drifted = sentPosition < 0 || Math.abs(position - predicted) > TOLERANCE_MS;
        if (!force && !drifted && sentPlaying == playing && at - lastSendAt < KEEPALIVE_MS) return;
        if (sendPosition(position, at)) {
            sentPosition = position;
            sentAt = at;
            sentPlaying = playing;
            lastSendAt = at;
        }
    }

    private void release() {
        if (bound) {
            try {
                context.unbindService(this);
            } catch (Throwable ignored) {
            }
        }
        bound = false;
        relay = null;
    }

    private void sendSession() {
        if (relay == null || token == null) return;
        Bundle data = new Bundle();
        data.putParcelable("token", token);
        data.putString("package", context.getPackageName());
        send(MSG_SESSION, data);
    }

    private boolean sendPosition(long position, long at) {
        if (relay == null) return false;
        Bundle data = new Bundle();
        data.putLong("position", position);
        data.putLong("elapsedRealtime", at);
        data.putBoolean("playing", playing);
        if (mediaId != null) data.putString("mediaId", mediaId);
        return send(MSG_POSITION, data);
    }

    private void sendLyrics() {
        if (relay == null) return;
        Bundle data = new Bundle();
        synchronized (LOCK) {
            if (lyricsKey == null) return;
            data.putString("key", lyricsKey);
            data.putString("title", lyricsTitle);
            if (lyricsBody != null) data.putString("body", lyricsBody);
            data.putBoolean("failed", lyricsFailed);
        }
        send(MSG_LYRICS, data);
    }

    private boolean send(int what, Bundle data) {
        Messenger target = relay;
        if (target == null) return false;
        try {
            Message message = Message.obtain(null, what);
            message.setData(data);
            target.send(message);
            return true;
        } catch (Throwable t) {
            relay = null;
            return false;
        }
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        relay = new Messenger(service);
        sendSession();
        sentPosition = -1L;
        sendLatest(playing);
        sendLyrics();
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        relay = null;
    }

    @Override
    public void onBindingDied(ComponentName name) {
        relay = null;
        if (bound) {
            try {
                context.unbindService(this);
            } catch (Throwable ignored) {
            }
            bound = false;
        }
    }

    @Override
    public void onNullBinding(ComponentName name) {
        onBindingDied(name);
    }
}
