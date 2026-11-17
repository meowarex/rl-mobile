.class public final Lradiant/CoverWave;
.super Ljava/lang/Object;

# interfaces
.implements Lyl0/l;
.implements Ljava/lang/Runnable;
.implements Landroid/view/Choreographer$FrameCallback;
.implements Lc0/c;


# static fields
.field private static final ABORT_FADE_MS:J = 0xfaL

.field private static final AGSL:Ljava/lang/String; = "uniform shader uOld;\nuniform shader uNew;\nuniform float2 uSize;\nuniform float2 uOldPx;\nuniform float2 uNewPx;\nuniform float2 uFitOld;\nuniform float2 uFitNew;\nuniform float uMix;\nuniform float uClock;\nuniform float uPulse;\nuniform float uPulseAge;\nuniform float uJitter;\nuniform float uFade;\nuniform float3 uHue;\n\nfloat rnd2(float2 q) {\n  float3 p = fract(float3(mod(q, 256.0).xyx) * 0.1031);\n  p += dot(p, p.yzx + 33.33);\n  return fract((p.x + p.y) * p.z);\n}\nfloat vnoise(float2 q) {\n  float2 k = floor(q);\n  float2 w = fract(q);\n  w = w * w * (3.0 - 2.0 * w);\n  return mix(mix(rnd2(k), rnd2(k + float2(1.0, 0.0)), w.x), mix(rnd2(k + float2(0.0, 1.0)), rnd2(k + float2(1.0, 1.0)), w.x), w.y);\n}\nfloat octaves(float2 q) {\n  float acc = 0.0;\n  float amp = 0.5;\n  for (int k = 0; k < 4; k++) {\n    acc += amp * vnoise(q);\n    q = q * 2.03 + 17.1;\n    amp *= 0.5;\n  }\n  return acc;\n}\nfloat2 mirrorUv(float2 uv) { return 1.0 - abs(1.0 - mod(uv, 2.0)); }\nfloat3 oldAt(float2 uv) { return uOld.eval(((mirrorUv(uv) - 0.5) * uFitOld + 0.5) * uOldPx).rgb; }\nfloat3 newAt(float2 uv) { return uNew.eval(((mirrorUv(uv) - 0.5) * uFitNew + 0.5) * uNewPx).rgb; }\nfloat3 oldFringe(float2 uv, float2 off) { return float3(oldAt(uv + off).r, oldAt(uv).g, oldAt(uv - off).b); }\nfloat3 newFringe(float2 uv, float2 off) { return float3(newAt(uv + off).r, newAt(uv).g, newAt(uv - off).b); }\n\nhalf4 main(float2 fragCoord) {\n  float2 uv = fragCoord / uSize;\n  float2 fromMid = uv - 0.5;\n  float radial = length(fromMid);\n  float swell = uPulseAge > 0.0 ? exp(-abs(radial - uPulseAge * 0.85) * 13.0) * uPulse : 0.0;\n  float2 bentUv = 0.5 + fromMid + normalize(fromMid + 1e-5) * swell * 0.04;\n  float2 aberr = fromMid * (0.05 * swell);\n  float busy = step(0.002, uMix) * step(uMix, 0.998);\n  float w = uv.x * 0.74 + uv.y * 0.26 + sin(uv.y * 7.0 + uClock * 1.7) * 0.045 + (octaves(uv * 3.0 + uJitter + float2(0.0, uClock * 0.08)) - 0.47) * 0.16;\n  float gap = w - mix(-0.2, 1.2, uMix);\n  float side = smoothstep(-0.01, 0.01, gap);\n  float bulge = exp(-abs(gap) * 9.0) * busy;\n  float wiggle = sin(gap * 70.0 - uClock * 5.0) * exp(-abs(gap) * 7.0) * busy;\n  float2 shove = float2(0.74, 0.26) * (bulge * 0.07 + wiggle * 0.018);\n  float3 shade = mix(newFringe(bentUv - shove, aberr + float2(0.01 * bulge, 0.0)), oldFringe(bentUv + shove, aberr + float2(0.02 * bulge, 0.0)), side);\n  shade *= 1.0 + wiggle * 0.18;\n  float shine = (exp(-abs(gap) * 45.0) * 1.4 + exp(-abs(gap) * 8.0) * 0.25) * busy;\n  float3 hueLight = mix(uHue, float3(1.0), 0.55);\n  float headroom = 1.0 - 0.65 * dot(shade, float3(0.3, 0.6, 0.1));\n  shade += shine * 0.3 * hueLight * headroom;\n  shade += swell * 0.1 * headroom;\n  return half4(half3(clamp(shade * uFade, 0.0, 1.0)), half(uFade));\n}\n"

.field private static final CLOCK:I = 0x4

.field private static final COVER_PX:I = 0x500

.field private static final FADE_OUT_MS:J = 0x15eL

.field private static final FRAMES:Lradiant/CoverWave;

.field private static final IDLE_STOP_MS:J = 0x1f4L

.field private static final LAND_GRACE_MS:J = 0x190L

.field private static final LOAD_TIMEOUT_MS:J = 0x9c4L

.field private static final MIN_CROSSFADE_MS:J = 0x12cL

.field private static final NODE:I = 0x0

.field private static final PARK:I = 0x2

.field private static final PREFETCH:I = 0x6

.field private static final SWAP:I = 0x3

.field private static final TRACK:I = 0x1

.field private static final USER_MS:J = 0x9c4L

.field private static final XFADE:I = 0x5

.field private static final XF_HOLD_MS:J = 0x9c4L

.field private static abortAt:J

.field private static app:Landroid/content/Context;

.field private static crossfade:Z

.field private static volatile crossfadeMs:J

.field private static final dst:Landroid/graphics/RectF;

.field private static end:J

