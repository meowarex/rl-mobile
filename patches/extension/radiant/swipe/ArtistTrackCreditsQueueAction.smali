.class public final Lradiant/swipe/ArtistTrackCreditsQueueAction;
.super Ljava/lang/Object;
.source "ArtistTrackCreditsQueueAction.smali"

# interfaces
.implements Lradiant/swipe/ComposeSwipeAction;


# instance fields
.field private final callback:Lam0/l;

.field private context:Landroid/content/Context;

.field private final moduleUuid:Ljava/lang/String;

.field private final pageId:Ljava/lang/String;

.field private final trackId:J


# direct methods
.method public constructor <init>(Lam0/l;Ljava/lang/String;Ljava/lang/String;Lm40/e$e;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->callback:Lam0/l;

    iput-object p2, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->moduleUuid:Ljava/lang/String;

    iget-wide v0, p4, Lm40/e$e;->a:J

    iput-wide v0, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->trackId:J

    return-void
.end method


# virtual methods
.method public invoke(I)Ljava/lang/Object;
    .locals 8

    iget-wide v1, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->trackId:J

    const/4 v0, 0x3

    if-eq p1, v0, :active_queue

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v0

    if-nez v0, :active_queue

    new-instance v0, Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b$a;

    iget-object v3, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->pageId:Ljava/lang/String;

    iget-object v4, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->moduleUuid:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b$a;-><init>(JLjava/lang/String;Ljava/lang/String;)V

    goto :emit

    :active_queue
    new-instance v0, Lradiant/swipe/ArtistTrackCreditsQueueEvent;

    iget-object v1, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->context:Landroid/content/Context;

    if-eqz v1, :done

    iget-object v2, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->pageId:Ljava/lang/String;

    iget-object v3, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->moduleUuid:Ljava/lang/String;

    iget-wide v4, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->trackId:J

    move v6, p1

    invoke-direct/range {v0 .. v6}, Lradiant/swipe/ArtistTrackCreditsQueueEvent;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;JI)V

    :emit
    iget-object v7, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->callback:Lam0/l;

    invoke-interface {v7, v0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public invoke()Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lradiant/swipe/ArtistTrackCreditsQueueAction;->invoke(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lradiant/swipe/ArtistTrackCreditsQueueAction;->context:Landroid/content/Context;

    return-void
.end method
