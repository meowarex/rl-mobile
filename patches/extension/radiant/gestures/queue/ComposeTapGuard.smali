.class public final Lradiant/gestures/queue/ComposeTapGuard;
.super Ljava/lang/Object;
.implements Lam0/a;    # MARKER: R8 Lam0/a;


# static fields
.field private static volatile deadline:J


# instance fields
.field private final delegate:Lam0/a;    # MARKER: R8 Lam0/a;


# direct methods
.method public constructor <init>(Lam0/a;)V    # MARKER: R8 Lam0/a;
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/ComposeTapGuard;->delegate:Lam0/a;    # MARKER: R8 Lam0/a;

    return-void
.end method

.method public static isSuppressed()Z
    .locals 5

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sget-wide v2, Lradiant/gestures/queue/ComposeTapGuard;->deadline:J

    cmp-long v4, v0, v2

    if-ltz v4, :suppressed

    const/4 v0, 0x0

    return v0

    :suppressed
    const/4 v0, 0x1

    return v0
.end method

.method public static suppressAfterSwipe()V
    .locals 4

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x96

    add-long/2addr v0, v2

    sput-wide v0, Lradiant/gestures/queue/ComposeTapGuard;->deadline:J

    return-void
.end method

.method public static wrap(Lam0/a;)Lam0/a;    # MARKER: R8 Lam0/a;
    .locals 1

    new-instance v0, Lradiant/gestures/queue/ComposeTapGuard;

    invoke-direct {v0, p0}, Lradiant/gestures/queue/ComposeTapGuard;-><init>(Lam0/a;)V    # MARKER: R8 Lam0/a;

    return-object v0
.end method


# virtual methods
.method public invoke()Ljava/lang/Object;
    .locals 1

    invoke-static {}, Lradiant/gestures/queue/ComposeTapGuard;->isSuppressed()Z

    move-result v0

    if-eqz v0, :dispatch

    sget-object v0, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object v0

    :dispatch
    iget-object v0, p0, Lradiant/gestures/queue/ComposeTapGuard;->delegate:Lam0/a;    # MARKER: R8 Lam0/a;

    invoke-interface {v0}, Lam0/a;->invoke()Ljava/lang/Object;    # MARKER: R8 Lam0/a;

    move-result-object v0

    return-object v0
.end method
