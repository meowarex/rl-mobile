.class public final Lradiant/RLKaraoke;
.super Ljava/lang/Object;


# static fields
.field private static final BREAK_IN_MS:J = 0x190L

.field static final BREAK_MIN_MS:J = 0x1b58L

.field private static final BREAK_OUT_MS:J = 0x15eL

.field private static final CLIMB:I = 0x2

.field private static final DAMP:D = 3.5

.field private static final DOTS:Ljava/lang/String; = "\u25cf\u25cf\u25cf"

.field private static final FALL_MS:J = 0x2bcL

.field private static final FREQ:D

.field private static final GLOW_FADE_MS:J = 0x258L

.field private static final HEADROOM:F = 0.06f

.field private static final LIFT:F = 0.08f

.field private static final LIFT_MS:J = 0x7d0L

.field private static final SHINE_FADE_MS:J = 0x12cL

.field private static final STILL:I = 0x0

.field private static final SWELL:I = 0x1

.field private static final SWELL_LIFT:F = 0.04f

.field private static volatile breakEnd:[J

.field private static volatile breakStart:[J

.field private static lastEm:F

.field private static lineRatio:F

.field private static steady:Landroidx/compose/ui/text/ParagraphStyle;

.field private static steadyBg:Landroidx/compose/ui/text/ParagraphStyle;

.field private static steadyRatio:F


# direct methods
.method static constructor <clinit>()V
    .registers 2

    const-wide/high16 v0, 0x402c000000000000L    # 14.0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    sput-wide v0, Lradiant/RLKaraoke;->FREQ:D

    const/high16 v0, 0x3fa00000    # 1.25f

    sput v0, Lradiant/RLKaraoke;->lineRatio:F

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static addBreaks(Lorg/json/JSONArray;)Lorg/json/JSONArray;
    .registers 16

    const/4 v0, 0x0

    :try_start_1
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    const/4 v2, 0x0

    const-wide/16 v3, -0x1

    move-wide v4, v3

    move v3, v2

    :goto_b
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-ge v2, v6, :cond_46

    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-nez v6, :cond_18

    goto :goto_43

    :cond_18
    invoke-static {v6}, Lradiant/RLKaraoke;->startOf(Lorg/json/JSONObject;)J

    move-result-wide v7

    const-wide/16 v9, 0x0

    cmp-long v11, v7, v9

    if-ltz v11, :cond_40

    cmp-long v11, v4, v9

    if-gez v11, :cond_27

    goto :goto_28

    :cond_27
    move-wide v9, v4

    :goto_28
    sub-long v11, v7, v9

    const-wide/16 v13, 0x1b58

    cmp-long v11, v11, v13

    if-ltz v11, :cond_38

    invoke-static {v9, v10, v7, v8}, Lradiant/RLKaraoke;->breakLine(JJ)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    const/4 v3, 0x1

    :cond_38
    invoke-static {v6, v7, v8}, Lradiant/RLKaraoke;->endOf(Lorg/json/JSONObject;J)J

    move-result-wide v7

    invoke-static {v4, v5, v7, v8}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v4

    :cond_40
    invoke-virtual {v1, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_43
    .catchall {:try_start_1 .. :try_end_43} :catchall_4a

    :goto_43
    add-int/lit8 v2, v2, 0x1

    goto :goto_b

    :cond_46
    if-eqz v3, :cond_49

    move-object v0, v1

    :cond_49
    return-object v0

    :catchall_4a
    move-exception p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "instrumental dots failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-object v0
.end method

.method private static bezier(FFFFF)F
    .registers 14

    const/high16 v0, 0x40400000    # 3.0f

    mul-float v1, p1, v0

    sub-float/2addr p3, p1

    mul-float/2addr p3, v0

    sub-float/2addr p3, v1

    const/high16 p1, 0x3f800000    # 1.0f

    sub-float v2, p1, v1

    sub-float/2addr v2, p3

    mul-float v3, p2, v0

    sub-float/2addr p4, p2

    mul-float/2addr p4, v0

    sub-float/2addr p4, v3

    sub-float/2addr p1, v3

    sub-float/2addr p1, p4

    const/4 p2, 0x0

    move v4, p0

    :goto_15
    const/16 v5, 0x8

    if-ge p2, v5, :cond_45

    mul-float v5, v2, v4

    add-float/2addr v5, p3

    mul-float/2addr v5, v4

    add-float/2addr v5, v1

    mul-float/2addr v5, v4

    sub-float/2addr v5, p0

    mul-float v6, v2, v0

    mul-float/2addr v6, v4

    const/high16 v7, 0x40000000    # 2.0f

    mul-float/2addr v7, p3

    add-float/2addr v6, v7

    mul-float/2addr v6, v4

    add-float/2addr v6, v1

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x3727c5ac    # 1.0E-5f

    cmpg-float v7, v7, v8

    if-ltz v7, :cond_45

    invoke-static {v6}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x358637bd    # 1.0E-6f

    cmpg-float v7, v7, v8

    if-gez v7, :cond_40

    goto :goto_45

    :cond_40
    div-float/2addr v5, v6

    sub-float/2addr v4, v5

    add-int/lit8 p2, p2, 0x1

    goto :goto_15

    :cond_45
    :goto_45
    mul-float/2addr p1, v4

    add-float/2addr p1, p4

    mul-float/2addr p1, v4

    add-float/2addr p1, v3

    mul-float/2addr p1, v4

    return p1
.end method

.method private static breakLine(JJ)Lorg/json/JSONObject;
    .registers 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "text"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v3, "time"

    invoke-virtual {v0, v3, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    sub-long v3, p2, p0

    const-string v5, "duration"

    invoke-virtual {v0, v5, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v6, "isBackground"

    const/4 v7, 0x0

    invoke-virtual {v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v6, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    long-to-double v1, p0

    const-wide v7, 0x408f400000000000L    # 1000.0

    div-double/2addr v1, v7

    const-string v9, "startTime"

    invoke-virtual {v6, v9, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    long-to-double v1, p2

    div-double/2addr v1, v7

    const-string v9, "endTime"

    invoke-virtual {v6, v9, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    long-to-double v1, v3

    div-double/2addr v1, v7

    invoke-virtual {v6, v5, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-result-object v0

    const-string v1, "syllabus"

    invoke-virtual {v6, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v0, "_rlBreak"

    const/4 v1, 0x1

    invoke-virtual {v6, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v0, "_rlFrom"

    invoke-virtual {v6, v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string p0, "_rlTo"

    invoke-virtual {v6, p0, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    return-object v6
.end method

.method private static clamp(F)F
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

.method private static clampD(D)D
    .registers 5

    const-wide/16 v0, 0x0

    cmpg-double v2, p0, v0

    if-gez v2, :cond_8

    :goto_6
    move-wide p0, v0

    goto :goto_f

    :cond_8
    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    cmpl-double v2, p0, v0

    if-lez v2, :cond_f

    goto :goto_6

    :cond_f
    :goto_f
    return-wide p0
.end method

.method static clear()V
    .registers 1

    const/4 v0, 0x0

    sput-object v0, Lradiant/RLKaraoke;->breakStart:[J

    sput-object v0, Lradiant/RLKaraoke;->breakEnd:[J

    return-void
.end method

.method private static dotSize()Landroidx/compose/ui/text/SpanStyle;
    .registers 24

    const v0, 0x3f19999a    # 0.6f

    invoke-static {v0}, Landroidx/compose/ui/unit/TextUnitKt;->getEm(F)J

    move-result-wide v4

    const v0, 0x3e19999a    # 0.15f

    invoke-static {v0}, Landroidx/compose/ui/unit/TextUnitKt;->getEm(F)J

    move-result-wide v11

    new-instance v1, Landroidx/compose/ui/text/SpanStyle;

    const v22, 0xff7d

    const/16 v23, 0x0

    const-wide/16 v2, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const-wide/16 v16, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    const/16 v21, 0x0

    invoke-direct/range {v1 .. v23}, Landroidx/compose/ui/text/SpanStyle;-><init>(JJLandroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontSynthesis;Landroidx/compose/ui/text/font/FontFamily;Ljava/lang/String;JLandroidx/compose/ui/text/style/BaselineShift;Landroidx/compose/ui/text/style/TextGeometricTransform;Landroidx/compose/ui/text/intl/LocaleList;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/graphics/Shadow;Landroidx/compose/ui/text/PlatformSpanStyle;Landroidx/compose/ui/graphics/drawscope/DrawStyle;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v1
.end method

.method static dots()Z
    .registers 1

    invoke-static {}, Lradiant/RLDefaults;->dots()I

    move-result v0

    if-eqz v0, :cond_8

    const/4 v0, 0x1

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    :goto_9
    return v0
.end method

.method private static emOf(I)F
    .registers 2

    invoke-static {p0}, Lradiant/SylLayout;->get(I)Landroidx/compose/ui/text/TextLayoutResult;

    move-result-object p0

    if-eqz p0, :cond_12

    invoke-static {p0}, Lradiant/SylLayout;->em(Landroidx/compose/ui/text/TextLayoutResult;)F

    move-result p0

    const/4 v0, 0x0

    cmpl-float v0, p0, v0

    if-lez v0, :cond_11

    sput p0, Lradiant/RLKaraoke;->lastEm:F

    :cond_11
    return p0

    :cond_12
    sget p0, Lradiant/RLKaraoke;->lastEm:F

    return p0
.end method

.method private static endOf(Lorg/json/JSONObject;J)J
    .registers 10

    const-string v0, "syllabus"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_32

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_32

    const/4 p0, 0x0

    :goto_f
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-ge p0, v1, :cond_31

    invoke-virtual {v0, p0}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_2e

    const-string v2, "time"

    const-wide/16 v3, 0x0

    invoke-virtual {v1, v2, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v5

    const-string v2, "duration"

    invoke-virtual {v1, v2, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    add-long/2addr v5, v1

    invoke-static {p1, p2, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    :cond_2e
    add-int/lit8 p0, p0, 0x1

    goto :goto_f

    :cond_31
    return-wide p1

    :cond_32
    const-string v0, "endTime"

    const-wide/high16 v1, -0x4010000000000000L    # -1.0

    invoke-virtual {p0, v0, v1, v2}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmpg-double p0, v0, v2

    if-gez p0, :cond_41

    goto :goto_4f

    :cond_41
    const-wide v2, 0x408f400000000000L    # 1000.0

    mul-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    invoke-static {p1, p2, v0, v1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    :goto_4f
    return-wide p1
.end method

.method private static fx(Landroidx/compose/ui/text/AnnotatedString$Builder;ILjava/lang/String;[Ljava/lang/String;[J[J[Z[I[IIJZJZIJ)V
    .registers 50

    move-object/from16 v0, p0

    move/from16 v1, p1

    move-object/from16 v2, p6

    move/from16 v3, p9

    move/from16 v4, p16

    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->length()I

    move-result v5

    new-array v6, v5, [F

    new-array v7, v5, [F

    new-array v8, v5, [F

    if-eqz p12, :cond_19

    move-wide/from16 v16, p10

    goto :goto_1b

    :cond_19
    move-wide/from16 v16, p13

    :goto_1b
    const/4 v9, 0x0

    if-eqz p12, :cond_20

    move v10, v9

    goto :goto_23

    :cond_20
    sub-long v10, p10, p13

    long-to-float v10, v10

    :goto_23
    const/high16 v11, 0x3f800000    # 1.0f

    if-eqz p12, :cond_2a

    move/from16 v18, v11

    goto :goto_40

    :cond_2a
    const/high16 v12, 0x442f0000    # 700.0f

    div-float v12, v10, v12

    invoke-static {v12}, Lradiant/RLKaraoke;->clamp(F)F

    move-result v12

    const v13, 0x3e6147ae    # 0.22f

    const v14, 0x3eb851ec    # 0.36f

    invoke-static {v12, v13, v11, v14, v11}, Lradiant/RLKaraoke;->bezier(FFFFF)F

    move-result v12

    sub-float v12, v11, v12

    move/from16 v18, v12

    :goto_40
    if-eqz p12, :cond_44

    move v12, v11

    goto :goto_57

    :cond_44
    const/high16 v12, 0x44160000    # 600.0f

    div-float v12, v10, v12

    invoke-static {v12}, Lradiant/RLKaraoke;->clamp(F)F

    move-result v12

    const v13, 0x3dcccccd    # 0.1f

    const/high16 v14, 0x3e800000    # 0.25f

    invoke-static {v12, v14, v13, v14, v11}, Lradiant/RLKaraoke;->bezier(FFFFF)F

    move-result v12

    sub-float v12, v11, v12

    :goto_57
    if-eqz p12, :cond_5c

    move/from16 v19, v11

    goto :goto_6e

    :cond_5c
    const/high16 v13, 0x43960000    # 300.0f

    div-float/2addr v10, v13

    invoke-static {v10}, Lradiant/RLKaraoke;->clamp(F)F

    move-result v10

    const v13, 0x3f147ae1    # 0.58f

    invoke-static {v10, v9, v9, v13, v11}, Lradiant/RLKaraoke;->bezier(FFFFF)F

    move-result v10

    sub-float v10, v11, v10

    move/from16 v19, v10

    :goto_6e
    const-wide/16 v13, 0x1

    const/16 v23, 0x0

    if-lez v4, :cond_e6

    cmpl-float v10, v12, v9

    if-lez v10, :cond_e6

    int-to-float v4, v4

    const/high16 v10, 0x41a00000    # 20.0f

    div-float/2addr v4, v10

    const v10, 0x3ee66666    # 0.45f

    mul-float/2addr v10, v4

    invoke-static {v11, v10}, Ljava/lang/Math;->min(FF)F

    move-result v10

    const v15, 0x3ecccccd    # 0.4f

    mul-float/2addr v4, v15

    const v15, 0x3f19999a    # 0.6f

    add-float/2addr v4, v15

    const/high16 v15, 0x40200000    # 2.5f

    invoke-static {v15, v4}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const v15, 0x3e99999a    # 0.3f

    mul-float/2addr v4, v15

    move/from16 v15, v23

    :goto_98
    if-ge v15, v3, :cond_e6

    move/from16 v20, v9

    move/from16 p10, v10

    aget-wide v9, p5, v15

    invoke-static {v13, v14, v9, v10}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v9

    aget-wide v21, p4, v15

    add-long v21, v21, v9

    cmp-long v21, v16, v21

    if-ltz v21, :cond_af

    move/from16 p13, v12

    goto :goto_c3

    :cond_af
    aget-wide v21, p4, v15

    cmp-long v21, v16, v21

    if-ltz v21, :cond_bf

    aget-wide v21, p4, v15

    move/from16 p13, v12

    sub-long v11, v16, v21

    long-to-float v11, v11

    long-to-float v9, v9

    div-float/2addr v11, v9

    goto :goto_c3

    :cond_bf
    move/from16 p13, v12

    move/from16 v11, v20

    :goto_c3
    cmpg-float v9, v11, v20

    if-gtz v9, :cond_c8

    goto :goto_db

    :cond_c8
    aget v9, p7, v15

    :goto_ca
    aget v10, p8, v15

    if-ge v9, v10, :cond_db

    if-ge v9, v5, :cond_db

    mul-float v10, p10, v11

    mul-float v10, v10, p13

    aput v10, v7, v9

    aput v4, v8, v9

    add-int/lit8 v9, v9, 0x1

    goto :goto_ca

    :cond_db
    :goto_db
    add-int/lit8 v15, v15, 0x1

    move/from16 v10, p10

    move/from16 v12, p13

    move/from16 v9, v20

    const/high16 v11, 0x3f800000    # 1.0f

    goto :goto_98

    :cond_e6
    move/from16 v20, v9

    if-eqz p15, :cond_21b

    sget-object v4, Lradiant/WordLyrics;->lineSylBg:[[Z

    if-eqz v4, :cond_f4

    array-length v9, v4

    if-ge v1, v9, :cond_f4

    aget-object v4, v4, v1

    goto :goto_f5

    :cond_f4
    const/4 v4, 0x0

    :goto_f5
    move/from16 v9, v23

    :goto_f7
    const/4 v10, 0x2

    if-ge v9, v10, :cond_21b

    const/4 v10, 0x1

    if-ne v9, v10, :cond_ff

    move v11, v10

    goto :goto_101

    :cond_ff
    move/from16 v11, v23

    :goto_101
    if-eqz v11, :cond_107

    if-nez v2, :cond_107

    goto/16 :goto_21b

    :cond_107
    move/from16 v12, v20

    move-object/from16 v20, v6

    new-array v6, v3, [I

    move/from16 p10, v10

    move/from16 v10, v23

    move v15, v10

    :goto_112
    if-ge v15, v3, :cond_123

    invoke-static {v2, v15, v11}, Lradiant/RLKaraoke;->inGroup([ZIZ)Z

    move-result v21

    if-eqz v21, :cond_120

    add-int/lit8 v21, v10, 0x1

    aput v15, v6, v10

    move/from16 v10, v21

    :cond_120
    add-int/lit8 v15, v15, 0x1

    goto :goto_112

    :cond_123
    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    move/from16 v12, v23

    move v15, v12

    :goto_12b
    if-ge v15, v10, :cond_15b

    aget v21, v6, v15

    move-wide/from16 p12, v13

    aget-object v13, p3, v21

    add-int/lit8 v14, v10, -0x1

    if-eq v15, v14, :cond_14d

    invoke-virtual {v13}, Ljava/lang/String;->length()I

    move-result v14

    if-lez v14, :cond_156

    invoke-virtual {v13}, Ljava/lang/String;->length()I

    move-result v14

    add-int/lit8 v14, v14, -0x1

    invoke-virtual {v13, v14}, Ljava/lang/String;->charAt(I)C

    move-result v13

    invoke-static {v13}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v13

    if-eqz v13, :cond_156

    :cond_14d
    filled-new-array {v12, v15}, [I

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v12, v15, 0x1

    :cond_156
    add-int/lit8 v15, v15, 0x1

    move-wide/from16 v13, p12

    goto :goto_12b

    :cond_15b
    move-wide/from16 p12, v13

    move/from16 v10, v23

    :goto_15f
    invoke-virtual {v11}, Ljava/util/ArrayList;->size()I

    move-result v12

    if-ge v10, v12, :cond_203

    invoke-virtual {v11, v10}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, [I

    aget v13, v12, v23

    aget v13, v6, v13

    aget-wide v13, p4, v13

    add-long v1, v13, p12

    aget v15, v12, v23

    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-wide v6, v1

    :goto_17a
    aget v3, v12, p10

    if-gt v15, v3, :cond_195

    aget v3, v22, v15

    aget-wide v24, p4, v3

    aget v3, v22, v15

    aget-wide v26, p5, v3

    move-object v3, v8

    move/from16 p14, v9

    add-long v8, v24, v26

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v6

    add-int/lit8 v15, v15, 0x1

    move/from16 v9, p14

    move-object v8, v3

    goto :goto_17a

    :cond_195
    move-object v3, v8

    move/from16 p14, v9

    add-int/lit8 v8, v10, 0x1

    invoke-virtual {v11}, Ljava/util/ArrayList;->size()I

    move-result v9

    if-ge v8, v9, :cond_1b8

    invoke-virtual {v11, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [I

    aget v9, v9, v23

    aget v9, v22, v9

    aget-wide v9, p4, v9

    cmp-long v15, v9, v13

    if-lez v15, :cond_1b8

    invoke-static {v6, v7, v9, v10}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    invoke-static {v1, v2, v6, v7}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v6

    :cond_1b8
    if-eqz v4, :cond_1ce

    aget v1, v12, v23

    aget v1, v22, v1

    array-length v2, v4

    if-ge v1, v2, :cond_1ce

    aget v1, v12, v23

    aget v1, v22, v1

    aget-boolean v1, v4, v1

    if-eqz v1, :cond_1ce

    move/from16 v15, p10

    move/from16 v26, v15

    goto :goto_1d2

    :cond_1ce
    move/from16 v26, p10

    move/from16 v15, v23

    :goto_1d2
    move-object/from16 v10, p2

    move-object/from16 v9, p8

    move-wide/from16 v24, p12

    move/from16 v2, p14

    move/from16 p10, v8

    const/4 v1, 0x0

    move-object/from16 v8, p7

    move-object/from16 v28, v22

    move-object/from16 v22, v3

    move-object v3, v11

    move-wide/from16 v29, v6

    move-object v7, v12

    move-wide v11, v13

    move-object/from16 v6, v28

    move-wide/from16 v13, v29

    invoke-static/range {v6 .. v22}, Lradiant/RLKaraoke;->lift([I[I[I[ILjava/lang/String;JJZJFF[F[F[F)V

    move/from16 v1, p1

    move/from16 v10, p10

    move v9, v2

    move-object v11, v3

    move-object/from16 v7, v21

    move-object/from16 v8, v22

    move-wide/from16 p12, v24

    move/from16 p10, v26

    move-object/from16 v2, p6

    move/from16 v3, p9

    goto/16 :goto_15f

    :cond_203
    move-wide/from16 v24, p12

    move-object/from16 v21, v7

    move-object/from16 v22, v8

    move v2, v9

    const/4 v1, 0x0

    add-int/lit8 v9, v2, 0x1

    move-object/from16 v2, p6

    move/from16 v3, p9

    move-object/from16 v6, v20

    move-wide/from16 v13, v24

    move/from16 v20, v1

    move/from16 v1, p1

    goto/16 :goto_f7

    :cond_21b
    :goto_21b
    move-object/from16 v21, v7

    move-object/from16 v22, v8

    move/from16 v1, v20

    move-object/from16 v20, v6

    invoke-static/range {p1 .. p1}, Lradiant/RLKaraoke;->emOf(I)F

    move-result v2

    move/from16 v3, v23

    :goto_229
    if-ge v3, v5, :cond_25f

    aget v4, v20, v3

    invoke-static {v1, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    const/high16 v6, 0x43c80000    # 400.0f

    mul-float/2addr v4, v6

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    int-to-float v4, v4

    div-float/2addr v4, v6

    add-int/lit8 v7, v3, 0x1

    :goto_23c
    if-ge v7, v5, :cond_252

    aget v8, v20, v7

    invoke-static {v1, v8}, Ljava/lang/Math;->max(FF)F

    move-result v8

    mul-float/2addr v8, v6

    invoke-static {v8}, Ljava/lang/Math;->round(F)I

    move-result v8

    int-to-float v8, v8

    div-float/2addr v8, v6

    cmpl-float v8, v8, v4

    if-nez v8, :cond_252

    add-int/lit8 v7, v7, 0x1

    goto :goto_23c

    :cond_252
    cmpl-float v6, v4, v1

    if-lez v6, :cond_25d

    invoke-static {v4}, Lradiant/RLKaraoke;->shiftSpan(F)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v4

    invoke-virtual {v0, v4, v3, v7}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :cond_25d
    move v3, v7

    goto :goto_229

    :cond_25f
    cmpg-float v3, v2, v1

    if-gtz v3, :cond_264

    return-void

    :cond_264
    move/from16 v3, v23

    :goto_266
    if-ge v3, v5, :cond_2b6

    aget v4, v21, v3

    const/high16 v6, 0x42800000    # 64.0f

    mul-float/2addr v4, v6

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    int-to-float v4, v4

    div-float/2addr v4, v6

    aget v7, v22, v3

    const/high16 v8, 0x42200000    # 40.0f

    mul-float/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Math;->round(F)I

    move-result v7

    int-to-float v7, v7

    div-float/2addr v7, v8

    add-int/lit8 v9, v3, 0x1

    :goto_280
    if-ge v9, v5, :cond_29f

    aget v10, v21, v9

    mul-float/2addr v10, v6

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v10

    int-to-float v10, v10

    div-float/2addr v10, v6

    cmpl-float v10, v10, v4

    if-nez v10, :cond_29f

    aget v10, v22, v9

    mul-float/2addr v10, v8

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v10

    int-to-float v10, v10

    div-float/2addr v10, v8

    cmpl-float v10, v10, v7

    if-nez v10, :cond_29f

    add-int/lit8 v9, v9, 0x1

    goto :goto_280

    :cond_29f
    cmpl-float v6, v4, v1

    if-lez v6, :cond_2b2

    cmpl-float v6, v7, v1

    if-lez v6, :cond_2b2

    mul-float/2addr v7, v2

    move-wide/from16 v10, p17

    invoke-static {v10, v11, v4, v7}, Lradiant/RLKaraoke;->glowSpan(JFF)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v4

    invoke-virtual {v0, v4, v3, v9}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    goto :goto_2b4

    :cond_2b2
    move-wide/from16 v10, p17

    :goto_2b4
    move v3, v9

    goto :goto_266

    :cond_2b6
    return-void
.end method

.method static glow()I
    .registers 1

    invoke-static {}, Lradiant/RLDefaults;->glowOn()I

    move-result v0

    if-eqz v0, :cond_b

    invoke-static {}, Lradiant/RLDefaults;->glow()I

    move-result v0

    goto :goto_c

    :cond_b
    const/4 v0, 0x0

    :goto_c
    return v0
.end method

.method public static glowLine(IILjava/lang/String;J)Landroidx/compose/ui/text/AnnotatedString;
    .registers 9

    new-instance v0, Landroidx/compose/ui/text/AnnotatedString$Builder;

    if-nez p2, :cond_7

    const-string v1, ""

    goto :goto_8

    :cond_7
    move-object v1, p2

    :goto_8
    invoke-direct {v0, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lradiant/RLKaraoke;->glow()I

    move-result v1

    const/4 v2, 0x0

    if-nez p2, :cond_14

    move p2, v2

    goto :goto_18

    :cond_14
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p2

    :goto_18
    if-lez v1, :cond_51

    if-ltz p0, :cond_51

    if-ne p0, p1, :cond_51

    if-lez p2, :cond_51

    invoke-static {p0}, Lradiant/RLKaraoke;->emOf(I)F

    move-result p0

    const/4 p1, 0x0

    cmpl-float p1, p0, p1

    if-lez p1, :cond_51

    int-to-float p1, v1

    const/high16 v1, 0x41a00000    # 20.0f

    div-float/2addr p1, v1

    const v1, 0x3ee66666    # 0.45f

    mul-float/2addr v1, p1

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    const v3, 0x3ecccccd    # 0.4f

    mul-float/2addr p1, v3

    const v3, 0x3f19999a    # 0.6f

    add-float/2addr p1, v3

    const/high16 v3, 0x40200000    # 2.5f

    invoke-static {v3, p1}, Ljava/lang/Math;->min(FF)F

    move-result p1

    const v3, 0x3e99999a    # 0.3f

    mul-float/2addr p1, v3

    mul-float/2addr p1, p0

    invoke-static {p3, p4, v1, p1}, Lradiant/RLKaraoke;->glowSpan(JFF)Landroidx/compose/ui/text/SpanStyle;

    move-result-object p0

    invoke-virtual {v0, p0, v2, p2}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :cond_51
    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object p0

    return-object p0
.end method

.method private static glowSpan(JFF)Landroidx/compose/ui/text/SpanStyle;
    .registers 27

    new-instance v0, Landroidx/compose/ui/graphics/Shadow;

    invoke-static/range {p0 .. p2}, Lradiant/RLKaraoke;->withAlpha(JF)J

    move-result-wide v1

    const v3, 0x3f5db22d    # 0.866f

    mul-float v3, v3, p3

    const/high16 v4, 0x3f000000    # 0.5f

    invoke-static {v4, v3}, Ljava/lang/Math;->max(FF)F

    move-result v5

    const/4 v6, 0x0

    const-wide/16 v3, 0x0

    invoke-direct/range {v0 .. v6}, Landroidx/compose/ui/graphics/Shadow;-><init>(JJFLkotlin/jvm/internal/DefaultConstructorMarker;)V

    new-instance v1, Landroidx/compose/ui/text/SpanStyle;

    const v21, 0xdfff

    const/16 v22, 0x0

    move-object/from16 v18, v0

    move-object v0, v1

    const-wide/16 v1, 0x0

    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-wide/16 v10, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const-wide/16 v15, 0x0

    const/16 v17, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    invoke-direct/range {v0 .. v22}, Landroidx/compose/ui/text/SpanStyle;-><init>(JJLandroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontSynthesis;Landroidx/compose/ui/text/font/FontFamily;Ljava/lang/String;JLandroidx/compose/ui/text/style/BaselineShift;Landroidx/compose/ui/text/style/TextGeometricTransform;Landroidx/compose/ui/text/intl/LocaleList;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/graphics/Shadow;Landroidx/compose/ui/text/PlatformSpanStyle;Landroidx/compose/ui/graphics/drawscope/DrawStyle;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v0
.end method

.method public static glowWord(ILandroidx/compose/ui/text/AnnotatedString;)Landroidx/compose/ui/text/AnnotatedString;
    .registers 21

    move-object/from16 v0, p1

    invoke-static {}, Lradiant/RLKaraoke;->glow()I

    move-result v1

    if-lez v1, :cond_e3

    if-eqz v0, :cond_e3

    sget-boolean v2, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-eqz v2, :cond_e3

    sget v2, Lradiant/WordLyrics;->pLineIdx:I

    move/from16 v3, p0

    if-eq v2, v3, :cond_16

    goto/16 :goto_e3

    :cond_16
    sget v2, Lradiant/WordLyrics;->pN:I

    sget-object v4, Lradiant/WordLyrics;->pStarts:[J

    sget-object v5, Lradiant/WordLyrics;->pBeg:[I

    sget-object v6, Lradiant/WordLyrics;->pVis:[I

    sget-object v7, Lradiant/WordLyrics;->pBg:[Z

    if-eqz v4, :cond_e3

    if-eqz v5, :cond_e3

    if-eqz v6, :cond_e3

    array-length v8, v4

    if-lt v8, v2, :cond_e3

    array-length v8, v5

    if-lt v8, v2, :cond_e3

    array-length v8, v6

    if-lt v8, v2, :cond_e3

    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString;->getLength()I

    move-result v8

    sget v9, Lradiant/WordLyrics;->pTotal:I

    if-ne v8, v9, :cond_e3

    invoke-static {v3}, Lradiant/WordLyrics;->isActiveLine(I)Z

    move-result v8

    if-nez v8, :cond_3f

    goto/16 :goto_e3

    :cond_3f
    invoke-static {v3}, Lradiant/RLKaraoke;->emOf(I)F

    move-result v3

    const/4 v8, 0x0

    cmpg-float v8, v3, v8

    if-gtz v8, :cond_49

    return-object v0

    :cond_49
    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v13

    int-to-float v1, v1

    const/high16 v8, 0x41a00000    # 20.0f

    div-float/2addr v1, v8

    const v8, 0x3ee66666    # 0.45f

    mul-float/2addr v8, v1

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-static {v9, v8}, Ljava/lang/Math;->min(FF)F

    move-result v8

    const v9, 0x3ecccccd    # 0.4f

    mul-float/2addr v1, v9

    const v9, 0x3f19999a    # 0.6f

    add-float/2addr v1, v9

    const/high16 v9, 0x40200000    # 2.5f

    invoke-static {v9, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    const v9, 0x3e99999a    # 0.3f

    mul-float/2addr v1, v9

    mul-float/2addr v1, v3

    const/4 v9, 0x0

    move-object v15, v9

    const/4 v9, 0x0

    :goto_71
    const/4 v10, 0x2

    if-ge v9, v10, :cond_dc

    const/4 v10, 0x1

    if-ne v9, v10, :cond_78

    goto :goto_79

    :cond_78
    const/4 v10, 0x0

    :goto_79
    const/4 v11, -0x1

    move/from16 v16, v11

    const/4 v11, 0x0

    :goto_7d
    if-ge v11, v2, :cond_92

    invoke-static {v7, v11, v10}, Lradiant/RLKaraoke;->inGroup([ZIZ)Z

    move-result v12

    if-nez v12, :cond_86

    goto :goto_8f

    :cond_86
    aget-wide v17, v4, v11

    cmp-long v12, v17, v13

    if-lez v12, :cond_8d

    goto :goto_92

    :cond_8d
    move/from16 v16, v11

    :goto_8f
    add-int/lit8 v11, v11, 0x1

    goto :goto_7d

    :cond_92
    :goto_92
    if-gez v16, :cond_96

    move v3, v9

    goto :goto_d9

    :cond_96
    aget-wide v11, v4, v16

    const-wide/16 v17, 0x320

    add-long v11, v11, v17

    add-int/lit8 v17, v16, 0x1

    move/from16 v3, v17

    :goto_a0
    if-ge v3, v2, :cond_ad

    invoke-static {v7, v3, v10}, Lradiant/RLKaraoke;->inGroup([ZIZ)Z

    move-result v17

    if-nez v17, :cond_ab

    add-int/lit8 v3, v3, 0x1

    goto :goto_a0

    :cond_ab
    aget-wide v11, v4, v3

    :cond_ad
    aget-wide v17, v4, v16

    move v3, v9

    move-wide/from16 v9, v17

    invoke-static/range {v9 .. v14}, Lradiant/WordLyrics;->bump(JJJ)F

    move-result v9

    const v10, 0x3c23d70a    # 0.01f

    cmpg-float v10, v9, v10

    if-lez v10, :cond_d9

    aget v10, v6, v16

    aget v11, v5, v16

    if-gt v10, v11, :cond_c4

    goto :goto_d9

    :cond_c4
    if-nez v15, :cond_cb

    new-instance v15, Landroidx/compose/ui/text/AnnotatedString$Builder;

    invoke-direct {v15, v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Landroidx/compose/ui/text/AnnotatedString;)V

    :cond_cb
    sget-wide v10, Lradiant/WordLyrics;->tmpSung:J

    mul-float/2addr v9, v8

    invoke-static {v10, v11, v9, v1}, Lradiant/RLKaraoke;->glowSpan(JFF)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v9

    aget v10, v5, v16

    aget v11, v6, v16

    invoke-virtual {v15, v9, v10, v11}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :cond_d9
    :goto_d9
    add-int/lit8 v9, v3, 0x1

    goto :goto_71

    :cond_dc
    if-nez v15, :cond_df

    goto :goto_e3

    :cond_df
    invoke-virtual {v15}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    :cond_e3
    :goto_e3
    return-object v0
.end method

.method private static inGroup([ZIZ)Z
    .registers 5

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-nez p0, :cond_7

    if-nez p2, :cond_c

    goto :goto_d

    :cond_7
    aget-boolean p0, p0, p1

    if-ne p0, p2, :cond_c

    goto :goto_d

    :cond_c
    move v0, v1

    :goto_d
    return v0
.end method

.method private static lift([I[I[I[ILjava/lang/String;JJZJFF[F[F[F)V
    .registers 43

    sub-long v0, p10, p5

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_9

    return-void

    :cond_9
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/text/BreakIterator;->getCharacterInstance()Ljava/text/BreakIterator;

    move-result-object v4

    const/4 v5, 0x0

    aget v6, p1, v5

    :goto_1a
    const/4 v7, 0x1

    aget v8, p1, v7

    if-gt v6, v8, :cond_5a

    aget v7, p0, v6

    aget v8, p2, v7

    aget v7, p3, v7

    invoke-virtual/range {p4 .. p4}, Ljava/lang/String;->length()I

    move-result v9

    invoke-static {v7, v9}, Ljava/lang/Math;->min(II)I

    move-result v7

    move-object/from16 v9, p4

    if-gt v7, v8, :cond_32

    goto :goto_57

    :cond_32
    invoke-virtual {v9, v8, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v7}, Ljava/text/BreakIterator;->setText(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/text/BreakIterator;->first()I

    move-result v7

    :goto_40
    invoke-virtual {v4}, Ljava/text/BreakIterator;->next()I

    move-result v10

    move/from16 v25, v10

    move v10, v7

    move/from16 v7, v25

    const/4 v11, -0x1

    if-eq v7, v11, :cond_57

    add-int/2addr v10, v8

    add-int v11, v8, v7

    filled-new-array {v10, v11}, [I

    move-result-object v10

    invoke-virtual {v2, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_40

    :cond_57
    :goto_57
    add-int/lit8 v6, v6, 0x1

    goto :goto_1a

    :cond_5a
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-nez v4, :cond_61

    return-void

    :cond_61
    const-wide/16 v8, 0x1

    sub-long v10, p7, p5

    invoke-static {v8, v9, v10, v11}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v8

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move/from16 v6, p9

    invoke-static {v3, v4, v8, v9, v6}, Lradiant/RLKaraoke;->modeOf(Ljava/lang/String;IJZ)I

    move-result v3

    const-wide v10, 0x408f400000000000L    # 1000.0

    const-wide/high16 v12, 0x3ff0000000000000L    # 1.0

    if-nez v3, :cond_b4

    const-wide/16 v3, 0x7d0

    cmp-long v3, v0, v3

    if-ltz v3, :cond_85

    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_8d

    :cond_85
    long-to-double v0, v0

    div-double/2addr v0, v10

    invoke-static {v0, v1}, Lradiant/RLKaraoke;->spring(D)D

    move-result-wide v0

    sub-double/2addr v12, v0

    double-to-float v0, v12

    :goto_8d
    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const v1, 0x3da3d70a    # 0.08f

    mul-float/2addr v0, v1

    mul-float v0, v0, p12

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_9c
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_b3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    aget v3, v2, v5

    :goto_aa
    aget v4, v2, v7

    if-ge v3, v4, :cond_9c

    aput v0, p14, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_aa

    :cond_b3
    return-void

    :cond_b4
    const/4 v6, 0x2

    if-ne v3, v6, :cond_b9

    move v3, v7

    goto :goto_ba

    :cond_b9
    move v3, v5

    :goto_ba
    long-to-double v8, v8

    div-double/2addr v8, v10

    const-wide v14, 0x3f50624dd2f1a9fcL    # 0.001

    invoke-static {v14, v15, v8, v9}, Ljava/lang/Math;->max(DD)D

    move-result-wide v8

    mul-double v14, v8, v10

    move/from16 p10, v5

    int-to-double v5, v4

    div-double/2addr v14, v5

    if-eqz v3, :cond_d3

    const-wide v16, 0x3fd999999999999aL    # 0.4

    goto :goto_d8

    :cond_d3
    const-wide v16, 0x3fd6666666666666L    # 0.35

    :goto_d8
    mul-double v14, v14, v16

    if-eqz v3, :cond_eb

    const-wide/high16 v16, 0x4069000000000000L    # 200.0

    move-wide/from16 p0, v10

    div-double v10, v16, v5

    move-wide/from16 p2, v12

    const-wide/high16 v12, 0x4049000000000000L    # 50.0

    invoke-static {v12, v13, v10, v11}, Ljava/lang/Math;->min(DD)D

    move-result-wide v10

    goto :goto_f4

    :cond_eb
    move-wide/from16 p0, v10

    move-wide/from16 p2, v12

    const-wide v10, 0x4075e00000000000L    # 350.0

    :goto_f4
    invoke-static {v14, v15, v10, v11}, Ljava/lang/Math;->min(DD)D

    move-result-wide v10

    const-wide/high16 v12, 0x4000000000000000L    # 2.0

    mul-double v14, v8, v12

    div-double/2addr v14, v5

    const-wide/high16 v5, 0x4008000000000000L    # 3.0

    move-wide/from16 p4, v12

    invoke-static {v5, v6, v8, v9}, Ljava/lang/Math;->min(DD)D

    move-result-wide v12

    if-eqz v3, :cond_10a

    const-wide/16 v16, 0x0

    goto :goto_110

    :cond_10a
    sub-double v16, v8, p2

    invoke-static/range {v16 .. v17}, Lradiant/RLKaraoke;->clampD(D)D

    move-result-wide v16

    :goto_110
    if-eqz v3, :cond_115

    const-wide/16 v8, 0x0

    goto :goto_126

    :cond_115
    sub-double v8, v8, p2

    const-wide/high16 v18, 0x3fe0000000000000L    # 0.5

    div-double v8, v8, v18

    invoke-static {v8, v9}, Lradiant/RLKaraoke;->clampD(D)D

    move-result-wide v8

    const-wide v18, 0x3fdccccccccccccdL    # 0.45

    mul-double v8, v8, v18

    :goto_126
    mul-double v18, v12, p4

    move/from16 p11, v7

    move-wide/from16 p4, v8

    add-double v7, v14, v18

    if-eqz v3, :cond_133

    const-wide/high16 v5, 0x4008000000000000L    # 3.0

    goto :goto_135

    :cond_133
    const-wide/16 v5, 0x0

    :goto_135
    const-wide/16 p6, 0x0

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->max(DD)D

    move-result-wide v5

    move/from16 v7, p10

    :goto_13d
    if-ge v7, v4, :cond_1d1

    long-to-double v8, v0

    move-wide/from16 v18, v0

    add-int/lit8 v0, v7, 0x1

    move/from16 p8, v3

    move v1, v4

    int-to-double v3, v0

    mul-double/2addr v3, v10

    sub-double/2addr v8, v3

    div-double v8, v8, p0

    cmpg-double v3, v8, p6

    if-gez v3, :cond_15a

    move-wide/from16 v3, p6

    move-wide v8, v3

    :goto_153
    move-wide/from16 v20, v8

    move/from16 p9, v0

    move/from16 v22, v1

    goto :goto_189

    :cond_15a
    cmpl-double v3, v8, v5

    if-ltz v3, :cond_163

    move-wide/from16 v3, p2

    move-wide/from16 v8, p6

    goto :goto_153

    :cond_163
    if-eqz p8, :cond_16c

    invoke-static {v8, v9}, Lradiant/RLKaraoke;->spring(D)D

    move-result-wide v3

    sub-double v3, p2, v3

    goto :goto_170

    :cond_16c
    invoke-static {v8, v9, v12, v13}, Lradiant/RLKaraoke;->ramp(DD)D

    move-result-wide v3

    :goto_170
    invoke-static {v8, v9, v12, v13}, Lradiant/RLKaraoke;->ramp(DD)D

    move-result-wide v20

    move/from16 p9, v0

    move/from16 v22, v1

    sub-double v0, v8, v14

    invoke-static {v0, v1, v12, v13}, Lradiant/RLKaraoke;->ramp(DD)D

    move-result-wide v0

    sub-double v0, p2, v0

    mul-double v20, v20, v0

    div-double/2addr v8, v5

    invoke-static {v8, v9}, Lradiant/RLKaraoke;->shineCurve(D)D

    move-result-wide v0

    mul-double v8, p4, v0

    :goto_189
    move-wide/from16 v0, p6

    const-wide v23, 0x3fb47ae140000000L    # 0.07999999821186066

    invoke-static {v0, v1, v3, v4}, Ljava/lang/Math;->max(DD)D

    move-result-wide v3

    mul-double v3, v3, v23

    const-wide v23, 0x3fa47ae140000000L    # 0.03999999910593033

    mul-double v23, v23, v16

    mul-double v23, v23, v20

    add-double v3, v3, v23

    double-to-float v3, v3

    mul-float v3, v3, p12

    double-to-float v4, v8

    mul-float v4, v4, p13

    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [I

    aget v8, v7, p10

    :goto_1af
    aget v9, v7, p11

    if-ge v8, v9, :cond_1c5

    aput v3, p14, v8

    aget v9, p15, v8

    cmpl-float v9, v4, v9

    if-lez v9, :cond_1c2

    aput v4, p15, v8

    const v9, 0x3e99999a    # 0.3f

    aput v9, p16, v8

    :cond_1c2
    add-int/lit8 v8, v8, 0x1

    goto :goto_1af

    :cond_1c5
    move/from16 v3, p8

    move/from16 v7, p9

    move-wide/from16 p6, v0

    move-wide/from16 v0, v18

    move/from16 v4, v22

    goto/16 :goto_13d

    :cond_1d1
    return-void
.end method

.method static load(Lorg/json/JSONArray;)V
    .registers 12

    if-nez p0, :cond_6

    invoke-static {}, Lradiant/RLKaraoke;->clear()V

    return-void

    :cond_6
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    new-array v1, v0, [J

    new-array v2, v0, [J

    const/4 v3, 0x0

    move v4, v3

    move v5, v4

    :goto_11
    if-ge v4, v0, :cond_50

    invoke-virtual {p0, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    const-wide/16 v7, -0x1

    aput-wide v7, v1, v4

    aput-wide v7, v2, v4

    if-eqz v6, :cond_4d

    const-string v9, "_rlBreak"

    invoke-virtual {v6, v9, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v9

    if-nez v9, :cond_28

    goto :goto_4d

    :cond_28
    const-string v9, "_rlFrom"

    invoke-virtual {v6, v9, v7, v8}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v9

    aput-wide v9, v1, v4

    const-string v9, "_rlTo"

    invoke-virtual {v6, v9, v7, v8}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v6

    aput-wide v6, v2, v4

    aget-wide v6, v1, v4

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-ltz v6, :cond_48

    aget-wide v6, v2, v4

    aget-wide v8, v1, v4

    cmp-long v6, v6, v8

    if-gtz v6, :cond_4a

    :cond_48
    if-eqz v5, :cond_4c

    :cond_4a
    const/4 v5, 0x1

    goto :goto_4d

    :cond_4c
    move v5, v3

    :cond_4d
    :goto_4d
    add-int/lit8 v4, v4, 0x1

    goto :goto_11

    :cond_50
    const/4 p0, 0x0

    if-eqz v5, :cond_54

    goto :goto_55

    :cond_54
    move-object v1, p0

    :goto_55
    sput-object v1, Lradiant/RLKaraoke;->breakStart:[J

    if-eqz v5, :cond_5a

    goto :goto_5b

    :cond_5a
    move-object v2, p0

    :goto_5b
    sput-object v2, Lradiant/RLKaraoke;->breakEnd:[J

    return-void
.end method

.method private static measure(I)V
    .registers 10

    invoke-static {p0}, Lradiant/SylLayout;->get(I)Landroidx/compose/ui/text/TextLayoutResult;

    move-result-object p0

    if-nez p0, :cond_7

    return-void

    :cond_7
    invoke-virtual {p0}, Landroidx/compose/ui/text/TextLayoutResult;->getLayoutInput()Landroidx/compose/ui/text/TextLayoutInput;

    move-result-object p0

    invoke-virtual {p0}, Landroidx/compose/ui/text/TextLayoutInput;->getStyle()Landroidx/compose/ui/text/TextStyle;

    move-result-object p0

    invoke-virtual {p0}, Landroidx/compose/ui/text/TextStyle;->getLineHeight-XSAIIZE()J

    move-result-wide v0

    invoke-virtual {p0}, Landroidx/compose/ui/text/TextStyle;->getFontSize-XSAIIZE()J

    move-result-wide v2

    long-to-int p0, v0

    invoke-static {p0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result p0

    long-to-int v4, v2

    invoke-static {v4}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v4

    const-wide v5, 0xff00000000L

    and-long/2addr v0, v5

    const-wide v7, 0x200000000L

    cmp-long v7, v0, v7

    if-nez v7, :cond_31

    goto :goto_47

    :cond_31
    const-wide v7, 0x100000000L

    cmp-long v0, v0, v7

    const/4 v1, 0x0

    if-nez v0, :cond_46

    and-long/2addr v2, v5

    cmp-long v0, v2, v7

    if-nez v0, :cond_46

    cmpl-float v0, v4, v1

    if-lez v0, :cond_46

    div-float/2addr p0, v4

    goto :goto_47

    :cond_46
    move p0, v1

    :goto_47
    const v0, 0x3f4ccccd    # 0.8f

    cmpl-float v0, p0, v0

    if-lez v0, :cond_5f

    const/high16 v0, 0x40400000    # 3.0f

    cmpg-float v0, p0, v0

    if-gez v0, :cond_5f

    const/high16 v0, 0x42c80000    # 100.0f

    mul-float/2addr p0, v0

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    int-to-float p0, p0

    div-float/2addr p0, v0

    sput p0, Lradiant/RLKaraoke;->lineRatio:F

    :cond_5f
    return-void
.end method

.method private static modeOf(Ljava/lang/String;IJZ)I
    .registers 11

    const/4 v0, 0x0

    move v1, v0

    move v2, v1

    :goto_3
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x1

    if-ge v1, v3, :cond_34

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v5, 0x590

    if-lt v3, v5, :cond_17

    const/16 v5, 0x8ff

    if-gt v3, v5, :cond_17

    return v0

    :cond_17
    const/16 v5, 0x3400

    if-lt v3, v5, :cond_1f

    const/16 v5, 0x4dbf

    if-le v3, v5, :cond_30

    :cond_1f
    const/16 v5, 0x4e00

    if-lt v3, v5, :cond_28

    const v5, 0x9fff

    if-le v3, v5, :cond_30

    :cond_28
    const/16 v5, 0x3040

    if-lt v3, v5, :cond_31

    const/16 v5, 0x30ff

    if-gt v3, v5, :cond_31

    :cond_30
    move v2, v4

    :cond_31
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_34
    if-eqz v2, :cond_3a

    if-le p1, v4, :cond_39

    const/4 v0, 0x2

    :cond_39
    return v0

    :cond_3a
    if-nez p4, :cond_46

    const-wide/16 v1, 0x3e8

    cmp-long p0, p2, v1

    if-ltz p0, :cond_46

    const/4 p0, 0x7

    if-gt p1, p0, :cond_46

    move v0, v4

    :cond_46
    return v0
.end method

.method private static paint(Landroidx/compose/ui/text/AnnotatedString$Builder;IIZ[Z[J[J[I[I[IIIJ)V
    .registers 19

    const/4 v0, -0x1

    const/4 v1, 0x0

    :goto_2
    if-ge v1, p10, :cond_16

    invoke-static {p4, v1, p3}, Lradiant/RLKaraoke;->inGroup([ZIZ)Z

    move-result v3

    if-nez v3, :cond_b

    goto :goto_13

    :cond_b
    aget-wide v3, p5, v1

    cmp-long v3, v3, p12

    if-lez v3, :cond_12

    goto :goto_16

    :cond_12
    move v0, v1

    :goto_13
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_16
    :goto_16
    if-gez v0, :cond_19

    return-void

    :cond_19
    aget p3, p7, v0

    if-le p3, p2, :cond_26

    invoke-static {}, Lradiant/WordLyrics;->sungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object p3

    aget p4, p7, v0

    invoke-virtual {p0, p3, p2, p4}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :cond_26
    const-wide/16 p2, 0x1

    aget-wide v1, p6, v0

    invoke-static {p2, p3, v1, v2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p2

    aget-wide p4, p5, v0

    sub-long p4, p12, p4

    cmp-long p6, p4, p2

    if-ltz p6, :cond_42

    invoke-static {}, Lradiant/WordLyrics;->sungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object p1

    aget p2, p7, v0

    aget p3, p8, v0

    invoke-virtual {p0, p1, p2, p3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    return-void

    :cond_42
    long-to-float p4, p4

    long-to-float p2, p2

    div-float/2addr p4, p2

    invoke-static {p4}, Lradiant/RLKaraoke;->clamp(F)F

    move-result p2

    aget p3, p7, v0

    aget p4, p9, v0

    move/from16 p5, p11

    invoke-static {p1, p3, p4, p2, p5}, Lradiant/WordLyrics;->sylWipe(IIIFI)Landroidx/compose/ui/graphics/Brush;

    move-result-object p1

    if-eqz p1, :cond_5e

    invoke-static {p1}, Lradiant/WordLyrics;->brushSpan(Landroidx/compose/ui/graphics/Brush;)Landroidx/compose/ui/text/SpanStyle;

    move-result-object p1

    aget p2, p7, v0

    aget p3, p8, v0

    goto :goto_6e

    :cond_5e
    sget-wide p3, Lradiant/WordLyrics;->tmpUnsung:J

    sget-wide p5, Lradiant/WordLyrics;->tmpSung:J

    invoke-static {p3, p4, p5, p6, p2}, Landroidx/compose/ui/graphics/ColorKt;->lerp-jxsXWHM(JJF)J

    move-result-wide p1

    invoke-static {p1, p2}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object p1

    aget p2, p7, v0

    aget p3, p8, v0

    :goto_6e
    invoke-virtual {p0, p1, p2, p3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    return-void
.end method

.method private static paragraphs(Landroidx/compose/ui/text/AnnotatedString$Builder;IIIZ)V
    .registers 9

    invoke-static {}, Lradiant/WordLyrics;->ctxSingers()Z

    move-result v0

    if-eqz v0, :cond_f

    sget-boolean v0, Lradiant/WordLyrics;->dualSide:Z

    if-eqz v0, :cond_f

    invoke-static {p1}, Lradiant/WordLyrics;->sideOf(I)I

    move-result p1

    goto :goto_10

    :cond_f
    const/4 p1, -0x1

    :goto_10
    if-ltz p2, :cond_14

    move v0, p2

    goto :goto_15

    :cond_14
    move v0, p3

    :goto_15
    if-gez p1, :cond_19

    if-eqz p4, :cond_2d

    :cond_19
    if-lez v0, :cond_2d

    const/4 v1, 0x0

    invoke-static {p1, v1}, Lradiant/WordLyrics;->paraStyle(IZ)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object v2

    if-eqz p4, :cond_2a

    invoke-static {}, Lradiant/RLKaraoke;->steady()Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/compose/ui/text/ParagraphStyle;->merge(Landroidx/compose/ui/text/ParagraphStyle;)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object v2

    :cond_2a
    invoke-virtual {p0, v2, v1, v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/ParagraphStyle;II)V

    :cond_2d
    if-ltz p2, :cond_4c

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lradiant/WordLyrics;->paraStyle(IZ)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object p1

    if-eqz p4, :cond_3f

    invoke-static {}, Lradiant/RLKaraoke;->steady()Landroidx/compose/ui/text/ParagraphStyle;

    sget-object p4, Lradiant/RLKaraoke;->steadyBg:Landroidx/compose/ui/text/ParagraphStyle;

    invoke-virtual {p1, p4}, Landroidx/compose/ui/text/ParagraphStyle;->merge(Landroidx/compose/ui/text/ParagraphStyle;)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object p1

    :cond_3f
    invoke-virtual {p0, p1, p2, p3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/ParagraphStyle;II)V

    const p1, 0x3f0ccccd    # 0.55f

    invoke-static {p1}, Lradiant/WordLyrics;->emSpan(F)Landroidx/compose/ui/text/SpanStyle;

    move-result-object p1

    invoke-virtual {p0, p1, p2, p3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :cond_4c
    return-void
.end method

.method private static plain(Ljava/lang/String;)Landroidx/compose/ui/text/AnnotatedString;
    .registers 2

    new-instance v0, Landroidx/compose/ui/text/AnnotatedString$Builder;

    if-nez p0, :cond_6

    const-string p0, ""

    :cond_6
    invoke-direct {v0, p0}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object p0

    return-object p0
.end method

.method public static prepare(Lorg/json/JSONArray;)Lorg/json/JSONArray;
    .registers 3

    invoke-static {}, Lradiant/WordLyrics;->ctxOn()Z

    move-result v0

    if-eqz v0, :cond_d

    invoke-static {p0}, Lradiant/RLBrackets;->apply(Lorg/json/JSONArray;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_d

    goto :goto_e

    :cond_d
    move-object v0, p0

    :goto_e
    invoke-static {}, Lradiant/RLKaraoke;->dots()Z

    move-result v1

    if-eqz v1, :cond_1b

    invoke-static {v0}, Lradiant/RLKaraoke;->addBreaks(Lorg/json/JSONArray;)Lorg/json/JSONArray;

    move-result-object v1

    if-eqz v1, :cond_1b

    move-object v0, v1

    :cond_1b
    if-ne v0, p0, :cond_1e

    const/4 v0, 0x0

    :cond_1e
    return-object v0
.end method

.method private static ramp(DD)D
    .registers 7

    const-wide/16 v0, 0x0

    cmpg-double v2, p0, v0

    if-gtz v2, :cond_7

    return-wide v0

    :cond_7
    const-wide v0, 0x401921fb54442d18L    # 6.283185307179586

    mul-double/2addr p0, v0

    const-wide v0, 0x3f50624dd2f1a9fcL    # 0.001

    invoke-static {v0, v1, p2, p3}, Ljava/lang/Math;->max(DD)D

    move-result-wide p2

    div-double/2addr p0, p2

    const-wide/high16 p2, 0x3ff0000000000000L    # 1.0

    add-double v0, p0, p2

    neg-double p0, p0

    invoke-static {p0, p1}, Ljava/lang/Math;->exp(D)D

    move-result-wide p0

    mul-double/2addr v0, p0

    sub-double/2addr p2, v0

    return-wide p2
.end method

.method public static renderBreak(IJ)Landroidx/compose/ui/text/AnnotatedString;
    .registers 15

    sget-object v0, Lradiant/RLKaraoke;->breakStart:[J

    sget-object v1, Lradiant/RLKaraoke;->breakEnd:[J

    sget-boolean v2, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-eqz v2, :cond_c1

    if-eqz v0, :cond_c1

    if-eqz v1, :cond_c1

    if-ltz p0, :cond_c1

    array-length v2, v0

    if-ge p0, v2, :cond_c1

    aget-wide v2, v0, p0

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-gez v2, :cond_1b

    goto/16 :goto_c1

    :cond_1b
    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    move-result-object v2

    invoke-interface {v2}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v2

    aget-wide v4, v0, p0

    aget-wide v0, v1, p0

    const-wide/16 v6, 0x15e

    sub-long v6, v0, v6

    const-wide/16 v8, 0x64

    sub-long v10, v4, v8

    cmp-long p0, v2, v10

    if-ltz p0, :cond_42

    add-long/2addr v8, v0

    cmp-long p0, v2, v8

    if-gez p0, :cond_42

    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    move-result-object p0

    invoke-interface {p0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    :cond_42
    cmp-long p0, v2, v4

    const v8, 0x3dcccccd    # 0.1f

    const/high16 v9, 0x3f800000    # 1.0f

    const/high16 v10, 0x3e800000    # 0.25f

    if-ltz p0, :cond_60

    cmp-long p0, v2, v6

    if-gez p0, :cond_60

    sub-long v0, v2, v4

    long-to-float p0, v0

    const/high16 v0, 0x43c80000    # 400.0f

    div-float/2addr p0, v0

    invoke-static {p0}, Lradiant/RLKaraoke;->clamp(F)F

    move-result p0

    invoke-static {p0, v10, v8, v10, v9}, Lradiant/RLKaraoke;->bezier(FFFFF)F

    move-result p0

    goto :goto_7a

    :cond_60
    cmp-long p0, v2, v6

    if-ltz p0, :cond_79

    cmp-long p0, v2, v0

    if-gez p0, :cond_79

    sub-long v0, v2, v6

    long-to-float p0, v0

    const/high16 v0, 0x43af0000    # 350.0f

    div-float/2addr p0, v0

    invoke-static {p0}, Lradiant/RLKaraoke;->clamp(F)F

    move-result p0

    invoke-static {p0, v10, v8, v10, v9}, Lradiant/RLKaraoke;->bezier(FFFFF)F

    move-result p0

    sub-float p0, v9, p0

    goto :goto_7a

    :cond_79
    const/4 p0, 0x0

    :goto_7a
    sub-long/2addr v2, v4

    long-to-float v0, v2

    const-wide/16 v1, 0x1

    sub-long/2addr v6, v4

    invoke-static {v1, v2, v6, v7}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v1

    long-to-float v1, v1

    div-float/2addr v0, v1

    invoke-static {v0}, Lradiant/RLKaraoke;->clamp(F)F

    move-result v0

    new-instance v1, Landroidx/compose/ui/text/AnnotatedString$Builder;

    const-string v2, "\u25cf\u25cf\u25cf"

    invoke-direct {v1, v2}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lradiant/RLKaraoke;->dotSize()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v3

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4, v2}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :goto_9c
    const/4 v2, 0x3

    if-ge v4, v2, :cond_bc

    const/high16 v2, 0x40400000    # 3.0f

    mul-float/2addr v2, v0

    int-to-float v3, v4

    sub-float/2addr v2, v3

    invoke-static {v2}, Lradiant/RLKaraoke;->clamp(F)F

    move-result v2

    const/high16 v3, 0x3f400000    # 0.75f

    mul-float/2addr v2, v3

    add-float/2addr v2, v10

    mul-float/2addr v2, p0

    invoke-static {p1, p2, v2}, Lradiant/RLKaraoke;->withAlpha(JF)J

    move-result-wide v2

    invoke-static {v2, v3}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v2

    add-int/lit8 v3, v4, 0x1

    invoke-virtual {v1, v2, v4, v3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    move v4, v3

    goto :goto_9c

    :cond_bc
    invoke-virtual {v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object p0

    return-object p0

    :cond_c1
    :goto_c1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static renderSyl(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;
    .registers 33

    move/from16 v1, p0

    invoke-static {}, Lradiant/RLKaraoke;->rising()Z

    move-result v15

    invoke-static {}, Lradiant/RLKaraoke;->glow()I

    move-result v16

    if-nez v15, :cond_13

    if-gtz v16, :cond_13

    invoke-static/range {p0 .. p6}, Lradiant/WordLyrics;->renderSyl(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_13
    sput-wide p3, Lradiant/WordLyrics;->tmpSung:J

    sput-wide p5, Lradiant/WordLyrics;->tmpUnsung:J

    sget-object v0, Lradiant/WordLyrics;->lineSylText:[[Ljava/lang/String;

    sget-object v2, Lradiant/WordLyrics;->lineSylStart:[[J

    sget-object v3, Lradiant/WordLyrics;->lineSylDur:[[J

    sget-boolean v4, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-eqz v4, :cond_17b

    if-eqz v0, :cond_17b

    if-eqz v2, :cond_17b

    if-eqz v3, :cond_17b

    if-ltz v1, :cond_17b

    array-length v4, v0

    if-ge v1, v4, :cond_17b

    array-length v4, v2

    if-ge v1, v4, :cond_17b

    array-length v4, v3

    if-lt v1, v4, :cond_34

    goto/16 :goto_17b

    :cond_34
    aget-object v14, v0, v1

    aget-object v5, v2, v1

    aget-object v6, v3, v1

    if-eqz v14, :cond_176

    if-eqz v5, :cond_176

    if-eqz v6, :cond_176

    array-length v0, v14

    if-eqz v0, :cond_176

    array-length v0, v5

    array-length v2, v14

    if-lt v0, v2, :cond_176

    array-length v0, v6

    array-length v2, v14

    if-ge v0, v2, :cond_4d

    goto/16 :goto_176

    :cond_4d
    array-length v10, v14

    sget-object v0, Lradiant/WordLyrics;->lineSylBg:[[Z

    invoke-static {v0, v1, v10}, Lradiant/WordLyrics;->bgFlags([[ZII)[Z

    move-result-object v4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    new-array v7, v10, [I

    new-array v8, v10, [I

    new-array v9, v10, [I

    const/4 v3, -0x1

    const/4 v11, 0x0

    :goto_61
    const/4 v12, 0x2

    const/4 v13, 0x1

    if-ge v11, v12, :cond_ad

    if-ne v11, v13, :cond_69

    move v12, v13

    goto :goto_6a

    :cond_69
    const/4 v12, 0x0

    :goto_6a
    if-eqz v12, :cond_6f

    if-nez v4, :cond_6f

    goto :goto_ad

    :cond_6f
    const/4 v13, 0x0

    :goto_70
    if-ge v13, v10, :cond_aa

    invoke-static {v4, v13, v12}, Lradiant/RLKaraoke;->inGroup([ZIZ)Z

    move-result v17

    if-nez v17, :cond_79

    goto :goto_a7

    :cond_79
    if-eqz v12, :cond_81

    if-gez v3, :cond_81

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    :cond_81
    if-eqz v12, :cond_8a

    aget-object v17, v14, v13

    invoke-static/range {v17 .. v17}, Lradiant/WordLyrics;->stripBrackets(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    goto :goto_8c

    :cond_8a
    aget-object v17, v14, v13

    :goto_8c
    move-object/from16 v2, v17

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v17

    aput v17, v7, v13

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v17

    aput v17, v8, v13

    aget v17, v7, v13

    invoke-static {v2}, Lradiant/RLKaraoke;->trimEndLen(Ljava/lang/String;)I

    move-result v2

    add-int v17, v17, v2

    aput v17, v9, v13

    :goto_a7
    add-int/lit8 v13, v13, 0x1

    goto :goto_70

    :cond_aa
    add-int/lit8 v11, v11, 0x1

    goto :goto_61

    :cond_ad
    :goto_ad
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v11

    new-instance v2, Landroidx/compose/ui/text/AnnotatedString$Builder;

    invoke-direct {v2, v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    if-eqz v15, :cond_bf

    invoke-static {v1}, Lradiant/RLKaraoke;->measure(I)V

    :cond_bf
    invoke-static {v2, v1, v3, v11, v15}, Lradiant/RLKaraoke;->paragraphs(Landroidx/compose/ui/text/AnnotatedString$Builder;IIIZ)V

    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    move-result-object v12

    invoke-interface {v12}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move/from16 v17, v13

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v12

    invoke-static {v1}, Lradiant/WordLyrics;->isActiveLine(I)Z

    move-result v18

    if-nez v18, :cond_de

    invoke-static {v1}, Lradiant/WordLyrics;->isPastLine(I)Z

    move-result v19

    if-eqz v19, :cond_de

    move/from16 v19, v17

    goto :goto_e0

    :cond_de
    const/16 v19, 0x0

    :goto_e0
    move-object/from16 p2, v0

    sget-object v0, Lradiant/WordLyrics;->lineEff:[J

    move/from16 p6, v3

    move-object/from16 p5, v4

    const-wide/16 v20, 0x2bc

    if-eqz v0, :cond_f2

    array-length v3, v0

    if-ge v1, v3, :cond_f2

    aget-wide v3, v0, v1

    goto :goto_f4

    :cond_f2
    sub-long v3, v12, v20

    :goto_f4
    move-wide/from16 v22, v3

    if-eqz v19, :cond_10d

    cmp-long v0, v12, v22

    if-ltz v0, :cond_10d

    sub-long v3, v12, v22

    const-wide/16 v0, 0x258

    move-wide/from16 v24, v3

    move-wide/from16 v3, v20

    invoke-static {v3, v4, v0, v1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    cmp-long v0, v24, v0

    if-gez v0, :cond_10d

    goto :goto_10f

    :cond_10d
    const/16 v17, 0x0

    :goto_10f
    if-eqz v19, :cond_117

    invoke-static {}, Lradiant/WordLyrics;->sungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    const/4 v1, 0x0

    goto :goto_11c

    :cond_117
    const/4 v1, 0x0

    invoke-static {}, Lradiant/WordLyrics;->unsungStyle()Landroidx/compose/ui/text/SpanStyle;

    move-result-object v0

    :goto_11c
    invoke-virtual {v2, v0, v1, v11}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    if-nez v18, :cond_127

    if-eqz v17, :cond_124

    goto :goto_127

    :cond_124
    move-object v0, v2

    goto/16 :goto_171

    :cond_127
    :goto_127
    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    if-eqz v18, :cond_15b

    move-object v0, v2

    const/4 v2, 0x0

    const/4 v3, 0x0

    move/from16 v1, p0

    move-object/from16 v17, p2

    move-object/from16 v4, p5

    move/from16 v19, p6

    invoke-static/range {v0 .. v13}, Lradiant/RLKaraoke;->paint(Landroidx/compose/ui/text/AnnotatedString$Builder;IIZ[Z[J[J[I[I[IIIJ)V

    if-ltz v19, :cond_148

    const/4 v3, 0x1

    move/from16 v1, p0

    move/from16 v2, v19

    invoke-static/range {v0 .. v13}, Lradiant/RLKaraoke;->paint(Landroidx/compose/ui/text/AnnotatedString$Builder;IIZ[Z[J[J[I[I[IIIJ)V

    :cond_148
    move-object v1, v6

    move-object v6, v4

    move-object v4, v5

    move-object v5, v1

    move/from16 v1, p0

    move-object v8, v9

    move v9, v10

    move-wide v10, v12

    move-object v3, v14

    move-object/from16 v2, v17

    move/from16 v12, v18

    move-wide/from16 v13, v22

    move-wide/from16 v17, p3

    goto :goto_16e

    :cond_15b
    move/from16 v1, p0

    move-object v0, v2

    move-object v4, v5

    move-object v5, v6

    move-object v8, v9

    move v9, v10

    move-wide v10, v12

    move-object v3, v14

    move/from16 v12, v18

    move-wide/from16 v13, v22

    move-object/from16 v2, p2

    move-wide/from16 v17, p3

    move-object/from16 v6, p5

    :goto_16e
    invoke-static/range {v0 .. v18}, Lradiant/RLKaraoke;->fx(Landroidx/compose/ui/text/AnnotatedString$Builder;ILjava/lang/String;[Ljava/lang/String;[J[J[Z[I[IIJZJZIJ)V

    :goto_171
    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_176
    :goto_176
    invoke-static/range {p2 .. p2}, Lradiant/RLKaraoke;->plain(Ljava/lang/String;)Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_17b
    :goto_17b
    invoke-static/range {p2 .. p2}, Lradiant/RLKaraoke;->plain(Ljava/lang/String;)Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0
.end method

.method static rising()Z
    .registers 1

    invoke-static {}, Lradiant/RLDefaults;->risingWords()I

    move-result v0

    if-eqz v0, :cond_8

    const/4 v0, 0x1

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    :goto_9
    return v0
.end method

.method private static shiftSpan(F)Landroidx/compose/ui/text/SpanStyle;
    .registers 24

    invoke-static/range {p0 .. p0}, Landroidx/compose/ui/text/style/BaselineShift;->box-impl(F)Landroidx/compose/ui/text/style/BaselineShift;

    move-result-object v12

    new-instance v0, Landroidx/compose/ui/text/SpanStyle;

    const v21, 0xfeff

    const/16 v22, 0x0

    const-wide/16 v1, 0x0

    const-wide/16 v3, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-wide/16 v10, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const-wide/16 v15, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    invoke-direct/range {v0 .. v22}, Landroidx/compose/ui/text/SpanStyle;-><init>(JJLandroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontSynthesis;Landroidx/compose/ui/text/font/FontFamily;Ljava/lang/String;JLandroidx/compose/ui/text/style/BaselineShift;Landroidx/compose/ui/text/style/TextGeometricTransform;Landroidx/compose/ui/text/intl/LocaleList;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/graphics/Shadow;Landroidx/compose/ui/text/PlatformSpanStyle;Landroidx/compose/ui/graphics/drawscope/DrawStyle;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v0
.end method

.method private static shineCurve(D)D
    .registers 11

    const-wide/16 v0, 0x0

    cmpg-double v2, p0, v0

    if-gtz v2, :cond_7

    return-wide v0

    :cond_7
    const-wide v2, 0x3fc3333333333333L    # 0.15

    cmpg-double v4, p0, v2

    const-wide v5, 0x3fe999999999999aL    # 0.8

    if-gez v4, :cond_18

    mul-double/2addr p0, v5

    div-double/2addr p0, v2

    return-wide p0

    :cond_18
    const-wide v7, 0x3fd3333333333333L    # 0.3

    cmpg-double v4, p0, v7

    if-gez v4, :cond_2b

    const-wide v0, 0x3fc999999999999aL    # 0.2

    sub-double/2addr p0, v2

    mul-double/2addr p0, v0

    div-double/2addr p0, v2

    add-double/2addr p0, v5

    return-wide p0

    :cond_2b
    const-wide v2, 0x3fe3333333333333L    # 0.6

    cmpg-double v4, p0, v2

    const-wide/high16 v5, 0x3ff0000000000000L    # 1.0

    if-gez v4, :cond_40

    const-wide v0, 0x3fe6666666666666L    # 0.7

    sub-double/2addr p0, v7

    mul-double/2addr p0, v0

    div-double/2addr p0, v7

    sub-double/2addr v5, p0

    return-wide v5

    :cond_40
    cmpg-double v4, p0, v5

    if-gez v4, :cond_4e

    sub-double/2addr p0, v2

    mul-double/2addr p0, v7

    const-wide v0, 0x3fd999999999999aL    # 0.4

    div-double/2addr p0, v0

    sub-double/2addr v7, p0

    return-wide v7

    :cond_4e
    return-wide v0
.end method

.method private static spring(D)D
    .registers 10

    sget-wide v0, Lradiant/RLKaraoke;->FREQ:D

    sget-wide v2, Lradiant/RLKaraoke;->FREQ:D

    mul-double/2addr v0, v2

    const-wide v2, 0x4028800000000000L    # 12.25

    sub-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    const-wide/high16 v2, -0x3ff4000000000000L    # -3.5

    mul-double/2addr v2, p0

    invoke-static {v2, v3}, Ljava/lang/Math;->exp(D)D

    move-result-wide v2

    mul-double/2addr p0, v0

    invoke-static {p0, p1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v4

    const-wide/high16 v6, 0x400c000000000000L    # 3.5

    div-double/2addr v6, v0

    invoke-static {p0, p1}, Ljava/lang/Math;->sin(D)D

    move-result-wide p0

    mul-double/2addr v6, p0

    add-double/2addr v4, v6

    mul-double/2addr v2, v4

    return-wide v2
.end method

.method private static startOf(Lorg/json/JSONObject;)J
    .registers 8

    const-string v0, "syllabus"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_14

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v0

    goto :goto_15

    :cond_14
    const/4 v0, 0x0

    :goto_15
    const-wide/16 v1, -0x1

    if-eqz v0, :cond_20

    const-string p0, "time"

    invoke-virtual {v0, p0, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0

    :cond_20
    const-string v0, "startTime"

    const-wide/high16 v3, -0x4010000000000000L    # -1.0

    invoke-virtual {p0, v0, v3, v4}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v3

    const-wide/16 v5, 0x0

    cmpg-double p0, v3, v5

    if-gez p0, :cond_2f

    goto :goto_39

    :cond_2f
    const-wide v0, 0x408f400000000000L    # 1000.0

    mul-double/2addr v3, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->round(D)J

    move-result-wide v1

    :goto_39
    return-wide v1
.end method

.method private static steady()Landroidx/compose/ui/text/ParagraphStyle;
    .registers 14

    sget-object v0, Lradiant/RLKaraoke;->steady:Landroidx/compose/ui/text/ParagraphStyle;

    if-eqz v0, :cond_c

    sget v0, Lradiant/RLKaraoke;->steadyRatio:F

    sget v1, Lradiant/RLKaraoke;->lineRatio:F

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_44

    :cond_c
    new-instance v8, Landroidx/compose/ui/text/style/LineHeightStyle;

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    const/16 v3, 0x10

    invoke-direct {v8, v2, v3, v0, v1}, Landroidx/compose/ui/text/style/LineHeightStyle;-><init>(FIILkotlin/jvm/internal/DefaultConstructorMarker;)V

    new-instance v1, Landroidx/compose/ui/text/ParagraphStyle;

    sget v0, Lradiant/RLKaraoke;->lineRatio:F

    const v2, 0x3d75c28f    # 0.06f

    add-float/2addr v0, v2

    invoke-static {v0}, Landroidx/compose/ui/unit/TextUnitKt;->getEm(F)J

    move-result-wide v4

    const/16 v12, 0x1db

    const/4 v13, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-direct/range {v1 .. v13}, Landroidx/compose/ui/text/ParagraphStyle;-><init>(IIJLandroidx/compose/ui/text/style/TextIndent;Landroidx/compose/ui/text/PlatformParagraphStyle;Landroidx/compose/ui/text/style/LineHeightStyle;IILandroidx/compose/ui/text/style/TextMotion;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v1, Lradiant/RLKaraoke;->steady:Landroidx/compose/ui/text/ParagraphStyle;

    new-instance v1, Landroidx/compose/ui/text/ParagraphStyle;

    const v0, 0x3f428f5c    # 0.76f

    invoke-static {v0}, Landroidx/compose/ui/unit/TextUnitKt;->getEm(F)J

    move-result-wide v4

    invoke-direct/range {v1 .. v13}, Landroidx/compose/ui/text/ParagraphStyle;-><init>(IIJLandroidx/compose/ui/text/style/TextIndent;Landroidx/compose/ui/text/PlatformParagraphStyle;Landroidx/compose/ui/text/style/LineHeightStyle;IILandroidx/compose/ui/text/style/TextMotion;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v1, Lradiant/RLKaraoke;->steadyBg:Landroidx/compose/ui/text/ParagraphStyle;

    sget v0, Lradiant/RLKaraoke;->lineRatio:F

    sput v0, Lradiant/RLKaraoke;->steadyRatio:F

    :cond_44
    sget-object v0, Lradiant/RLKaraoke;->steady:Landroidx/compose/ui/text/ParagraphStyle;

    return-object v0
.end method

.method private static trimEndLen(Ljava/lang/String;)I
    .registers 4

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    :goto_4
    if-lez v0, :cond_13

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x20

    if-gt v1, v2, :cond_13

    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    :cond_13
    return v0
.end method

.method static withAlpha(JF)J
    .registers 3

    invoke-static {p0, p1}, Landroidx/compose/ui/graphics/ColorKt;->toArgb-8_81llA(J)I

    move-result p0

    ushr-int/lit8 p1, p0, 0x18

    and-int/lit16 p1, p1, 0xff

    int-to-float p1, p1

    invoke-static {p2}, Lradiant/RLKaraoke;->clamp(F)F

    move-result p2

    mul-float/2addr p1, p2

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    const p2, 0xffffff

    and-int/2addr p0, p2

    shl-int/lit8 p1, p1, 0x18

    or-int/2addr p0, p1

    invoke-static {p0}, Landroidx/compose/ui/graphics/ColorKt;->Color(I)J

    move-result-wide p0

    return-wide p0
.end method
