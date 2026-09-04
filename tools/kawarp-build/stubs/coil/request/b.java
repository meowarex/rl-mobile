package coil.request;
// MARKER: R8 whole class: TIDAL dex FQN is `coil.request.b` - both package and name roll
import kotlinx.coroutines.CoroutineDispatcher;
/**
 * coil.request.DefaultRequestOptions; i/j/k are the memory/disk/network cache policies (proven
 * via h$a.a() -> ImageRequest.o/p/q -> Options.m/n/o, the last of which HttpUriFetcher gates on).
 * Fields are deliberately non-final: a `final boolean h = false` would be a compile-time constant
 * and javac would fold the read away instead of emitting iget-boolean. (claude)
 */
public final class b {
    public CoroutineDispatcher a, b, c, d;
    public d0.c.a e;  // MARKER: R8 d0.c.a
    public coil.size.Precision f;
    public android.graphics.Bitmap.Config g;
    public boolean h;
    public CachePolicy i, j, k;
    public b(CoroutineDispatcher a, CoroutineDispatcher b, CoroutineDispatcher c, CoroutineDispatcher d,
             d0.c.a transition, coil.size.Precision precision, android.graphics.Bitmap.Config config,  // MARKER: R8 d0.c.a
             boolean h, CachePolicy memory, CachePolicy disk, CachePolicy network) {}
}
