.class public final Ldev/kawarp/KawarpEngine;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static final AGSL:Ljava/lang/String; = "uniform shader texA;\nuniform shader texB;\nuniform float2 uRes;\nuniform float uTime;\nuniform float uBlend;\nuniform float uWarp;\nuniform float uSat;\nuniform float uDither;\nuniform float uScale;\nuniform float uBright;\nuniform float uContrast;\n\nfloat3 m289_3(float3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }\nfloat2 m289_2(float2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }\nfloat3 permute(float3 x) { return m289_3(((x * 34.0) + 1.0) * x); }\n\nfloat snoise(float2 v) {\n  float4 C = float4(0.211324865405187, 0.366025403784439,\n                    -0.577350269189626, 0.024390243902439);\n  float2 i = floor(v + dot(v, C.yy));\n  float2 x0 = v - i + dot(i, C.xx);\n  float2 i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);\n  float4 x12 = x0.xyxy + C.xxzz;\n  x12.xy -= i1;\n  i = m289_2(i);\n  float3 p = permute(permute(i.y + float3(0.0, i1.y, 1.0)) + i.x + float3(0.0, i1.x, 1.0));\n  float3 m = max(0.5 - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);\n  m = m * m;\n  m = m * m;\n  float3 x = 2.0 * fract(p * C.www) - 1.0;\n  float3 h = abs(x) - 0.5;\n  float3 ox = floor(x + 0.5);\n  float3 a0 = x - ox;\n  m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);\n  float3 g;\n  g.x = a0.x * x0.x + h.x * x0.y;\n  g.yz = a0.yz * x12.xz + h.yz * x12.yw;\n  return 130.0 * dot(m, g);\n}\n\nfloat hash13(float3 seed) {\n  float3 q = fract(seed * 0.1031);\n  q += dot(q, q.zyx + 31.32);\n  return fract((q.x + q.y) * q.z);\n}\n\nhalf4 main(float2 fragCoord) {\n  float2 uv0 = fragCoord / uRes;\n  float2 uv = clamp((uv0 - 0.5) / uScale + 0.5, 0.0, 1.0);\n\n  float t = uTime * 0.05;\n  float2 c = uv - 0.5;\n  float centerWeight = 1.0 - smoothstep(0.0, 0.7, length(c));\n  float n1 = snoise(uv * 0.35 + float2(t, t * 0.7));\n  float n2 = snoise(uv * 0.35 + float2(-t * 0.8, t * 0.5) + float2(50.0, 50.0));\n  float n3 = snoise(uv * 0.9 + float2(t * 1.2, -t) + float2(100.0, 0.0));\n  float n4 = snoise(uv * 0.9 + float2(-t, t * 1.1) + float2(0.0, 100.0));\n  float2 warp = float2(n1 * 0.65 + n3 * 0.35, n2 * 0.65 + n4 * 0.35) * centerWeight;\n  float2 wuv = clamp(uv + warp * uWarp, 0.0, 1.0);\n\n  float2 sp = wuv * 128.0;\n  float3 col = mix(float3(texA.eval(sp).rgb), float3(texB.eval(sp).rgb), uBlend);\n\n  float2 c2 = uv0 - 0.5;\n  col *= 1.0 - dot(c2, c2) * 0.3;\n  float gray = dot(col, float3(0.299, 0.587, 0.114));\n  col = mix(float3(gray), col, uSat);\n  float n = hash13(float3(floor(uv0 * uRes), floor(uTime * 60.0)));\n  col += (n - 0.5) * uDither;\n\n  col = (col - 0.5) * uContrast + 0.5;\n  col *= uBright;\n  return half4(half3(clamp(col, 0.0, 1.0)), 1.0);\n}\n"

.field private static final BLUR_SIZE:I = 0x80

.field private static final CEIL_MAX:F = 0.15f

.field private static final CEIL_MIN:F = 0.9f

.field private static final LOADER:Ljava/util/concurrent/ExecutorService;

.field private static final MIN_BRIGHTNESS:F = 0.15f

.field private static final RAMP_SECONDS:F = 1.8f


# instance fields
.field private volatile animationSpeed:F

.field private volatile autoDarken:F