.field private static final fitH:[I

.field private static fitNext:I

.field private static final fitOut:[Landroid/graphics/Bitmap;

.field private static final fitShader:[Landroid/graphics/BitmapShader;

.field private static final fitSrc:[Landroid/graphics/Bitmap;

.field private static final fitW:[I

.field private static frameQueued:Z

.field private static final frameState:Landroidx/compose/runtime/MutableIntState;

.field private static from:Landroid/graphics/Bitmap;

.field private static fromKey:Ljava/lang/String;

.field private static heldSince:J

.field private static hueB:F

.field private static hueG:F

.field private static hueR:F

.field private static jitter:F

.field private static landedAt:J

.field private static lastDraw:J

.field private static loader:Lcoil/e;

.field private static main:Landroid/os/Handler;

.field private static final paint:Landroid/graphics/Paint;

.field private static queue:Ljava/lang/Object;

.field private static shader:Landroid/graphics/RuntimeShader;

.field private static shaderFailed:Z

.field private static shown:Landroid/graphics/Bitmap;

.field private static shownKey:Ljava/lang/String;

.field private static span:J

.field private static final src:Landroid/graphics/Rect;

.field private static start:J

.field private static swapping:Z

.field private static volatile swipeAt:J

.field private static tick:I

.field private static tidalAlbum:I

.field private static tidalKey:Ljava/lang/String;

.field private static to:Landroid/graphics/Bitmap;

.field private static toKey:Ljava/lang/String;

.field private static token:I

.field private static final viewWaves:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/widget/ImageView;",
            "Lradiant/CoverWaveView;",
            ">;"
        }
    .end annotation
.end field

.field private static xfAlbum:I

.field private static xfKey:Ljava/lang/String;

.field private static final xfState:Landroidx/compose/runtime/MutableIntState;

.field private static xfTick:I


# instance fields
.field private final albumId:I

.field private final cover:Ljava/lang/String;

.field private final job:I

.field private final mode:I


# direct methods
.method static constructor <clinit>()V
    .registers 4

    const/4 v0, 0x0

    invoke-static {v0}, Landroidx/compose/runtime/SnapshotIntStateKt;->mutableIntStateOf(I)Landroidx/compose/runtime/MutableIntState;

    move-result-object v1

    sput-object v1, Lradiant/CoverWave;->frameState:Landroidx/compose/runtime/MutableIntState;

    invoke-static {v0}, Landroidx/compose/runtime/SnapshotIntStateKt;->mutableIntStateOf(I)Landroidx/compose/runtime/MutableIntState;

    move-result-object v1

    sput-object v1, Lradiant/CoverWave;->xfState:Landroidx/compose/runtime/MutableIntState;

    new-instance v1, Lradiant/CoverWave;

    const/4 v2, 0x4

    const/4 v3, 0x0

    invoke-direct {v1, v2, v0, v3, v0}, Lradiant/CoverWave;-><init>(IILjava/lang/String;I)V

    sput-object v1, Lradiant/CoverWave;->FRAMES:Lradiant/CoverWave;

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    sput-object v0, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    sput-object v0, Lradiant/CoverWave;->src:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    sput-object v0, Lradiant/CoverWave;->dst:Landroid/graphics/RectF;

    const/16 v0, 0x8

    new-array v1, v0, [Landroid/graphics/Bitmap;

    sput-object v1, Lradiant/CoverWave;->fitSrc:[Landroid/graphics/Bitmap;

    new-array v1, v0, [Landroid/graphics/Bitmap;

    sput-object v1, Lradiant/CoverWave;->fitOut:[Landroid/graphics/Bitmap;

    new-array v1, v0, [Landroid/graphics/BitmapShader;

    sput-object v1, Lradiant/CoverWave;->fitShader:[Landroid/graphics/BitmapShader;

    new-array v1, v0, [I

    sput-object v1, Lradiant/CoverWave;->fitW:[I

    new-array v0, v0, [I

    sput-object v0, Lradiant/CoverWave;->fitH:[I

    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lradiant/CoverWave;->viewWaves:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>(IILjava/lang/String;I)V
    .registers 5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/CoverWave;->mode:I

    iput p2, p0, Lradiant/CoverWave;->albumId:I

    iput-object p3, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    iput p4, p0, Lradiant/CoverWave;->job:I

    return-void
.end method

.method private arrive(Landroid/graphics/Bitmap;)V
    .registers 8

    iget v0, p0, Lradiant/CoverWave;->mode:I

    const/4 v1, 0x6

    if-eq v0, v1, :cond_57

    iget v0, p0, Lradiant/CoverWave;->job:I

    sget v1, Lradiant/CoverWave;->token:I

    if-eq v0, v1, :cond_c

    goto :goto_57

    :cond_c
    iget v0, p0, Lradiant/CoverWave;->mode:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1f

    if-eqz p1, :cond_1e

    sget-boolean v0, Lradiant/CoverWave;->swapping:Z

    if-eqz v0, :cond_18

    goto :goto_1e

    :cond_18
    sput-object p1, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    iget-object p1, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    sput-object p1, Lradiant/CoverWave;->shownKey:Ljava/lang/String;

    :cond_1e
    :goto_1e
    return-void

    :cond_1f
    sget-boolean v0, Lradiant/CoverWave;->swapping:Z

    if-eqz v0, :cond_57

    iget-object v0, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    sget-object v1, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2e

    goto :goto_57

    :cond_2e
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    if-nez p1, :cond_42

    sget-wide v4, Lradiant/CoverWave;->abortAt:J

    cmp-long p1, v4, v2

    if-nez p1, :cond_3e

    sput-wide v0, Lradiant/CoverWave;->abortAt:J

    :cond_3e
    invoke-static {}, Lradiant/CoverWave;->kick()V

    return-void

    :cond_42
    sput-object p1, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    invoke-static {p1}, Lradiant/CoverWave;->meanColour(Landroid/graphics/Bitmap;)V

    sget-wide v4, Lradiant/CoverWave;->start:J

    cmp-long p1, v4, v2

    if-nez p1, :cond_54

    sput-wide v0, Lradiant/CoverWave;->start:J

    sget-wide v2, Lradiant/CoverWave;->span:J

    add-long/2addr v0, v2

    sput-wide v0, Lradiant/CoverWave;->end:J

    :cond_54
    invoke-static {}, Lradiant/CoverWave;->kick()V

    :cond_57
    :goto_57
    return-void
.end method

.method private static attach()Z
    .registers 5

    sget-object v0, Lradiant/CoverWave;->loader:Lcoil/e;

    const/4 v1, 0x1

    if-eqz v0, :cond_6

    return v1

    :cond_6
    const/4 v0, 0x0

    :try_start_7
    const-string v2, "android.app.ActivityThread"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "currentApplication"

    new-array v4, v0, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v3, v0, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-virtual {v2, v4, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/content/Context;

    instance-of v3, v2, Lud0/b$a;

    if-nez v3, :cond_23

    return v0

    :cond_23
    move-object v3, v2

    check-cast v3, Lud0/b$a;

    invoke-interface {v3}, Lud0/b$a;->a()Lud0/b;

    move-result-object v3

    invoke-interface {v3}, Lud0/b;->a()Lpd0/e;

    move-result-object v3

    instance-of v4, v3, Lcom/tidal/android/image/coil/base/CoilImageLoader;

    if-nez v4, :cond_33

    return v0

    :cond_33
    sput-object v2, Lradiant/CoverWave;->app:Landroid/content/Context;

    check-cast v3, Lcom/tidal/android/image/coil/base/CoilImageLoader;

    iget-object v2, v3, Lcom/tidal/android/image/coil/base/CoilImageLoader;->a:Lcoil/e;

    sput-object v2, Lradiant/CoverWave;->loader:Lcoil/e;

    sget-object v2, Lradiant/CoverWave;->loader:Lcoil/e;
    :try_end_3d
    .catchall {:try_start_7 .. :try_end_3d} :catchall_42

    if-eqz v2, :cond_40

    goto :goto_41

    :cond_40
    move v1, v0

    :goto_41
    return v1

    :catchall_42
    move-exception v1

    return v0
.end method

.method public static attachView(Landroid/widget/ImageView;ILjava/lang/String;)V
    .registers 6

    if-eqz p0, :cond_3c

    if-eqz p2, :cond_3c

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p1

    if-nez p1, :cond_b

    goto :goto_3c

    :cond_b
    :try_start_b
    sget-object p1, Lradiant/CoverWave;->viewWaves:Ljava/util/WeakHashMap;

    invoke-virtual {p1, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lradiant/CoverWaveView;

    if-nez p1, :cond_35

    new-instance p1, Lradiant/CoverWaveView;

    invoke-direct {p1}, Lradiant/CoverWaveView;-><init>()V

    invoke-virtual {p0}, Landroid/widget/ImageView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/widget/ImageView;->getHeight()I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p1, v2, v2, v0, v1}, Lradiant/CoverWaveView;->setBounds(IIII)V

    invoke-virtual {p0}, Landroid/widget/ImageView;->getOverlay()Landroid/view/ViewOverlay;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/view/ViewOverlay;->add(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {p0, p1}, Landroid/widget/ImageView;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    sget-object v0, Lradiant/CoverWave;->viewWaves:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_35
    iput-object p2, p1, Lradiant/CoverWaveView;->cover:Ljava/lang/String;

    invoke-virtual {p1}, Lradiant/CoverWaveView;->invalidateSelf()V
    :try_end_3a
    .catchall {:try_start_b .. :try_end_3a} :catchall_3b

    goto :goto_3c

    :catchall_3b
    move-exception p0

    :cond_3c
    :goto_3c
    return-void
.end method

.method public static backdropAlbum(I)I
    .registers 2

    sget-object v0, Lradiant/CoverWave;->xfKey:Ljava/lang/String;

    if-eqz v0, :cond_6

    sget p0, Lradiant/CoverWave;->xfAlbum:I

    :cond_6
    return p0
.end method

.method public static backdropCover(Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    sget-object v0, Lradiant/CoverWave;->xfState:Landroidx/compose/runtime/MutableIntState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableIntState;->getIntValue()I

    sget-object v0, Lradiant/CoverWave;->xfKey:Ljava/lang/String;

    if-eqz v0, :cond_a

    move-object p0, v0

    :cond_a
    return-object p0
.end method

.method public static backdropMs()I
    .registers 4

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sget-boolean v2, Lradiant/CoverWave;->swapping:Z

    if-eqz v2, :cond_1d

    sget-boolean v2, Lradiant/CoverWave;->crossfade:Z

    if-eqz v2, :cond_1d

    sget-wide v2, Lradiant/CoverWave;->end:J

    cmp-long v2, v2, v0

    if-lez v2, :cond_1d

    sget-wide v2, Lradiant/CoverWave;->end:J

    sub-long/2addr v2, v0

    const-wide/16 v0, 0x12c

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    long-to-int v0, v0

    return v0

    :cond_1d
    invoke-static {}, Lradiant/CoverWave;->transitionMs()I

    move-result v0

    return v0
.end method

.method private static clamp01(F)F
    .registers 3

    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gez v1, :cond_7

    :goto_5
    move p0, v0

    goto :goto_e

    :cond_7
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-lez v1, :cond_e

    goto :goto_5

    :cond_e
    :goto_e
    return p0
.end method

.method private static clearSwap()V
    .registers 3

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/CoverWave;->swapping:Z

    const-wide/16 v1, 0x0

    sput-wide v1, Lradiant/CoverWave;->landedAt:J

    invoke-static {}, Lradiant/CoverWave;->clearXf()V

    const/4 v1, 0x0

    sput-object v1, Lradiant/CoverWave;->from:Landroid/graphics/Bitmap;

    sput-object v1, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    sput-object v1, Lradiant/CoverWave;->fromKey:Ljava/lang/String;

    sput-object v1, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    :goto_13
    const/16 v2, 0x8

    if-ge v0, v2, :cond_26

    sget-object v2, Lradiant/CoverWave;->fitSrc:[Landroid/graphics/Bitmap;

    aput-object v1, v2, v0

    sget-object v2, Lradiant/CoverWave;->fitOut:[Landroid/graphics/Bitmap;

    aput-object v1, v2, v0

    sget-object v2, Lradiant/CoverWave;->fitShader:[Landroid/graphics/BitmapShader;

    aput-object v1, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_13

    :cond_26
    return-void
.end method

.method private static clearXf()V
    .registers 2

    sget-object v0, Lradiant/CoverWave;->xfKey:Ljava/lang/String;

    if-nez v0, :cond_5

    return-void

    :cond_5
    const/4 v0, 0x0

    sput-object v0, Lradiant/CoverWave;->xfKey:Ljava/lang/String;

    sget-object v0, Lradiant/CoverWave;->xfState:Landroidx/compose/runtime/MutableIntState;

    sget v1, Lradiant/CoverWave;->xfTick:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lradiant/CoverWave;->xfTick:I

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableIntState;->setIntValue(I)V

    return-void
.end method

.method private static crop(Landroid/graphics/Bitmap;FF)V
    .registers 5

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p0

    int-to-float p0, p0

    div-float/2addr p1, p2

    div-float p2, v0, p0

    div-float/2addr p1, p2

    const/high16 p2, 0x3f800000    # 1.0f

    invoke-static {p1, p2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    mul-float/2addr v1, v0

    div-float p1, p2, p1

    invoke-static {p1, p2}, Ljava/lang/Math;->min(FF)F

    move-result p1

    mul-float/2addr p1, p0

    sub-float/2addr v0, v1

    const/high16 p2, 0x40000000    # 2.0f

    div-float/2addr v0, p2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    sub-float/2addr p0, p1

    div-float/2addr p0, p2

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    sget-object p2, Lradiant/CoverWave;->src:Landroid/graphics/Rect;

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    add-int/2addr v1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    add-int/2addr p1, p0

    invoke-virtual {p2, v0, p0, v1, p1}, Landroid/graphics/Rect;->set(IIII)V

    return-void
.end method

.method private static crossfadeStart(I)V
    .registers 8

    invoke-static {}, Lradiant/CoverDefaults;->follow()Z

    move-result v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    invoke-static {}, Lradiant/CoverWave;->nextAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v0

    if-nez v0, :cond_e

    return-void

    :cond_e
    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getCover()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_55

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_55

    sget-object v2, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_23

    goto :goto_55

    :cond_23
    sget-boolean v2, Lradiant/CoverWave;->swapping:Z

    if-eqz v2, :cond_30

    sget-object v2, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_30

    return-void

    :cond_30
    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v2

    const-wide/16 v3, 0x12c

    int-to-long v5, p0

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    invoke-static {v2, v1, v3, v4}, Lradiant/CoverWave;->startSwap(ILjava/lang/String;J)Z

    move-result p0

    if-nez p0, :cond_42

    return-void

    :cond_42
    sput-object v1, Lradiant/CoverWave;->xfKey:Ljava/lang/String;

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result p0

    sput p0, Lradiant/CoverWave;->xfAlbum:I

    sget-object p0, Lradiant/CoverWave;->xfState:Landroidx/compose/runtime/MutableIntState;

    sget v0, Lradiant/CoverWave;->xfTick:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lradiant/CoverWave;->xfTick:I

    invoke-interface {p0, v0}, Landroidx/compose/runtime/MutableIntState;->setIntValue(I)V

    :cond_55
    :goto_55
    return-void
.end method

.method private static draw(Landroid/graphics/Canvas;FF)V
    .registers 24

    const/high16 v0, 0x40000000    # 2.0f

    cmpg-float v1, p1, v0

    if-ltz v1, :cond_109

    cmpg-float v1, p2, v0

    if-ltz v1, :cond_109

    sget-object v1, Lradiant/CoverWave;->from:Landroid/graphics/Bitmap;

    if-nez v1, :cond_10

    goto/16 :goto_109

    :cond_10
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    sget-object v3, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    const/4 v4, 0x0

    const-wide/16 v5, 0x9c4

    const-wide/16 v7, 0x0

    const/high16 v9, 0x3f800000    # 1.0f

    const/4 v10, 0x0

    if-nez v3, :cond_5e

    sget-wide v11, Lradiant/CoverWave;->abortAt:J

    cmp-long v0, v11, v7

    if-nez v0, :cond_3c

    sget-wide v11, Lradiant/CoverWave;->heldSince:J

    sub-long v11, v1, v11

    cmp-long v0, v11, v5

    if-gtz v0, :cond_3a

    sget-wide v5, Lradiant/CoverWave;->end:J

    cmp-long v0, v5, v7

    if-eqz v0, :cond_3c

    sget-wide v5, Lradiant/CoverWave;->end:J

    cmp-long v0, v1, v5

    if-ltz v0, :cond_3c

    :cond_3a
    sput-wide v1, Lradiant/CoverWave;->abortAt:J

    :cond_3c
    sget-wide v5, Lradiant/CoverWave;->abortAt:J

    cmp-long v0, v5, v7

    if-eqz v0, :cond_4a

    sget-wide v5, Lradiant/CoverWave;->abortAt:J

    sub-long/2addr v1, v5

    long-to-float v0, v1

    const/high16 v1, 0x437a0000    # 250.0f

    div-float/2addr v0, v1

    sub-float/2addr v9, v0

    :cond_4a
    cmpg-float v0, v9, v10

    if-gtz v0, :cond_52

    invoke-static {v4}, Lradiant/CoverWave;->endSwap(Z)V

    return-void

    :cond_52
    const/high16 v0, -0x40800000    # -1.0f

    move/from16 v19, v0

    move/from16 v16, v10

    move/from16 v17, v16

    move/from16 v18, v17

    goto/16 :goto_d5

    :cond_5e
    sget-wide v11, Lradiant/CoverWave;->end:J

    sget-wide v13, Lradiant/CoverWave;->start:J

    sub-long/2addr v11, v13

    const-wide/16 v13, 0x1

    invoke-static {v13, v14, v11, v12}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v11

    long-to-float v3, v1

    sget-wide v13, Lradiant/CoverWave;->start:J

    long-to-float v13, v13

    long-to-float v11, v11

    div-float v0, v11, v0

    add-float/2addr v13, v0

    sub-float/2addr v3, v13

    const/high16 v0, 0x447a0000    # 1000.0f

    div-float/2addr v3, v0

    sget-wide v12, Lradiant/CoverWave;->end:J

    cmp-long v12, v1, v12

    if-ltz v12, :cond_ab

    sget-boolean v12, Lradiant/CoverWave;->crossfade:Z

    const/4 v13, 0x1

    if-eqz v12, :cond_87

    sget-wide v14, Lradiant/CoverWave;->landedAt:J

    cmp-long v7, v14, v7

    if-nez v7, :cond_87

    move v4, v13

    :cond_87
    if-eqz v4, :cond_8d

    sget-wide v7, Lradiant/CoverWave;->end:J

    add-long/2addr v7, v5

    goto :goto_95

    :cond_8d
    sget-wide v5, Lradiant/CoverWave;->end:J

    sget-wide v7, Lradiant/CoverWave;->landedAt:J

    invoke-static {v5, v6, v7, v8}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v7

    :goto_95
    cmp-long v5, v1, v7

    if-gez v5, :cond_9a

    goto :goto_a1

    :cond_9a
    sub-long v5, v1, v7

    long-to-float v5, v5

    const/high16 v6, 0x43af0000    # 350.0f

    div-float/2addr v5, v6

    sub-float/2addr v9, v5

    :goto_a1
    cmpg-float v5, v9, v10

    if-gtz v5, :cond_ab

    xor-int/lit8 v0, v4, 0x1

    invoke-static {v0}, Lradiant/CoverWave;->endSwap(Z)V

    return-void

    :cond_ab
    sget-wide v4, Lradiant/CoverWave;->start:J

    sub-long v4, v1, v4

    long-to-float v4, v4

    div-float/2addr v4, v11

    invoke-static {v4}, Lradiant/CoverWave;->ease3(F)F

    move-result v4

    sget-wide v5, Lradiant/CoverWave;->start:J

    sub-long/2addr v1, v5

    long-to-float v1, v1

    div-float/2addr v1, v0

    invoke-static {v10, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    cmpl-float v1, v3, v10

    if-ltz v1, :cond_cd

    neg-float v1, v3

    const v2, 0x400ccccd    # 2.2f

    mul-float/2addr v1, v2

    float-to-double v1, v1

    invoke-static {v1, v2}, Ljava/lang/Math;->exp(D)D

    move-result-wide v1

    double-to-float v10, v1

    :cond_cd
    move/from16 v17, v0

    move/from16 v19, v3

    move/from16 v16, v4

    move/from16 v18, v10

    :goto_d5
    move/from16 v20, v9

    sget-object v1, Lradiant/CoverWave;->from:Landroid/graphics/Bitmap;

    sget-object v0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_e0

    sget-object v0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    goto :goto_e2

    :cond_e0
    sget-object v0, Lradiant/CoverWave;->from:Landroid/graphics/Bitmap;

    :goto_e2
    move-object v13, v0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    if-lt v0, v2, :cond_fb

    sget-boolean v0, Lradiant/CoverWave;->shaderFailed:Z

    if-nez v0, :cond_fb

    move-object/from16 v11, p0

    move/from16 v14, p1

    move/from16 v15, p2

    move-object v12, v1

    invoke-static/range {v11 .. v20}, Lradiant/CoverWave;->wave(Landroid/graphics/Canvas;Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;FFFFFFF)Z

    move-result v0

    if-eqz v0, :cond_fb

    return-void

    :cond_fb
    move-object/from16 v0, p0

    move/from16 v3, p1

    move/from16 v4, p2

    move-object v2, v13

    move/from16 v5, v16

    move/from16 v6, v20

    invoke-static/range {v0 .. v6}, Lradiant/CoverWave;->fade(Landroid/graphics/Canvas;Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;FFFF)V

    :cond_109
    :goto_109
    return-void
.end method

.method static drawView(Landroid/graphics/Canvas;Ljava/lang/String;FF)V
    .registers 6

    invoke-static {p1}, Lradiant/CoverWave;->showsSwap(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    return-void

    :cond_7
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sput-wide v0, Lradiant/CoverWave;->lastDraw:J

    invoke-static {}, Lradiant/CoverWave;->schedule()V

    invoke-static {p0, p2, p3}, Lradiant/CoverWave;->draw(Landroid/graphics/Canvas;FF)V

    return-void
.end method

.method private static ease3(F)F
    .registers 3

    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p0}, Ljava/lang/Math;->min(FF)F

    move-result p0

    mul-float v0, p0, p0

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr p0, v1

    const/high16 v1, 0x40400000    # 3.0f

    sub-float/2addr v1, p0

    mul-float/2addr v0, v1

    return v0
.end method

.method private static endSwap(Z)V
    .registers 2

    if-eqz p0, :cond_8

    sget-object p0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    if-eqz p0, :cond_8

    const/4 p0, 0x1

    goto :goto_9

    :cond_8
    const/4 p0, 0x0

    :goto_9
    if-eqz p0, :cond_13

    sget-object v0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    sput-object v0, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    sget-object v0, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    sput-object v0, Lradiant/CoverWave;->shownKey:Ljava/lang/String;

    :cond_13
    invoke-static {}, Lradiant/CoverWave;->clearSwap()V

    if-nez p0, :cond_23

    sget-object p0, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    if-eqz p0, :cond_23

    sget p0, Lradiant/CoverWave;->tidalAlbum:I

    sget-object v0, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    invoke-static {p0, v0}, Lradiant/CoverWave;->park(ILjava/lang/String;)V

    :cond_23
    return-void
.end method

.method private static fade(Landroid/graphics/Canvas;Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;FFFF)V
    .registers 14

    const/high16 v0, 0x437f0000    # 255.0f

    mul-float/2addr p6, v0

    invoke-static {p6}, Ljava/lang/Math;->round(F)I

    move-result v6

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v1, p0

    move v4, p3

    move v5, p4

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->saveLayerAlpha(FFFFI)I

    move-result p0

    sget-object p3, Lradiant/CoverWave;->dst:Landroid/graphics/RectF;

    const/4 p4, 0x0

    invoke-virtual {p3, p4, p4, v4, v5}, Landroid/graphics/RectF;->set(FFFF)V

    sget-object p3, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    const/16 p4, 0xff

    invoke-virtual {p3, p4}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-static {p2, v4, v5}, Lradiant/CoverWave;->crop(Landroid/graphics/Bitmap;FF)V

    sget-object p3, Lradiant/CoverWave;->src:Landroid/graphics/Rect;

    sget-object p6, Lradiant/CoverWave;->dst:Landroid/graphics/RectF;

    sget-object v2, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    invoke-virtual {v1, p2, p3, p6, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    if-eq p2, p1, :cond_4d

    const/high16 p2, 0x3f800000    # 1.0f

    cmpg-float p3, p5, p2

    if-gez p3, :cond_4d

    sget-object p3, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    sub-float/2addr p2, p5

    mul-float/2addr p2, v0

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p2

    invoke-virtual {p3, p2}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-static {p1, v4, v5}, Lradiant/CoverWave;->crop(Landroid/graphics/Bitmap;FF)V

    sget-object p2, Lradiant/CoverWave;->src:Landroid/graphics/Rect;

    sget-object p3, Lradiant/CoverWave;->dst:Landroid/graphics/RectF;

    sget-object p5, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    invoke-virtual {v1, p1, p2, p3, p5}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    sget-object p1, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, p4}, Landroid/graphics/Paint;->setAlpha(I)V

    :cond_4d
    invoke-virtual {v1, p0}, Landroid/graphics/Canvas;->restoreToCount(I)V

    return-void
.end method

.method private static fit(Landroid/graphics/Bitmap;FF)I
    .registers 6

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    const/4 v0, 0x1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p2

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    const/4 v0, 0x0

    :goto_12
    const/16 v1, 0x8

    if-ge v0, v1, :cond_2c

    sget-object v1, Lradiant/CoverWave;->fitSrc:[Landroid/graphics/Bitmap;

    aget-object v1, v1, v0

    if-ne v1, p0, :cond_29

    sget-object v1, Lradiant/CoverWave;->fitW:[I

    aget v1, v1, v0

    if-ne v1, p1, :cond_29

    sget-object v1, Lradiant/CoverWave;->fitH:[I

    aget v1, v1, v0

    if-ne v1, p2, :cond_29

    return v0

    :cond_29
    add-int/lit8 v0, v0, 0x1

    goto :goto_12

    :cond_2c
    sget v0, Lradiant/CoverWave;->fitNext:I

    add-int/lit8 v1, v0, 0x1

    and-int/lit8 v1, v1, 0x7

    sput v1, Lradiant/CoverWave;->fitNext:I

    invoke-static {p0, p1, p2}, Lradiant/CoverWave;->shrink(Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;

    move-result-object v1

    sget-object v2, Lradiant/CoverWave;->fitSrc:[Landroid/graphics/Bitmap;

    aput-object p0, v2, v0

    sget-object p0, Lradiant/CoverWave;->fitOut:[Landroid/graphics/Bitmap;

    aput-object v1, p0, v0

    sget-object p0, Lradiant/CoverWave;->fitW:[I

    aput p1, p0, v0

    sget-object p0, Lradiant/CoverWave;->fitH:[I

    aput p2, p0, v0

    sget-object p0, Lradiant/CoverWave;->fitShader:[Landroid/graphics/BitmapShader;

    invoke-static {v1}, Lradiant/CoverWave;->linear(Landroid/graphics/Bitmap;)Landroid/graphics/BitmapShader;

    move-result-object p1

    aput-object p1, p0, v0

    return v0
.end method

.method private static jitterFor(Ljava/lang/String;)F
    .registers 5

    const v0, -0x7ee3623b

    const/4 v1, 0x0

    :goto_4
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_16

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    xor-int/2addr v0, v2

    const v2, 0x1000193

    mul-int/2addr v0, v2

    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_16
    int-to-long v0, v0

    const-wide v2, 0xffffffffL

    and-long/2addr v0, v2

    const-wide/16 v2, 0x3e8

    rem-long/2addr v0, v2

    long-to-float p0, v0

    const/high16 v0, 0x42140000    # 37.0f

    div-float/2addr p0, v0

    return p0
.end method

.method private static kick()V
    .registers 2

    sget-object v0, Lradiant/CoverWave;->frameState:Landroidx/compose/runtime/MutableIntState;

    sget v1, Lradiant/CoverWave;->tick:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lradiant/CoverWave;->tick:I

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableIntState;->setIntValue(I)V

    sget-object v0, Lradiant/CoverWave;->viewWaves:Ljava/util/WeakHashMap;

    invoke-virtual {v0}, Ljava/util/WeakHashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_15
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_25

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lradiant/CoverWaveView;

    invoke-virtual {v1}, Lradiant/CoverWaveView;->invalidateSelf()V

    goto :goto_15

    :cond_25
    return-void
.end method

.method private static linear(Landroid/graphics/Bitmap;)Landroid/graphics/BitmapShader;
    .registers 4

    new-instance v0, Landroid/graphics/BitmapShader;

    sget-object v1, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    sget-object v2, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct {v0, p0, v1, v2}, Landroid/graphics/BitmapShader;-><init>(Landroid/graphics/Bitmap;Landroid/graphics/Shader$TileMode;Landroid/graphics/Shader$TileMode;)V

    const/4 p0, 0x2

    invoke-virtual {v0, p0}, Landroid/graphics/BitmapShader;->setFilterMode(I)V

    return-object v0
.end method

.method private static load(IILjava/lang/String;I)V
    .registers 15

    invoke-static {}, Lradiant/CoverWave;->attach()Z

    move-result v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    new-instance v1, Lradiant/CoverWave;

    invoke-direct {v1, p0, p1, p2, p3}, Lradiant/CoverWave;-><init>(IILjava/lang/String;I)V

    const/4 p0, 0x0

    :try_start_d
    new-instance v2, Lpd0/g;

    sget-object v3, Lradiant/CoverWave;->app:Landroid/content/Context;

    new-instance v4, Lcom/tidal/android/image/core/b$a;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v4, p1, p2}, Lcom/tidal/android/image/core/b$a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v9, Lpd0/f;

    new-instance p1, Lpd0/h$c;

    const/16 p2, 0x500

    invoke-direct {p1, p2, p2}, Lpd0/h$c;-><init>(II)V

    invoke-direct {v9, p1}, Lpd0/f;-><init>(Lpd0/h;)V

    const/4 v10, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-direct/range {v2 .. v10}, Lpd0/g;-><init>(Landroid/content/Context;Lcom/tidal/android/image/core/b;Lcom/tidal/android/image/core/b$h$a;Lcom/tidal/android/image/core/b$h$a;ZLjava/util/List;Lpd0/f;Z)V

    invoke-static {v2, p0}, Lcom/tidal/android/image/coil/c;->a(Lpd0/g;Landroidx/compose/ui/layout/ContentScale;)Lcoil/request/h;

    move-result-object p1

    invoke-static {p1}, Lcoil/request/h;->a(Lcoil/request/h;)Lcoil/request/h$a;

    move-result-object p1

    iput-object v1, p1, Lcoil/request/h$a;->d:Lc0/c;

    sget-object p2, Lradiant/CoverWave;->loader:Lcoil/e;

    invoke-virtual {p1}, Lcoil/request/h$a;->a()Lcoil/request/h;

    move-result-object p1

    invoke-interface {p2, p1}, Lcoil/e;->b(Lcoil/request/h;)Lcoil/request/d;
    :try_end_41
    .catchall {:try_start_d .. :try_end_41} :catchall_42

    goto :goto_46

    :catchall_42
    move-exception v0

    invoke-virtual {v1, p0}, Lradiant/CoverWave;->c(Landroid/graphics/drawable/Drawable;)V

    :goto_46
    return-void
.end method

.method private static meanColour(Landroid/graphics/Bitmap;)V
    .registers 12

    const/4 v0, 0x1

    const/16 v1, 0x10

    const/high16 v2, 0x3f800000    # 1.0f

    :try_start_5
    invoke-static {p0, v1, v1, v0}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v3

    const/16 p0, 0x100

    new-array v4, p0, [I

    const/16 v9, 0x10

    const/16 v10, 0x10

    const/4 v5, 0x0

    const/16 v6, 0x10

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual/range {v3 .. v10}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    const/4 v0, 0x0

    const/4 v3, 0x0

    move v5, v0

    move v6, v3

    move v3, v5

    :goto_1e
    if-ge v6, p0, :cond_38

    aget v7, v4, v6

    shr-int/2addr v7, v1

    and-int/lit16 v7, v7, 0xff

    int-to-float v7, v7

    add-float/2addr v0, v7

    aget v7, v4, v6

    shr-int/lit8 v7, v7, 0x8

    and-int/lit16 v7, v7, 0xff

    int-to-float v7, v7

    add-float/2addr v3, v7

    aget v7, v4, v6
    :try_end_31
    .catchall {:try_start_5 .. :try_end_31} :catchall_6a

    and-int/lit16 v7, v7, 0xff

    int-to-float v7, v7

    add-float/2addr v5, v7

    add-int/lit8 v6, v6, 0x1

    goto :goto_1e

    :cond_38
    const/high16 p0, 0x477f0000    # 65280.0f

    div-float v2, v0, p0

    div-float v1, v3, p0

    div-float p0, v5, p0

    add-float v0, v2, v1

    add-float/2addr v0, p0

    const/high16 v3, 0x40400000    # 3.0f

    div-float/2addr v0, v3

    sub-float v3, v2, v0

    const v4, 0x3fcccccd    # 1.6f

    mul-float/2addr v3, v4

    add-float/2addr v3, v0

    const v5, 0x3df5c28f    # 0.12f

    add-float/2addr v3, v5

    :try_start_51
    invoke-static {v3}, Lradiant/CoverWave;->clamp01(F)F

    move-result v2

    sub-float v3, v1, v0

    mul-float/2addr v3, v4

    add-float/2addr v3, v0

    add-float/2addr v3, v5

    invoke-static {v3}, Lradiant/CoverWave;->clamp01(F)F

    move-result v1

    sub-float v3, p0, v0

    mul-float/2addr v3, v4

    add-float/2addr v0, v3

    add-float/2addr v0, v5

    invoke-static {v0}, Lradiant/CoverWave;->clamp01(F)F

    move-result p0
    :try_end_67
    .catchall {:try_start_51 .. :try_end_67} :catchall_68

    goto :goto_6d

    :catchall_68
    move-exception v0

    goto :goto_6d

    :catchall_6a
    move-exception v0

    move p0, v2

    move v1, p0

    :goto_6d
    sput v2, Lradiant/CoverWave;->hueR:F

    sput v1, Lradiant/CoverWave;->hueG:F

    sput p0, Lradiant/CoverWave;->hueB:F

    return-void
.end method

.method private static nextAlbum()Lcom/aspiro/wamp/model/Album;
    .registers 3

    const/4 v0, 0x0

    :try_start_1
    sget-object v1, Lradiant/CoverWave;->queue:Ljava/lang/Object;

    if-nez v1, :cond_6

    return-object v0

    :cond_6
    check-cast v1, Lzh/e;

    invoke-interface {v1}, Lzh/e;->getPlayQueue()Lcom/aspiro/wamp/playqueue/t;

    move-result-object v1

    invoke-interface {v1}, Lcom/aspiro/wamp/playqueue/t;->peekNext()Lcom/aspiro/wamp/playqueue/q0;

    move-result-object v1

    if-eqz v1, :cond_21

    invoke-interface {v1}, Lcom/aspiro/wamp/playqueue/q0;->getMediaItem()Lcom/aspiro/wamp/model/MediaItem;

    move-result-object v2

    if-nez v2, :cond_19

    goto :goto_21

    :cond_19
    invoke-interface {v1}, Lcom/aspiro/wamp/playqueue/q0;->getMediaItem()Lcom/aspiro/wamp/model/MediaItem;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v0
    :try_end_21
    .catchall {:try_start_1 .. :try_end_21} :catchall_22

    :cond_21
    :goto_21
    return-object v0

    :catchall_22
    move-exception v1

    return-object v0
.end method

.method public static onCrossfade(J)V
    .registers 5

    const-wide/16 v0, 0x0

    cmp-long v2, p0, v0

    if-gez v2, :cond_7

    move-wide p0, v0

    :cond_7
    sput-wide p0, Lradiant/CoverWave;->crossfadeMs:J

    return-void
.end method

.method public static onCrossfadePrepare()V
    .registers 4

    new-instance v0, Lradiant/CoverWave;

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x6

    invoke-direct {v0, v3, v1, v2, v1}, Lradiant/CoverWave;-><init>(IILjava/lang/String;I)V

    invoke-static {v0}, Lradiant/CoverWave;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method public static onCrossfadeStart(J)V
    .registers 5

    new-instance v0, Lradiant/CoverWave;

    const-wide/16 v1, 0x0

    invoke-static {v1, v2, p0, p1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p0

    const-wide/32 v1, 0x7fffffff

    invoke-static {v1, v2, p0, p1}, Ljava/lang/Math;->min(JJ)J

    move-result-wide p0

    long-to-int p0, p0

    const/4 p1, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x5

    invoke-direct {v0, v2, p0, p1, v1}, Lradiant/CoverWave;-><init>(IILjava/lang/String;I)V

    invoke-static {v0}, Lradiant/CoverWave;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method public static onSwipe()V
    .registers 2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sput-wide v0, Lradiant/CoverWave;->swipeAt:J

    return-void
.end method

.method public static onTrack(ILjava/lang/String;)V
    .registers 5

    if-eqz p1, :cond_13

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_9

    goto :goto_13

    :cond_9
    new-instance v0, Lradiant/CoverWave;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-direct {v0, v1, p0, p1, v2}, Lradiant/CoverWave;-><init>(IILjava/lang/String;I)V

    invoke-static {v0}, Lradiant/CoverWave;->post(Ljava/lang/Runnable;)V

    :cond_13
    :goto_13
    return-void
.end method

.method private static park(ILjava/lang/String;)V
    .registers 4

    sget v0, Lradiant/CoverWave;->token:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lradiant/CoverWave;->token:I

    const/4 v1, 0x2

    invoke-static {v1, p0, p1, v0}, Lradiant/CoverWave;->load(IILjava/lang/String;I)V

    return-void
.end method

.method private static post(Ljava/lang/Runnable;)V
    .registers 3

    sget-object v0, Lradiant/CoverWave;->main:Landroid/os/Handler;

    if-nez v0, :cond_f

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/CoverWave;->main:Landroid/os/Handler;

    :cond_f
    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private static prefetchNext()V
    .registers 4

    invoke-static {}, Lradiant/CoverDefaults;->follow()Z

    move-result v0

    if-eqz v0, :cond_34

    sget-wide v0, Lradiant/CoverWave;->crossfadeMs:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-gtz v0, :cond_f

    goto :goto_34

    :cond_f
    invoke-static {}, Lradiant/CoverWave;->nextAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v0

    if-nez v0, :cond_16

    return-void

    :cond_16
    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getCover()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_34

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_34

    sget-object v2, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2b

    goto :goto_34

    :cond_2b
    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v0

    const/4 v2, 0x0

    const/4 v3, 0x6

    invoke-static {v3, v0, v1, v2}, Lradiant/CoverWave;->load(IILjava/lang/String;I)V

    :cond_34
    :goto_34
    return-void
.end method

.method private static schedule()V
    .registers 2

    sget-boolean v0, Lradiant/CoverWave;->frameQueued:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    const/4 v0, 0x1

    sput-boolean v0, Lradiant/CoverWave;->frameQueued:Z

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    sget-object v1, Lradiant/CoverWave;->FRAMES:Lradiant/CoverWave;

    invoke-virtual {v0, v1}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    return-void
.end method

.method public static setQueue(Ljava/lang/Object;)V
    .registers 1

    sput-object p0, Lradiant/CoverWave;->queue:Ljava/lang/Object;

    return-void
.end method

.method private static showsSwap(Ljava/lang/String;)Z
    .registers 8

    sget-boolean v0, Lradiant/CoverWave;->swapping:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_34

    if-nez p0, :cond_8

    goto :goto_34

    :cond_8
    sget-object v0, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v2, 0x1

    if-eqz v0, :cond_12

    return v2

    :cond_12
    sget-boolean v0, Lradiant/CoverWave;->crossfade:Z

    if-eqz v0, :cond_34

    sget-object v0, Lradiant/CoverWave;->fromKey:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_34

    sget-wide v3, Lradiant/CoverWave;->landedAt:J

    const-wide/16 v5, 0x0

    cmp-long p0, v3, v5

    if-eqz p0, :cond_33

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    sget-wide v5, Lradiant/CoverWave;->landedAt:J

    sub-long/2addr v3, v5

    const-wide/16 v5, 0x190

    cmp-long p0, v3, v5

    if-gez p0, :cond_34

    :cond_33
    move v1, v2

    :cond_34
    :goto_34
    return v1
.end method

.method private static shrink(Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
    .registers 6

    int-to-float p1, p1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr p1, v0

    int-to-float p2, p2

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr p2, v0

    invoke-static {p1, p2}, Ljava/lang/Math;->max(FF)F

    move-result p1

    const p2, 0x3f733333    # 0.95f

    cmpl-float p2, p1, p2

    if-ltz p2, :cond_1a

    return-object p0

    :cond_1a
    move-object p2, p0

    :goto_1b
    const/high16 v0, 0x3f000000    # 0.5f

    cmpg-float v0, p1, v0

    const/4 v1, 0x1

    if-gtz v0, :cond_44

    :try_start_22
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-static {p2, v0, v2, v1}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eq p2, p0, :cond_3f

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->recycle()V

    :cond_3f
    const/high16 p2, 0x40000000    # 2.0f

    mul-float/2addr p1, p2

    move-object p2, v0

    goto :goto_1b

    :cond_44
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v2, p1

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result p1

    invoke-static {v1, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-static {p2, v0, p1, v1}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eq p2, p0, :cond_6b

    if-eq p2, p1, :cond_6b

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_6b
    .catchall {:try_start_22 .. :try_end_6b} :catchall_6c

    :cond_6b
    return-object p1

    :catchall_6c
    move-exception p1

    return-object p0
.end method

.method private static startSwap(ILjava/lang/String;J)Z
    .registers 11

    invoke-static {}, Lradiant/CoverWave;->attach()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_8

    return v1

    :cond_8
    sget-boolean v0, Lradiant/CoverWave;->swapping:Z

    if-eqz v0, :cond_22

    sget-object v0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_17

    sget-object v0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    sput-object v0, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    sget-object v0, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    goto :goto_1d

    :cond_17
    sget-object v0, Lradiant/CoverWave;->from:Landroid/graphics/Bitmap;

    sput-object v0, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    sget-object v0, Lradiant/CoverWave;->fromKey:Ljava/lang/String;

    :goto_1d
    sput-object v0, Lradiant/CoverWave;->shownKey:Ljava/lang/String;

    invoke-static {}, Lradiant/CoverWave;->clearSwap()V

    :cond_22
    sget-object v0, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    if-nez v0, :cond_27

    return v1

    :cond_27
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    sget-object v0, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    sput-object v0, Lradiant/CoverWave;->from:Landroid/graphics/Bitmap;

    sget-object v0, Lradiant/CoverWave;->shownKey:Ljava/lang/String;

    sput-object v0, Lradiant/CoverWave;->fromKey:Ljava/lang/String;

    const/4 v0, 0x0

    sput-object v0, Lradiant/CoverWave;->shown:Landroid/graphics/Bitmap;

    sput-object v0, Lradiant/CoverWave;->shownKey:Ljava/lang/String;

    sput-object v0, Lradiant/CoverWave;->to:Landroid/graphics/Bitmap;

    sput-object p1, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    invoke-static {p1}, Lradiant/CoverWave;->jitterFor(Ljava/lang/String;)F

    move-result v0

    sput v0, Lradiant/CoverWave;->jitter:F

    sput-wide v2, Lradiant/CoverWave;->heldSince:J

    const-wide/16 v4, 0x0

    sput-wide v4, Lradiant/CoverWave;->abortAt:J

    sput-wide v4, Lradiant/CoverWave;->landedAt:J

    cmp-long v0, p2, v4

    const/4 v6, 0x1

    if-lez v0, :cond_50

    move v1, v6

    :cond_50
    sput-boolean v1, Lradiant/CoverWave;->crossfade:Z

    sget-boolean v0, Lradiant/CoverWave;->crossfade:Z

    if-eqz v0, :cond_57

    goto :goto_5c

    :cond_57
    invoke-static {}, Lradiant/CoverWave;->transitionMs()I

    move-result p2

    int-to-long p2, p2

    :goto_5c
    sput-wide p2, Lradiant/CoverWave;->span:J

    sget-boolean p2, Lradiant/CoverWave;->crossfade:Z

    if-eqz p2, :cond_64

    move-wide p2, v2

    goto :goto_65

    :cond_64
    move-wide p2, v4

    :goto_65
    sput-wide p2, Lradiant/CoverWave;->start:J

    sget-boolean p2, Lradiant/CoverWave;->crossfade:Z

    if-eqz p2, :cond_6f

    sget-wide p2, Lradiant/CoverWave;->span:J

    add-long v4, v2, p2

    :cond_6f
    sput-wide v4, Lradiant/CoverWave;->end:J

    sput-boolean v6, Lradiant/CoverWave;->swapping:Z

    sget p2, Lradiant/CoverWave;->token:I

    add-int/2addr p2, v6

    sput p2, Lradiant/CoverWave;->token:I

    const/4 p3, 0x3

    invoke-static {p3, p0, p1, p2}, Lradiant/CoverWave;->load(IILjava/lang/String;I)V

    invoke-static {}, Lradiant/CoverWave;->kick()V

    return v6
.end method

.method private static toBitmap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;
    .registers 5

    const/4 v0, 0x0

    if-nez p0, :cond_4

    return-object v0

    :cond_4
    instance-of v1, p0, Landroid/graphics/drawable/BitmapDrawable;

    if-eqz v1, :cond_f

    move-object v0, p0

    check-cast v0, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v0

    :cond_f
    if-eqz v0, :cond_20

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_1f

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->HARDWARE:Landroid/graphics/Bitmap$Config;

    if-eq v1, v2, :cond_20

    :cond_1f
    return-object v0

    :cond_20
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    const/16 v1, 0x500

    if-lez v0, :cond_2d

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    goto :goto_2e

    :cond_2d
    move v0, v1

    :goto_2e
    const/4 v2, 0x1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v3

    if-lez v3, :cond_3d

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    :cond_3d
    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {p0, v3, v3, v0, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0, v2}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {p0, v0}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-object v2
.end method

.method private static track(ILjava/lang/String;)V
    .registers 11

    sget-object v0, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    return-void

    :cond_9
    sget-object v0, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_11

    move v0, v1

    goto :goto_12

    :cond_11
    move v0, v2

    :goto_12
    sput-object p1, Lradiant/CoverWave;->tidalKey:Ljava/lang/String;

    sput p0, Lradiant/CoverWave;->tidalAlbum:I

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    sget-wide v5, Lradiant/CoverWave;->swipeAt:J

    sub-long v5, v3, v5

    const-wide/16 v7, 0x9c4

    cmp-long v5, v5, v7

    if-gez v5, :cond_25

    goto :goto_26

    :cond_25
    move v1, v2

    :goto_26
    const-wide/16 v5, 0x0

    sput-wide v5, Lradiant/CoverWave;->swipeAt:J

    invoke-static {}, Lradiant/CoverWave;->clearXf()V

    sget-boolean v7, Lradiant/CoverWave;->swapping:Z

    if-eqz v7, :cond_3f

    sget-object v7, Lradiant/CoverWave;->toKey:Ljava/lang/String;

    invoke-virtual {p1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3f

    sput-wide v3, Lradiant/CoverWave;->landedAt:J

    invoke-static {}, Lradiant/CoverWave;->kick()V

    return-void

    :cond_3f
    sget-boolean v3, Lradiant/CoverWave;->swapping:Z

    if-nez v3, :cond_4c

    sget-object v3, Lradiant/CoverWave;->shownKey:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4c

    return-void

    :cond_4c
    if-eqz v1, :cond_59

    sget-boolean v0, Lradiant/CoverWave;->swapping:Z

    if-eqz v0, :cond_55

    invoke-static {v2}, Lradiant/CoverWave;->endSwap(Z)V

    :cond_55
    invoke-static {p0, p1}, Lradiant/CoverWave;->park(ILjava/lang/String;)V

    return-void

    :cond_59
    if-nez v0, :cond_62

    invoke-static {p0, p1, v5, v6}, Lradiant/CoverWave;->startSwap(ILjava/lang/String;J)Z

    move-result v0

    if-eqz v0, :cond_62

    return-void

    :cond_62
    invoke-static {p0, p1}, Lradiant/CoverWave;->park(ILjava/lang/String;)V

    return-void
.end method

.method private static transitionMs()I
    .registers 2

    const/16 v0, 0x1f4

    invoke-static {}, Lradiant/CoverDefaults;->ms()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method private static wave(Landroid/graphics/Canvas;Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;FFFFFFF)Z
    .registers 16

    const/4 v1, 0x0

    const/4 v2, 0x1

    :try_start_2
    sget-object v0, Lradiant/CoverWave;->shader:Landroid/graphics/RuntimeShader;

    if-nez v0, :cond_f

    new-instance v0, Landroid/graphics/RuntimeShader;

    const-string v3, "uniform shader uOld;\nuniform shader uNew;\nuniform float2 uSize;\nuniform float2 uOldPx;\nuniform float2 uNewPx;\nuniform float2 uFitOld;\nuniform float2 uFitNew;\nuniform float uMix;\nuniform float uClock;\nuniform float uPulse;\nuniform float uPulseAge;\nuniform float uJitter;\nuniform float uFade;\nuniform float3 uHue;\n\nfloat rnd2(float2 q) {\n  float3 p = fract(float3(mod(q, 256.0).xyx) * 0.1031);\n  p += dot(p, p.yzx + 33.33);\n  return fract((p.x + p.y) * p.z);\n}\nfloat vnoise(float2 q) {\n  float2 k = floor(q);\n  float2 w = fract(q);\n  w = w * w * (3.0 - 2.0 * w);\n  return mix(mix(rnd2(k), rnd2(k + float2(1.0, 0.0)), w.x), mix(rnd2(k + float2(0.0, 1.0)), rnd2(k + float2(1.0, 1.0)), w.x), w.y);\n}\nfloat octaves(float2 q) {\n  float acc = 0.0;\n  float amp = 0.5;\n  for (int k = 0; k < 4; k++) {\n    acc += amp * vnoise(q);\n    q = q * 2.03 + 17.1;\n    amp *= 0.5;\n  }\n  return acc;\n}\nfloat2 mirrorUv(float2 uv) { return 1.0 - abs(1.0 - mod(uv, 2.0)); }\nfloat3 oldAt(float2 uv) { return uOld.eval(((mirrorUv(uv) - 0.5) * uFitOld + 0.5) * uOldPx).rgb; }\nfloat3 newAt(float2 uv) { return uNew.eval(((mirrorUv(uv) - 0.5) * uFitNew + 0.5) * uNewPx).rgb; }\nfloat3 oldFringe(float2 uv, float2 off) { return float3(oldAt(uv + off).r, oldAt(uv).g, oldAt(uv - off).b); }\nfloat3 newFringe(float2 uv, float2 off) { return float3(newAt(uv + off).r, newAt(uv).g, newAt(uv - off).b); }\n\nhalf4 main(float2 fragCoord) {\n  float2 uv = fragCoord / uSize;\n  float2 fromMid = uv - 0.5;\n  float radial = length(fromMid);\n  float swell = uPulseAge > 0.0 ? exp(-abs(radial - uPulseAge * 0.85) * 13.0) * uPulse : 0.0;\n  float2 bentUv = 0.5 + fromMid + normalize(fromMid + 1e-5) * swell * 0.04;\n  float2 aberr = fromMid * (0.05 * swell);\n  float busy = step(0.002, uMix) * step(uMix, 0.998);\n  float w = uv.x * 0.74 + uv.y * 0.26 + sin(uv.y * 7.0 + uClock * 1.7) * 0.045 + (octaves(uv * 3.0 + uJitter + float2(0.0, uClock * 0.08)) - 0.47) * 0.16;\n  float gap = w - mix(-0.2, 1.2, uMix);\n  float side = smoothstep(-0.01, 0.01, gap);\n  float bulge = exp(-abs(gap) * 9.0) * busy;\n  float wiggle = sin(gap * 70.0 - uClock * 5.0) * exp(-abs(gap) * 7.0) * busy;\n  float2 shove = float2(0.74, 0.26) * (bulge * 0.07 + wiggle * 0.018);\n  float3 shade = mix(newFringe(bentUv - shove, aberr + float2(0.01 * bulge, 0.0)), oldFringe(bentUv + shove, aberr + float2(0.02 * bulge, 0.0)), side);\n  shade *= 1.0 + wiggle * 0.18;\n  float shine = (exp(-abs(gap) * 45.0) * 1.4 + exp(-abs(gap) * 8.0) * 0.25) * busy;\n  float3 hueLight = mix(uHue, float3(1.0), 0.55);\n  float headroom = 1.0 - 0.65 * dot(shade, float3(0.3, 0.6, 0.1));\n  shade += shine * 0.3 * hueLight * headroom;\n  shade += swell * 0.1 * headroom;\n  return half4(half3(clamp(shade * uFade, 0.0, 1.0)), half(uFade));\n}\n"

    invoke-direct {v0, v3}, Landroid/graphics/RuntimeShader;-><init>(Ljava/lang/String;)V

    sput-object v0, Lradiant/CoverWave;->shader:Landroid/graphics/RuntimeShader;

    :cond_f
    invoke-static {p1, p3, p4}, Lradiant/CoverWave;->fit(Landroid/graphics/Bitmap;FF)I

    move-result v0

    sget-object v3, Lradiant/CoverWave;->fitOut:[Landroid/graphics/Bitmap;

    aget-object v3, v3, v0

    sget-object v4, Lradiant/CoverWave;->fitShader:[Landroid/graphics/BitmapShader;

    aget-object v0, v4, v0

    if-eq p2, p1, :cond_2a

    invoke-static {p2, p3, p4}, Lradiant/CoverWave;->fit(Landroid/graphics/Bitmap;FF)I

    move-result p1

    sget-object p2, Lradiant/CoverWave;->fitOut:[Landroid/graphics/Bitmap;

    aget-object p2, p2, p1

    sget-object v4, Lradiant/CoverWave;->fitShader:[Landroid/graphics/BitmapShader;

    aget-object p1, v4, p1

    goto :goto_2c

    :cond_2a
    move-object p1, v0

    move-object p2, v3

    :goto_2c
    sget-object v4, Lradiant/CoverWave;->shader:Landroid/graphics/RuntimeShader;

    const-string v5, "uOld"

    invoke-virtual {v4, v5, v0}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    const-string v0, "uNew"

    invoke-virtual {v4, v0, p1}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    const-string p1, "uSize"

    invoke-virtual {v4, p1, p3, p4}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    const-string p1, "uOldPx"

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    int-to-float v5, v5

    invoke-virtual {v4, p1, v0, v5}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    const-string p1, "uNewPx"

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    int-to-float v5, v5

    invoke-virtual {v4, p1, v0, v5}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    div-float p1, p3, p4

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v0, v3

    div-float v0, p1, v0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p2

    int-to-float p2, p2

    div-float/2addr v3, p2

    div-float/2addr p1, v3

    const-string p2, "uFitOld"

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v5

    div-float v0, v3, v0

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-virtual {v4, p2, v5, v0}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    const-string p2, "uFitNew"

    invoke-static {p1, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    div-float p1, v3, p1

    invoke-static {p1, v3}, Ljava/lang/Math;->min(FF)F

    move-result p1

    invoke-virtual {v4, p2, v0, p1}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    const-string p1, "uMix"

    invoke-virtual {v4, p1, p5}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    const-string p1, "uClock"

    invoke-virtual {v4, p1, p6}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    const-string p1, "uPulse"

    invoke-virtual {v4, p1, p7}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    const-string p1, "uPulseAge"

    invoke-virtual {v4, p1, p8}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    const-string p1, "uJitter"

    sget p2, Lradiant/CoverWave;->jitter:F

    invoke-virtual {v4, p1, p2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    const-string p1, "uFade"

    invoke-virtual {v4, p1, p9}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    const-string p1, "uHue"

    sget p2, Lradiant/CoverWave;->hueR:F

    sget p5, Lradiant/CoverWave;->hueG:F

    sget p6, Lradiant/CoverWave;->hueB:F

    invoke-virtual {v4, p1, p2, p5, p6}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FFF)V

    sget-object p1, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    const/16 p2, 0xff

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setAlpha(I)V

    sget-object p1, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    sget-object p7, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    move p5, p3

    const/4 p3, 0x0

    move p6, p4

    const/4 p4, 0x0

    move-object p2, p0

    invoke-virtual/range {p2 .. p7}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    sget-object p0, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    invoke-virtual {p0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;
    :try_end_dc
    .catchall {:try_start_2 .. :try_end_dc} :catchall_dd

    return v2

    :catchall_dd
    move-exception v0

    sput-boolean v2, Lradiant/CoverWave;->shaderFailed:Z

    sget-object p0, Lradiant/CoverWave;->paint:Landroid/graphics/Paint;

    invoke-virtual {p0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    const/4 p0, 0x0

    return p0
.end method

.method public static wrap(Landroidx/compose/ui/Modifier;ILjava/lang/String;)Landroidx/compose/ui/Modifier;
    .registers 5

    if-eqz p2, :cond_13

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_9

    goto :goto_13

    :cond_9
    new-instance v0, Lradiant/CoverWave;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p1, p2, v1}, Lradiant/CoverWave;-><init>(IILjava/lang/String;I)V

    invoke-static {p0, v0}, Landroidx/compose/ui/draw/DrawModifierKt;->drawWithContent(Landroidx/compose/ui/Modifier;Lyl0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    :cond_13
    :goto_13
    return-object p0
.end method


# virtual methods
.method public a(Landroid/graphics/drawable/Drawable;)V
    .registers 2

    invoke-static {p1}, Lradiant/CoverWave;->toBitmap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-direct {p0, p1}, Lradiant/CoverWave;->arrive(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public b(Landroid/graphics/drawable/Drawable;)V
    .registers 2

    return-void
.end method

.method public c(Landroid/graphics/drawable/Drawable;)V
    .registers 2

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lradiant/CoverWave;->arrive(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public doFrame(J)V
    .registers 5

    const/4 p1, 0x0

    sput-boolean p1, Lradiant/CoverWave;->frameQueued:Z

    sget-boolean p1, Lradiant/CoverWave;->swapping:Z

    if-nez p1, :cond_8

    return-void

    :cond_8
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide p1

    sget-wide v0, Lradiant/CoverWave;->lastDraw:J

    sub-long/2addr p1, v0

    const-wide/16 v0, 0x1f4

    cmp-long p1, p1, v0

    if-lez p1, :cond_16

    return-void

    :cond_16
    invoke-static {}, Lradiant/CoverWave;->kick()V

    invoke-static {}, Lradiant/CoverWave;->schedule()V

    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .registers 6

    const/4 v0, 0x1

    if-ne p0, p1, :cond_4

    return v0

    :cond_4
    instance-of v1, p1, Lradiant/CoverWave;

    const/4 v2, 0x0

    if-nez v1, :cond_a

    return v2

    :cond_a
    check-cast p1, Lradiant/CoverWave;

    iget v1, p0, Lradiant/CoverWave;->mode:I

    iget v3, p1, Lradiant/CoverWave;->mode:I

    if-ne v1, v3, :cond_32

    iget v1, p0, Lradiant/CoverWave;->albumId:I

    iget v3, p1, Lradiant/CoverWave;->albumId:I

    if-ne v1, v3, :cond_32

    iget v1, p0, Lradiant/CoverWave;->job:I

    iget v3, p1, Lradiant/CoverWave;->job:I

    if-ne v1, v3, :cond_32

    iget-object v1, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    if-nez v1, :cond_27

    iget-object p1, p1, Lradiant/CoverWave;->cover:Ljava/lang/String;

    if-nez p1, :cond_32

    goto :goto_33

    :cond_27
    iget-object v1, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    iget-object p1, p1, Lradiant/CoverWave;->cover:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_32

    goto :goto_33

    :cond_32
    move v0, v2

    :goto_33
    return v0
.end method

.method public hashCode()I
    .registers 3

    iget v0, p0, Lradiant/CoverWave;->mode:I

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lradiant/CoverWave;->albumId:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    if-nez v1, :cond_f

    const/4 v1, 0x0

    goto :goto_15

    :cond_f
    iget-object v1, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    :goto_15
    add-int/2addr v0, v1

    return v0
.end method

.method public invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 5

    check-cast p1, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;

    sget-object v0, Lradiant/CoverWave;->frameState:Landroidx/compose/runtime/MutableIntState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableIntState;->getIntValue()I

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->drawContent()V

    iget-object v0, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    invoke-static {v0}, Lradiant/CoverWave;->showsSwap(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_36

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sput-wide v0, Lradiant/CoverWave;->lastDraw:J

    invoke-static {}, Lradiant/CoverWave;->schedule()V

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->getSize-NH-jbRc()J

    move-result-wide v0

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object p1

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object p1

    invoke-static {p1}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object p1

    invoke-static {v0, v1}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F

    move-result v2

    invoke-static {v0, v1}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F

    move-result v0

    invoke-static {p1, v2, v0}, Lradiant/CoverWave;->draw(Landroid/graphics/Canvas;FF)V

    :cond_36
    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public run()V
    .registers 3

    iget v0, p0, Lradiant/CoverWave;->mode:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_d

    iget v0, p0, Lradiant/CoverWave;->albumId:I

    iget-object v1, p0, Lradiant/CoverWave;->cover:Ljava/lang/String;

    invoke-static {v0, v1}, Lradiant/CoverWave;->track(ILjava/lang/String;)V

    goto :goto_20

    :cond_d
    iget v0, p0, Lradiant/CoverWave;->mode:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_18

    iget v0, p0, Lradiant/CoverWave;->albumId:I

    invoke-static {v0}, Lradiant/CoverWave;->crossfadeStart(I)V

    goto :goto_20

    :cond_18
    iget v0, p0, Lradiant/CoverWave;->mode:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_20

    invoke-static {}, Lradiant/CoverWave;->prefetchNext()V

    :cond_20
    :goto_20
    return-void
.end method
