.class public final Lradiant/SparkleIcons;
.super Landroidx/compose/ui/graphics/painter/Painter;

# interfaces
.implements Landroid/view/Choreographer$FrameCallback;
.implements Ljava/lang/Runnable;


# static fields
.field private static final ARC_SWEEP:F = 300.80283f

.field static final CYCLE_MS:J = 0x1770L

.field private static final LOADING_TIMEOUT_MS:J = 0xea60L

.field static final MODE_LOADING:I = 0x1

.field static final MODE_NONE:I = 0x2

.field static final MODE_SPARKLE:I = 0x0

.field static final MODE_SYLLA:I = 0x3

.field private static final NONE_GRACE_MS:J = 0x1388L

.field private static final NOTE_SCALE:F = 0.75f

.field private static final PALETTE:[I

.field private static final POSTER:Lradiant/SparkleIcons;

.field private static final RING_R:F = 0.355f

.field private static final RING_STROKE:F = 0.089999996f

.field private static final SPIN_MS:J = 0x384L

.field private static final STATES:Lradiant/SparkleIcons;

.field static final STOPS:[F

.field private static final TAG:Ljava/lang/String; = "RLSparkle"

.field private static final TIMEOUT:Lradiant/SparkleIcons;

.field private static final busyJobs:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile busyPending:Z

.field static final busyState:Landroidx/compose/runtime/MutableState;

.field public static currentMode:I

.field public static enabled:Z

.field private static frameScheduled:Z

.field private static lastBranch:I

.field private static lastMedia:Ljava/lang/Object;

.field private static lastSpinDrawMs:J

.field private static latestRunning:Z

.field private static latestWorker:Ljava/lang/Object;

.field private static loadingSinceMs:J

.field private static final lock:Ljava/lang/Object;

.field private static volatile newFetch:Z

.field private static noLyrics:Lradiant/SparkleIcons;

.field private static noneSinceMs:J

.field private static postedAtMs:J

.field private static rainbowSpinner:Lradiant/SparkleIcons;

.field static final rlLoading:Landroidx/compose/runtime/MutableState;

.field private static spinner:Lradiant/SparkleIcons;

.field private static final syllaJobs:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile syllaPending:Z

.field static final syllaState:Landroidx/compose/runtime/MutableState;

.field static final tick:Landroidx/compose/runtime/MutableState;

.field private static timeoutPosted:Z

.field static final timeoutTick:Landroidx/compose/runtime/MutableState;


# instance fields
.field private final clear:Landroid/graphics/Paint;

.field private final inner:Landroidx/compose/ui/graphics/painter/Painter;

.field private final mode:I

.field private final oval:Landroid/graphics/RectF;

.field private final paint:Landroid/graphics/Paint;

.field private final rainbow:[I

.field private final sizeRef:Landroidx/compose/ui/graphics/painter/Painter;


# direct methods
.method static constructor <clinit>()V
    .registers 6

    const v0, -0xa11801

    const v1, -0x587406

    const v2, -0x9463

    const/16 v3, -0x2e9a

    filled-new-array {v2, v3, v0, v1}, [I

    move-result-object v0

    sput-object v0, Lradiant/SparkleIcons;->PALETTE:[I

    const/4 v0, 0x4

    new-array v0, v0, [F

    fill-array-data v0, :array_86

    sput-object v0, Lradiant/SparkleIcons;->STOPS:[F

    const/4 v0, 0x0

    sput v0, Lradiant/SparkleIcons;->currentMode:I

    const/4 v1, 0x1

    sput-boolean v1, Lradiant/SparkleIcons;->enabled:Z

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const/4 v2, 0x0

    const/4 v3, 0x2

    invoke-static {v1, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/SparkleIcons;->rlLoading:Landroidx/compose/runtime/MutableState;

    const-wide/16 v4, 0x0

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {v1, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/SparkleIcons;->tick:Landroidx/compose/runtime/MutableState;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/SparkleIcons;->syllaState:Landroidx/compose/runtime/MutableState;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/SparkleIcons;->busyState:Landroidx/compose/runtime/MutableState;

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    sput-object v1, Lradiant/SparkleIcons;->syllaJobs:Ljava/util/HashSet;

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    sput-object v1, Lradiant/SparkleIcons;->busyJobs:Ljava/util/HashSet;

    new-instance v1, Lradiant/SparkleIcons;

    const/4 v4, -0x2

    invoke-direct {v1, v4, v2, v2}, Lradiant/SparkleIcons;-><init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object v1, Lradiant/SparkleIcons;->STATES:Lradiant/SparkleIcons;

    new-instance v1, Lradiant/SparkleIcons;

    invoke-direct {v1, v0, v2, v2}, Lradiant/SparkleIcons;-><init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object v1, Lradiant/SparkleIcons;->POSTER:Lradiant/SparkleIcons;

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    sput-object v1, Lradiant/SparkleIcons;->lock:Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v0, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/SparkleIcons;->timeoutTick:Landroidx/compose/runtime/MutableState;

    const/4 v0, -0x1

    sput v0, Lradiant/SparkleIcons;->lastBranch:I

    const-wide v3, 0x7fffffffffffffffL

    sput-wide v3, Lradiant/SparkleIcons;->postedAtMs:J

    new-instance v1, Lradiant/SparkleIcons;

    invoke-direct {v1, v0, v2, v2}, Lradiant/SparkleIcons;-><init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object v1, Lradiant/SparkleIcons;->TIMEOUT:Lradiant/SparkleIcons;

    return-void

    nop

    :array_86
    .array-data 4
        0x0
        0x3eb33333    # 0.35f
        0x3f266666    # 0.65f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private constructor <init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V
    .registers 6

    invoke-direct {p0}, Landroidx/compose/ui/graphics/painter/Painter;-><init>()V

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lradiant/SparkleIcons;->clear:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lradiant/SparkleIcons;->oval:Landroid/graphics/RectF;

    const/4 v0, 0x4

    new-array v0, v0, [I

    iput-object v0, p0, Lradiant/SparkleIcons;->rainbow:[I

    iput p1, p0, Lradiant/SparkleIcons;->mode:I

    iput-object p2, p0, Lradiant/SparkleIcons;->inner:Landroidx/compose/ui/graphics/painter/Painter;

    iput-object p3, p0, Lradiant/SparkleIcons;->sizeRef:Landroidx/compose/ui/graphics/painter/Painter;

    iget-object p1, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    const/4 p2, -0x1

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object p1, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p1, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    iget-object p1, p0, Lradiant/SparkleIcons;->clear:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p1, p0, Lradiant/SparkleIcons;->clear:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    iget-object p1, p0, Lradiant/SparkleIcons;->clear:Landroid/graphics/Paint;

    new-instance p2, Landroid/graphics/PorterDuffXfermode;

    sget-object p3, Landroid/graphics/PorterDuff$Mode;->CLEAR:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {p2, p3}, Landroid/graphics/PorterDuffXfermode;-><init>(Landroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    return-void
.end method

.method public static forMode(Landroidx/compose/ui/graphics/painter/Painter;ILandroidx/compose/runtime/Composer;)Landroidx/compose/ui/graphics/painter/Painter;
    .registers 6

    const v0, 0x52415300

    add-int/2addr v0, p1

    invoke-interface {p2, v0}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1d

    if-eqz p0, :cond_1d

    sget-object p1, Lradiant/SparkleIcons;->spinner:Lradiant/SparkleIcons;

    if-eqz p1, :cond_14

    iget-object v1, p1, Lradiant/SparkleIcons;->inner:Landroidx/compose/ui/graphics/painter/Painter;

    if-eq v1, p0, :cond_1b

    :cond_14
    new-instance p1, Lradiant/SparkleIcons;

    invoke-direct {p1, v0, p0, p0}, Lradiant/SparkleIcons;-><init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object p1, Lradiant/SparkleIcons;->spinner:Lradiant/SparkleIcons;

    :cond_1b
    :goto_1b
    move-object p0, p1

    goto :goto_52

    :cond_1d
    const/4 v0, 0x3

    if-ne p1, v0, :cond_32

    if-eqz p0, :cond_32

    sget-object p1, Lradiant/SparkleIcons;->rainbowSpinner:Lradiant/SparkleIcons;

    if-eqz p1, :cond_2a

    iget-object v1, p1, Lradiant/SparkleIcons;->inner:Landroidx/compose/ui/graphics/painter/Painter;

    if-eq v1, p0, :cond_1b

    :cond_2a
    new-instance p1, Lradiant/SparkleIcons;

    invoke-direct {p1, v0, p0, p0}, Lradiant/SparkleIcons;-><init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object p1, Lradiant/SparkleIcons;->rainbowSpinner:Lradiant/SparkleIcons;

    goto :goto_1b

    :cond_32
    const/4 v0, 0x2

    if-ne p1, v0, :cond_52

    if-eqz p0, :cond_52

    sget p1, Lcom/aspiro/wamp/R$drawable;->ic_music_note:I

    const/4 v1, 0x0

    invoke-static {p1, p2, v1}, Landroidx/compose/ui/res/PainterResources_androidKt;->painterResource(ILandroidx/compose/runtime/Composer;I)Landroidx/compose/ui/graphics/painter/Painter;

    move-result-object p1

    sget-object v1, Lradiant/SparkleIcons;->noLyrics:Lradiant/SparkleIcons;

    if-eqz v1, :cond_4a

    iget-object v2, v1, Lradiant/SparkleIcons;->inner:Landroidx/compose/ui/graphics/painter/Painter;

    if-ne v2, p1, :cond_4a

    iget-object v2, v1, Lradiant/SparkleIcons;->sizeRef:Landroidx/compose/ui/graphics/painter/Painter;

    if-eq v2, p0, :cond_51

    :cond_4a
    new-instance v1, Lradiant/SparkleIcons;

    invoke-direct {v1, v0, p1, p0}, Lradiant/SparkleIcons;-><init>(ILandroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object v1, Lradiant/SparkleIcons;->noLyrics:Lradiant/SparkleIcons;

    :cond_51
    move-object p0, v1

    :cond_52
    :goto_52
    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-object p0
.end method

.method static lerpPalette(F)I
    .registers 8

    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->floor(D)D

    move-result-wide v0

    double-to-float v0, v0

    sub-float/2addr p0, v0

    const/high16 v0, 0x40800000    # 4.0f

    mul-float/2addr p0, v0

    float-to-int v0, p0

    int-to-float v1, v0

    sub-float/2addr p0, v1

    sget-object v1, Lradiant/SparkleIcons;->PALETTE:[I

    and-int/lit8 v2, v0, 0x3

    aget v1, v1, v2

    sget-object v2, Lradiant/SparkleIcons;->PALETTE:[I

    add-int/lit8 v0, v0, 0x1

    and-int/lit8 v0, v0, 0x3

    aget v0, v2, v0

    shr-int/lit8 v2, v1, 0x10

    and-int/lit16 v2, v2, 0xff

    shr-int/lit8 v3, v1, 0x8

    and-int/lit16 v3, v3, 0xff

    and-int/lit16 v1, v1, 0xff

    shr-int/lit8 v4, v0, 0x10

    and-int/lit16 v4, v4, 0xff

    shr-int/lit8 v5, v0, 0x8

    and-int/lit16 v5, v5, 0xff

    and-int/lit16 v0, v0, 0xff

    int-to-float v6, v2

    sub-int/2addr v4, v2

    int-to-float v2, v4

    mul-float/2addr v2, p0

    add-float/2addr v6, v2

    float-to-int v2, v6

    int-to-float v4, v3

    sub-int/2addr v5, v3

    int-to-float v3, v5

    mul-float/2addr v3, p0

    add-float/2addr v4, v3

    float-to-int v3, v4

    int-to-float v4, v1

    sub-int/2addr v0, v1

    int-to-float v0, v0

    mul-float/2addr v0, p0

    add-float/2addr v4, v0

    float-to-int p0, v4

    const/high16 v0, -0x1000000

    shl-int/lit8 v1, v2, 0x10

    or-int/2addr v0, v1

    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v0, v1

    or-int/2addr p0, v0

    return p0
.end method

.method public static modeFor(Ljava/lang/Object;ZLjava/lang/Object;)I
    .registers 12

    sget-object v0, Lradiant/SparkleIcons;->timeoutTick:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    sget-object v4, Lradiant/SparkleIcons;->lastMedia:Ljava/lang/Object;

    if-nez p2, :cond_12

    if-eqz v4, :cond_1f

    goto :goto_18

    :cond_12
    invoke-virtual {p2, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1f

    :goto_18
    sput-object p2, Lradiant/SparkleIcons;->lastMedia:Ljava/lang/Object;

    sput-wide v2, Lradiant/SparkleIcons;->loadingSinceMs:J

    const/4 p2, -0x1

    sput p2, Lradiant/SparkleIcons;->lastBranch:I

    :cond_1f
    sget-object p2, Lradiant/SparkleIcons;->rlLoading:Landroidx/compose/runtime/MutableState;

    invoke-interface {p2}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-nez p1, :cond_78

    instance-of v6, p0, Lcom/tidal/android/feature/playerscreen/ui/g$c;

    if-nez v6, :cond_78

    instance-of v6, p0, Lcom/tidal/android/feature/playerscreen/ui/g$d;

    if-eqz v6, :cond_38

    goto :goto_78

    :cond_38
    const/4 v6, 0x2

    if-nez p2, :cond_5b

    instance-of v7, p0, Lcom/tidal/android/feature/playerscreen/ui/g$b;

    if-eqz v7, :cond_40

    goto :goto_5b

    :cond_40
    sget v7, Lradiant/SparkleIcons;->lastBranch:I

    if-eq v7, v6, :cond_46

    sput-wide v0, Lradiant/SparkleIcons;->noneSinceMs:J

    :cond_46
    sget-wide v7, Lradiant/SparkleIcons;->noneSinceMs:J

    sub-long/2addr v0, v7

    const-wide/16 v7, 0x1388

    cmp-long v0, v0, v7

    if-gez v0, :cond_57

    sget-wide v0, Lradiant/SparkleIcons;->noneSinceMs:J

    add-long/2addr v0, v7

    invoke-static {v0, v1}, Lradiant/SparkleIcons;->scheduleRecompose(J)V

    move v0, v5

    goto :goto_58

    :cond_57
    move v0, v6

    :goto_58
    sput-wide v2, Lradiant/SparkleIcons;->loadingSinceMs:J

    goto :goto_7c

    :cond_5b
    :goto_5b
    sget-wide v7, Lradiant/SparkleIcons;->loadingSinceMs:J

    cmp-long v2, v7, v2

    if-nez v2, :cond_63

    sput-wide v0, Lradiant/SparkleIcons;->loadingSinceMs:J

    :cond_63
    sget-wide v2, Lradiant/SparkleIcons;->loadingSinceMs:J

    sub-long/2addr v0, v2

    const-wide/32 v2, 0xea60

    cmp-long v0, v0, v2

    if-ltz v0, :cond_70

    move v0, v6

    move v6, v5

    goto :goto_7c

    :cond_70
    sget-wide v0, Lradiant/SparkleIcons;->loadingSinceMs:J

    add-long/2addr v0, v2

    invoke-static {v0, v1}, Lradiant/SparkleIcons;->scheduleRecompose(J)V

    move v0, v5

    goto :goto_7b

    :cond_78
    :goto_78
    sput-wide v2, Lradiant/SparkleIcons;->loadingSinceMs:J

    move v0, v4

    :goto_7b
    move v6, v0

    :goto_7c
    sput v6, Lradiant/SparkleIcons;->lastBranch:I

    if-nez v0, :cond_81

    move v4, v5

    :cond_81
    sput-boolean v4, Lradiant/SparkleIcons;->enabled:Z

    sget-object v1, Lradiant/SparkleIcons;->syllaState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_93

    const/4 v5, 0x3

    goto :goto_a3

    :cond_93
    sget-object v1, Lradiant/SparkleIcons;->busyState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_a2

    goto :goto_a3

    :cond_a2
    move v5, v0

    :goto_a3
    sget v0, Lradiant/SparkleIcons;->currentMode:I

    if-eq v5, v0, :cond_fc

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mode "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lradiant/SparkleIcons;->currentMode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " -> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " (lyricsState="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-nez p0, :cond_cd

    const-string p0, "null"

    goto :goto_d5

    :cond_cd
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    :goto_d5
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " hasLyrics="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " rlLoading="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ")"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p1, "RLSparkle"

    invoke-static {p1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_fc
    sput v5, Lradiant/SparkleIcons;->currentMode:I

    return v5
.end method

.method static resetWork()V
    .registers 2

    sget-object v0, Lradiant/SparkleIcons;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/SparkleIcons;->syllaJobs:Ljava/util/HashSet;

    invoke-virtual {v1}, Ljava/util/HashSet;->clear()V

    sget-object v1, Lradiant/SparkleIcons;->busyJobs:Ljava/util/HashSet;

    invoke-virtual {v1}, Ljava/util/HashSet;->clear()V

    const/4 v1, 0x0

    sput-boolean v1, Lradiant/SparkleIcons;->syllaPending:Z

    sput-boolean v1, Lradiant/SparkleIcons;->busyPending:Z

    monitor-exit v0
    :try_end_13
    .catchall {:try_start_3 .. :try_end_13} :catchall_22

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sget-object v1, Lradiant/SparkleIcons;->STATES:Lradiant/SparkleIcons;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :catchall_22
    move-exception v1

    :try_start_23
    monitor-exit v0
    :try_end_24
    .catchall {:try_start_23 .. :try_end_24} :catchall_22

    throw v1
.end method

.method public static rlBegin(Ljava/lang/Object;)V
    .registers 2

    sget-object v0, Lradiant/SparkleIcons;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    sput-object p0, Lradiant/SparkleIcons;->latestWorker:Ljava/lang/Object;

    const/4 p0, 0x1

    sput-boolean p0, Lradiant/SparkleIcons;->latestRunning:Z

    monitor-exit v0
    :try_end_9
    .catchall {:try_start_3 .. :try_end_9} :catchall_1a

    sput-boolean p0, Lradiant/SparkleIcons;->newFetch:Z

    new-instance p0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sget-object v0, Lradiant/SparkleIcons;->POSTER:Lradiant/SparkleIcons;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :catchall_1a
    move-exception p0

    :try_start_1b
    monitor-exit v0
    :try_end_1c
    .catchall {:try_start_1b .. :try_end_1c} :catchall_1a

    throw p0
.end method

.method public static rlEnd(Ljava/lang/Object;)V
    .registers 3

    sget-object v0, Lradiant/SparkleIcons;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/SparkleIcons;->latestWorker:Ljava/lang/Object;

    if-ne p0, v1, :cond_a

    const/4 p0, 0x0

    sput-boolean p0, Lradiant/SparkleIcons;->latestRunning:Z

    :cond_a
    monitor-exit v0
    :try_end_b
    .catchall {:try_start_3 .. :try_end_b} :catchall_1a

    new-instance p0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sget-object v0, Lradiant/SparkleIcons;->POSTER:Lradiant/SparkleIcons;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :catchall_1a
    move-exception p0

    :try_start_1b
    monitor-exit v0
    :try_end_1c
    .catchall {:try_start_1b .. :try_end_1c} :catchall_1a

    throw p0
.end method

.method private static scheduleRecompose(J)V
    .registers 4

    sget-boolean v0, Lradiant/SparkleIcons;->timeoutPosted:Z

    if-eqz v0, :cond_b

    sget-wide v0, Lradiant/SparkleIcons;->postedAtMs:J

    cmp-long v0, p0, v0

    if-ltz v0, :cond_b

    return-void

    :cond_b
    const/4 v0, 0x1

    sput-boolean v0, Lradiant/SparkleIcons;->timeoutPosted:Z

    sput-wide p0, Lradiant/SparkleIcons;->postedAtMs:J

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sub-long/2addr p0, v0

    const-wide/16 v0, 0x0

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p0

    const-wide/16 v0, 0x32

    add-long/2addr p0, v0

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sget-object v1, Lradiant/SparkleIcons;->TIMEOUT:Lradiant/SparkleIcons;

    invoke-virtual {v0, v1, p0, p1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method static work(Ljava/lang/Object;ZZ)V
    .registers 4

    sget-object v0, Lradiant/SparkleIcons;->lock:Ljava/lang/Object;

    monitor-enter v0

    if-eqz p1, :cond_8

    :try_start_5
    sget-object p1, Lradiant/SparkleIcons;->syllaJobs:Ljava/util/HashSet;

    goto :goto_a

    :cond_8
    sget-object p1, Lradiant/SparkleIcons;->busyJobs:Ljava/util/HashSet;

    :goto_a
    if-eqz p2, :cond_10

    invoke-virtual {p1, p0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_13

    :cond_10
    invoke-virtual {p1, p0}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    :goto_13
    sget-object p0, Lradiant/SparkleIcons;->syllaJobs:Ljava/util/HashSet;

    invoke-virtual {p0}, Ljava/util/HashSet;->isEmpty()Z

    move-result p0

    xor-int/lit8 p0, p0, 0x1

    sput-boolean p0, Lradiant/SparkleIcons;->syllaPending:Z

    sget-object p0, Lradiant/SparkleIcons;->busyJobs:Ljava/util/HashSet;

    invoke-virtual {p0}, Ljava/util/HashSet;->isEmpty()Z

    move-result p0

    xor-int/lit8 p0, p0, 0x1

    sput-boolean p0, Lradiant/SparkleIcons;->busyPending:Z

    monitor-exit v0
    :try_end_28
    .catchall {:try_start_5 .. :try_end_28} :catchall_37

    new-instance p0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object p1

    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sget-object p1, Lradiant/SparkleIcons;->STATES:Lradiant/SparkleIcons;

    invoke-virtual {p0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :catchall_37
    move-exception p0

    :try_start_38
    monitor-exit v0
    :try_end_39
    .catchall {:try_start_38 .. :try_end_39} :catchall_37

    throw p0
.end method


# virtual methods
.method public applyColorFilter(Landroidx/compose/ui/graphics/ColorFilter;)Z
    .registers 3

    iget p1, p0, Lradiant/SparkleIcons;->mode:I

    const/4 v0, 0x3

    if-ne p1, v0, :cond_7

    const/4 p1, 0x1

    goto :goto_8

    :cond_7
    const/4 p1, 0x0

    :goto_8
    return p1
.end method

.method public doFrame(J)V
    .registers 7

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide p1

    sget-wide v0, Lradiant/SparkleIcons;->lastSpinDrawMs:J

    sub-long v0, p1, v0

    const-wide/16 v2, 0x1f4

    cmp-long v0, v0, v2

    if-gez v0, :cond_21

    sget-object v0, Lradiant/SparkleIcons;->tick:Landroidx/compose/runtime/MutableState;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-interface {v0, p1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object p1

    sget-object p2, Lradiant/SparkleIcons;->POSTER:Lradiant/SparkleIcons;

    invoke-virtual {p1, p2}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    goto :goto_24

    :cond_21
    const/4 p1, 0x0

    sput-boolean p1, Lradiant/SparkleIcons;->frameScheduled:Z

    :goto_24
    return-void
.end method

.method public getIntrinsicSize-NH-jbRc()J
    .registers 3

    iget-object v0, p0, Lradiant/SparkleIcons;->sizeRef:Landroidx/compose/ui/graphics/painter/Painter;

    invoke-virtual {v0}, Landroidx/compose/ui/graphics/painter/Painter;->getIntrinsicSize-NH-jbRc()J

    move-result-wide v0

    return-wide v0
.end method

.method public onDraw(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V
    .registers 16

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J

    move-result-wide v2

    invoke-static {v2, v3}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F

    move-result v7

    invoke-static {v2, v3}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F

    move-result v6

    const/4 v0, 0x0

    cmpg-float v1, v7, v0

    if-lez v1, :cond_10b

    cmpg-float v0, v6, v0

    if-gtz v0, :cond_17

    goto/16 :goto_10b

    :cond_17
    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v0

    invoke-static {v0}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object v8

    invoke-static {v7, v6}, Ljava/lang/Math;->min(FF)F

    move-result v10

    iget v0, p0, Lradiant/SparkleIcons;->mode:I

    const/4 v1, 0x3

    const/4 v4, 0x1

    const/high16 v11, 0x40000000    # 2.0f

    if-eq v0, v4, :cond_84

    iget v0, p0, Lradiant/SparkleIcons;->mode:I

    if-ne v0, v1, :cond_34

    goto :goto_84

    :cond_34
    move-object v4, v8

    move v8, v6

    const/4 v6, 0x0

    const/4 v9, 0x0

    const/4 v5, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->saveLayer(FFFFLandroid/graphics/Paint;)I

    move-result v6

    move-object v9, v4

    invoke-virtual {v9}, Landroid/graphics/Canvas;->save()I

    div-float/2addr v7, v11

    div-float v0, v8, v11

    const/high16 v1, 0x3f400000    # 0.75f

    invoke-virtual {v9, v1, v1, v7, v0}, Landroid/graphics/Canvas;->scale(FFFF)V

    iget-object v0, p0, Lradiant/SparkleIcons;->inner:Landroidx/compose/ui/graphics/painter/Painter;

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v5, 0x0

    move-object v1, p1

    invoke-virtual/range {v0 .. v5}, Landroidx/compose/ui/graphics/painter/Painter;->draw-x_KDEd0(Landroidx/compose/ui/graphics/drawscope/DrawScope;JFLandroidx/compose/ui/graphics/ColorFilter;)V

    invoke-virtual {v9}, Landroid/graphics/Canvas;->restore()V

    const p1, 0x3d75c28f    # 0.06f

    mul-float/2addr p1, v10

    const v0, 0x3e4ccccd    # 0.2f

    mul-float/2addr v0, v10

    const v1, 0x3f4ccccd    # 0.8f

    mul-float v11, v10, v1

    iget-object v1, p0, Lradiant/SparkleIcons;->clear:Landroid/graphics/Paint;

    const v2, 0x40266666    # 2.6f

    mul-float/2addr v2, p1

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v13, p0, Lradiant/SparkleIcons;->clear:Landroid/graphics/Paint;

    move v10, v0

    move v12, v11

    move-object v8, v9

    move v9, v0

    invoke-virtual/range {v8 .. v13}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    iget-object v0, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v13, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    move v10, v9

    invoke-virtual/range {v8 .. v13}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    move-object p1, v8

    invoke-virtual {p1, v6}, Landroid/graphics/Canvas;->restoreToCount(I)V

    return-void

    :cond_84
    :goto_84
    move v0, v4

    move-object p1, v8

    move v8, v6

    sget-object v2, Lradiant/SparkleIcons;->tick:Landroidx/compose/runtime/MutableState;

    invoke-interface {v2}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    sput-wide v2, Lradiant/SparkleIcons;->lastSpinDrawMs:J

    sget-boolean v4, Lradiant/SparkleIcons;->frameScheduled:Z

    if-nez v4, :cond_a1

    sput-boolean v0, Lradiant/SparkleIcons;->frameScheduled:Z

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    sget-object v4, Lradiant/SparkleIcons;->POSTER:Lradiant/SparkleIcons;

    invoke-virtual {v0, v4}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    :cond_a1
    const v0, 0x3eb5c28f    # 0.355f

    mul-float/2addr v0, v10

    iget-object v4, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    const v5, 0x3db851eb    # 0.089999996f

    mul-float/2addr v10, v5

    invoke-virtual {v4, v10}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v4, p0, Lradiant/SparkleIcons;->oval:Landroid/graphics/RectF;

    div-float v5, v7, v11

    sub-float v6, v5, v0

    div-float v9, v8, v11

    sub-float v10, v9, v0

    add-float/2addr v5, v0

    add-float/2addr v9, v0

    invoke-virtual {v4, v6, v10, v5, v9}, Landroid/graphics/RectF;->set(FFFF)V

    const-wide/16 v4, 0x384

    rem-long v4, v2, v4

    long-to-float v0, v4

    const/high16 v4, 0x44610000    # 900.0f

    div-float/2addr v0, v4

    const/high16 v4, 0x43b40000    # 360.0f

    mul-float/2addr v0, v4

    iget v4, p0, Lradiant/SparkleIcons;->mode:I

    if-ne v4, v1, :cond_fb

    const-wide/16 v4, 0x1770

    rem-long/2addr v2, v4

    long-to-float v1, v2

    const v2, 0x45bb8000    # 6000.0f

    div-float/2addr v1, v2

    const/4 v2, 0x0

    :goto_d5
    const/4 v3, 0x4

    if-ge v2, v3, :cond_e8

    iget-object v3, p0, Lradiant/SparkleIcons;->rainbow:[I

    int-to-float v4, v2

    const/high16 v5, 0x3e800000    # 0.25f

    mul-float/2addr v4, v5

    add-float/2addr v4, v1

    invoke-static {v4}, Lradiant/SparkleIcons;->lerpPalette(F)I

    move-result v4

    aput v4, v3, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_d5

    :cond_e8
    iget-object v1, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    new-instance v4, Landroid/graphics/LinearGradient;

    iget-object v9, p0, Lradiant/SparkleIcons;->rainbow:[I

    sget-object v10, Lradiant/SparkleIcons;->STOPS:[F

    sget-object v11, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v5, 0x0

    move v6, v8

    const/4 v8, 0x0

    invoke-direct/range {v4 .. v11}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    :cond_fb
    iget-object v9, p0, Lradiant/SparkleIcons;->oval:Landroid/graphics/RectF;

    const/high16 v1, 0x42b40000    # 90.0f

    sub-float v10, v0, v1

    const/4 v12, 0x0

    iget-object v13, p0, Lradiant/SparkleIcons;->paint:Landroid/graphics/Paint;

    const v11, 0x439666c3

    move-object v8, p1

    invoke-virtual/range {v8 .. v13}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    :cond_10b
    :goto_10b
    return-void
.end method

.method public run()V
    .registers 5

    iget v0, p0, Lradiant/SparkleIcons;->mode:I

    const/4 v1, -0x2

    if-ne v0, v1, :cond_34

    sget-boolean v0, Lradiant/SparkleIcons;->syllaPending:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sget-object v1, Lradiant/SparkleIcons;->syllaState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1c

    sget-object v1, Lradiant/SparkleIcons;->syllaState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :cond_1c
    sget-boolean v0, Lradiant/SparkleIcons;->busyPending:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sget-object v1, Lradiant/SparkleIcons;->busyState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_33

    sget-object v1, Lradiant/SparkleIcons;->busyState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :cond_33
    return-void

    :cond_34
    iget v0, p0, Lradiant/SparkleIcons;->mode:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_5b

    sput-boolean v2, Lradiant/SparkleIcons;->timeoutPosted:Z

    const-wide v0, 0x7fffffffffffffffL

    sput-wide v0, Lradiant/SparkleIcons;->postedAtMs:J

    sget-object v0, Lradiant/SparkleIcons;->timeoutTick:Landroidx/compose/runtime/MutableState;

    sget-object v1, Lradiant/SparkleIcons;->timeoutTick:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    return-void

    :cond_5b
    sget-object v0, Lradiant/SparkleIcons;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_5e
    sget-boolean v1, Lradiant/SparkleIcons;->latestRunning:Z

    monitor-exit v0
    :try_end_61
    .catchall {:try_start_5e .. :try_end_61} :catchall_98

    sget-boolean v0, Lradiant/SparkleIcons;->newFetch:Z

    if-eqz v0, :cond_82

    sput-boolean v2, Lradiant/SparkleIcons;->newFetch:Z

    const-wide/16 v2, 0x0

    sput-wide v2, Lradiant/SparkleIcons;->loadingSinceMs:J

    sget-object v0, Lradiant/SparkleIcons;->timeoutTick:Landroidx/compose/runtime/MutableState;

    sget-object v2, Lradiant/SparkleIcons;->timeoutTick:Landroidx/compose/runtime/MutableState;

    invoke-interface {v2}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :cond_82
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sget-object v1, Lradiant/SparkleIcons;->rlLoading:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_97

    sget-object v1, Lradiant/SparkleIcons;->rlLoading:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :cond_97
    return-void

    :catchall_98
    move-exception v1

    :try_start_99
    monitor-exit v0
    :try_end_9a
    .catchall {:try_start_99 .. :try_end_9a} :catchall_98

    throw v1
.end method
