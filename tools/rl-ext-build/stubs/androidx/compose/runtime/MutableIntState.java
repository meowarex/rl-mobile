package androidx.compose.runtime;
public interface MutableIntState extends State {
    int getIntValue();
    void setIntValue(int value);
}
