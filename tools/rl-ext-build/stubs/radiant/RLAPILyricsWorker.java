package radiant;
import com.tidal.android.feature.playerscreen.ui.PlayerViewModel;
// Handwritten smali
public final class RLAPILyricsWorker implements Runnable {
    public static volatile RLAPILyricsWorker last;
    public final PlayerViewModel vm = null;
    public final String title = null, artist = null, key = null, lyricsId = null;
    public RLAPILyricsWorker(PlayerViewModel vm, String title, String artist, String key, String lyricsId) {}
    public boolean publish(String body) { return false; }
    public static void pushTo(PlayerViewModel vm, Object state) {}
    public boolean isLive() { return false; }
    static String clientIp() { return null; }
    static String uric(String s) { return null; }
    public static java.util.ArrayList parseLines(String b) { return null; }
    public void run() {}
}
