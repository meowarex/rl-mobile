.class public final Lradiant/Kawarp;
.super Ljava/lang/Object;

# interfaces
.implements Lam0/l;
.implements Ljava/lang/Runnable;
.implements Landroid/view/Choreographer$FrameCallback;


# static fields
.field private static final DRAW:Lradiant/Kawarp;

.field private static final IDLE_STOP_MS:J = 0x1f4L

.field private static final LOADER:Ljava/util/concurrent/ExecutorService;

.field private static final TAG:Ljava/lang/String; = "RLKawarp"

.field private static engine:Ldev/kawarp/KawarpEngine;

.field private static final fallbackState:Landroidx/compose/runtime/MutableState;

.field private static frameScheduled:Z

.field private static final frameState:Landroidx/compose/runtime/MutableState;

.field private static frameTick:I

.field private static lastDrawUptime:J

.field private static volatile loadToken:I

.field private static loggedDraw:Z

.field private static volatile requestedUuid:Ljava/lang/String;


# instance fields
.field private final token:I

.field private final uuid:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 4

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lradiant/Kawarp;->LOADER:Ljava/util/concurrent/ExecutorService;

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x2

    invoke-static {v1, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/Kawarp;->frameState:Landroidx/compose/runtime/MutableState;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3, v2}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    new-instance v1, Lradiant/Kawarp;

    invoke-direct {v1, v2, v0}, Lradiant/Kawarp;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lradiant/Kawarp;->DRAW:Lradiant/Kawarp;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/Kawarp;->uuid:Ljava/lang/String;

    iput p2, p0, Lradiant/Kawarp;->token:I

    return-void
.end method

