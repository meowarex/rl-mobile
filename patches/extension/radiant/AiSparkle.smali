.class public final Lradiant/AiSparkle;
.super Landroidx/compose/ui/graphics/painter/Painter;

# interfaces
.implements Landroid/view/Choreographer$FrameCallback;
.implements Ljava/lang/Runnable;


# static fields
.field private static final CYCLE_MS:J = 0x1770L

.field private static final POSTER:Lradiant/AiSparkle;

.field private static final TAG:Ljava/lang/String; = "RLAiSparkle"

.field static final aiState:Landroidx/compose/runtime/MutableState;

.field private static cached:Lradiant/AiSparkle;

.field private static frameScheduled:Z

.field private static lastDrawMs:J

.field private static volatile pending:Z

.field static final tick:Landroidx/compose/runtime/MutableState;


# instance fields
.field private final base:Landroidx/compose/ui/graphics/painter/Painter;

.field private final colors:[I

.field private final fillPaint:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .registers 5

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-static {v0, v1, v2, v1}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/AiSparkle;->aiState:Landroidx/compose/runtime/MutableState;

    const-wide/16 v3, 0x0

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-static {v0, v1, v2, v1}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/AiSparkle;->tick:Landroidx/compose/runtime/MutableState;

    new-instance v0, Lradiant/AiSparkle;

    invoke-direct {v0, v1}, Lradiant/AiSparkle;-><init>(Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object v0, Lradiant/AiSparkle;->POSTER:Lradiant/AiSparkle;

    return-void
.end method

.method private constructor <init>(Landroidx/compose/ui/graphics/painter/Painter;)V
    .registers 4

    invoke-direct {p0}, Landroidx/compose/ui/graphics/painter/Painter;-><init>()V

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lradiant/AiSparkle;->fillPaint:Landroid/graphics/Paint;

    const/4 v0, 0x4

    new-array v0, v0, [I

    iput-object v0, p0, Lradiant/AiSparkle;->colors:[I

    iput-object p1, p0, Lradiant/AiSparkle;->base:Landroidx/compose/ui/graphics/painter/Painter;

    iget-object p1, p0, Lradiant/AiSparkle;->fillPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/PorterDuffXfermode;

    sget-object v1, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v0, v1}, Landroid/graphics/PorterDuffXfermode;-><init>(Landroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    return-void
.end method

.method private static post(Z)V
    .registers 2

    sput-boolean p0, Lradiant/AiSparkle;->pending:Z

    new-instance p0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sget-object v0, Lradiant/AiSparkle;->POSTER:Lradiant/AiSparkle;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method static set(Z)V
    .registers 1

    invoke-static {p0}, Lradiant/AiSparkle;->post(Z)V

    return-void
.end method

.method public static wrap(Landroidx/compose/ui/graphics/painter/Painter;Landroidx/compose/runtime/Composer;)Landroidx/compose/ui/graphics/painter/Painter;
    .registers 3

    sget-object p1, Lradiant/AiSparkle;->aiState:Landroidx/compose/runtime/MutableState;

    invoke-interface {p1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-eqz p1, :cond_25

    if-eqz p0, :cond_25

    instance-of p1, p0, Lradiant/SparkleIcons;

    if-eqz p1, :cond_15

    goto :goto_25

    :cond_15
    sget-object p1, Lradiant/AiSparkle;->cached:Lradiant/AiSparkle;

    if-eqz p1, :cond_1d

    iget-object v0, p1, Lradiant/AiSparkle;->base:Landroidx/compose/ui/graphics/painter/Painter;

    if-eq v0, p0, :cond_24

    :cond_1d
    new-instance p1, Lradiant/AiSparkle;

    invoke-direct {p1, p0}, Lradiant/AiSparkle;-><init>(Landroidx/compose/ui/graphics/painter/Painter;)V

    sput-object p1, Lradiant/AiSparkle;->cached:Lradiant/AiSparkle;

    :cond_24
    return-object p1

    :cond_25
    :goto_25
    return-object p0
.end method


# virtual methods
.method public applyColorFilter(Landroidx/compose/ui/graphics/ColorFilter;)Z
    .registers 2

    const/4 p1, 0x1

    return p1
.end method

.method public doFrame(J)V
    .registers 7

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide p1

    sget-object v0, Lradiant/AiSparkle;->aiState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_2f

    sget-wide v0, Lradiant/AiSparkle;->lastDrawMs:J

    sub-long v0, p1, v0

    const-wide/16 v2, 0x1f4

    cmp-long v0, v0, v2

    if-gez v0, :cond_2f

    sget-object v0, Lradiant/AiSparkle;->tick:Landroidx/compose/runtime/MutableState;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-interface {v0, p1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object p1

    sget-object p2, Lradiant/AiSparkle;->POSTER:Lradiant/AiSparkle;

    invoke-virtual {p1, p2}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    goto :goto_32

    :cond_2f
    const/4 p1, 0x0

    sput-boolean p1, Lradiant/AiSparkle;->frameScheduled:Z

    :goto_32
    return-void
.end method

.method public getIntrinsicSize-NH-jbRc()J
    .registers 3

    iget-object v0, p0, Lradiant/AiSparkle;->base:Landroidx/compose/ui/graphics/painter/Painter;

    invoke-virtual {v0}, Landroidx/compose/ui/graphics/painter/Painter;->getIntrinsicSize-NH-jbRc()J

    move-result-wide v0

    return-wide v0
.end method

.method public onDraw(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V
    .registers 19

    move-object/from16 v0, p0

    sget-object v1, Lradiant/AiSparkle;->tick:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    sput-wide v1, Lradiant/AiSparkle;->lastDrawMs:J

    sget-boolean v3, Lradiant/AiSparkle;->frameScheduled:Z

    if-nez v3, :cond_1d

    const/4 v3, 0x1

    sput-boolean v3, Lradiant/AiSparkle;->frameScheduled:Z

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v3

    sget-object v4, Lradiant/AiSparkle;->POSTER:Lradiant/AiSparkle;

    invoke-virtual {v3, v4}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    :cond_1d
    invoke-interface/range {p1 .. p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J

    move-result-wide v7

    invoke-static {v7, v8}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F

    move-result v12

    invoke-static {v7, v8}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F

    move-result v13

    const/4 v3, 0x0

    cmpg-float v4, v12, v3

    if-lez v4, :cond_8b

    cmpg-float v3, v13, v3

    if-gtz v3, :cond_33

    goto :goto_8b

    :cond_33
    invoke-interface/range {p1 .. p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object v3

    invoke-interface {v3}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v3

    invoke-static {v3}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object v9

    const-wide/16 v3, 0x1770

    rem-long/2addr v1, v3

    long-to-float v1, v1

    const v2, 0x45bb8000    # 6000.0f

    div-float/2addr v1, v2

    const/4 v11, 0x0

    const/4 v14, 0x0

    const/4 v10, 0x0

    invoke-virtual/range {v9 .. v14}, Landroid/graphics/Canvas;->saveLayer(FFFFLandroid/graphics/Paint;)I

    move-result v2

    move-object v3, v9

    iget-object v5, v0, Lradiant/AiSparkle;->base:Landroidx/compose/ui/graphics/painter/Painter;

    const/high16 v9, 0x3f800000    # 1.0f

    const/4 v10, 0x0

    move-object/from16 v6, p1

    invoke-virtual/range {v5 .. v10}, Landroidx/compose/ui/graphics/painter/Painter;->draw-x_KDEd0(Landroidx/compose/ui/graphics/drawscope/DrawScope;JFLandroidx/compose/ui/graphics/ColorFilter;)V

    const/4 v4, 0x0

    :goto_5a
    const/4 v5, 0x4

    if-ge v4, v5, :cond_6d

    iget-object v5, v0, Lradiant/AiSparkle;->colors:[I

    int-to-float v6, v4

    const/high16 v7, 0x3e800000    # 0.25f

    mul-float/2addr v6, v7

    add-float/2addr v6, v1

    invoke-static {v6}, Lradiant/SparkleIcons;->lerpPalette(F)I

    move-result v6

    aput v6, v5, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_5a

    :cond_6d
    iget-object v1, v0, Lradiant/AiSparkle;->fillPaint:Landroid/graphics/Paint;

    new-instance v9, Landroid/graphics/LinearGradient;

    iget-object v14, v0, Lradiant/AiSparkle;->colors:[I

    sget-object v15, Lradiant/SparkleIcons;->STOPS:[F

    sget-object v16, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v10, 0x0

    move v11, v13

    const/4 v13, 0x0

    invoke-direct/range {v9 .. v16}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    move v13, v11

    invoke-virtual {v1, v9}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    const/4 v11, 0x0

    iget-object v14, v0, Lradiant/AiSparkle;->fillPaint:Landroid/graphics/Paint;

    move-object v9, v3

    invoke-virtual/range {v9 .. v14}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    invoke-virtual {v9, v2}, Landroid/graphics/Canvas;->restoreToCount(I)V

    :cond_8b
    :goto_8b
    return-void
.end method

.method public run()V
    .registers 3

    sget-boolean v0, Lradiant/AiSparkle;->pending:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sget-object v1, Lradiant/AiSparkle;->aiState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_17

    sget-object v1, Lradiant/AiSparkle;->aiState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :cond_17
    return-void
.end method
