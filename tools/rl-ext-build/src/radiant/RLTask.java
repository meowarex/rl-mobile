package radiant;

// RLLyrics jobs and posts, no lambdas in the ext build
public final class RLTask implements Runnable {
    static final int AUTO_SYLLA = 0;
    static final int FLUSH = 1;
    static final int TOAST = 3;
    static final int BUMP = 4;
    static final int REFETCH = 5;

    private final int op;
    private final Object a;
    private final Object b;
    private final Object c;
    private final int n;

    RLTask(int op, Object a, Object b, Object c, int n) {
        this.op = op;
        this.a = a;
        this.b = b;
        this.c = c;
        this.n = n;
    }

    @Override
    public void run() {
        try {
            switch (op) {
                case AUTO_SYLLA:
                    RLLyrics.runAutoSylla((RLAPILyricsWorker) a, (String) b, (String) c, n);
                    break;
                case FLUSH:
                    RLLyrics.runFlush();
                    break;
                case TOAST:
                    RLLyrics.showToast((String) a, n != 0);
                    break;
                case BUMP:
                    RLLyrics.bumpNow();
                    break;
                case REFETCH:
                    RLLyrics.runRefetch((RLAPILyricsWorker) a);
                    break;
            }
        } catch (Throwable t) {
            RLAPILyricsHook.dlog("RLTask " + op + " failed: " + t);
        }
    }
}
