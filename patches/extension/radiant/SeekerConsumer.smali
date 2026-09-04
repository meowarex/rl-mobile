.class public final Lradiant/SeekerConsumer;
.super Ljava/lang/Object;

.implements Lio/reactivex/functions/Consumer;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 3

    if-eqz p1, :ret    # null guard

    instance-of v0, p1, Lgh/b;    # type guard  MARKER: R8 Lgh/b;

    if-eqz v0, :ret    # skip if wrong type

    check-cast p1, Lgh/b;    # narrow type  MARKER: R8 Lgh/b;

    iget v0, p1, Lgh/b;->b:F    # raw progress  MARKER: R8 Lgh/b; b

    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z    # nan check

    move-result v1    # nan flag

    if-eqz v1, :not_nan    # skip clamp if finite

    const/4 v0, 0x0    # default to zero

    :not_nan
    const/4 v1, 0x0    # lower bound

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F    # clamp low

    move-result v0    # clamped low

    const/high16 v2, 0x3f800000    # 1.0f upper bound

    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F    # clamp high

    move-result v0    # final value

    sget-object v1, Lradiant/MiniSeekerLine;->progressState:Landroidx/compose/runtime/MutableFloatState;    # shared state

    if-eqz v1, :ret    # safety

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableFloatState;->setFloatValue(F)V    # publish

    :ret
    return-void
.end method
