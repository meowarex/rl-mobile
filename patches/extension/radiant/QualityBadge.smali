.class public final Lradiant/QualityBadge;
.super Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# qualities : 0 = LOW / HIGH, 1 = LOSSLESS, 2 = HI_RES_LOSSLESS
.method private static backgroundArgb(I)I
    .locals 0

    packed-switch p0, :quality_switch

    const p0, 0x66475569    # LOW / HIGH bg
    return p0

    :lossless
    const p0, 0x3306b6d4    # LOSSLESS bg
    return p0

    :hires
    const p0, 0x40f59e0b    # HI_RES_LOSSLESS bg
    return p0

    :quality_switch
    .packed-switch 0x1
        :lossless
        :hires
    .end packed-switch
.end method

.method private static textArgb(I)I
    .locals 0

    packed-switch p0, :quality_switch

    const p0, -0x1d1710    # LOW / HIGH text
    return p0

    :lossless
    const p0, -0x5a0c04    # LOSSLESS text
    return p0

    :hires
    const p0, -0x21976    # HI_RES_LOSSLESS text
    return p0

    :quality_switch
    .packed-switch 0x1
        :lossless
        :hires
    .end packed-switch
.end method


.method public static modifier(Landroidx/compose/ui/Modifier;I)Landroidx/compose/ui/Modifier;
    .locals 3

    invoke-static {p1}, Lradiant/QualityBadge;->backgroundArgb(I)I

    move-result p1
    invoke-static {p1}, Landroidx/compose/ui/graphics/ColorKt;->Color(I)J
    move-result-wide v0
    const/high16 p1, 0x40800000    # 4.0f
    invoke-static {p1}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F
    move-result p1
    invoke-static {p1}, Landroidx/compose/foundation/shape/RoundedCornerShapeKt;->RoundedCornerShape-0680j_4(F)Landroidx/compose/foundation/shape/RoundedCornerShape;
    move-result-object v2
    invoke-static {p0, v0, v1, v2}, Landroidx/compose/foundation/BackgroundKt;->background-bw27NRU(Landroidx/compose/ui/Modifier;JLandroidx/compose/ui/graphics/Shape;)Landroidx/compose/ui/Modifier;
    move-result-object p0
    const/high16 p1, 0x40c00000    # 6.0f
    invoke-static {p1}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F
    move-result p1
    const/high16 v0, 0x40000000    # 2.0f
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F
    move-result v0
    invoke-static {p0, p1, v0}, Landroidx/compose/foundation/layout/PaddingKt;->padding-VpY3zN4(Landroidx/compose/ui/Modifier;FF)Landroidx/compose/ui/Modifier;
    move-result-object p0
    return-object p0
.end method

.method public static style(ILq20/c2;)Lq20/c2;    # MARKER: R8 Lq20/c2;
    .registers 16

    invoke-static {p0}, Lradiant/QualityBadge;->textArgb(I)I

    move-result v0
    new-instance v1, Lf20/a;    # MARKER: R8 Lf20/a;
    invoke-direct {v1, v0}, Lf20/a;-><init>(I)V    # MARKER: R8 Lf20/a;
    new-instance v0, Lf20/d;    # MARKER: R8 Lf20/d;
    const/4 v2, 0x0
    const/4 v3, 0x0
    const/4 v4, 0x0
    const/4 v5, 0x0
    const/4 v6, 0x0
    const/4 v7, 0x0
    const/4 v8, 0x0
    const/4 v9, 0x0
    const/4 v10, 0x0
    const/4 v11, 0x0
    const/4 v12, 0x0
    const/16 v13, 0xffe
    const/4 v14, 0x0
    invoke-direct/range {v0 .. v14}, Lf20/d;-><init>(Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;Lf20/a;ILkotlin/jvm/internal/DefaultConstructorMarker;)V    # MARKER: R8 Lf20/d; Lf20/a;

    move-object v9, v0
    move-object/from16 v0, p1
    const/4 v1, 0x0
    move-object v2, v9
    const/4 v3, 0x0
    const/4 v4, 0x0
    const/4 v5, 0x0
    const/16 v6, 0x1d
    const/4 v7, 0x0
    invoke-static/range {v0 .. v7}, Lq20/c2;->g(Lq20/c2;Lq20/s4;Lf20/d;Lcom/squareup/ui/market/core/text/MarketTextAlignment;Lcom/squareup/ui/market/core/text/MarketTextTransform;Lq20/r4;ILjava/lang/Object;)Lq20/c2;    # MARKER: R8 Lq20/c2; Lq20/s4; Lf20/d; Lq20/r4; g
    move-result-object p0
    return-object p0
.end method