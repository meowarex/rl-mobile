.class public final Lradiant/gestures/lyrics/LyricsDrag$Guard;
.super Ljava/lang/Object;

# interfaces
.implements Landroidx/compose/ui/input/nestedscroll/NestedScrollConnection;

# Blocks leftover scroll from the sheet


# static state

.field public static final INSTANCE:Lradiant/gestures/lyrics/LyricsDrag$Guard;


.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/gestures/lyrics/LyricsDrag$Guard;

    invoke-direct {v0}, Lradiant/gestures/lyrics/LyricsDrag$Guard;-><init>()V

    sput-object v0, Lradiant/gestures/lyrics/LyricsDrag$Guard;->INSTANCE:Lradiant/gestures/lyrics/LyricsDrag$Guard;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods

# Consume what the list didn't use
.method public onPostScroll-DzOQY0M(JJI)J
    .locals 0

    return-wide p3
.end method

.method public onPostFling-RZ2iAVY(JJLkotlin/coroutines/e;)Ljava/lang/Object;    # MARKER: R8 Lkotlin/coroutines/e;
    .locals 2

    invoke-static {p3, p4}, Landroidx/compose/ui/unit/Velocity;->box-impl(J)Landroidx/compose/ui/unit/Velocity;

    move-result-object v0

    return-object v0
.end method
