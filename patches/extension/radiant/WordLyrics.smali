.class public final Lradiant/WordLyrics;
.super Ljava/lang/Object;

# Word-level lyrics highlighting support for the RL-API lyrics injection.
# Parses the API "Word" payload (per-line syllabus[]) into per-line word arrays,
# runs a 50ms main-thread clock that publishes an interpolated playhead into a Compose
# MutableState, and builds a two-tone AnnotatedString (sung / unsung) that the patched
# PlayerScreen line composable (f2) renders for whatever line Compose marks active.
# Line-level data (scroll, line index) still comes from TIDAL's own g$c pipeline.
#
# ROBUSTNESS: render() gates on Compose's OWN active-line index (f2.b) — not a clock
# guess — and the active line ALWAYS reads the playhead state, so it can never lose its
# recomposition subscription and get stranded on line-highlighting.


# static state

.field public static lineStarts:[J

.field public static lineWordText:[[Ljava/lang/String;

.field public static lineWordStart:[[J

# Per-syllable text and timings
.field public static lineSylText:[[Ljava/lang/String;

.field public static lineSylStart:[[J

.field public static lineSylDur:[[J

# MARKER: Context Aware Lyrics
# Adlib flags and singer sides
.field public static lineSylBg:[[Z

.field public static lineWordBg:[[Z

# Line ends and adlib lines
.field public static lineEnds:[J

.field public static lineIsBg:[Z

.field public static lineEff:[J

.field public static lineSide:[I

.field public static dualSide:Z

# Scratch shared with the render helpers
.field public static pBeg:[I

.field public static pFin:[I

.field public static pVis:[I

.field public static pBg:[Z

.field public static pStarts:[J

.field public static pDurs:[J

.field public static pN:I

.field public static pTotal:I

.field public static pBgStart:I

.field public static pLineIdx:I

.field public static pNow:J

.field public static volatile playheadState:Landroidx/compose/runtime/MutableState;

# active RL line index (from clock over lineStarts)
.field public static volatile activeLineState:Landroidx/compose/runtime/MutableState;

.field public static volatile baseMs:J

.field public static volatile baseAnchor:J

.field public static volatile ticking:Z

# per-render scratch handed to spotGroup
.field public static tmpStarts:[J

.field public static tmpOffs:[I

.field public static tmpN:I

.field public static tmpNow:J

.field public static tmpSung:J

.field public static tmpUnsung:J

.field public static handler:Landroid/os/Handler;

.field public static tickRunnable:Ljava/lang/Runnable;

.field public static sungColor:J

.field public static sungSpan:Landroidx/compose/ui/text/SpanStyle;

.field public static unsungColor:J

.field public static unsungSpan:Landroidx/compose/ui/text/SpanStyle;


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# snapshot state (interpolated playhead ms)

.method public static state()Landroidx/compose/runtime/MutableState;
    .locals 2

    sget-object v0, Lradiant/WordLyrics;->playheadState:Landroidx/compose/runtime/MutableState;

    if-nez v0, :ret

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {}, Landroidx/compose/runtime/SnapshotStateKt;->structuralEqualityPolicy()Landroidx/compose/runtime/SnapshotMutationPolicy;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/WordLyrics;->playheadState:Landroidx/compose/runtime/MutableState;

    :ret
    return-object v0
.end method

# active-line snapshot state (init -1)
.method public static lineState()Landroidx/compose/runtime/MutableState;
    .locals 2

    sget-object v0, Lradiant/WordLyrics;->activeLineState:Landroidx/compose/runtime/MutableState;

    if-nez v0, :ret

    const/4 v0, -0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {}, Landroidx/compose/runtime/SnapshotStateKt;->structuralEqualityPolicy()Landroidx/compose/runtime/SnapshotMutationPolicy;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/WordLyrics;->activeLineState:Landroidx/compose/runtime/MutableState;

    :ret
    return-object v0
.end method

.method public static setData([J[[Ljava/lang/String;[[J)V
    .locals 0

    sput-object p0, Lradiant/WordLyrics;->lineStarts:[J

    sput-object p1, Lradiant/WordLyrics;->lineWordText:[[Ljava/lang/String;

    sput-object p2, Lradiant/WordLyrics;->lineWordStart:[[J

    # Forget the old song's layouts
    invoke-static {}, Lradiant/SylLayout;->reset()V

    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    invoke-static {}, Lradiant/WordLyrics;->startClock()V

    return-void
.end method

.method public static clear()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lradiant/WordLyrics;->lineStarts:[J

    sput-object v0, Lradiant/WordLyrics;->lineWordText:[[Ljava/lang/String;

    sput-object v0, Lradiant/WordLyrics;->lineWordStart:[[J

    sput-object v0, Lradiant/WordLyrics;->lineSylText:[[Ljava/lang/String;

    sput-object v0, Lradiant/WordLyrics;->lineSylStart:[[J

    sput-object v0, Lradiant/WordLyrics;->lineSylDur:[[J

    sput-object v0, Lradiant/WordLyrics;->lineSylBg:[[Z

    sput-object v0, Lradiant/WordLyrics;->lineWordBg:[[Z

    sput-object v0, Lradiant/WordLyrics;->lineEnds:[J

    sput-object v0, Lradiant/WordLyrics;->lineIsBg:[Z

    sput-object v0, Lradiant/WordLyrics;->lineEff:[J

    sput-object v0, Lradiant/WordLyrics;->lineSide:[I

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/WordLyrics;->dualSide:Z

    const/4 v0, 0x0

    invoke-static {}, Lradiant/SylLayout;->reset()V

    invoke-static {}, Lradiant/WordLyrics;->stopClock()V

    return-void
.end method

.method public static onProgress(J)V
    .locals 4

    sput-wide p0, Lradiant/WordLyrics;->baseMs:J

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sput-wide v0, Lradiant/WordLyrics;->baseAnchor:J

    # self-heal: restart the clock if data is present but it stopped
    sget-object v2, Lradiant/WordLyrics;->lineWordText:[[Ljava/lang/String;

    if-eqz v2, :done_op

    sget-boolean v2, Lradiant/WordLyrics;->ticking:Z

    if-nez v2, :done_op

    invoke-static {}, Lradiant/WordLyrics;->startClock()V

    :done_op
    return-void
.end method


# Clock

.method public static startClock()V
    .locals 2

    sget-boolean v0, Lradiant/WordLyrics;->ticking:Z

    if-nez v0, :done

    const/4 v0, 0x1

    sput-boolean v0, Lradiant/WordLyrics;->ticking:Z

    sget-object v0, Lradiant/WordLyrics;->handler:Landroid/os/Handler;

    if-nez v0, :have_h

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/WordLyrics;->handler:Landroid/os/Handler;

    :have_h
    sget-object v0, Lradiant/WordLyrics;->tickRunnable:Ljava/lang/Runnable;

    if-nez v0, :have_r

    new-instance v0, Lradiant/WordLyricsTick;

    invoke-direct {v0}, Lradiant/WordLyricsTick;-><init>()V

    sput-object v0, Lradiant/WordLyrics;->tickRunnable:Ljava/lang/Runnable;

    :have_r
    sget-object v0, Lradiant/WordLyrics;->handler:Landroid/os/Handler;

    sget-object v1, Lradiant/WordLyrics;->tickRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :done
    return-void
.end method

.method public static stopClock()V
    .locals 2

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/WordLyrics;->ticking:Z

    sget-object v0, Lradiant/WordLyrics;->handler:Landroid/os/Handler;

    if-eqz v0, :ret

    sget-object v1, Lradiant/WordLyrics;->tickRunnable:Ljava/lang/Runnable;

    if-eqz v1, :ret

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :ret
    return-void
.end method

.method static computeNow()J
    .locals 7

    sget-wide v0, Lradiant/WordLyrics;->baseMs:J

    sget-wide v2, Lradiant/WordLyrics;->baseAnchor:J

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long/2addr v4, v2

    const-wide/16 v2, 0x0

    cmp-long v6, v4, v2

    if-gez v6, :chk_hi

    move-wide v4, v2

    goto :add

    :chk_hi
    const-wide/16 v2, 0x190

    cmp-long v6, v4, v2

    if-lez v6, :add

    move-wide v4, v2

    :add
    add-long/2addr v0, v4

    return-wide v0
.end method

# largest index i with arr[i] <= v, else -1 (arr ascending)
.method static search([JJ)I
    .locals 5

    const/4 v0, -0x1

    if-eqz p0, :done

    array-length v1, p0

    const/4 v2, 0x0

    :loop
    if-ge v2, v1, :done

    aget-wide v3, p0, v2

    cmp-long v4, v3, p1

    if-gtz v4, :done

    move v0, v2

    add-int/lit8 v2, v2, 0x1

    goto :loop

    :done
    return v0
.end method

# 33ms tick: publish the interpolated playhead + the active RL line into snapshot states
.method public static tick()V
    .locals 6

    sget-object v0, Lradiant/WordLyrics;->lineWordText:[[Ljava/lang/String;

    if-eqz v0, :stop

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v0

    # active RL line index (search over lineStarts)
    sget-object v2, Lradiant/WordLyrics;->lineStarts:[J

    invoke-static {v2, v0, v1}, Lradiant/WordLyrics;->search([JJ)I

    move-result v2

    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    move-result-object v3

    invoke-interface {v3}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :set_al

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v5

    if-eq v5, v2, :al_done

    :set_al
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v3, v4}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :al_done
    # playhead tick (every frame) -> playheadState (drives active line fade)
    long-to-int v0, v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    move-result-object v1

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    sget-boolean v0, Lradiant/WordLyrics;->ticking:Z

    if-eqz v0, :done

    sget-object v0, Lradiant/WordLyrics;->handler:Landroid/os/Handler;

    if-eqz v0, :done

    sget-object v1, Lradiant/WordLyrics;->tickRunnable:Ljava/lang/Runnable;

    if-eqz v1, :done

    const-wide/16 v2, 0x21

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :done
    return-void

    :stop
    const/4 v0, 0x0

    sput-boolean v0, Lradiant/WordLyrics;->ticking:Z

    return-void
.end method


# render

# Builds one word-highlighted line
.method public static render(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;
    .locals 16

    move/from16 v15, p0

    move-wide/from16 v10, p3

    sput-wide v10, Lradiant/WordLyrics;->tmpSung:J

    move-wide/from16 v10, p5

    sput-wide v10, Lradiant/WordLyrics;->tmpUnsung:J

    # only style lines that have RL word data
    sget-boolean v0, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-eqz v0, :plain

    sget-object v0, Lradiant/WordLyrics;->lineWordText:[[Ljava/lang/String;

    if-eqz v0, :plain

    if-ltz v15, :plain

    array-length v1, v0

    if-ge v15, v1, :plain

    aget-object v1, v0, v15

    if-eqz v1, :plain

    array-length v2, v1

    if-eqz v2, :plain

    sget-object v3, Lradiant/WordLyrics;->lineWordStart:[[J

    if-eqz v3, :plain

    aget-object v3, v3, v15

    if-eqz v3, :plain

    # Hand the helpers this line
    sput v15, Lradiant/WordLyrics;->pLineIdx:I

    sput v2, Lradiant/WordLyrics;->pN:I

    sput-object v3, Lradiant/WordLyrics;->pStarts:[J

    sget-object v0, Lradiant/WordLyrics;->lineWordBg:[[Z

    invoke-static {v0, v15, v2}, Lradiant/WordLyrics;->bgFlags([[ZII)[Z

    move-result-object v0

    sput-object v0, Lradiant/WordLyrics;->pBg:[Z

    new-array v0, v2, [I

    sput-object v0, Lradiant/WordLyrics;->pBeg:[I

    new-array v0, v2, [I

    sput-object v0, Lradiant/WordLyrics;->pFin:[I

    new-array v0, v2, [I

    sput-object v0, Lradiant/WordLyrics;->pVis:[I

    new-instance v6, Landroidx/compose/ui/text/AnnotatedString$Builder;

    invoke-direct {v6}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>()V

    invoke-static {v6, v1}, Lradiant/WordLyrics;->emitLine(Landroidx/compose/ui/text/AnnotatedString$Builder;[Ljava/lang/String;)V

    sget v9, Lradiant/WordLyrics;->pTotal:I

    sget v7, Lradiant/WordLyrics;->pBgStart:I

    invoke-static {v6, v15, v7, v9}, Lradiant/WordLyrics;->applyParagraphs(Landroidx/compose/ui/text/AnnotatedString$Builder;III)V

    # Unsung base for the line
    invoke-static {}, Lradiant/WordLyrics;->unsungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    const/4 v8, 0x0

    invoke-virtual {v6, v0, v8, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    # Recompose when the playing line changes
    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {v15}, Lradiant/WordLyrics;->isActiveLine(I)Z

    move-result v5

    if-eqz v5, :w_emit

    # Re-render this line every tick
    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v10

    sput-wide v10, Lradiant/WordLyrics;->pNow:J

    # Lead vocal first, then adlibs
    const/4 v8, 0x0

    invoke-static {v6, v8}, Lradiant/WordLyrics;->spotGroup(Landroidx/compose/ui/text/AnnotatedString$Builder;Z)V

    if-ltz v7, :w_emit

    const/4 v8, 0x1

    invoke-static {v6, v8}, Lradiant/WordLyrics;->spotGroup(Landroidx/compose/ui/text/AnnotatedString$Builder;Z)V

    :w_emit
    invoke-virtual {v6}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :plain
    new-instance v0, Landroidx/compose/ui/text/AnnotatedString$Builder;

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0
.end method

# Lights up one group's active word
.method static spotGroup(Landroidx/compose/ui/text/AnnotatedString$Builder;Z)V
    .locals 12

    sget v0, Lradiant/WordLyrics;->pN:I

    sget-object v1, Lradiant/WordLyrics;->pBg:[Z

    sget-object v2, Lradiant/WordLyrics;->pStarts:[J

    sget-wide v10, Lradiant/WordLyrics;->pNow:J

    const/4 v3, -0x1

    const/4 v4, 0x0

    :sp_find
    if-ge v4, v0, :sp_found

    invoke-static {v1, v4, p1}, Lradiant/WordLyrics;->inGroup([ZIZ)Z

    move-result v5

    if-eqz v5, :sp_find_next

    aget-wide v5, v2, v4

    cmp-long v7, v5, v10

    if-gtz v7, :sp_found

    move v3, v4

    :sp_find_next
    add-int/lit8 v4, v4, 0x1

    goto :sp_find

    :sp_found
    if-ltz v3, :sp_ret

    aget-wide v5, v2, v3

    # Tail for the group's last word
    const-wide/16 v7, 0x320

    add-long/2addr v7, v5

    add-int/lit8 v4, v3, 0x1

    :sp_end
    if-ge v4, v0, :sp_have_end

    invoke-static {v1, v4, p1}, Lradiant/WordLyrics;->inGroup([ZIZ)Z

    move-result v9

    if-eqz v9, :sp_end_next

    aget-wide v7, v2, v4

    goto :sp_have_end

    :sp_end_next
    add-int/lit8 v4, v4, 0x1

    goto :sp_end

    :sp_have_end
    sget-wide v9, Lradiant/WordLyrics;->pNow:J

    invoke-static/range {v5 .. v10}, Lradiant/WordLyrics;->bump(JJJ)F

    move-result v4

    const v9, 0x3c23d70a    # 0.01f

    cmpg-float v0, v4, v9

    if-lez v0, :sp_ret

    sget-wide v0, Lradiant/WordLyrics;->tmpUnsung:J

    sget-wide v5, Lradiant/WordLyrics;->tmpSung:J

    invoke-static {v0, v1, v5, v6, v4}, Landroidx/compose/ui/graphics/ColorKt;->lerp-jxsXWHM(JJF)J

    move-result-wide v0

    invoke-static {v0, v1}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    sget-object v1, Lradiant/WordLyrics;->pBeg:[I

    aget v1, v1, v3

    sget-object v2, Lradiant/WordLyrics;->pFin:[I

    aget v2, v2, v3

    invoke-virtual {p0, v0, v1, v2}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :sp_ret
    return-void
.end method

# Fade Curve (tech blabble below)
# Fade curve for a word active over [ws, we) ramps 0 -> 1 over the first FADE ms & 1 -> 0 over the last FADE ms (min of the two ramps) 0 outside the window
.method static bump(JJJ)F
    .locals 6

    cmp-long v0, p4, p0

    if-ltz v0, :zero

    cmp-long v0, p4, p2

    if-gez v0, :zero

    sub-long v0, p4, p0

    long-to-float v0, v0

    const v1, 0x42f00000

    div-float v0, v0, v1

    sub-long v2, p2, p4

    long-to-float v2, v2

    div-float v2, v2, v1

    cmpg-float v3, v0, v2

    if-lez v3, :have_min

    move v0, v2

    :have_min
    const v1, 0x3f800000

    cmpg-float v3, v0, v1

    if-lez v3, :ret

    move v0, v1

    :ret
    return v0

    :zero
    const/4 v0, 0x0

    return v0
.end method

# cached SpanStyle per color (p2=isSung slot)
.method static span(JZ)Landroidx/compose/ui/text/SpanStyle;
    .locals 3

    if-eqz p2, :unsung

    sget-object v0, Lradiant/WordLyrics;->sungSpan:Landroidx/compose/ui/text/SpanStyle;

    if-eqz v0, :build_s

    sget-wide v1, Lradiant/WordLyrics;->sungColor:J

    cmp-long v2, v1, p0

    if-nez v2, :build_s

    return-object v0

    :build_s
    invoke-static {p0, p1}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    sput-object v0, Lradiant/WordLyrics;->sungSpan:Landroidx/compose/ui/text/SpanStyle;

    sput-wide p0, Lradiant/WordLyrics;->sungColor:J

    return-object v0

    :unsung
    sget-object v0, Lradiant/WordLyrics;->unsungSpan:Landroidx/compose/ui/text/SpanStyle;

    if-eqz v0, :build_u

    sget-wide v1, Lradiant/WordLyrics;->unsungColor:J

    cmp-long v2, v1, p0

    if-nez v2, :build_u

    return-object v0

    :build_u
    invoke-static {p0, p1}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    sput-object v0, Lradiant/WordLyrics;->unsungSpan:Landroidx/compose/ui/text/SpanStyle;

    sput-wide p0, Lradiant/WordLyrics;->unsungColor:J

    return-object v0
.end method

# SpanStyle(color = <p0>) with every other property defaulted (mask 0xFFFE, bit0 clear = provide color)
.method static makeSpan(J)Landroidx/compose/ui/text/SpanStyle;
    .locals 23

    new-instance v0, Landroidx/compose/ui/text/SpanStyle;

    move-wide/from16 v1, p0

    const-wide/16 v3, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-wide/16 v10, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const-wide/16 v15, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    const v21, 0xfffe

    const/16 v22, 0x0

    invoke-direct/range {v0 .. v22}, Landroidx/compose/ui/text/SpanStyle;-><init>(JJLandroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontSynthesis;Landroidx/compose/ui/text/font/FontFamily;Ljava/lang/String;JLandroidx/compose/ui/text/style/BaselineShift;Landroidx/compose/ui/text/style/TextGeometricTransform;Landroidx/compose/ui/text/intl/LocaleList;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/graphics/Shadow;Landroidx/compose/ui/text/PlatformSpanStyle;Landroidx/compose/ui/graphics/drawscope/DrawStyle;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v0
.end method


# ingest API ("Word" payload into per line word arrays)

.method public static ingest(Ljava/lang/String;)V
    .locals 20

    :try_start
    move-object/from16 v9, p0

    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6, v9}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v7, "type"

    const-string v8, ""

    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "Word"

    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :is_word

    const-string v7, "WordLyrics ingest: not Word type -> cleared"

    invoke-static {v7}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    invoke-static {}, Lradiant/WordLyrics;->clear()V

    return-void

    :is_word
    const-string v7, "data"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-nez v0, :have_data

    invoke-static {}, Lradiant/WordLyrics;->clear()V

    return-void

    :have_data
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-nez v1, :nonempty

    invoke-static {}, Lradiant/WordLyrics;->clear()V

    return-void

    :nonempty
    new-array v2, v1, [J

    new-array v3, v1, [[Ljava/lang/String;

    new-array v4, v1, [[J

    const/4 v5, 0x0

    :line_loop
    if-ge v5, v1, :lines_done

    invoke-virtual {v0, v5}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "startTime"

    const-wide/16 v8, 0x0

    invoke-virtual {v6, v7, v8, v9}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v7

    const-wide v9, 0x408f400000000000L

    mul-double/2addr v7, v9

    double-to-long v7, v7

    aput-wide v7, v2, v5

    const-string v7, "syllabus"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v7

    if-eqz v7, :single

    invoke-virtual {v7}, Lorg/json/JSONArray;->length()I

    move-result v8

    if-nez v8, :have_syl

    :single
    const/4 v8, 0x1

    new-array v9, v8, [Ljava/lang/String;

    const-string v10, "text"

    const-string v11, ""

    invoke-virtual {v6, v10, v11}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    const/4 v11, 0x0

    aput-object v10, v9, v11

    aput-object v9, v3, v5

    new-array v9, v8, [J

    aget-wide v7, v2, v5

    aput-wide v7, v9, v11

    aput-object v9, v4, v5

    goto :line_next

    :have_syl
    const/4 v9, 0x0

    const/4 v10, 0x0

    :count_loop
    if-ge v10, v8, :count_done

    invoke-virtual {v7, v10}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v11

    invoke-static {v11}, Lradiant/WordLyrics;->sylText(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v10, v8}, Lradiant/WordLyrics;->isWordEnd(Ljava/lang/String;II)Z

    move-result v11

    if-eqz v11, :count_next

    add-int/lit8 v9, v9, 0x1

    :count_next
    add-int/lit8 v10, v10, 0x1

    goto :count_loop

    :count_done
    if-nez v9, :count_ok

    const/4 v9, 0x1

    :count_ok
    new-array v10, v9, [Ljava/lang/String;

    new-array v11, v9, [J

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v13, 0x0

    const/4 v14, 0x0

    const-wide/16 v15, 0x0

    const/16 v17, 0x0

    :fill_loop
    if-ge v13, v8, :fill_done

    invoke-virtual {v7, v13}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-nez v17, :grp_open

    const-string v9, "time"

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v15

    const/16 v17, 0x1

    :grp_open
    invoke-static {v6}, Lradiant/WordLyrics;->sylText(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v6, v13, v8}, Lradiant/WordLyrics;->isWordEnd(Ljava/lang/String;II)Z

    move-result v6

    if-eqz v6, :fill_next

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v10, v14

    aput-wide v15, v11, v14

    add-int/lit8 v14, v14, 0x1

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v17, 0x0

    :fill_next
    add-int/lit8 v13, v13, 0x1

    goto :fill_loop

    :fill_done
    aput-object v10, v3, v5

    aput-object v11, v4, v5

    :line_next
    # use the first WORD's start as the line's start so the active-line clock and the word times come from the same source (API line startTime can precede its words btw)
    aget-object v6, v4, v5

    const/4 v7, 0x0

    aget-wide v8, v6, v7

    aput-wide v8, v2, v5

    add-int/lit8 v5, v5, 0x1

    goto :line_loop

    :lines_done
    # Keep the per-syllable timings
    invoke-static {v0}, Lradiant/WordLyrics;->buildSyl(Lorg/json/JSONArray;)V

    # Adlib flags and singer sides
    invoke-static {v0}, Lradiant/WordLyrics;->buildSylBg(Lorg/json/JSONArray;)V

    invoke-static {v0}, Lradiant/WordLyrics;->buildWordBg(Lorg/json/JSONArray;)V

    invoke-static {v0}, Lradiant/WordLyrics;->buildLineMeta(Lorg/json/JSONArray;)V

    move-object/from16 v6, p0

    invoke-static {v6, v0}, Lradiant/WordLyrics;->buildSides(Ljava/lang/String;Lorg/json/JSONArray;)V

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "WordLyrics ingest: Word, lines="

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    invoke-static {v2, v3, v4}, Lradiant/WordLyrics;->setData([J[[Ljava/lang/String;[[J)V

    return-void

    :try_end
    .catchall {:try_start .. :try_end} :catch

    :catch
    move-exception v0

    invoke-static {}, Lradiant/WordLyrics;->clear()V

    return-void
.end method

# Reads per-syllable text and timings
.method static buildSyl(Lorg/json/JSONArray;)V
    .locals 15

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    new-array v2, v0, [[Ljava/lang/String;

    new-array v3, v0, [[J

    new-array v4, v0, [[J

    const/4 v1, 0x0

    :bs_line
    if-ge v1, v0, :bs_done

    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "syllabus"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v6

    if-eqz v6, :bs_single

    invoke-virtual {v6}, Lorg/json/JSONArray;->length()I

    move-result v7

    if-nez v7, :bs_have

    :bs_single
    # Treat the line as one syllable
    const-string v8, "text"

    const-string v9, ""

    invoke-virtual {v5, v8, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "startTime"

    const-wide/16 v10, 0x0

    invoke-virtual {v5, v9, v10, v11}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v13

    const-wide v10, 0x408f400000000000L    # 1000.0

    mul-double/2addr v13, v10

    double-to-long v13, v13

    const/4 v7, 0x1

    new-array v10, v7, [Ljava/lang/String;

    new-array v11, v7, [J

    new-array v12, v7, [J

    const/4 v9, 0x0

    aput-object v8, v10, v9

    aput-wide v13, v11, v9

    const-wide/16 v13, 0x320

    aput-wide v13, v12, v9

    goto :bs_store

    :bs_have
    new-array v10, v7, [Ljava/lang/String;

    new-array v11, v7, [J

    new-array v12, v7, [J

    const/4 v8, 0x0

    :bs_syl
    if-ge v8, v7, :bs_store

    invoke-virtual {v6, v8}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v9

    invoke-static {v9}, Lradiant/WordLyrics;->sylText(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v13

    aput-object v13, v10, v8

    const-string v13, "time"

    invoke-virtual {v9, v13}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v13

    aput-wide v13, v11, v8

    const-string v13, "duration"

    invoke-virtual {v9, v13}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v13

    # Clamped later, at render time
    aput-wide v13, v12, v8

    add-int/lit8 v8, v8, 0x1

    goto :bs_syl

    :bs_store
    aput-object v10, v2, v1

    aput-object v11, v3, v1

    aput-object v12, v4, v1

    add-int/lit8 v1, v1, 0x1

    goto :bs_line

    :bs_done
    sput-object v2, Lradiant/WordLyrics;->lineSylText:[[Ljava/lang/String;

    sput-object v3, Lradiant/WordLyrics;->lineSylStart:[[J

    sput-object v4, Lradiant/WordLyrics;->lineSylDur:[[J

    return-void
.end method



# MARKER: RL API user settings
# Baked in by the Manager's options
# CTX bits: 0x1 adlibs, 0x2 singers

# Is context aware switched on
# The mode bits alone can't say "off"
.method static ctxOn()Z
    .locals 2

    const v0, __RL_CTX_ON__

    const/4 v1, 0x0

    if-eqz v0, :off

    const/4 v1, 0x1

    :off
    return v1
.end method

.method static ctxBit(I)Z
    .locals 2

    const/4 v0, 0x0

    invoke-static {}, Lradiant/WordLyrics;->ctxOn()Z

    move-result v1

    if-eqz v1, :off

    const v1, __RL_CTX__

    and-int/2addr v1, p0

    if-eqz v1, :off

    const/4 v0, 0x1

    :off
    return v0
.end method

.method static ctxAdlibs()Z
    .locals 1

    const/4 v0, 0x1

    invoke-static {v0}, Lradiant/WordLyrics;->ctxBit(I)Z

    move-result v0

    return v0
.end method

.method static ctxSingers()Z
    .locals 1

    const/4 v0, 0x2

    invoke-static {v0}, Lradiant/WordLyrics;->ctxBit(I)Z

    move-result v0

    return v0
.end method

.method public static romanizeOn()Z
    .locals 2

    const v0, __RL_ROMANIZE__

    const/4 v1, 0x0

    if-eqz v0, :off

    const/4 v1, 0x1

    :off
    return v1
.end method

# Romanized text when it was asked for
.method static pick(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    const-string v0, ""

    invoke-virtual {p0, p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lradiant/WordLyrics;->romanizeOn()Z

    move-result v0

    if-eqz v0, :ret

    const-string v0, "romanized"

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :ret

    move-object v3, v0

    :ret
    return-object v3
.end method

.method static sylText(Lorg/json/JSONObject;)Ljava/lang/String;
    .locals 1

    const-string v0, "text"

    invoke-static {p0, v0}, Lradiant/WordLyrics;->pick(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static lineText(Lorg/json/JSONObject;)Ljava/lang/String;
    .locals 1

    const-string v0, "text"

    invoke-static {p0, v0}, Lradiant/WordLyrics;->pick(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

# Works out when each line ends
.method static buildLineMeta(Lorg/json/JSONArray;)V
    .locals 16

    move-object/from16 v14, p0

    invoke-virtual {v14}, Lorg/json/JSONArray;->length()I

    move-result v0

    new-array v1, v0, [J

    new-array v2, v0, [Z

    new-array v3, v0, [J

    const/4 v4, 0x0

    :lm_line
    if-ge v4, v0, :lm_eff

    invoke-virtual {v14, v4}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "syllabus"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v6

    if-eqz v6, :lm_single

    invoke-virtual {v6}, Lorg/json/JSONArray;->length()I

    move-result v7

    if-nez v7, :lm_have

    :lm_single
    # No syllables, use the line start
    const-string v8, "startTime"

    const-wide/16 v9, 0x0

    invoke-virtual {v5, v8, v9, v10}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v9

    const-wide v11, 0x408f400000000000L    # 1000.0

    mul-double/2addr v9, v11

    double-to-long v9, v9

    aput-wide v9, v3, v4

    const-wide/16 v11, 0x320

    add-long/2addr v9, v11

    aput-wide v9, v1, v4

    const/4 v8, 0x0

    aput-boolean v8, v2, v4

    goto :lm_next

    :lm_have
    const/4 v8, 0x0

    invoke-virtual {v6, v8}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v8

    const-string v9, "time"

    invoke-virtual {v8, v9}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v9

    aput-wide v9, v3, v4

    add-int/lit8 v8, v7, -0x1

    invoke-virtual {v6, v8}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v8

    const-string v9, "time"

    invoke-virtual {v8, v9}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v9

    const-string v11, "duration"

    invoke-virtual {v8, v11}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v11

    add-long/2addr v9, v11

    aput-wide v9, v1, v4

    # Whole line an adlib?
    const/4 v8, 0x1

    const/4 v9, 0x0

    :lm_bg
    if-ge v9, v7, :lm_bg_done

    invoke-virtual {v6, v9}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v10

    const-string v11, "isBackground"

    const/4 v12, 0x0

    invoke-virtual {v10, v11, v12}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v10

    if-nez v10, :lm_bg_next

    const/4 v8, 0x0

    goto :lm_bg_done

    :lm_bg_next
    add-int/lit8 v9, v9, 0x1

    goto :lm_bg

    :lm_bg_done
    aput-boolean v8, v2, v4

    :lm_next
    add-int/lit8 v4, v4, 0x1

    goto :lm_line

    :lm_eff
    new-array v5, v0, [J

    const/4 v4, 0x0

    :lm_eff_loop
    if-ge v4, v0, :lm_store

    # Hold until the next lead vocal
    const-wide v6, 0x7fffffffffffffffL

    add-int/lit8 v8, v4, 0x1

    :lm_scan
    if-ge v8, v0, :lm_have_next

    aget-boolean v9, v2, v8

    if-nez v9, :lm_scan_next

    aget-wide v6, v3, v8

    goto :lm_have_next

    :lm_scan_next
    add-int/lit8 v8, v8, 0x1

    goto :lm_scan

    :lm_have_next
    aget-wide v9, v1, v4

    const-wide/16 v11, 0x9c4

    add-long/2addr v11, v9

    cmp-long v13, v6, v11

    if-gez v13, :lm_cap_ok

    move-wide v11, v6

    :lm_cap_ok
    cmp-long v13, v11, v9

    if-gez v13, :lm_eff_set

    move-wide v11, v9

    :lm_eff_set
    aput-wide v11, v5, v4

    add-int/lit8 v4, v4, 0x1

    goto :lm_eff_loop

    :lm_store
    sput-object v1, Lradiant/WordLyrics;->lineEnds:[J

    sput-object v2, Lradiant/WordLyrics;->lineIsBg:[Z

    sput-object v5, Lradiant/WordLyrics;->lineEff:[J

    return-void
.end method

# The last line that has started
.method static activeIdx()I
    .locals 3

    sget-object v0, Lradiant/WordLyrics;->lineStarts:[J

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lradiant/WordLyrics;->search([JJ)I

    move-result v0

    return v0
.end method

# Is this line still being sung
.method public static isActiveLine(I)Z
    .locals 8

    const/4 v0, 0x0

    sget-object v2, Lradiant/WordLyrics;->lineEff:[J

    if-nez v2, :al_meta

    # No ends, fall back to one line
    invoke-static {}, Lradiant/WordLyrics;->activeIdx()I

    move-result v7

    if-ne p0, v7, :ret

    const/4 v0, 0x1

    return v0

    :al_meta
    sget-object v1, Lradiant/WordLyrics;->lineStarts:[J

    if-eqz v1, :ret

    if-ltz p0, :ret

    array-length v7, v1

    if-ge p0, v7, :ret

    array-length v7, v2

    if-ge p0, v7, :ret

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v3

    aget-wide v5, v1, p0

    cmp-long v7, v3, v5

    if-ltz v7, :ret

    aget-wide v5, v2, p0

    cmp-long v7, v3, v5

    if-gez v7, :ret

    const/4 v0, 0x1

    :ret
    return v0
.end method

# Has this line finished for good
.method public static isPastLine(I)Z
    .locals 6

    const/4 v0, 0x0

    sget-object v1, Lradiant/WordLyrics;->lineEff:[J

    if-nez v1, :pl_meta

    invoke-static {}, Lradiant/WordLyrics;->activeIdx()I

    move-result v5

    if-ge p0, v5, :pl_ret

    const/4 v0, 0x1

    return v0

    :pl_meta
    if-ltz p0, :pl_ret

    array-length v5, v1

    if-ge p0, v5, :pl_ret

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v2

    aget-wide v4, v1, p0

    cmp-long v5, v2, v4

    if-ltz v5, :pl_ret

    const/4 v0, 0x1

    :pl_ret
    return v0
.end method

# First of any overlapping pair
.method public static primaryLine(I)I
    .locals 4

    sget-object v0, Lradiant/WordLyrics;->lineEff:[J

    if-eqz v0, :pr_ret

    array-length v1, v0

    const/4 v2, 0x0

    :pr_loop
    if-ge v2, v1, :pr_ret

    invoke-static {v2}, Lradiant/WordLyrics;->isActiveLine(I)Z

    move-result v3

    if-eqz v3, :pr_next

    return v2

    :pr_next
    add-int/lit8 v2, v2, 0x1

    goto :pr_loop

    :pr_ret
    return p0
.end method

# MARKER: Context Aware Lyrics ingest
# Which syllables are adlibs
.method static buildSylBg(Lorg/json/JSONArray;)V
    .locals 11

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    new-array v1, v0, [[Z

    const/4 v2, 0x0

    :bg_line
    if-ge v2, v0, :bg_done

    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "syllabus"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    const/4 v4, 0x1

    if-eqz v3, :bg_single

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-nez v5, :bg_have

    :bg_single
    new-array v5, v4, [Z

    goto :bg_store

    :bg_have
    new-array v6, v5, [Z

    const/4 v7, 0x0

    :bg_syl
    if-ge v7, v5, :bg_syl_done

    invoke-virtual {v3, v7}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v8

    const-string v9, "isBackground"

    const/4 v10, 0x0

    invoke-virtual {v8, v9, v10}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v8

    aput-boolean v8, v6, v7

    add-int/lit8 v7, v7, 0x1

    goto :bg_syl

    :bg_syl_done
    move-object v5, v6

    :bg_store
    aput-object v5, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :bg_line

    :bg_done
    sput-object v1, Lradiant/WordLyrics;->lineSylBg:[[Z

    return-void
.end method

# Which words are adlibs
.method static buildWordBg(Lorg/json/JSONArray;)V
    .locals 14

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    new-array v1, v0, [[Z

    const/4 v2, 0x0

    :wb_line
    if-ge v2, v0, :wb_done

    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "syllabus"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    const/4 v4, 0x1

    if-eqz v3, :wb_single

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-nez v5, :wb_have

    :wb_single
    new-array v6, v4, [Z

    goto :wb_store

    :wb_have
    # Count the words first
    const/4 v6, 0x0

    const/4 v7, 0x0

    :wb_count
    if-ge v7, v5, :wb_count_done

    invoke-virtual {v3, v7}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v8

    invoke-static {v8}, Lradiant/WordLyrics;->sylText(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v7, v5}, Lradiant/WordLyrics;->isWordEnd(Ljava/lang/String;II)Z

    move-result v8

    if-eqz v8, :wb_count_next

    add-int/lit8 v6, v6, 0x1

    :wb_count_next
    add-int/lit8 v7, v7, 0x1

    goto :wb_count

    :wb_count_done
    if-nez v6, :wb_count_ok

    const/4 v6, 0x1

    :wb_count_ok
    new-array v11, v6, [Z

    const/4 v7, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v6, 0x0

    :wb_fill
    if-ge v7, v5, :wb_fill_done

    invoke-virtual {v3, v7}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v8

    if-nez v13, :wb_open

    const-string v9, "isBackground"

    const/4 v10, 0x0

    invoke-virtual {v8, v9, v10}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v6

    const/4 v13, 0x1

    :wb_open
    invoke-static {v8}, Lradiant/WordLyrics;->sylText(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v7, v5}, Lradiant/WordLyrics;->isWordEnd(Ljava/lang/String;II)Z

    move-result v8

    if-eqz v8, :wb_fill_next

    array-length v9, v11

    if-ge v12, v9, :wb_fill_next

    aput-boolean v6, v11, v12

    add-int/lit8 v12, v12, 0x1

    const/4 v13, 0x0

    :wb_fill_next
    add-int/lit8 v7, v7, 0x1

    goto :wb_fill

    :wb_fill_done
    move-object v6, v11

    :wb_store
    aput-object v6, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :wb_line

    :wb_done
    sput-object v1, Lradiant/WordLyrics;->lineWordBg:[[Z

    return-void
.end method

# Puts each singer on a side
.method static buildSides(Ljava/lang/String;Lorg/json/JSONArray;)V
    .locals 14

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/WordLyrics;->dualSide:Z

    const/4 v1, 0x0

    sput-object v1, Lradiant/WordLyrics;->lineSide:[I

    invoke-static {p0}, Lradiant/WordLyrics;->agentsOf(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    :sd_agents
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v3

    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    const/4 v5, 0x0

    const/4 v6, 0x0

    :sd_map
    if-ge v6, v3, :sd_map_done

    invoke-static {p1, v6}, Lradiant/WordLyrics;->singerOf(Lorg/json/JSONArray;I)Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :sd_map_next

    invoke-virtual {v4, v7}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :sd_map_next

    invoke-static {v2, v7}, Lradiant/WordLyrics;->agentType(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "person"

    invoke-virtual {v9, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :sd_person

    # Groups always sit on the left
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v4, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :sd_map_next

    :sd_person
    add-int/lit8 v5, v5, 0x1

    const/4 v8, 0x2

    if-ne v5, v8, :sd_person_left

    const/4 v8, 0x1

    goto :sd_person_put

    :sd_person_left
    const/4 v8, 0x0

    :sd_person_put
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v4, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :sd_map_next
    add-int/lit8 v6, v6, 0x1

    goto :sd_map

    :sd_map_done
    new-array v9, v3, [I

    const/4 v6, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    :sd_fill
    if-ge v6, v3, :sd_fill_done

    const/4 v7, -0x1

    aput v7, v9, v6

    invoke-static {p1, v6}, Lradiant/WordLyrics;->singerOf(Lorg/json/JSONArray;I)Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :sd_fill_next

    invoke-virtual {v4, v7}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    if-eqz v7, :sd_fill_left

    check-cast v7, Ljava/lang/Integer;

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    goto :sd_fill_side

    :sd_fill_left
    const/4 v7, 0x0

    :sd_fill_side
    aput v7, v9, v6

    add-int/lit8 v10, v10, 0x1

    const/4 v8, 0x1

    if-ne v7, v8, :sd_fill_next

    add-int/lit8 v11, v11, 0x1

    :sd_fill_next
    add-int/lit8 v6, v6, 0x1

    goto :sd_fill

    :sd_fill_done
    if-lez v10, :sd_scan

    # Nearly all right? swap the sides
    mul-int/lit8 v6, v11, 0x64

    div-int/2addr v6, v10

    const/16 v7, 0x55

    if-lt v6, v7, :sd_scan

    const/4 v6, 0x0

    :sd_flip
    if-ge v6, v3, :sd_scan

    aget v7, v9, v6

    if-ltz v7, :sd_flip_next

    const/4 v8, 0x1

    sub-int/2addr v8, v7

    aput v8, v9, v6

    :sd_flip_next
    add-int/lit8 v6, v6, 0x1

    goto :sd_flip

    :sd_scan
    const/4 v6, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    :sd_scan_loop
    if-ge v6, v3, :sd_scan_done

    aget v7, v9, v6

    if-nez v7, :sd_scan_right

    const/4 v10, 0x1

    goto :sd_scan_next

    :sd_scan_right
    const/4 v8, 0x1

    if-ne v7, v8, :sd_scan_next

    const/4 v11, 0x1

    :sd_scan_next
    add-int/lit8 v6, v6, 0x1

    goto :sd_scan_loop

    :sd_scan_done
    sput-object v9, Lradiant/WordLyrics;->lineSide:[I

    if-eqz v10, :sd_ret

    if-eqz v11, :sd_ret

    const/4 v6, 0x1

    sput-boolean v6, Lradiant/WordLyrics;->dualSide:Z

    :sd_ret
    return-void
.end method

# Pulls the singer list out
.method static agentsOf(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 3

    const/4 v0, 0x0

    :try_start
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "metadata"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :ret

    const-string v2, "agents"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0
    :try_end
    .catchall {:try_start .. :try_end} :catch

    :ret
    return-object v0

    :catch
    move-exception v1

    const/4 v0, 0x0

    return-object v0
.end method

# Who sings this line
.method static singerOf(Lorg/json/JSONArray;I)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    invoke-virtual {p0, p1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :none

    const-string v2, "element"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :none

    const-string v2, "singer"

    const-string v0, ""

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :ret

    const/4 v0, 0x0

    :ret
    return-object v0

    :none
    const/4 v0, 0x0

    return-object v0
.end method

# Is this singer one person
.method static agentType(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    if-eqz p0, :fallback

    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :fallback

    const-string v1, "type"

    const-string v2, "person"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :fallback
    const-string v0, "v1000"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :chk_other

    const-string v0, "group"

    return-object v0

    :chk_other
    const-string v0, "v2000"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :person

    const-string v0, "other"

    return-object v0

    :person
    const-string v0, "person"

    return-object v0
.end method

# Adlib flags, if the line splits
.method static bgFlags([[ZII)[Z
    .locals 6

    const/4 v0, 0x0

    invoke-static {}, Lradiant/WordLyrics;->ctxAdlibs()Z

    move-result v1

    if-eqz v1, :none

    if-eqz p0, :none

    if-ltz p1, :none

    array-length v1, p0

    if-ge p1, v1, :none

    aget-object v1, p0, p1

    if-eqz v1, :none

    array-length v2, v1

    if-lt v2, p2, :none

    # Only split mixed lines
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    :flag_loop
    if-ge v3, p2, :flag_done

    aget-boolean v5, v1, v3

    if-eqz v5, :flag_main

    const/4 v2, 0x1

    goto :flag_next

    :flag_main
    const/4 v4, 0x1

    :flag_next
    add-int/lit8 v3, v3, 0x1

    goto :flag_loop

    :flag_done
    if-eqz v2, :none

    if-eqz v4, :none

    return-object v1

    :none
    return-object v0
.end method

# Writes out the line, adlibs last
.method static emitLine(Landroidx/compose/ui/text/AnnotatedString$Builder;[Ljava/lang/String;)V
    .locals 12

    sget v0, Lradiant/WordLyrics;->pN:I

    sget-object v1, Lradiant/WordLyrics;->pBg:[Z

    sget-object v2, Lradiant/WordLyrics;->pBeg:[I

    sget-object v3, Lradiant/WordLyrics;->pFin:[I

    sget-object v4, Lradiant/WordLyrics;->pVis:[I

    const/4 v5, 0x0

    const/4 v6, -0x1

    sput v6, Lradiant/WordLyrics;->pBgStart:I

    const/4 v6, 0x0

    :em_main
    if-ge v6, v0, :em_main_done

    if-eqz v1, :em_main_emit

    aget-boolean v7, v1, v6

    if-nez v7, :em_main_next

    :em_main_emit
    aget-object v7, p1, v6

    invoke-static {p0, v7, v5}, Lradiant/WordLyrics;->emitSyl(Landroidx/compose/ui/text/AnnotatedString$Builder;Ljava/lang/String;I)I

    move-result v8

    aput v5, v2, v6

    aput v8, v3, v6

    aget-object v7, p1, v6

    invoke-static {v7}, Lradiant/WordLyrics;->trimEndLen(Ljava/lang/String;)I

    move-result v7

    add-int/2addr v7, v5

    aput v7, v4, v6

    move v5, v8

    :em_main_next
    add-int/lit8 v6, v6, 0x1

    goto :em_main

    :em_main_done
    if-eqz v1, :em_done

    const/4 v6, 0x0

    :em_bg
    if-ge v6, v0, :em_done

    aget-boolean v7, v1, v6

    if-eqz v7, :em_bg_next

    sget v7, Lradiant/WordLyrics;->pBgStart:I

    if-gez v7, :em_bg_emit

    # Its own paragraph breaks the line
    sput v5, Lradiant/WordLyrics;->pBgStart:I

    :em_bg_emit
    aget-object v7, p1, v6

    invoke-static {v7}, Lradiant/WordLyrics;->stripBrackets(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-static {p0, v7, v5}, Lradiant/WordLyrics;->emitSyl(Landroidx/compose/ui/text/AnnotatedString$Builder;Ljava/lang/String;I)I

    move-result v8

    aput v5, v2, v6

    aput v8, v3, v6

    invoke-static {v7}, Lradiant/WordLyrics;->trimEndLen(Ljava/lang/String;)I

    move-result v7

    add-int/2addr v7, v5

    aput v7, v4, v6

    move v5, v8

    :em_bg_next
    add-int/lit8 v6, v6, 0x1

    goto :em_bg

    :em_done
    sput v5, Lradiant/WordLyrics;->pTotal:I

    return-void
.end method

.method static emitSyl(Landroidx/compose/ui/text/AnnotatedString$Builder;Ljava/lang/String;I)I
    .locals 1

    invoke-virtual {p0, p1}, Landroidx/compose/ui/text/AnnotatedString$Builder;->append(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, p2

    return v0
.end method

# Drops the brackets round adlibs
.method static stripBrackets(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    const-string v0, "("

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    const-string v0, ")"

    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

# Wipes one group's active syllable
.method static paintGroup(Landroidx/compose/ui/text/AnnotatedString$Builder;IZ)V
    .locals 13

    sget v0, Lradiant/WordLyrics;->pN:I

    sget-object v1, Lradiant/WordLyrics;->pBg:[Z

    sget-object v2, Lradiant/WordLyrics;->pStarts:[J

    sget-wide v11, Lradiant/WordLyrics;->pNow:J

    # Find the syllable being sung
    const/4 v4, -0x1

    const/4 v5, 0x0

    :pg_find
    if-ge v5, v0, :pg_found

    invoke-static {v1, v5, p2}, Lradiant/WordLyrics;->inGroup([ZIZ)Z

    move-result v6

    if-eqz v6, :pg_find_next

    aget-wide v6, v2, v5

    cmp-long v8, v6, v11

    if-gtz v8, :pg_found

    move v4, v5

    :pg_find_next
    add-int/lit8 v5, v5, 0x1

    goto :pg_find

    :pg_found
    if-ltz v4, :pg_ret

    sget-object v0, Lradiant/WordLyrics;->pBeg:[I

    aget v8, v0, v4

    sget-object v0, Lradiant/WordLyrics;->pFin:[I

    aget v9, v0, v4

    sget-object v0, Lradiant/WordLyrics;->pVis:[I

    aget v10, v0, v4

    # Everything before it is sung
    if-le v8, p1, :pg_no_prefix

    invoke-static {}, Lradiant/WordLyrics;->sungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    invoke-virtual {p0, v0, p1, v8}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :pg_no_prefix
    sget-object v0, Lradiant/WordLyrics;->pStarts:[J

    aget-wide v0, v0, v4

    sub-long v0, v11, v0

    sget-object v2, Lradiant/WordLyrics;->pDurs:[J

    aget-wide v2, v2, v4

    const-wide/16 v5, 0x1

    cmp-long v7, v2, v5

    if-gez v7, :pg_dur_ok

    move-wide v2, v5

    :pg_dur_ok
    cmp-long v7, v0, v2

    if-ltz v7, :pg_wipe

    # Already finished, so just sung
    invoke-static {}, Lradiant/WordLyrics;->sungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    invoke-virtual {p0, v0, v8, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    goto :pg_ret

    :pg_wipe
    # How far through the syllable
    long-to-float v0, v0

    long-to-float v2, v2

    div-float v0, v0, v2

    const/4 v2, 0x0

    cmpg-float v3, v0, v2

    if-gez v3, :pg_lo

    move v0, v2

    :pg_lo
    const v2, 0x3f800000    # 1.0f

    cmpg-float v3, v0, v2

    if-lez v3, :pg_hi

    move v0, v2

    :pg_hi
    sget v2, Lradiant/WordLyrics;->pLineIdx:I

    sget v3, Lradiant/WordLyrics;->pTotal:I

    invoke-static {v2, v8, v10, v0, v3}, Lradiant/WordLyrics;->sylWipe(IIIFI)Landroidx/compose/ui/graphics/Brush;

    move-result-object v2

    if-eqz v2, :pg_fade

    invoke-static {v2}, Lradiant/WordLyrics;->brushSpan(Landroidx/compose/ui/graphics/Brush;)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v2

    invoke-virtual {p0, v2, v8, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    goto :pg_ret

    :pg_fade
    # Not measured yet, so fade instead
    sget-wide v2, Lradiant/WordLyrics;->tmpUnsung:J

    sget-wide v4, Lradiant/WordLyrics;->tmpSung:J

    invoke-static {v2, v3, v4, v5, v0}, Landroidx/compose/ui/graphics/ColorKt;->lerp-jxsXWHM(JJF)J

    move-result-wide v2

    invoke-static {v2, v3}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v2

    invoke-virtual {p0, v2, v8, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :pg_ret
    return-void
.end method

.method static inGroup([ZIZ)Z
    .locals 2

    const/4 v0, 0x0

    if-nez p0, :have

    # No adlibs, so all lead vocal
    if-eqz p2, :yes

    goto :ret

    :have
    aget-boolean v1, p0, p1

    if-ne v1, p2, :ret

    :yes
    const/4 v0, 0x1

    :ret
    return v0
.end method

# Shrinks text to a fraction of the line
.method static emSpan(F)Landroidx/compose/ui/text/SpanStyle;
    .locals 23

    invoke-static/range {p0 .. p0}, Landroidx/compose/ui/unit/TextUnitKt;->getEm(F)J

    move-result-wide v3

    new-instance v0, Landroidx/compose/ui/text/SpanStyle;

    const-wide/16 v1, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-wide/16 v10, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const-wide/16 v15, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    const v21, 0xfffd

    const/16 v22, 0x0

    invoke-direct/range {v0 .. v22}, Landroidx/compose/ui/text/SpanStyle;-><init>(JJLandroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontSynthesis;Landroidx/compose/ui/text/font/FontFamily;Ljava/lang/String;JLandroidx/compose/ui/text/style/BaselineShift;Landroidx/compose/ui/text/style/TextGeometricTransform;Landroidx/compose/ui/text/intl/LocaleList;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/graphics/Shadow;Landroidx/compose/ui/text/PlatformSpanStyle;Landroidx/compose/ui/graphics/drawscope/DrawStyle;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v0
.end method

# Applies singer side and adlib size
.method static applyParagraphs(Landroidx/compose/ui/text/AnnotatedString$Builder;III)V
    .locals 5

    const/4 v0, -0x1

    invoke-static {}, Lradiant/WordLyrics;->ctxSingers()Z

    move-result v1

    if-eqz v1, :ap_have_side

    sget-boolean v1, Lradiant/WordLyrics;->dualSide:Z

    if-eqz v1, :ap_have_side

    invoke-static {p1}, Lradiant/WordLyrics;->sideOf(I)I

    move-result v0

    :ap_have_side
    # Lead vocal paragraph
    move v1, p3

    if-ltz p2, :ap_lead

    move v1, p2

    :ap_lead
    if-ltz v0, :ap_adlib

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lradiant/WordLyrics;->paraStyle(IZ)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/ParagraphStyle;II)V

    :ap_adlib
    if-ltz p2, :ap_ret

    # Adlibs: own line, smaller text
    const/4 v2, 0x1

    invoke-static {v0, v2}, Lradiant/WordLyrics;->paraStyle(IZ)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object v2

    invoke-virtual {p0, v2, p2, p3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/ParagraphStyle;II)V

    const v2, 0x3f0ccccd    # 0.55f

    invoke-static {v2}, Lradiant/WordLyrics;->emSpan(F)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v2

    invoke-virtual {p0, v2, p2, p3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :ap_ret
    return-void
.end method

# Alignment and line height for a paragraph
# p0: -1 inherit, 0 left singer, 1 right
.method static paraStyle(IZ)Landroidx/compose/ui/text/ParagraphStyle;
    .locals 13

    sget-object v0, Landroidx/compose/ui/text/style/TextAlign;->Companion:Landroidx/compose/ui/text/style/TextAlign$Companion;

    if-gez p0, :pa_sided

    invoke-virtual {v0}, Landroidx/compose/ui/text/style/TextAlign$Companion;->getUnspecified-e0LSkKk()I

    move-result v1

    goto :pa_have_align

    :pa_sided
    const/4 v1, 0x1

    if-ne p0, v1, :pa_left

    invoke-virtual {v0}, Landroidx/compose/ui/text/style/TextAlign$Companion;->getEnd-e0LSkKk()I

    move-result v1

    goto :pa_have_align

    :pa_left
    invoke-virtual {v0}, Landroidx/compose/ui/text/style/TextAlign$Companion;->getStart-e0LSkKk()I

    move-result v1

    :pa_have_align
    const/16 v11, 0x1fe

    const-wide/16 v3, 0x0

    if-eqz p1, :pa_build

    const v0, 0x3f333333    # 0.7f

    invoke-static {v0}, Landroidx/compose/ui/unit/TextUnitKt;->getEm(F)J

    move-result-wide v3

    const/16 v11, 0x1fa

    :pa_build
    new-instance v0, Landroidx/compose/ui/text/ParagraphStyle;

    const/4 v2, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v12, 0x0

    invoke-direct/range {v0 .. v12}, Landroidx/compose/ui/text/ParagraphStyle;-><init>(IIJLandroidx/compose/ui/text/style/TextIndent;Landroidx/compose/ui/text/PlatformParagraphStyle;Landroidx/compose/ui/text/style/LineHeightStyle;IILandroidx/compose/ui/text/style/TextMotion;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v0
.end method


# Builds one syllable-wiped line
.method public static renderSyl(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;
    .locals 16

    move/from16 v15, p0

    # Stash the line's two colours
    move-wide/from16 v10, p3

    sput-wide v10, Lradiant/WordLyrics;->tmpSung:J

    move-wide/from16 v10, p5

    sput-wide v10, Lradiant/WordLyrics;->tmpUnsung:J

    # Only style lines with RL data
    sget-boolean v0, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-eqz v0, :plain

    sget-object v0, Lradiant/WordLyrics;->lineSylText:[[Ljava/lang/String;

    if-eqz v0, :plain

    if-ltz v15, :plain

    array-length v1, v0

    if-ge v15, v1, :plain

    aget-object v1, v0, v15

    if-eqz v1, :plain

    array-length v2, v1

    if-eqz v2, :plain

    sget-object v3, Lradiant/WordLyrics;->lineSylStart:[[J

    if-eqz v3, :plain

    aget-object v3, v3, v15

    if-eqz v3, :plain

    sget-object v4, Lradiant/WordLyrics;->lineSylDur:[[J

    if-eqz v4, :plain

    aget-object v4, v4, v15

    if-eqz v4, :plain

    # Hand the helpers this line
    sput v15, Lradiant/WordLyrics;->pLineIdx:I

    sput v2, Lradiant/WordLyrics;->pN:I

    sput-object v3, Lradiant/WordLyrics;->pStarts:[J

    sput-object v4, Lradiant/WordLyrics;->pDurs:[J

    sget-object v0, Lradiant/WordLyrics;->lineSylBg:[[Z

    invoke-static {v0, v15, v2}, Lradiant/WordLyrics;->bgFlags([[ZII)[Z

    move-result-object v0

    sput-object v0, Lradiant/WordLyrics;->pBg:[Z

    new-array v0, v2, [I

    sput-object v0, Lradiant/WordLyrics;->pBeg:[I

    new-array v0, v2, [I

    sput-object v0, Lradiant/WordLyrics;->pFin:[I

    new-array v0, v2, [I

    sput-object v0, Lradiant/WordLyrics;->pVis:[I

    new-instance v6, Landroidx/compose/ui/text/AnnotatedString$Builder;

    invoke-direct {v6}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>()V

    invoke-static {v6, v1}, Lradiant/WordLyrics;->emitLine(Landroidx/compose/ui/text/AnnotatedString$Builder;[Ljava/lang/String;)V

    sget v9, Lradiant/WordLyrics;->pTotal:I

    sget v7, Lradiant/WordLyrics;->pBgStart:I

    invoke-static {v6, v15, v7, v9}, Lradiant/WordLyrics;->applyParagraphs(Landroidx/compose/ui/text/AnnotatedString$Builder;III)V

    # Recompose when the playing line changes
    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {v15}, Lradiant/WordLyrics;->isPastLine(I)Z

    move-result v5

    if-eqz v5, :sl_not_past

    # Past lines stay fully sung
    invoke-static {}, Lradiant/WordLyrics;->sungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    const/4 v8, 0x0

    invoke-virtual {v6, v0, v8, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    goto :sl_emit

    :sl_not_past
    # Unsung base for the line
    invoke-static {}, Lradiant/WordLyrics;->unsungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    const/4 v8, 0x0

    invoke-virtual {v6, v0, v8, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    invoke-static {v15}, Lradiant/WordLyrics;->isActiveLine(I)Z

    move-result v5

    if-eqz v5, :sl_emit

    # Re-render this line every tick
    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v10

    sput-wide v10, Lradiant/WordLyrics;->pNow:J

    # Lead vocal first, then adlibs
    const/4 v0, 0x0

    const/4 v8, 0x0

    invoke-static {v6, v0, v8}, Lradiant/WordLyrics;->paintGroup(Landroidx/compose/ui/text/AnnotatedString$Builder;IZ)V

    if-ltz v7, :sl_emit

    const/4 v8, 0x1

    invoke-static {v6, v7, v8}, Lradiant/WordLyrics;->paintGroup(Landroidx/compose/ui/text/AnnotatedString$Builder;IZ)V

    :sl_emit
    invoke-virtual {v6}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :plain
    new-instance v0, Landroidx/compose/ui/text/AnnotatedString$Builder;

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0
.end method

.method static sideOf(I)I
    .locals 2

    const/4 v0, -0x1

    sget-object v1, Lradiant/WordLyrics;->lineSide:[I

    if-eqz v1, :ret

    if-ltz p0, :ret

    array-length v0, v1

    if-le v0, p0, :none

    aget v0, v1, p0

    return v0

    :none
    const/4 v0, -0x1

    :ret
    return v0
.end method


# Wipe gradient for one syllable
.method static sylWipe(IIIFI)Landroidx/compose/ui/graphics/Brush;
    .locals 10

    const/4 v9, 0x0

    if-ltz p1, :none

    if-le p2, p1, :none

    invoke-static {p0}, Lradiant/SylLayout;->get(I)Landroidx/compose/ui/text/TextLayoutResult;

    move-result-object v0

    if-eqz v0, :none

    invoke-virtual {v0}, Landroidx/compose/ui/text/TextLayoutResult;->getLayoutInput()Landroidx/compose/ui/text/TextLayoutInput;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/compose/ui/text/TextLayoutInput;->getText()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/compose/ui/text/AnnotatedString;->getLength()I

    move-result v1

    if-ne v1, p4, :none

    invoke-virtual {v0, p1}, Landroidx/compose/ui/text/TextLayoutResult;->getBoundingBox(I)Landroidx/compose/ui/geometry/Rect;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/compose/ui/geometry/Rect;->getLeft()F

    move-result v2

    add-int/lit8 v3, p2, -0x1

    invoke-virtual {v0, v3}, Landroidx/compose/ui/text/TextLayoutResult;->getBoundingBox(I)Landroidx/compose/ui/geometry/Rect;

    move-result-object v3

    invoke-virtual {v3}, Landroidx/compose/ui/geometry/Rect;->getRight()F

    move-result v3

    sub-float v4, v3, v2

    const/4 v5, 0x0

    cmpg-float v5, v4, v5

    if-lez v5, :none

    # Where the wipe edge sits
    mul-float v4, v4, p3

    add-float v4, v4, v2

    # Soft trail behind the edge
    invoke-static {v0}, Lradiant/SylLayout;->em(Landroidx/compose/ui/text/TextLayoutResult;)F

    move-result v5

    const v6, 0x3ec00000    # 0.375f

    mul-float v5, v5, v6

    const v6, 0x3f800000    # 1.0f

    cmpg-float v7, v5, v6

    if-gtz v7, :feather_ok

    move v5, v6

    :feather_ok
    add-float v5, v4, v5

    sget-wide v6, Lradiant/WordLyrics;->tmpSung:J

    invoke-static {v6, v7}, Landroidx/compose/ui/graphics/ColorKt;->toArgb-8_81llA(J)I

    move-result v6

    sget-wide v7, Lradiant/WordLyrics;->tmpUnsung:J

    invoke-static {v7, v8}, Landroidx/compose/ui/graphics/ColorKt;->toArgb-8_81llA(J)I

    move-result v7

    new-instance v8, Lradiant/SylBrush;

    invoke-direct {v8, v4, v5, v6, v7}, Lradiant/SylBrush;-><init>(FFII)V

    return-object v8

    :none
    return-object v9
.end method

# Length without the trailing space
.method static trimEndLen(Ljava/lang/String;)I
    .locals 3

    const/4 v0, 0x0

    if-eqz p0, :done

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    :loop
    if-lez v0, :done

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v1, 0x20

    if-gt v2, v1, :done

    add-int/lit8 v0, v0, -0x1

    goto :loop

    :done
    return v0
.end method

.method static sungStyle()Landroidx/compose/ui/text/SpanStyle;
    .locals 3

    sget-wide v0, Lradiant/WordLyrics;->tmpSung:J

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lradiant/WordLyrics;->span(JZ)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    return-object v0
.end method

.method static unsungStyle()Landroidx/compose/ui/text/SpanStyle;
    .locals 3

    sget-wide v0, Lradiant/WordLyrics;->tmpUnsung:J

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lradiant/WordLyrics;->span(JZ)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    return-object v0
.end method

# Paints a span with a gradient
.method static brushSpan(Landroidx/compose/ui/graphics/Brush;)Landroidx/compose/ui/text/SpanStyle;
    .locals 23

    new-instance v0, Landroidx/compose/ui/text/SpanStyle;

    move-object/from16 v1, p0

    const v2, 0x3f800000    # 1.0f

    const-wide/16 v3, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-wide/16 v10, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const-wide/16 v15, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    const v21, 0x1fffc

    const/16 v22, 0x0

    invoke-direct/range {v0 .. v22}, Landroidx/compose/ui/text/SpanStyle;-><init>(Landroidx/compose/ui/graphics/Brush;FJLandroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontSynthesis;Landroidx/compose/ui/text/font/FontFamily;Ljava/lang/String;JLandroidx/compose/ui/text/style/BaselineShift;Landroidx/compose/ui/text/style/TextGeometricTransform;Landroidx/compose/ui/text/intl/LocaleList;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/graphics/Shadow;Landroidx/compose/ui/text/PlatformSpanStyle;Landroidx/compose/ui/graphics/drawscope/DrawStyle;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v0
.end method


# boundary if last char is whitespace or last syllable in the line
.method static isWordEnd(Ljava/lang/String;II)Z
    .locals 3

    add-int/lit8 v0, p2, -0x1

    if-ne p1, v0, :not_last

    const/4 v0, 0x1

    return v0

    :not_last
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :has_len

    const/4 v0, 0x0

    return v0

    :has_len
    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v1

    return v1
.end method