.field private volatile blurPasses:I

.field private volatile brightness:F

.field private volatile contrast:F

.field private volatile coverToken:I

.field private volatile dithering:F

.field private lastFrameUptime:J

.field private volatile nextDarken:F

.field private volatile nextShader:Landroid/graphics/BitmapShader;

.field private final paint:Landroid/graphics/Paint;

.field private volatile pendingCover:Landroid/graphics/Bitmap;

.field private volatile playbackReactive:Z

.field private volatile playing:Z

.field private volatile prevDarken:F

.field private volatile prevShader:Landroid/graphics/BitmapShader;

.field private volatile saturation:F

.field private volatile scale:F

.field private final shader:Landroid/graphics/RuntimeShader;

.field private shaderTime:F

.field private speedFactor:F

.field private volatile tintB:F

.field private volatile tintG:F

.field private volatile tintIntensity:F

.field private volatile tintR:F

.field private volatile transitionMs:I

.field private volatile transitionStart:J

.field private volatile warpIntensity:F


# direct methods
.method static constructor <clinit>()V
    .registers 1

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Ldev/kawarp/KawarpEngine;->LOADER:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public constructor <init>()V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Ldev/kawarp/KawarpEngine;->warpIntensity:F

    const/16 v1, 0x8

    iput v1, p0, Ldev/kawarp/KawarpEngine;->blurPasses:I

    iput v0, p0, Ldev/kawarp/KawarpEngine;->animationSpeed:F

    const/high16 v1, 0x3fc00000    # 1.5f

    iput v1, p0, Ldev/kawarp/KawarpEngine;->saturation:F

    const v1, 0x3c03126f    # 0.008f

    iput v1, p0, Ldev/kawarp/KawarpEngine;->dithering:F

    iput v0, p0, Ldev/kawarp/KawarpEngine;->scale:F

    iput v0, p0, Ldev/kawarp/KawarpEngine;->contrast:F

    iput v0, p0, Ldev/kawarp/KawarpEngine;->brightness:F

    const/4 v1, 0x0

    iput v1, p0, Ldev/kawarp/KawarpEngine;->autoDarken:F

    const/16 v1, 0x3e8

    iput v1, p0, Ldev/kawarp/KawarpEngine;->transitionMs:I

    const v1, 0x3e20c49c    # 0.157f

    iput v1, p0, Ldev/kawarp/KawarpEngine;->tintR:F

    iput v1, p0, Ldev/kawarp/KawarpEngine;->tintG:F

    const v1, 0x3e70a3d7    # 0.235f

    iput v1, p0, Ldev/kawarp/KawarpEngine;->tintB:F

    const v1, 0x3e19999a    # 0.15f

    iput v1, p0, Ldev/kawarp/KawarpEngine;->tintIntensity:F

    const/4 v1, 0x0

    iput-boolean v1, p0, Ldev/kawarp/KawarpEngine;->playbackReactive:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Ldev/kawarp/KawarpEngine;->playing:Z

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, p0, Ldev/kawarp/KawarpEngine;->paint:Landroid/graphics/Paint;

    iput v0, p0, Ldev/kawarp/KawarpEngine;->prevDarken:F

    iput v0, p0, Ldev/kawarp/KawarpEngine;->nextDarken:F

    iput v0, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    invoke-static {}, Ldev/kawarp/KawarpEngine;->isSupported()Z

    move-result v0

    if-eqz v0, :cond_57

    new-instance v0, Landroid/graphics/RuntimeShader;

    const-string v1, "uniform shader texA;\nuniform shader texB;\nuniform float2 uRes;\nuniform float uTime;\nuniform float uBlend;\nuniform float uWarp;\nuniform float uSat;\nuniform float uDither;\nuniform float uScale;\nuniform float uBright;\nuniform float uContrast;\n\nfloat3 m289_3(float3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }\nfloat2 m289_2(float2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }\nfloat3 permute(float3 x) { return m289_3(((x * 34.0) + 1.0) * x); }\n\nfloat snoise(float2 v) {\n  float4 C = float4(0.211324865405187, 0.366025403784439,\n                    -0.577350269189626, 0.024390243902439);\n  float2 i = floor(v + dot(v, C.yy));\n  float2 x0 = v - i + dot(i, C.xx);\n  float2 i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);\n  float4 x12 = x0.xyxy + C.xxzz;\n  x12.xy -= i1;\n  i = m289_2(i);\n  float3 p = permute(permute(i.y + float3(0.0, i1.y, 1.0)) + i.x + float3(0.0, i1.x, 1.0));\n  float3 m = max(0.5 - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);\n  m = m * m;\n  m = m * m;\n  float3 x = 2.0 * fract(p * C.www) - 1.0;\n  float3 h = abs(x) - 0.5;\n  float3 ox = floor(x + 0.5);\n  float3 a0 = x - ox;\n  m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);\n  float3 g;\n  g.x = a0.x * x0.x + h.x * x0.y;\n  g.yz = a0.yz * x12.xz + h.yz * x12.yw;\n  return 130.0 * dot(m, g);\n}\n\nfloat hash13(float3 seed) {\n  float3 q = fract(seed * 0.1031);\n  q += dot(q, q.zyx + 31.32);\n  return fract((q.x + q.y) * q.z);\n}\n\nhalf4 main(float2 fragCoord) {\n  float2 uv0 = fragCoord / uRes;\n  float2 uv = clamp((uv0 - 0.5) / uScale + 0.5, 0.0, 1.0);\n\n  float t = uTime * 0.05;\n  float2 c = uv - 0.5;\n  float centerWeight = 1.0 - smoothstep(0.0, 0.7, length(c));\n  float n1 = snoise(uv * 0.35 + float2(t, t * 0.7));\n  float n2 = snoise(uv * 0.35 + float2(-t * 0.8, t * 0.5) + float2(50.0, 50.0));\n  float n3 = snoise(uv * 0.9 + float2(t * 1.2, -t) + float2(100.0, 0.0));\n  float n4 = snoise(uv * 0.9 + float2(-t, t * 1.1) + float2(0.0, 100.0));\n  float2 warp = float2(n1 * 0.65 + n3 * 0.35, n2 * 0.65 + n4 * 0.35) * centerWeight;\n  float2 wuv = clamp(uv + warp * uWarp, 0.0, 1.0);\n\n  float2 sp = wuv * 128.0;\n  float3 col = mix(float3(texA.eval(sp).rgb), float3(texB.eval(sp).rgb), uBlend);\n\n  float2 c2 = uv0 - 0.5;\n  col *= 1.0 - dot(c2, c2) * 0.3;\n  float gray = dot(col, float3(0.299, 0.587, 0.114));\n  col = mix(float3(gray), col, uSat);\n  float n = hash13(float3(floor(uv0 * uRes), floor(uTime * 60.0)));\n  col += (n - 0.5) * uDither;\n\n  col = (col - 0.5) * uContrast + 0.5;\n  col *= uBright;\n  return half4(half3(clamp(col, 0.0, 1.0)), 1.0);\n}\n"

    invoke-direct {v0, v1}, Landroid/graphics/RuntimeShader;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    return-void

    :cond_57
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "KawarpEngine needs API 33+ (AGSL)"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private brightnessFor(F)F
    .registers 6

    iget v0, p0, Ldev/kawarp/KawarpEngine;->autoDarken:F

    const/4 v1, 0x0

    cmpg-float v2, v0, v1

    const/high16 v3, 0x3f800000    # 1.0f

    if-lez v2, :cond_23

    cmpg-float v1, p1, v1

    if-gtz v1, :cond_e

    goto :goto_23

    :cond_e
    const/high16 v1, 0x3f400000    # 0.75f

    mul-float/2addr v0, v1

    const v1, 0x3f666666    # 0.9f

    sub-float/2addr v1, v0

    cmpg-float v0, p1, v1

    if-gtz v0, :cond_1a

    return v3

    :cond_1a
    div-float/2addr v1, p1

    const p1, 0x3e19999a    # 0.15f

    invoke-static {v1, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    return p1

    :cond_23
    :goto_23
    return v3
.end method

.method private static channel(F)I
    .registers 2

    const/high16 v0, 0x437f0000    # 255.0f

    mul-float/2addr p0, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p0, v0

    float-to-int p0, p0

    if-gez p0, :cond_b

    const/4 p0, 0x0

    goto :goto_10

    :cond_b
    const/16 v0, 0xff

    if-le p0, v0, :cond_10

    move p0, v0

    :cond_10
    :goto_10
    return p0
.end method

.method private static clamp(I)I
    .registers 2

    if-gez p0, :cond_4

    const/4 p0, 0x0

    goto :goto_a

    :cond_4
    const/16 v0, 0x80

    if-lt p0, v0, :cond_a

    const/16 p0, 0x7f

    :cond_a
    :goto_a
    return p0
.end method

.method public static isSupported()Z
    .registers 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_8

    const/4 v0, 0x1

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    :goto_9
    return v0
.end method

.method private static kawasePass([F[FI)V
    .registers 16

    add-int/lit8 v0, p2, 0x1

    neg-int v1, v0

    neg-int v2, p2

    filled-new-array {v1, v2, p2, v0}, [I

    move-result-object p2

    const/4 v0, 0x0

    move v1, v0

    :goto_a
    const/16 v2, 0x80

    if-ge v1, v2, :cond_5b

    move v3, v0

    :goto_f
    if-ge v3, v2, :cond_58

    const/4 v4, 0x0

    move v7, v0

    move v5, v4

    move v6, v5

    :goto_15
    const/4 v8, 0x4

    if-ge v7, v8, :cond_41

    aget v9, p2, v7

    add-int/2addr v9, v1

    invoke-static {v9}, Ldev/kawarp/KawarpEngine;->clamp(I)I

    move-result v9

    move v10, v0

    :goto_20
    if-ge v10, v8, :cond_3e

    aget v11, p2, v10

    mul-int/lit16 v12, v9, 0x80

    add-int/2addr v11, v3

    invoke-static {v11}, Ldev/kawarp/KawarpEngine;->clamp(I)I

    move-result v11

    add-int/2addr v12, v11

    mul-int/lit8 v12, v12, 0x3

    aget v11, p0, v12

    add-float/2addr v4, v11

    add-int/lit8 v11, v12, 0x1

    aget v11, p0, v11

    add-float/2addr v5, v11

    add-int/lit8 v12, v12, 0x2

    aget v11, p0, v12

    add-float/2addr v6, v11

    add-int/lit8 v10, v10, 0x1

    goto :goto_20

    :cond_3e
    add-int/lit8 v7, v7, 0x1

    goto :goto_15

    :cond_41
    mul-int/lit16 v7, v1, 0x80

    add-int/2addr v7, v3

    mul-int/lit8 v7, v7, 0x3

    const/high16 v8, 0x41800000    # 16.0f

    div-float/2addr v4, v8

    aput v4, p1, v7

    add-int/lit8 v4, v7, 0x1

    div-float/2addr v5, v8

    aput v5, p1, v4

    add-int/lit8 v7, v7, 0x2

    div-float/2addr v6, v8

    aput v6, p1, v7

    add-int/lit8 v3, v3, 0x1

    goto :goto_f

    :cond_58
    add-int/lit8 v1, v1, 0x1

    goto :goto_a

    :cond_5b
    return-void
.end method

.method private process(Landroid/graphics/Bitmap;I)V
    .registers 25

    move-object/from16 v0, p0

    const/16 v1, 0x4000

    new-array v3, v1, [I

    const/16 v8, 0x80

    const/16 v9, 0x80

    const/4 v4, 0x0

    const/16 v5, 0x80

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object/from16 v2, p1

    invoke-virtual/range {v2 .. v9}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    const v2, 0xc000

    new-array v4, v2, [F

    new-array v2, v2, [F

    iget v5, v0, Ldev/kawarp/KawarpEngine;->tintR:F

    iget v6, v0, Ldev/kawarp/KawarpEngine;->tintG:F

    iget v7, v0, Ldev/kawarp/KawarpEngine;->tintB:F

    iget v8, v0, Ldev/kawarp/KawarpEngine;->tintIntensity:F

    const/4 v10, 0x0

    move v11, v10

    const/4 v12, 0x0

    :goto_26
    const/4 v13, 0x2

    if-ge v11, v1, :cond_ac

    aget v14, v3, v11

    shr-int/lit8 v15, v14, 0x10

    and-int/lit16 v15, v15, 0xff

    int-to-float v15, v15

    const/high16 v16, 0x437f0000    # 255.0f

    div-float v15, v15, v16

    const/16 p1, 0x0

    shr-int/lit8 v9, v14, 0x8

    and-int/lit16 v9, v9, 0xff

    int-to-float v9, v9

    div-float v9, v9, v16

    and-int/lit16 v14, v14, 0xff

    int-to-float v14, v14

    div-float v14, v14, v16

    const v16, 0x3e59b3d0    # 0.2126f

    mul-float v16, v16, v15

    const v17, 0x3f371759    # 0.7152f

    mul-float v17, v17, v9

    add-float v16, v16, v17

    const v17, 0x3d93dd98    # 0.0722f

    mul-float v17, v17, v14

    add-float v16, v16, v17

    add-float v12, v12, v16

    const v16, 0x3e991687    # 0.299f

    mul-float v16, v16, v15

    const v17, 0x3f1645a2    # 0.587f

    mul-float v17, v17, v9

    add-float v16, v16, v17

    const v17, 0x3de978d5    # 0.114f

    mul-float v17, v17, v14

    add-float v16, v16, v17

    const/high16 v17, 0x40000000    # 2.0f

    mul-float v16, v16, v17

    cmpg-float v18, v16, p1

    const/high16 v19, 0x3f800000    # 1.0f

    if-gez v18, :cond_77

    move/from16 v16, p1

    goto :goto_7d

    :cond_77
    cmpl-float v18, v16, v19

    if-lez v18, :cond_7d

    move/from16 v16, v19

    :cond_7d
    :goto_7d
    mul-float v18, v16, v16

    const/high16 v20, 0x40400000    # 3.0f

    mul-float v16, v16, v17

    sub-float v20, v20, v16

    mul-float v18, v18, v20

    sub-float v19, v19, v18

    mul-float v19, v19, v8

    mul-int/lit8 v16, v11, 0x3

    sub-float v17, v5, v15

    mul-float v17, v17, v19

    add-float v15, v15, v17

    aput v15, v4, v16

    add-int/lit8 v15, v16, 0x1

    sub-float v17, v6, v9

    mul-float v17, v17, v19

    add-float v9, v9, v17

    aput v9, v4, v15

    add-int/lit8 v16, v16, 0x2

    sub-float v9, v7, v14

    mul-float v9, v9, v19

    add-float/2addr v14, v9

    aput v14, v4, v16

    add-int/lit8 v11, v11, 0x1

    goto/16 :goto_26

    :cond_ac
    const/high16 v5, 0x46800000    # 16384.0f

    div-float/2addr v12, v5

    iget v5, v0, Ldev/kawarp/KawarpEngine;->blurPasses:I

    move v6, v10

    :goto_b2
    if-ge v6, v5, :cond_bf

    invoke-static {v4, v2, v6}, Ldev/kawarp/KawarpEngine;->kawasePass([F[FI)V

    add-int/lit8 v6, v6, 0x1

    move-object/from16 v21, v4

    move-object v4, v2

    move-object/from16 v2, v21

    goto :goto_b2

    :cond_bf
    :goto_bf
    if-ge v10, v1, :cond_e6

    mul-int/lit8 v2, v10, 0x3

    aget v5, v4, v2

    invoke-static {v5}, Ldev/kawarp/KawarpEngine;->channel(F)I

    move-result v5

    shl-int/lit8 v5, v5, 0x10

    const/high16 v6, -0x1000000

    or-int/2addr v5, v6

    add-int/lit8 v6, v2, 0x1

    aget v6, v4, v6

    invoke-static {v6}, Ldev/kawarp/KawarpEngine;->channel(F)I

    move-result v6

    shl-int/lit8 v6, v6, 0x8

    or-int/2addr v5, v6

    add-int/2addr v2, v13

    aget v2, v4, v2

    invoke-static {v2}, Ldev/kawarp/KawarpEngine;->channel(F)I

    move-result v2

    or-int/2addr v2, v5

    aput v2, v3, v10

    add-int/lit8 v10, v10, 0x1

    goto :goto_bf

    :cond_e6
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    const/16 v2, 0x80

    invoke-static {v2, v2, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    const/16 v8, 0x80

    const/16 v9, 0x80

    const/4 v4, 0x0

    const/16 v5, 0x80

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v9}, Landroid/graphics/Bitmap;->setPixels([IIIIIII)V

    iget v1, v0, Ldev/kawarp/KawarpEngine;->coverToken:I

    move/from16 v3, p2

    if-eq v3, v1, :cond_101

    return-void

    :cond_101
    new-instance v1, Landroid/graphics/BitmapShader;

    sget-object v3, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    sget-object v4, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct {v1, v2, v3, v4}, Landroid/graphics/BitmapShader;-><init>(Landroid/graphics/Bitmap;Landroid/graphics/Shader$TileMode;Landroid/graphics/Shader$TileMode;)V

    invoke-virtual {v1, v13}, Landroid/graphics/BitmapShader;->setFilterMode(I)V

    iget-object v2, v0, Ldev/kawarp/KawarpEngine;->nextShader:Landroid/graphics/BitmapShader;

    iput-object v2, v0, Ldev/kawarp/KawarpEngine;->prevShader:Landroid/graphics/BitmapShader;

    iput-object v1, v0, Ldev/kawarp/KawarpEngine;->nextShader:Landroid/graphics/BitmapShader;

    iget v1, v0, Ldev/kawarp/KawarpEngine;->nextDarken:F

    iput v1, v0, Ldev/kawarp/KawarpEngine;->prevDarken:F

    invoke-direct {v0, v12}, Ldev/kawarp/KawarpEngine;->brightnessFor(F)F

    move-result v1

    iput v1, v0, Ldev/kawarp/KawarpEngine;->nextDarken:F

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Ldev/kawarp/KawarpEngine;->transitionStart:J

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;FF)Z
    .registers 13

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->nextShader:Landroid/graphics/BitmapShader;

    if-eqz v0, :cond_f5

    const/4 v1, 0x0

    cmpg-float v2, p2, v1

    if-lez v2, :cond_f5

    cmpg-float v2, p3, v1

    if-gtz v2, :cond_f

    goto/16 :goto_f5

    :cond_f
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Ldev/kawarp/KawarpEngine;->lastFrameUptime:J

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-nez v4, :cond_1d

    move v4, v1

    goto :goto_2c

    :cond_1d
    iget-wide v4, p0, Ldev/kawarp/KawarpEngine;->lastFrameUptime:J

    sub-long v4, v2, v4

    long-to-float v4, v4

    const/high16 v5, 0x447a0000    # 1000.0f

    div-float/2addr v4, v5

    const v5, 0x3dcccccd    # 0.1f

    invoke-static {v4, v5}, Ljava/lang/Math;->min(FF)F

    move-result v4

    :goto_2c
    iput-wide v2, p0, Ldev/kawarp/KawarpEngine;->lastFrameUptime:J

    iget-boolean v5, p0, Ldev/kawarp/KawarpEngine;->playbackReactive:Z

    const/high16 v6, 0x3f800000    # 1.0f

    if-eqz v5, :cond_38

    iget-boolean v5, p0, Ldev/kawarp/KawarpEngine;->playing:Z

    if-eqz v5, :cond_39

    :cond_38
    move v1, v6

    :cond_39
    const v5, 0x3fe66666    # 1.8f

    div-float v5, v4, v5

    iget v7, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    cmpg-float v7, v7, v1

    iget v8, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    if-gez v7, :cond_4e

    add-float/2addr v8, v5

    invoke-static {v1, v8}, Ljava/lang/Math;->min(FF)F

    move-result v1

    :goto_4b
    iput v1, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    goto :goto_5a

    :cond_4e
    cmpl-float v7, v8, v1

    if-lez v7, :cond_5a

    iget v7, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    sub-float/2addr v7, v5

    invoke-static {v1, v7}, Ljava/lang/Math;->max(FF)F

    move-result v1

    goto :goto_4b

    :cond_5a
    :goto_5a
    iget v1, p0, Ldev/kawarp/KawarpEngine;->shaderTime:F

    iget v5, p0, Ldev/kawarp/KawarpEngine;->animationSpeed:F

    mul-float/2addr v4, v5

    iget v5, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    mul-float/2addr v4, v5

    add-float/2addr v1, v4

    iput v1, p0, Ldev/kawarp/KawarpEngine;->shaderTime:F

    iget v1, p0, Ldev/kawarp/KawarpEngine;->transitionMs:I

    iget-wide v4, p0, Ldev/kawarp/KawarpEngine;->transitionStart:J

    sub-long/2addr v2, v4

    if-lez v1, :cond_75

    int-to-long v4, v1

    cmp-long v4, v2, v4

    if-gez v4, :cond_75

    long-to-float v2, v2

    int-to-float v1, v1

    div-float v6, v2, v1

    :cond_75
    iget-object v1, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    iget-object v2, p0, Ldev/kawarp/KawarpEngine;->prevShader:Landroid/graphics/BitmapShader;

    if-eqz v2, :cond_7e

    iget-object v2, p0, Ldev/kawarp/KawarpEngine;->prevShader:Landroid/graphics/BitmapShader;

    goto :goto_7f

    :cond_7e
    move-object v2, v0

    :goto_7f
    const-string v3, "texA"

    invoke-virtual {v1, v3, v2}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    iget-object v1, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v2, "texB"

    invoke-virtual {v1, v2, v0}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uRes"

    invoke-virtual {v0, v1, p2, p3}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uTime"

    iget v2, p0, Ldev/kawarp/KawarpEngine;->shaderTime:F

    invoke-virtual {v0, v1, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uBlend"

    invoke-virtual {v0, v1, v6}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uWarp"

    iget v2, p0, Ldev/kawarp/KawarpEngine;->warpIntensity:F

    invoke-virtual {v0, v1, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uSat"

    iget v2, p0, Ldev/kawarp/KawarpEngine;->saturation:F

    invoke-virtual {v0, v1, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uDither"

    iget v2, p0, Ldev/kawarp/KawarpEngine;->dithering:F

    invoke-virtual {v0, v1, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uScale"

    iget v2, p0, Ldev/kawarp/KawarpEngine;->scale:F

    invoke-virtual {v0, v1, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget v0, p0, Ldev/kawarp/KawarpEngine;->prevDarken:F

    iget v1, p0, Ldev/kawarp/KawarpEngine;->nextDarken:F

    iget v2, p0, Ldev/kawarp/KawarpEngine;->prevDarken:F

    sub-float/2addr v1, v2

    mul-float/2addr v1, v6

    add-float/2addr v0, v1

    iget-object v1, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    iget v2, p0, Ldev/kawarp/KawarpEngine;->brightness:F

    mul-float/2addr v2, v0

    const-string v0, "uBright"

    invoke-virtual {v1, v0, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    const-string v1, "uContrast"

    iget v2, p0, Ldev/kawarp/KawarpEngine;->contrast:F

    invoke-virtual {v0, v1, v2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;F)V

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->paint:Landroid/graphics/Paint;

    iget-object v1, p0, Ldev/kawarp/KawarpEngine;->shader:Landroid/graphics/RuntimeShader;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    const/4 v4, 0x0

    iget-object v7, p0, Ldev/kawarp/KawarpEngine;->paint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    move-object v2, p1

    move v5, p2

    move v6, p3

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    const/4 p1, 0x1

    return p1

    :cond_f5
    :goto_f5
    const/4 p1, 0x0

    return p1
.end method

.method public isAnimating()Z
    .registers 7

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->nextShader:Landroid/graphics/BitmapShader;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    return v1

    :cond_6
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Ldev/kawarp/KawarpEngine;->transitionStart:J

    sub-long/2addr v2, v4

    iget v0, p0, Ldev/kawarp/KawarpEngine;->transitionMs:I

    int-to-long v4, v0

    cmp-long v0, v2, v4

    const/4 v2, 0x1

    if-gez v0, :cond_16

    return v2

    :cond_16
    iget-boolean v0, p0, Ldev/kawarp/KawarpEngine;->playbackReactive:Z

    const/4 v3, 0x0

    if-eqz v0, :cond_22

    iget-boolean v0, p0, Ldev/kawarp/KawarpEngine;->playing:Z

    if-eqz v0, :cond_20

    goto :goto_22

    :cond_20
    move v0, v3

    goto :goto_24

    :cond_22
    :goto_22
    const/high16 v0, 0x3f800000    # 1.0f

    :goto_24
    iget v4, p0, Ldev/kawarp/KawarpEngine;->speedFactor:F

    cmpl-float v4, v4, v3

    if-nez v4, :cond_2e

    cmpl-float v0, v0, v3

    if-eqz v0, :cond_2f

    :cond_2e
    move v1, v2

    :cond_2f
    return v1
.end method

.method public isReady()Z
    .registers 2

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->nextShader:Landroid/graphics/BitmapShader;

    if-eqz v0, :cond_6

    const/4 v0, 0x1

    goto :goto_7

    :cond_6
    const/4 v0, 0x0

    :goto_7
    return v0
.end method

.method public run()V
    .registers 3

    iget-object v0, p0, Ldev/kawarp/KawarpEngine;->pendingCover:Landroid/graphics/Bitmap;

    iget v1, p0, Ldev/kawarp/KawarpEngine;->coverToken:I

    if-nez v0, :cond_7

    return-void

    :cond_7
    invoke-direct {p0, v0, v1}, Ldev/kawarp/KawarpEngine;->process(Landroid/graphics/Bitmap;I)V

    return-void
.end method

.method public setAnimationSpeed(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->animationSpeed:F

    return-void
.end method

.method public setAutoDarken(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->autoDarken:F

    return-void
.end method

.method public setBlurPasses(I)V
    .registers 3

    const/16 v0, 0x28

    invoke-static {v0, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    const/4 v0, 0x1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ldev/kawarp/KawarpEngine;->blurPasses:I

    return-void
.end method

.method public setBrightness(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->brightness:F

    return-void
.end method

.method public setContrast(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->contrast:F

    return-void
.end method

.method public setCover(Landroid/graphics/Bitmap;)V
    .registers 4

    if-nez p1, :cond_3

    return-void

    :cond_3
    const/16 v0, 0x80

    const/4 v1, 0x1

    invoke-static {p1, v0, v0, v1}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Ldev/kawarp/KawarpEngine;->pendingCover:Landroid/graphics/Bitmap;

    iget p1, p0, Ldev/kawarp/KawarpEngine;->coverToken:I

    add-int/2addr p1, v1

    iput p1, p0, Ldev/kawarp/KawarpEngine;->coverToken:I

    sget-object p1, Ldev/kawarp/KawarpEngine;->LOADER:Ljava/util/concurrent/ExecutorService;

    invoke-interface {p1, p0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setDithering(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->dithering:F

    return-void
.end method

.method public setPlaybackReactive(Z)V
    .registers 2

    iput-boolean p1, p0, Ldev/kawarp/KawarpEngine;->playbackReactive:Z

    return-void
.end method

.method public setPlaying(Z)V
    .registers 2

    iput-boolean p1, p0, Ldev/kawarp/KawarpEngine;->playing:Z

    return-void
.end method

.method public setSaturation(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->saturation:F

    return-void
.end method

.method public setScale(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->scale:F

    return-void
.end method

.method public setTintColor(FFF)V
    .registers 4

    iput p1, p0, Ldev/kawarp/KawarpEngine;->tintR:F

    iput p2, p0, Ldev/kawarp/KawarpEngine;->tintG:F

    iput p3, p0, Ldev/kawarp/KawarpEngine;->tintB:F

    return-void
.end method

.method public setTintIntensity(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->tintIntensity:F

    return-void
.end method

.method public setTransitionDuration(I)V
    .registers 3

    const/4 v0, 0x0

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ldev/kawarp/KawarpEngine;->transitionMs:I

    return-void
.end method

.method public setWarpIntensity(F)V
    .registers 2

    iput p1, p0, Ldev/kawarp/KawarpEngine;->warpIntensity:F

    return-void
.end method
