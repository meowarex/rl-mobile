.class public final Lradiant/MiniPlayerBackground;
.super Ljava/lang/Object;


# static fields
.field public static final colorFlow:Lkotlinx/coroutines/flow/MutableStateFlow; # player bg color


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    sput-object v0, Lradiant/MiniPlayerBackground;->colorFlow:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-void
.end method


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


.method public static color(JLandroidx/compose/runtime/Composer;I)J
    .locals 8
    .annotation build Landroidx/compose/runtime/Composable;
    .end annotation

    const v0, 0x4d504442 # compose group key

    invoke-interface {p2, v0}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    sget-object v0, Lradiant/MiniPlayerBackground;->colorFlow:Lkotlinx/coroutines/flow/MutableStateFlow;

    const/4 v1, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-static {v0, v1, p2, v3, v4}, Landroidx/compose/runtime/SnapshotStateKt;->collectAsState(Lkotlinx/coroutines/flow/StateFlow;Lkotlin/coroutines/h;Landroidx/compose/runtime/Composer;II)Landroidx/compose/runtime/State;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/State;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/compose/ui/graphics/Color;

    if-eqz v0, :fallback

    invoke-virtual {v0}, Landroidx/compose/ui/graphics/Color;->unbox-impl()J

    move-result-wide p0

    :fallback
    const/16 v0, 0x2ee # 750ms

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x6

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Landroidx/compose/animation/core/AnimationSpecKt;->tween$default(IILandroidx/compose/animation/core/Easing;ILjava/lang/Object;)Landroidx/compose/animation/core/TweenSpec;

    move-result-object v2

    move-wide v0, p0

    const-string v3, "miniPlayerBackgroundColorAnimation"

    const/4 v4, 0x0

    move-object v5, p2

    const/16 v6, 0x1b0

    const/16 v7, 0x8

    invoke-static/range {v0 .. v7}, Landroidx/compose/animation/SingleValueAnimationKt;->animateColorAsState-euL9pac(JLandroidx/compose/animation/core/AnimationSpec;Ljava/lang/String;Lam0/l;Landroidx/compose/runtime/Composer;II)Landroidx/compose/runtime/State;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/runtime/State;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/compose/ui/graphics/Color;

    invoke-virtual {v0}, Landroidx/compose/ui/graphics/Color;->unbox-impl()J

    move-result-wide p0

    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-wide p0
.end method


.method public static setHex(Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p0, :set_color

    :try_start
    invoke-static {p0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result p0

    invoke-static {p0}, Landroidx/compose/ui/graphics/ColorKt;->Color(I)J # pack ARGB color

    move-result-wide v1

    invoke-static {v1, v2}, Landroidx/compose/ui/graphics/Color;->box-impl(J)Landroidx/compose/ui/graphics/Color;

    move-result-object v0
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_parse

    goto :set_color

    :catch_parse
    move-exception p0

    :set_color
    sget-object p0, Lradiant/MiniPlayerBackground;->colorFlow:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-interface {p0, v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V

    return-void
.end method
