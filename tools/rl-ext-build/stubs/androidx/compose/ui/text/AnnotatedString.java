package androidx.compose.ui.text;
public final class AnnotatedString {
    public int getLength() { return 0; }
    public String getText() { return null; }
    public static final class Builder {
        public Builder() {}
        public Builder(String text) {}
        public Builder(AnnotatedString text) {}
        public final void append(String text) {}
        public final void append(AnnotatedString text) {}
        public final void addStyle(SpanStyle style, int start, int end) {}
        public final void addStyle(ParagraphStyle style, int start, int end) {}
        public final int getLength() { return 0; }
        public final AnnotatedString toAnnotatedString() { return null; }
    }
}
