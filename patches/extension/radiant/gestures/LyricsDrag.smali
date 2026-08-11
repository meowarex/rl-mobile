.class public final Lradiant/gestures/LyricsDrag;
.super Ljava/lang/Object;

# Stops lyrics scroll dismissing the player


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Stop leftover scroll reaching the sheet
.method public static wrap(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;
    .locals 2

    sget-object v0, Lradiant/gestures/LyricsDrag$Guard;->INSTANCE:Lradiant/gestures/LyricsDrag$Guard;

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroidx/compose/ui/input/nestedscroll/NestedScrollModifierKt;->nestedScroll(Landroidx/compose/ui/Modifier;Landroidx/compose/ui/input/nestedscroll/NestedScrollConnection;Landroidx/compose/ui/input/nestedscroll/NestedScrollDispatcher;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    return-object p0
.end method
