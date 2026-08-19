package androidx.compose.runtime;
public interface Composer {
    void startReplaceGroup(int key);
    void endReplaceGroup();
    Object consume(CompositionLocal key);
}