.method public static b(Lcom/tidal/android/feature/playerscreen/ui/model/PlayerBackgroundStyle;JILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V
    .registers 11

    invoke-static {p3, p4, p5, p8, p9}, Lradiant/Kawarp;->render(ILjava/lang/String;ZLandroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;)V

    return-void
.end method

.method private static draw(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V
    .registers 6

    sget-object v0, Lradiant/Kawarp;->frameState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sput-wide v0, Lradiant/Kawarp;->lastDrawUptime:J

    invoke-static {}, Lradiant/Kawarp;->schedule()V

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J

    move-result-wide v0

    invoke-static {v0, v1}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F

    move-result v2

    invoke-static {v0, v1}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F

    move-result v0

    sget-boolean v1, Lradiant/Kawarp;->loggedDraw:Z

    const-string v3, "RLKawarp"

    if-nez v1, :cond_53

    const/4 v1, 0x1

    sput-boolean v1, Lradiant/Kawarp;->loggedDraw:Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "first draw: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "x"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " ready="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v4, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v4}, Ldev/kawarp/KawarpEngine;->isReady()Z

    move-result v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_53
    :try_start_53
    sget-object v1, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object p0

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object p0

    invoke-static {p0}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object p0

    invoke-virtual {v1, p0, v2, v0}, Ldev/kawarp/KawarpEngine;->draw(Landroid/graphics/Canvas;FF)Z
    :try_end_64
    .catchall {:try_start_53 .. :try_end_64} :catchall_65

    goto :goto_83

    :catchall_65
    move-exception p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AGSL draw failed, falling back: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v3, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object p0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {p0, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :goto_83
    return-void
.end method

.method private static ensureEngine()Z
    .registers 4

    sget-object v0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    const/4 v1, 0x1

    if-eqz v0, :cond_6

    return v1

    :cond_6
    invoke-static {}, Ldev/kawarp/KawarpEngine;->isSupported()Z

    move-result v0

    const/4 v2, 0x0

    if-nez v0, :cond_e

    return v2

    :cond_e
    :try_start_e
    new-instance v0, Ldev/kawarp/KawarpEngine;

    invoke-direct {v0}, Ldev/kawarp/KawarpEngine;-><init>()V

    const v3, __RL_KW_WARP__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setWarpIntensity(F)V

    const v3, __RL_KW_SPEED__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setAnimationSpeed(F)V

    const v3, __RL_KW_SCALE__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setScale(F)V

    const v3, __RL_KW_DITHER__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setDithering(F)V

    const v3, __RL_KW_DARKEN__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setAutoDarken(F)V

    const v3, __RL_KW_REACTIVE__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    if-eqz v3, :cond_64

    move v3, v1

    goto :goto_65

    :cond_64
    move v3, v2

    :goto_65
    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setPlaybackReactive(Z)V

    const v3, __RL_KW_BLUR__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setBlurPasses(I)V

    const v3, __RL_KW_CONTRAST__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setContrast(F)V

    const v3, __RL_KW_SAT__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setSaturation(F)V

    const v3, __RL_KW_BRIGHT__

    invoke-static {v3}, Lradiant/Kawarp;->tk(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v3

    invoke-virtual {v0, v3}, Ldev/kawarp/KawarpEngine;->setBrightness(F)V

    sput-object v0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;
    :try_end_9e
    .catchall {:try_start_e .. :try_end_9e} :catchall_9f

    return v1

    :catchall_9f
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AGSL rejected, staying on the native backdrop: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "RLKawarp"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    return v2
.end method

.method public static render(ILjava/lang/String;ZLandroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;)V
    .registers 13

    const v0, 0x52415750

    invoke-interface {p4, v0}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    sget-object v0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_34

    invoke-static {}, Lradiant/Kawarp;->ensureEngine()Z

    move-result v0

    if-eqz v0, :cond_34

    sget-object p0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {p0, p2}, Ldev/kawarp/KawarpEngine;->setPlaying(Z)V

    invoke-static {p1}, Lradiant/Kawarp;->request(Ljava/lang/String;)V

    const/high16 p0, 0x3f800000    # 1.0f

    invoke-static {p3, p0}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxSize(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;

    move-result-object p0

    sget-object p1, Lradiant/Kawarp;->DRAW:Lradiant/Kawarp;

    invoke-static {p0, p1}, Landroidx/compose/ui/draw/DrawModifierKt;->drawBehind(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    const/4 p1, 0x0

    invoke-static {p0, p4, p1}, Landroidx/compose/foundation/layout/SpacerKt;->Spacer(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V

    move-object v6, p4

    goto :goto_3f

    :cond_34
    const/4 v4, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x0

    move v0, p0

    move-object v1, p1

    move v2, p2

    move-object v5, p3

    move-object v6, p4

    invoke-static/range {v0 .. v7}, Lcom/tidal/android/feature/playerscreen/ui/composables/p3;->a(ILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V

    :goto_3f
    invoke-interface {v6}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-void
.end method

.method private static request(Ljava/lang/String;)V
    .registers 4

    if-eqz p0, :cond_23

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_23

    sget-object v0, Lradiant/Kawarp;->requestedUuid:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_23

    :cond_11
    sput-object p0, Lradiant/Kawarp;->requestedUuid:Ljava/lang/String;

    sget-object v0, Lradiant/Kawarp;->LOADER:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lradiant/Kawarp;

    sget v2, Lradiant/Kawarp;->loadToken:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lradiant/Kawarp;->loadToken:I

    invoke-direct {v1, p0, v2}, Lradiant/Kawarp;-><init>(Ljava/lang/String;I)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_23
    :goto_23
    return-void
.end method

.method private static schedule()V
    .registers 2

    sget-boolean v0, Lradiant/Kawarp;->frameScheduled:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    const/4 v0, 0x1

    sput-boolean v0, Lradiant/Kawarp;->frameScheduled:Z

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    sget-object v1, Lradiant/Kawarp;->DRAW:Lradiant/Kawarp;

    invoke-virtual {v0, v1}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    return-void
.end method

.method private static tk(I)I
    .registers 1

    return p0
.end method


# virtual methods
.method public doFrame(J)V
    .registers 5

    const/4 p1, 0x0

    sput-boolean p1, Lradiant/Kawarp;->frameScheduled:Z

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide p1

    sget-wide v0, Lradiant/Kawarp;->lastDrawUptime:J

    sub-long/2addr p1, v0

    const-wide/16 v0, 0x1f4

    cmp-long p1, p1, v0

    if-lez p1, :cond_11

    return-void

    :cond_11
    sget-object p1, Lradiant/Kawarp;->frameState:Landroidx/compose/runtime/MutableState;

    sget p2, Lradiant/Kawarp;->frameTick:I

    add-int/lit8 p2, p2, 0x1

    sput p2, Lradiant/Kawarp;->frameTick:I

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-interface {p1, p2}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    invoke-static {}, Lradiant/Kawarp;->schedule()V

    return-void
.end method

.method public invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2

    check-cast p1, Landroidx/compose/ui/graphics/drawscope/DrawScope;

    invoke-static {p1}, Lradiant/Kawarp;->draw(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V

    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public run()V
    .registers 8

    const-string v0, "RLKawarp"

    const/4 v1, 0x0

    :try_start_3
    new-instance v2, Ljava/net/URL;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "https://resources.tidal.com/images/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lradiant/Kawarp;->uuid:Ljava/lang/String;

    const/16 v5, 0x2d

    const/16 v6, 0x2f

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/640x640.jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;
    :try_end_31
    .catchall {:try_start_3 .. :try_end_31} :catchall_7f

    const/16 v3, 0x2710

    :try_start_33
    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    const/16 v3, 0x3a98

    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v3
    :try_end_3f
    .catchall {:try_start_33 .. :try_end_3f} :catchall_7d

    :try_start_3f
    invoke-static {v3}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v4
    :try_end_43
    .catchall {:try_start_3f .. :try_end_43} :catchall_78

    :try_start_43
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    if-eqz v4, :cond_72

    iget v3, p0, Lradiant/Kawarp;->token:I

    sget v5, Lradiant/Kawarp;->loadToken:I

    if-eq v3, v5, :cond_4f

    goto :goto_72

    :cond_4f
    sget-object v3, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v3, v4}, Ldev/kawarp/KawarpEngine;->setCover(Landroid/graphics/Bitmap;)V

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->recycle()V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "cover submitted: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lradiant/Kawarp;->uuid:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6f
    .catchall {:try_start_43 .. :try_end_6f} :catchall_7d

    if-eqz v2, :cond_a4

    goto :goto_a1

    :cond_72
    :goto_72
    if-eqz v2, :cond_77

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_77
    return-void

    :catchall_78
    move-exception v4

    :try_start_79
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    throw v4
    :try_end_7d
    .catchall {:try_start_79 .. :try_end_7d} :catchall_7d

    :catchall_7d
    move-exception v3

    goto :goto_81

    :catchall_7f
    move-exception v3

    move-object v2, v1

    :goto_81
    :try_start_81
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "cover load failed: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v0, p0, Lradiant/Kawarp;->token:I

    sget v3, Lradiant/Kawarp;->loadToken:I

    if-ne v0, v3, :cond_9f

    sput-object v1, Lradiant/Kawarp;->requestedUuid:Ljava/lang/String;
    :try_end_9f
    .catchall {:try_start_81 .. :try_end_9f} :catchall_a5

    :cond_9f
    if-eqz v2, :cond_a4

    :goto_a1
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_a4
    return-void

    :catchall_a5
    move-exception v0

    if-eqz v2, :cond_ab

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_ab
    throw v0
.end method
