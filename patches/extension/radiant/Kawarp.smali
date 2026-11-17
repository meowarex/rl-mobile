.class public final Lradiant/Kawarp;
.super Ljava/lang/Object;

# interfaces
.implements Lyl0/l;    # MARKER: R8 Lyl0/l;
.implements Ljava/lang/Runnable;
.implements Landroid/view/Choreographer$FrameCallback;
.implements Lc0/c;    # MARKER: R8 Lc0/c;


# static fields
.field private static final DRAW:Lradiant/Kawarp;

.field private static final IDLE_STOP_MS:J = 0x1f4L

.field private static final LOADER:Ljava/util/concurrent/ExecutorService;

.field private static final STOCK_BLEND:Ljava/lang/String; = "  float3 col = mix(float3(texA.eval(sp).rgb), float3(texB.eval(sp).rgb), uBlend);\n"

.field private static final WAVE_FN:Ljava/lang/String; = "uniform float uClock;\nfloat rlRnd(float2 q) {\n  float3 p = fract(float3(mod(q, 256.0).xyx) * 0.1031);\n  p += dot(p, p.yzx + 33.33);\n  return fract((p.x + p.y) * p.z);\n}\nfloat rlNoise(float2 q) {\n  float2 k = floor(q);\n  float2 w = fract(q);\n  w = w * w * (3.0 - 2.0 * w);\n  return mix(mix(rlRnd(k), rlRnd(k + float2(1.0, 0.0)), w.x), mix(rlRnd(k + float2(0.0, 1.0)), rlRnd(k + float2(1.0, 1.0)), w.x), w.y);\n}\nfloat rlOctaves(float2 q) {\n  float acc = 0.0;\n  float amp = 0.5;\n  for (int k = 0; k < 4; k++) {\n    acc += amp * rlNoise(q);\n    q = q * 2.03 + 17.1;\n    amp *= 0.5;\n  }\n  return acc;\n}\nfloat3 rlWave(float2 uv) {\n  float lin = clamp(uBlend, 0.0, 1.0);\n  float eased = lin * lin * (3.0 - 2.0 * lin);\n  float busy = step(0.002, eased) * step(eased, 0.998);\n  float w = uv.x * 0.74 + uv.y * 0.26 + sin(uv.y * 7.0 + uClock * 1.7) * 0.045 + (rlOctaves(uv * 3.0 + float2(0.0, uClock * 0.08)) - 0.47) * 0.16;\n  float gap = w - mix(-0.2, 1.2, eased);\n  float side = smoothstep(-0.08, 0.08, gap);\n  float bulge = exp(-abs(gap) * 9.0) * busy;\n  float2 shove = float2(0.74, 0.26) * bulge * 0.07;\n  float3 before = texA.eval(clamp(uv + shove, 0.0, 1.0) * 128.0).rgb;\n  float3 after = texB.eval(clamp(uv - shove, 0.0, 1.0) * 128.0).rgb;\n  float3 shade = mix(after, before, side);\n  shade += exp(-abs(gap) * 12.0) * 0.08 * busy;\n  return shade;\n}\n"

.field private static volatile appContext:Landroid/content/Context;

.field private static engine:Ldev/kawarp/KawarpEngine;

.field private static final fallbackState:Landroidx/compose/runtime/MutableState;

.field private static frameScheduled:Z

.field private static final frameState:Landroidx/compose/runtime/MutableIntState;

.field private static frameTick:I

.field private static lastDrawUptime:J

.field private static volatile loadToken:I

.field private static volatile loader:Lcoil/e;    # MARKER: R8 Lcoil/e;

.field private static volatile requestedUuid:Ljava/lang/String;

.field private static waveShader:Landroid/graphics/RuntimeShader;

.field private static waveStart:Ljava/lang/reflect/Field;


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

    sget-object v0, Lradiant/Kawarp;->loader:Lcoil/e;    # MARKER: R8 Lcoil/e;

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

    instance-of v0, p0, Lud0/b$a;    # MARKER: R8 Lud0/b$a;

    if-nez v0, :cond_1d

    return-void

    :cond_1d
    move-object v0, p0

    check-cast v0, Lud0/b$a;    # MARKER: R8 Lud0/b$a;

    invoke-interface {v0}, Lud0/b$a;->a()Lud0/b;    # MARKER: R8 Lud0/b$a; Lud0/b; a

    move-result-object v0

    invoke-interface {v0}, Lud0/b;->a()Lpd0/e;    # MARKER: R8 Lud0/b; Lpd0/e; a

    move-result-object v0

    instance-of v1, v0, Lcom/tidal/android/image/coil/base/CoilImageLoader;

    if-nez v1, :cond_2d

    return-void

    :cond_2d
    sput-object p0, Lradiant/Kawarp;->appContext:Landroid/content/Context;

    check-cast v0, Lcom/tidal/android/image/coil/base/CoilImageLoader;

    iget-object p0, v0, Lcom/tidal/android/image/coil/base/CoilImageLoader;->a:Lcoil/e;    # MARKER: R8 Lcoil/e; a

    sput-object p0, Lradiant/Kawarp;->loader:Lcoil/e;    # MARKER: R8 Lcoil/e;
    :try_end_35
    .catchall {:try_start_5 .. :try_end_35} :catchall_36

    goto :goto_37

    :catchall_36
    move-exception p0

    :goto_37
    return-void
