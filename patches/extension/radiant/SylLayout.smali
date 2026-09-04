.class public final Lradiant/SylLayout;
.super Ljava/lang/Object;

# interfaces
.implements Lam0/l;    # MARKER: R8 Lam0/l;

# Remembers where each line's glyphs landed


# static state

.field public static cbs:[Lradiant/SylLayout;

.field public static layouts:[Landroidx/compose/ui/text/TextLayoutResult;


# instance state

.field public final idx:I


.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/SylLayout;->idx:I

    return-void
.end method


# One reusable callback per line
.method public static cb(I)Lam0/l;    # MARKER: R8 Lam0/l;
    .locals 5

    if-gez p0, :have_idx

    const/4 p0, 0x0

    :have_idx
    sget-object v0, Lradiant/SylLayout;->cbs:[Lradiant/SylLayout;

    if-eqz v0, :grow

    array-length v1, v0

    if-gt v1, p0, :have_arr

    :grow
    add-int/lit8 v1, p0, 0x1

    const/16 v2, 0x40

    if-ge v1, v2, :cap_ok

    const/16 v1, 0x40

    :cap_ok
    if-nez v0, :copy

    new-array v0, v1, [Lradiant/SylLayout;

    goto :store_arr

    :copy
    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lradiant/SylLayout;

    :store_arr
    sput-object v0, Lradiant/SylLayout;->cbs:[Lradiant/SylLayout;

    :have_arr
    aget-object v1, v0, p0

    if-nez v1, :ret

    new-instance v1, Lradiant/SylLayout;

    invoke-direct {v1, p0}, Lradiant/SylLayout;-><init>(I)V

    aput-object v1, v0, p0

    :ret
    return-object v1
.end method

.method public static get(I)Landroidx/compose/ui/text/TextLayoutResult;
    .locals 2

    if-ltz p0, :none

    sget-object v0, Lradiant/SylLayout;->layouts:[Landroidx/compose/ui/text/TextLayoutResult;

    if-eqz v0, :none

    array-length v1, v0

    if-ge p0, v1, :none

    aget-object v0, v0, p0

    return-object v0

    :none
    const/4 v0, 0x0

    return-object v0
.end method

# Forget the layouts on track change
.method public static reset()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lradiant/SylLayout;->layouts:[Landroidx/compose/ui/text/TextLayoutResult;

    return-void
.end method

# Font size in pixels
.method public static em(Landroidx/compose/ui/text/TextLayoutResult;)F
    .locals 8

    invoke-virtual {p0}, Landroidx/compose/ui/text/TextLayoutResult;->getLayoutInput()Landroidx/compose/ui/text/TextLayoutInput;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/compose/ui/text/TextLayoutInput;->getStyle()Landroidx/compose/ui/text/TextStyle;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/compose/ui/text/TextStyle;->getFontSize-XSAIIZE()J

    move-result-wide v1

    # Only Sp converts to pixels
    invoke-static {v1, v2}, Landroidx/compose/ui/unit/TextUnit;->getType-UIouoOA(J)J

    move-result-wide v3

    sget-object v5, Landroidx/compose/ui/unit/TextUnitType;->Companion:Landroidx/compose/ui/unit/TextUnitType$Companion;

    invoke-virtual {v5}, Landroidx/compose/ui/unit/TextUnitType$Companion;->getSp-UIouoOA()J

    move-result-wide v5

    invoke-static {v3, v4, v5, v6}, Landroidx/compose/ui/unit/TextUnitType;->equals-impl0(JJ)Z

    move-result v3

    if-eqz v3, :fallback

    invoke-virtual {v0}, Landroidx/compose/ui/text/TextLayoutInput;->getDensity()Landroidx/compose/ui/unit/Density;

    move-result-object v0

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/unit/Density;->toPx--R2X_6o(J)F

    move-result v0

    const/4 v1, 0x0

    cmpg-float v1, v0, v1

    if-lez v1, :fallback

    return v0

    :fallback
    # No font size, guess from the line box
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/compose/ui/text/TextLayoutResult;->getLineBottom(I)F

    move-result v1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/compose/ui/text/TextLayoutResult;->getLineTop(I)F

    move-result v2

    sub-float/2addr v1, v2

    const/4 v0, 0x0

    cmpg-float v0, v1, v0

    if-lez v0, :default_em

    const v0, 0x3f4ccccd    # 0.8f

    mul-float/2addr v0, v1

    return v0

    :default_em
    const/high16 v0, 0x42200000    # 40.0f

    return v0
.end method


# virtual methods

.method public invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    iget v0, p0, Lradiant/SylLayout;->idx:I

    if-ltz v0, :ret

    instance-of v1, p1, Landroidx/compose/ui/text/TextLayoutResult;

    if-eqz v1, :ret

    sget-object v1, Lradiant/SylLayout;->layouts:[Landroidx/compose/ui/text/TextLayoutResult;

    if-eqz v1, :grow

    array-length v2, v1

    if-gt v2, v0, :store

    :grow
    add-int/lit8 v2, v0, 0x1

    const/16 v3, 0x40

    if-ge v2, v3, :cap_ok

    const/16 v2, 0x40

    :cap_ok
    if-nez v1, :copy

    new-array v1, v2, [Landroidx/compose/ui/text/TextLayoutResult;

    goto :store

    :copy
    invoke-static {v1, v2}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroidx/compose/ui/text/TextLayoutResult;

    :store
    sput-object v1, Lradiant/SylLayout;->layouts:[Landroidx/compose/ui/text/TextLayoutResult;

    check-cast p1, Landroidx/compose/ui/text/TextLayoutResult;

    aput-object p1, v1, v0

    :ret
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object v0
.end method
