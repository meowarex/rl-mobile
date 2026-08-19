.class public final Lradiant/Kawarp;
.super Ljava/lang/Object;

# interfaces
.implements Lam0/l;
.implements Ljava/lang/Runnable;
.implements Landroid/view/Choreographer$FrameCallback;
.implements Lb0/c;


# static fields
.field private static final DRAW:Lradiant/Kawarp;

.field private static final IDLE_STOP_MS:J = 0x1f4L

.field private static final LOADER:Ljava/util/concurrent/ExecutorService;

.field private static volatile appContext:Landroid/content/Context;

.field private static engine:Ldev/kawarp/KawarpEngine;

.field private static final fallbackState:Landroidx/compose/runtime/MutableState;

.field private static frameScheduled:Z

.field private static final frameState:Landroidx/compose/runtime/MutableIntState;

.field private static frameTick:I

.field private static lastDrawUptime:J

.field private static volatile loadToken:I

.field private static volatile loader:Lcoil/f;

.field private static volatile requestedUuid:Ljava/lang/String;


# instance fields
.field private final albumId:I

.field private final token:I

.field private final uuid:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 4

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lradiant/Kawarp;->LOADER:Ljava/util/concurrent/ExecutorService;

    const/4 v0, 0x0

    invoke-static {v0}, Landroidx/compose/runtime/SnapshotIntStateKt;->mutableIntStateOf(I)Landroidx/compose/runtime/MutableIntState;

    move-result-object v1

    sput-object v1, Lradiant/Kawarp;->frameState:Landroidx/compose/runtime/MutableIntState;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v1, v3, v2, v3}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v1

    sput-object v1, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    new-instance v1, Lradiant/Kawarp;

    invoke-direct {v1, v0, v3, v0}, Lradiant/Kawarp;-><init>(ILjava/lang/String;I)V

    sput-object v1, Lradiant/Kawarp;->DRAW:Lradiant/Kawarp;

    return-void
.end method

.method private constructor <init>(ILjava/lang/String;I)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/Kawarp;->albumId:I

    iput-object p2, p0, Lradiant/Kawarp;->uuid:Ljava/lang/String;

    iput p3, p0, Lradiant/Kawarp;->token:I

    return-void
.end method

.method private static attach(Landroidx/compose/runtime/Composer;)V
    .registers 3

    sget-object v0, Lradiant/Kawarp;->loader:Lcoil/f;

    if-eqz v0, :cond_5

    return-void

    :cond_5
    :try_start_5
    invoke-static {}, Landroidx/compose/ui/platform/AndroidCompositionLocals_androidKt;->getLocalContext()Landroidx/compose/runtime/ProvidableCompositionLocal;

    move-result-object v0

    invoke-interface {p0, v0}, Landroidx/compose/runtime/Composer;->consume(Landroidx/compose/runtime/CompositionLocal;)Ljava/lang/Object;

    move-result-object p0

    instance-of v0, p0, Landroid/content/Context;

    if-nez v0, :cond_12

    return-void

    :cond_12
    check-cast p0, Landroid/content/Context;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    instance-of v0, p0, Lce0/b$a;

    if-nez v0, :cond_1d

    return-void

    :cond_1d
    move-object v0, p0

    check-cast v0, Lce0/b$a;

    invoke-interface {v0}, Lce0/b$a;->a()Lce0/b;

    move-result-object v0

    invoke-interface {v0}, Lce0/b;->a()Lxd0/e;

    move-result-object v0

    instance-of v1, v0, Lcom/tidal/android/image/coil/base/CoilImageLoader;

    if-nez v1, :cond_2d

    return-void

    :cond_2d
    sput-object p0, Lradiant/Kawarp;->appContext:Landroid/content/Context;

    check-cast v0, Lcom/tidal/android/image/coil/base/CoilImageLoader;

    iget-object p0, v0, Lcom/tidal/android/image/coil/base/CoilImageLoader;->a:Lcoil/f;

    sput-object p0, Lradiant/Kawarp;->loader:Lcoil/f;
    :try_end_35
    .catchall {:try_start_5 .. :try_end_35} :catchall_36

    goto :goto_37

    :catchall_36
    move-exception p0

    :goto_37
    return-void
.end method