.end method

.method public static b(Lcom/tidal/android/feature/playerscreen/ui/model/PlayerBackgroundStyle;JILjava/lang/String;ZZLyl0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V    # MARKER: R8 Lyl0/a;
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
    invoke-static {}, Lradiant/Kawarp;->stepWave()V

    sget-object v1, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object p0

    invoke-interface {p0}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object p0

    invoke-static {p0}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object p0

    invoke-virtual {v1, p0, v2, v0}, Ldev/kawarp/KawarpEngine;->draw(Landroid/graphics/Canvas;FF)Z
    :try_end_2e
    .catchall {:try_start_1a .. :try_end_2e} :catchall_2f

    goto :goto_37

    :catchall_2f
    move-exception p0

    sget-object p0, Lradiant/Kawarp;->fallbackState:Landroidx/compose/runtime/MutableState;

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {p0, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :goto_37
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

    invoke-static {}, Lradiant/Kawarp;->waveMs()I

    move-result v3

    if-ltz v3, :cond_a5

    invoke-static {v0}, Lradiant/Kawarp;->mountWave(Ldev/kawarp/KawarpEngine;)V

    :cond_a5
    sput-object v0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;
    :try_end_a7
    .catchall {:try_start_e .. :try_end_a7} :catchall_a8

    return v1

    :catchall_a8
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

.method private static mountWave(Ldev/kawarp/KawarpEngine;)V
    .registers 8

    const-string v0, "  float3 col = mix(float3(texA.eval(sp).rgb), float3(texB.eval(sp).rgb), uBlend);\n"

    const/4 v1, 0x0

    :try_start_3
    const-class v2, Ldev/kawarp/KawarpEngine;

    const-string v3, "AGSL"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v2, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    const-string v4, "half4 main("

    invoke-virtual {v2, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-ltz v4, :cond_6d

    invoke-virtual {v2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    if-gez v5, :cond_24

    goto :goto_6d

    :cond_24
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v6, 0x0

    invoke-virtual {v2, v6, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "uniform float uClock;\nfloat rlRnd(float2 q) {\n  float3 p = fract(float3(mod(q, 256.0).xyx) * 0.1031);\n  p += dot(p, p.yzx + 33.33);\n  return fract((p.x + p.y) * p.z);\n}\nfloat rlNoise(float2 q) {\n  float2 k = floor(q);\n  float2 w = fract(q);\n  w = w * w * (3.0 - 2.0 * w);\n  return mix(mix(rlRnd(k), rlRnd(k + float2(1.0, 0.0)), w.x), mix(rlRnd(k + float2(0.0, 1.0)), rlRnd(k + float2(1.0, 1.0)), w.x), w.y);\n}\nfloat rlOctaves(float2 q) {\n  float acc = 0.0;\n  float amp = 0.5;\n  for (int k = 0; k < 4; k++) {\n    acc += amp * rlNoise(q);\n    q = q * 2.03 + 17.1;\n    amp *= 0.5;\n  }\n  return acc;\n}\nfloat3 rlWave(float2 uv) {\n  float lin = clamp(uBlend, 0.0, 1.0);\n  float eased = lin * lin * (3.0 - 2.0 * lin);\n  float busy = step(0.002, eased) * step(eased, 0.998);\n  float w = uv.x * 0.74 + uv.y * 0.26 + sin(uv.y * 7.0 + uClock * 1.7) * 0.045 + (rlOctaves(uv * 3.0 + float2(0.0, uClock * 0.08)) - 0.47) * 0.16;\n  float gap = w - mix(-0.2, 1.2, eased);\n  float side = smoothstep(-0.08, 0.08, gap);\n  float bulge = exp(-abs(gap) * 9.0) * busy;\n  float2 shove = float2(0.74, 0.26) * bulge * 0.07;\n  float3 before = texA.eval(clamp(uv + shove, 0.0, 1.0) * 128.0).rgb;\n  float3 after = texB.eval(clamp(uv - shove, 0.0, 1.0) * 128.0).rgb;\n  float3 shade = mix(after, before, side);\n  shade += exp(-abs(gap) * 12.0) * 0.08 * busy;\n  return shade;\n}\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v4, "  float3 col = rlWave(wuv);\n"

    invoke-virtual {v2, v0, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Landroid/graphics/RuntimeShader;

    invoke-direct {v2, v0}, Landroid/graphics/RuntimeShader;-><init>(Ljava/lang/String;)V

    const-class v0, Ldev/kawarp/KawarpEngine;

    const-string v4, "transitionStart"

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    const-class v4, Ldev/kawarp/KawarpEngine;

    const-string v5, "shader"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v4, p0, v2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    sput-object v0, Lradiant/Kawarp;->waveStart:Ljava/lang/reflect/Field;

    sput-object v2, Lradiant/Kawarp;->waveShader:Landroid/graphics/RuntimeShader;
    :try_end_6c
    .catchall {:try_start_3 .. :try_end_6c} :catchall_6e

    goto :goto_71

    :cond_6d
    :goto_6d
    return-void

    :catchall_6e
    move-exception p0

    sput-object v1, Lradiant/Kawarp;->waveShader:Landroid/graphics/RuntimeShader;

    :goto_71
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

    invoke-static {p0, p1}, Landroidx/compose/ui/draw/DrawModifierKt;->drawBehind(Landroidx/compose/ui/Modifier;Lyl0/l;)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lyl0/l;

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

    invoke-static/range {v0 .. v7}, Lcom/tidal/android/feature/playerscreen/ui/composables/e3;->a(ILjava/lang/String;ZZLyl0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V    # MARKER: R8 Lcom/tidal/android/feature/playerscreen/ui/composables/e3; Lyl0/a; a

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
    sget-object v0, Lradiant/Kawarp;->loader:Lcoil/e;    # MARKER: R8 Lcoil/e;

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

.method private static stepWave()V
    .registers 6

    sget-object v0, Lradiant/Kawarp;->waveShader:Landroid/graphics/RuntimeShader;

    if-nez v0, :cond_5

    return-void

    :cond_5
    :try_start_5
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    sget-object v3, Lradiant/Kawarp;->waveStart:Ljava/lang/reflect/Field;

    sget-object v4, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->getLong(Ljava/lang/Object;)J

    move-result-wide v3

    sub-long/2addr v1, v3

    const-string v3, "uClock"

    const-wide/16 v4, 0x0

    invoke-static {v4, v5, v1, v2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v1

    long-to-float v1, v1

    const/high16 v2, 0x447a0000    # 1000.0f

    div-float/2addr v1, v2

    invoke-virtual {v0, v3, v1}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V
    :try_end_21
    .catchall {:try_start_5 .. :try_end_21} :catchall_22

    goto :goto_23

    :catchall_22
    move-exception v0

    :goto_23
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

.method private static waveMs()I
    .registers 1

    const/4 v0, -0x1

    return v0
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
    invoke-static {}, Lradiant/Kawarp;->waveMs()I

    move-result v0

    if-lez v0, :cond_1c

    sget-object v1, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v1, v0}, Ldev/kawarp/KawarpEngine;->setTransitionDuration(I)V

    :cond_1c
    sget-object v0, Lradiant/Kawarp;->engine:Ldev/kawarp/KawarpEngine;

    invoke-virtual {v0, p1}, Ldev/kawarp/KawarpEngine;->setCover(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public b(Landroid/graphics/drawable/Drawable;)V
    .registers 2

    return-void
.end method

.method public c(Landroid/graphics/drawable/Drawable;)V
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

    sget-object p1, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object p1
.end method

.method public run()V
    .registers 15

    :try_start_0
    new-instance v0, Lpd0/g;    # MARKER: R8 Lpd0/g;

    sget-object v1, Lradiant/Kawarp;->appContext:Landroid/content/Context;

    new-instance v2, Lcom/tidal/android/image/core/b$a;    # MARKER: R8 Lcom/tidal/android/image/core/b$a;

    iget v3, p0, Lradiant/Kawarp;->albumId:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lradiant/Kawarp;->uuid:Ljava/lang/String;

    invoke-direct {v2, v3, v4}, Lcom/tidal/android/image/core/b$a;-><init>(Ljava/lang/String;Ljava/lang/String;)V    # MARKER: R8 Lcom/tidal/android/image/core/b$a;

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-direct/range {v0 .. v8}, Lpd0/g;-><init>(Landroid/content/Context;Lcom/tidal/android/image/core/b;Lcom/tidal/android/image/core/b$h$a;Lcom/tidal/android/image/core/b$h$a;ZLjava/util/List;Lpd0/f;Z)V    # MARKER: R8 Lpd0/g; Lcom/tidal/android/image/core/b; Lcom/tidal/android/image/core/b$h$a; Lpd0/f;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/tidal/android/image/coil/c;->a(Lpd0/g;Landroidx/compose/ui/layout/ContentScale;)Lcoil/request/h;    # MARKER: R8 Lcom/tidal/android/image/coil/c; Lpd0/g; Lcoil/request/h; a

    move-result-object v0

    invoke-static {v0}, Lcoil/request/h;->a(Lcoil/request/h;)Lcoil/request/h$a;    # MARKER: R8 Lcoil/request/h; Lcoil/request/h$a; a

    move-result-object v0

    iget-object v1, v0, Lcoil/request/h$a;->b:Lcoil/request/b;    # MARKER: R8 Lcoil/request/h$a; Lcoil/request/b; b

    new-instance v2, Lcoil/request/b;    # MARKER: R8 Lcoil/request/b;

    iget-object v3, v1, Lcoil/request/b;->a:Lkotlinx/coroutines/CoroutineDispatcher;    # MARKER: R8 Lcoil/request/b; a

    iget-object v4, v1, Lcoil/request/b;->b:Lkotlinx/coroutines/CoroutineDispatcher;    # MARKER: R8 Lcoil/request/b; b

    iget-object v5, v1, Lcoil/request/b;->c:Lkotlinx/coroutines/CoroutineDispatcher;    # MARKER: R8 Lcoil/request/b; c

    iget-object v6, v1, Lcoil/request/b;->d:Lkotlinx/coroutines/CoroutineDispatcher;    # MARKER: R8 Lcoil/request/b; d

    iget-object v7, v1, Lcoil/request/b;->e:Le0/c$a;    # MARKER: R8 Lcoil/request/b; Le0/c$a; e

    iget-object v8, v1, Lcoil/request/b;->f:Lcoil/size/Precision;    # MARKER: R8 Lcoil/request/b; f

    iget-object v9, v1, Lcoil/request/b;->g:Landroid/graphics/Bitmap$Config;    # MARKER: R8 Lcoil/request/b; g

    iget-boolean v10, v1, Lcoil/request/b;->h:Z    # MARKER: R8 Lcoil/request/b; h

    iget-object v11, v1, Lcoil/request/b;->i:Lcoil/request/CachePolicy;    # MARKER: R8 Lcoil/request/b; i

    iget-object v12, v1, Lcoil/request/b;->j:Lcoil/request/CachePolicy;    # MARKER: R8 Lcoil/request/b; j

    sget-object v13, Lcoil/request/CachePolicy;->DISABLED:Lcoil/request/CachePolicy;

    invoke-direct/range {v2 .. v13}, Lcoil/request/b;-><init>(Lkotlinx/coroutines/CoroutineDispatcher;Lkotlinx/coroutines/CoroutineDispatcher;Lkotlinx/coroutines/CoroutineDispatcher;Lkotlinx/coroutines/CoroutineDispatcher;Le0/c$a;Lcoil/size/Precision;Landroid/graphics/Bitmap$Config;ZLcoil/request/CachePolicy;Lcoil/request/CachePolicy;Lcoil/request/CachePolicy;)V    # MARKER: R8 Lcoil/request/b; Le0/c$a;

    iput-object v2, v0, Lcoil/request/h$a;->b:Lcoil/request/b;    # MARKER: R8 Lcoil/request/h$a; Lcoil/request/b; b

    iput-object p0, v0, Lcoil/request/h$a;->d:Lc0/c;    # MARKER: R8 Lcoil/request/h$a; Lc0/c; d

    sget-object v1, Lradiant/Kawarp;->loader:Lcoil/e;    # MARKER: R8 Lcoil/e;

    invoke-virtual {v0}, Lcoil/request/h$a;->a()Lcoil/request/h;    # MARKER: R8 Lcoil/request/h$a; Lcoil/request/h; a

    move-result-object v0

    invoke-interface {v1, v0}, Lcoil/e;->b(Lcoil/request/h;)Lcoil/request/d;    # MARKER: R8 Lcoil/e; Lcoil/request/h; Lcoil/request/d; b
    :try_end_4d
    .catchall {:try_start_0 .. :try_end_4d} :catchall_4e

    goto :goto_52

    :catchall_4e
    move-exception v0

    invoke-direct {p0}, Lradiant/Kawarp;->fail()V

    :goto_52
    return-void
.end method
