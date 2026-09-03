.class public final Lradiant/swipe/ViewAllTrackQueueAction;
.super Ljava/lang/Object;
.source "ViewAllTrackQueueAction.smali"

# interfaces
.implements Lradiant/swipe/ComposeSwipeAction;


# instance fields
.field private final callback:Lam0/l;

.field private context:Landroid/content/Context;

.field private final trackId:J


# direct methods
.method public constructor <init>(Lam0/l;Lm40/e$e;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/ViewAllTrackQueueAction;->callback:Lam0/l;

    iget-wide v0, p2, Lm40/e$e;->a:J

    iput-wide v0, p0, Lradiant/swipe/ViewAllTrackQueueAction;->trackId:J

    return-void
.end method


# virtual methods
.method public invoke(I)Ljava/lang/Object;
    .locals 5

    iget-object v0, p0, Lradiant/swipe/ViewAllTrackQueueAction;->callback:Lam0/l;

    if-eqz v0, :done

    iget-wide v1, p0, Lradiant/swipe/ViewAllTrackQueueAction;->trackId:J

    const/4 v3, 0x3

    if-eq p1, v3, :queue_event

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v3

    if-eqz v3, :play_existing

    :queue_event
    iget-object v3, p0, Lradiant/swipe/ViewAllTrackQueueAction;->context:Landroid/content/Context;

    if-eqz v3, :done

    invoke-static {v3}, Lradiant/swipe/ViewAllTrackQueue;->setContext(Landroid/content/Context;)V

    invoke-static {v1, v2, p1}, Lradiant/swipe/ViewAllTrackQueue;->marker(JI)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Li40/c$b;

    invoke-direct {v4, v3}, Li40/c$b;-><init>(Ljava/lang/Object;)V

    goto :emit

    :play_existing
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    new-instance v4, Li40/c$b;

    invoke-direct {v4, v3}, Li40/c$b;-><init>(Ljava/lang/Object;)V

    :emit
    invoke-interface {v0, v4}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public invoke()Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lradiant/swipe/ViewAllTrackQueueAction;->invoke(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lradiant/swipe/ViewAllTrackQueueAction;->context:Landroid/content/Context;

    return-void
.end method