.method public static b(Lcom/tidal/android/feature/playerscreen/ui/model/PlayerBackgroundStyle;JILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V
    .registers 11

    invoke-static {p3, p4, p5, p8, p9}, Lradiant/Kawarp;->render(ILjava/lang/String;ZLandroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;)V

    return-void
.end method

.method private static draw(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V
    .registers 4

    sget-object v0, Lradiant/Kawarp;->frameState:Landroidx/compose/runtime/MutableIntState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableIntState;->getIntValue()I

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

    :try_start_1a
    sget-object v1, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object p0

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object p0

    invoke-static {p0}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object p0

    invoke-virtual {v1, p0, v2, v0}, Ldev/kawarp/KawarpEngine;->draw(Landroid/graphics/Canvas;FF)Z
    :try_end_2b
    .catchall {:try_start_1a .. :try_end_2b} :catchall_2c

    goto :goto_34

    :catchall_2c
    move-exception p0

    sget-object p0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {p0, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :goto_34
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

    sget-object v0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    return v2
.end method

.method private fail()V
    .registers 3

    iget v0, p0, Lradiant/Kawarp;->token:I

    sget v1, Lradiant/Kawarp;->loadToken:I

    if-ne v0, v1, :cond_9

    const/4 v0, 0x0

    sput-object v0, Lradiant/Kawarp;->requestedUuid:Ljava/lang/String;

    :cond_9
    return-void
.end method

.method public static render(ILjava/lang/String;ZLandroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;)V
    .registers 13

    const v0, 0x52415750

    invoke-interface {p4, v0}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    invoke-static {p4}, Lradiant/Kawarp;->attach(Landroidx/compose/runtime/Composer;)V

    sget-object v0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_37

    invoke-static {}, Lradiant/Kawarp;->ensureEngine()Z

    move-result v0

    if-eqz v0, :cond_37

    sget-object v0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v0, p2}, Ldev/kawarp/KawarpEngine;->setPlaying(Z)V

    invoke-static {p0, p1}, Lradiant/Kawarp;->request(ILjava/lang/String;)V

    const/high16 p0, 0x3f800000    # 1.0f

    invoke-static {p3, p0}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxSize(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;

    move-result-object p0

    sget-object p1, Lradiant/Kawarp;->DRAW:Lradiant/Kawarp;

    invoke-static {p0, p1}, Landroidx/compose/ui/draw/DrawModifierKt;->drawBehind(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    const/4 p1, 0x0

    invoke-static {p0, p4, p1}, Landroidx/compose/foundation/layout/SpacerKt;->Spacer(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V

    move-object v6, p4

    goto :goto_42

    :cond_37
    const/4 v4, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x0

    move v0, p0

    move-object v1, p1

    move v2, p2

    move-object v5, p3

    move-object v6, p4

    invoke-static/range {v0 .. v7}, Lcom/tidal/android/feature/playerscreen/ui/composables/p3;->a(ILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V

    :goto_42
    invoke-interface {v6}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-void
.end method

.method private static request(ILjava/lang/String;)V
    .registers 5

    if-eqz p1, :cond_28

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_28

    sget-object v0, Lradiant/Kawarp;->requestedUuid:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_28

    :cond_11
    sget-object v0, Lradiant/Kawarp;->loader:Lcoil/f;

    if-nez v0, :cond_16

    return-void

    :cond_16
    sput-object p1, Lradiant/Kawarp;->requestedUuid:Ljava/lang/String;

    sget-object v0, Lradiant/Kawarp;->LOADER:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lradiant/Kawarp;

    sget v2, Lradiant/Kawarp;->loadToken:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lradiant/Kawarp;->loadToken:I

    invoke-direct {v1, p0, p1, v2}, Lradiant/Kawarp;-><init>(ILjava/lang/String;I)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_28
    :goto_28
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

.method private static toBitmap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;
    .registers 4

    if-nez p0, :cond_4

    const/4 p0, 0x0

    return-object p0

    :cond_4
    instance-of v0, p0, Landroid/graphics/drawable/BitmapDrawable;

    if-eqz v0, :cond_f

    check-cast p0, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {p0}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0

    :cond_f
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    const/16 v1, 0x100

    invoke-static {v1, v1, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v2, v1, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-object v0
.end method


# virtual methods
.method public a(Landroid/graphics/drawable/Drawable;)V
    .registers 4

    iget v0, p0, Lradiant/Kawarp;->token:I

    sget v1, Lradiant/Kawarp;->loadToken:I

    if-eq v0, v1, :cond_7

    return-void

    :cond_7
    invoke-static {p1}, Lradiant/Kawarp;->toBitmap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;

    move-result-object p1

    if-nez p1, :cond_11

    invoke-direct {p0}, Lradiant/Kawarp;->fail()V

    return-void

    :cond_11
    sget-object v0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v0, p1}, Ldev/kawarp/KawarpEngine;->setCover(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public b(Landroid/graphics/drawable/Drawable;)V
    .registers 2

    return-void
.end method

.method public d(Landroid/graphics/drawable/Drawable;)V
    .registers 2

    invoke-direct {p0}, Lradiant/Kawarp;->fail()V

    return-void
.end method

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
    sget-object p1, Lradiant/Kawarp;->frameState:Landroidx/compose/runtime/MutableIntState;

    sget p2, Lradiant/Kawarp;->frameTick:I

    add-int/lit8 p2, p2, 0x1

    sput p2, Lradiant/Kawarp;->frameTick:I

    invoke-interface {p1, p2}, Landroidx/compose/runtime/MutableIntState;->setIntValue(I)V

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
    .registers 15

    :try_start_0
    new-instance v0, Lxd0/g;

    sget-object v1, Lradiant/Kawarp;->appContext:Landroid/content/Context;

    new-instance v2, Lcom/tidal/android/image/core/b$a;

    iget v3, p0, Lradiant/Kawarp;->albumId:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lradiant/Kawarp;->uuid:Ljava/lang/String;

    invoke-direct {v2, v3, v4}, Lcom/tidal/android/image/core/b$a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-direct/range {v0 .. v8}, Lxd0/g;-><init>(Landroid/content/Context;Lcom/tidal/android/image/core/b;Lcom/tidal/android/image/core/b$h$a;Lcom/tidal/android/image/core/b$h$a;ZLjava/util/List;Lxd0/f;Z)V

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/tidal/android/image/coil/c;->a(Lxd0/g;Landroidx/compose/ui/layout/ContentScale;)Lcoil/request/h;

    move-result-object v0

    invoke-static {v0}, Lcoil/request/h;->a(Lcoil/request/h;)Lcoil/request/h$a;

    move-result-object v0

    iget-object v1, v0, Lcoil/request/h$a;->b:Lcoil/request/b;

    new-instance v2, Lcoil/request/b;

    iget-object v3, v1, Lcoil/request/b;->a:Lkotlinx/coroutines/CoroutineDispatcher;

    iget-object v4, v1, Lcoil/request/b;->b:Lkotlinx/coroutines/CoroutineDispatcher;

    iget-object v5, v1, Lcoil/request/b;->c:Lkotlinx/coroutines/CoroutineDispatcher;

    iget-object v6, v1, Lcoil/request/b;->d:Lkotlinx/coroutines/CoroutineDispatcher;

    iget-object v7, v1, Lcoil/request/b;->e:Ld0/c$a;

    iget-object v8, v1, Lcoil/request/b;->f:Lcoil/size/Precision;

    iget-object v9, v1, Lcoil/request/b;->g:Landroid/graphics/Bitmap$Config;

    iget-boolean v10, v1, Lcoil/request/b;->h:Z

    iget-object v11, v1, Lcoil/request/b;->i:Lcoil/request/CachePolicy;

    iget-object v12, v1, Lcoil/request/b;->j:Lcoil/request/CachePolicy;

    sget-object v13, Lcoil/request/CachePolicy;->DISABLED:Lcoil/request/CachePolicy;

    invoke-direct/range {v2 .. v13}, Lcoil/request/b;-><init>(Lkotlinx/coroutines/CoroutineDispatcher;Lkotlinx/coroutines/CoroutineDispatcher;Lkotlinx/coroutines/CoroutineDispatcher;Lkotlinx/coroutines/CoroutineDispatcher;Ld0/c$a;Lcoil/size/Precision;Landroid/graphics/Bitmap$Config;ZLcoil/request/CachePolicy;Lcoil/request/CachePolicy;Lcoil/request/CachePolicy;)V

    iput-object v2, v0, Lcoil/request/h$a;->b:Lcoil/request/b;

    iput-object p0, v0, Lcoil/request/h$a;->d:Lb0/c;

    sget-object v1, Lradiant/Kawarp;->loader:Lcoil/f;

    invoke-virtual {v0}, Lcoil/request/h$a;->a()Lcoil/request/h;

    move-result-object v0

    invoke-interface {v1, v0}, Lcoil/f;->b(Lcoil/request/h;)Lcoil/request/d;
    :try_end_4d
    .catchall {:try_start_0 .. :try_end_4d} :catchall_4e

    goto :goto_52

    :catchall_4e
    move-exception v0

    invoke-direct {p0}, Lradiant/Kawarp;->fail()V

    :goto_52
    return-void
.end method
