.class public final Lradiant/MiniNavInset;
.super Ljava/lang/Object;

# Bottom gap for the floating mini-player
# Fixed gap when the nav bar is hidden


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# Stock inset, fixed gap when the nav bar is hidden
.method public static apply(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;)Landroidx/compose/ui/Modifier;
    .locals 5
    .annotation build Landroidx/compose/runtime/Composable;
    .end annotation

    sget-object v0, Landroidx/compose/foundation/layout/WindowInsets;->Companion:Landroidx/compose/foundation/layout/WindowInsets$Companion;    # companion

    const/4 v1, 0x6    # $changed, stable static arg

    invoke-static {v0, p1, v1}, Landroidx/compose/foundation/layout/WindowInsets_androidKt;->getNavigationBars(Landroidx/compose/foundation/layout/WindowInsets$Companion;Landroidx/compose/runtime/Composer;I)Landroidx/compose/foundation/layout/WindowInsets;    # nav bar insets (state backed)

    move-result-object v0    # insets

    invoke-static {}, Landroidx/compose/ui/platform/CompositionLocalsKt;->getLocalDensity()Landroidx/compose/runtime/ProvidableCompositionLocal;    # LocalDensity

    move-result-object v1    # local

    invoke-interface {p1, v1}, Landroidx/compose/runtime/Composer;->consume(Landroidx/compose/runtime/CompositionLocal;)Ljava/lang/Object;    # current density

    move-result-object v1    # density

    check-cast v1, Landroidx/compose/ui/unit/Density;    # narrow

    invoke-interface {v0, v1}, Landroidx/compose/foundation/layout/WindowInsets;->getBottom(Landroidx/compose/ui/unit/Density;)I    # bottom px

    move-result v2    # bottom

    if-gtz v2, :system    # nav bar shown at the bottom

    sget-object v3, Landroidx/compose/ui/unit/LayoutDirection;->Ltr:Landroidx/compose/ui/unit/LayoutDirection;    # side check direction

    invoke-interface {v0, v1, v3}, Landroidx/compose/foundation/layout/WindowInsets;->getLeft(Landroidx/compose/ui/unit/Density;Landroidx/compose/ui/unit/LayoutDirection;)I    # left px

    move-result v2    # left

    if-gtz v2, :system    # nav bar on the side (landscape)

    invoke-interface {v0, v1, v3}, Landroidx/compose/foundation/layout/WindowInsets;->getRight(Landroidx/compose/ui/unit/Density;Landroidx/compose/ui/unit/LayoutDirection;)I    # right px

    move-result v2    # right

    if-gtz v2, :system    # nav bar on the side (landscape)

    const/high16 v4, 0x41600000    # 14dp, nav bar hidden

    const/4 v2, 0x0    # 0dp

    invoke-static {p0, v2, v2, v2, v4}, Landroidx/compose/foundation/layout/PaddingKt;->padding-qDBjuR0(Landroidx/compose/ui/Modifier;FFFF)Landroidx/compose/ui/Modifier;    # fixed bottom gap

    move-result-object p0    # padded

    return-object p0

    :system
    invoke-static {p0}, Landroidx/compose/foundation/layout/WindowInsetsPadding_androidKt;->navigationBarsPadding(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;    # stock inset

    move-result-object p0    # padded

    return-object p0
.end method
