.class public final Lradiant/swipe/VerticalMediaQueueAction;
.super Ljava/lang/Object;
.source "VerticalMediaQueueAction.smali"

# interfaces
.implements Lradiant/swipe/ComposeSwipeAction;


# static fields
.field public static final TYPE_ALBUM:I = 0x1

.field public static final TYPE_MIX:I = 0x2

.field public static final TYPE_PLAYLIST:I = 0x3

.field public static final TYPE_TRACK:I = 0x4


# instance fields
.field private final callback:Lam0/l;

.field private context:Landroid/content/Context;

.field private final itemId:Ljava/lang/String;

.field private final mediaType:I

.field private final moduleUuid:Ljava/lang/String;

.field private final pageId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lam0/l;Ljava/lang/String;Ljava/lang/String;Lm40/e;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/VerticalMediaQueueAction;->callback:Lam0/l;

    iput-object p2, p0, Lradiant/swipe/VerticalMediaQueueAction;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/swipe/VerticalMediaQueueAction;->moduleUuid:Ljava/lang/String;

    instance-of v0, p4, Lm40/e$a;

    if-eqz v0, :mix

    check-cast p4, Lm40/e$a;

    iget-wide v0, p4, Lm40/e$a;->a:J

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    goto :store

    :mix
    instance-of v0, p4, Lm40/e$c;

    if-eqz v0, :playlist

    check-cast p4, Lm40/e$c;

    iget-object v0, p4, Lm40/e$c;->a:Ljava/lang/String;

    const/4 v1, 0x2

    goto :store

    :playlist
    instance-of v0, p4, Lm40/e$d;

    if-eqz v0, :track

    check-cast p4, Lm40/e$d;

    iget-object v0, p4, Lm40/e$d;->a:Ljava/lang/String;

    const/4 v1, 0x3

    goto :store

    :track
    instance-of v0, p4, Lm40/e$e;

    if-eqz v0, :unsupported

    check-cast p4, Lm40/e$e;

    iget-wide v0, p4, Lm40/e$e;->a:J

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x4

    goto :store

    :unsupported
    const/4 v0, 0x0

    const/4 v1, 0x0

    :store
    iput-object v0, p0, Lradiant/swipe/VerticalMediaQueueAction;->itemId:Ljava/lang/String;

    iput v1, p0, Lradiant/swipe/VerticalMediaQueueAction;->mediaType:I

    return-void
.end method

.method public static isEligible(Lm40/e;)Z
    .locals 1

    instance-of v0, p0, Lm40/e$a;

    if-eqz v0, :mix

    check-cast p0, Lm40/e$a;

    iget-boolean p0, p0, Lm40/e$a;->e:Z

    return p0

    :mix
    instance-of v0, p0, Lm40/e$c;

    if-eqz v0, :playlist

    check-cast p0, Lm40/e$c;

    iget-boolean p0, p0, Lm40/e$c;->h:Z

    return p0

    :playlist
    instance-of v0, p0, Lm40/e$d;

    if-eqz v0, :track

    check-cast p0, Lm40/e$d;

    iget-boolean p0, p0, Lm40/e$d;->g:Z

    return p0

    :track
    instance-of v0, p0, Lm40/e$e;

    if-eqz v0, :invalid

    check-cast p0, Lm40/e$e;

    iget-boolean p0, p0, Lm40/e$e;->j:Z

    return p0

    :invalid
    const/4 p0, 0x0

    return p0
.end method

.method public static isSupported(Lm40/e;)Z
    .locals 1

    instance-of v0, p0, Lm40/e$a;

    if-nez v0, :supported

    instance-of v0, p0, Lm40/e$c;

    if-nez v0, :supported

    instance-of v0, p0, Lm40/e$d;

    if-nez v0, :supported

    instance-of v0, p0, Lm40/e$e;

    if-eqz v0, :invalid

    :supported
    const/4 p0, 0x1

    return p0

    :invalid
    const/4 p0, 0x0

    return p0
.end method


# virtual methods
.method public invoke()Ljava/lang/Object;
    .locals 7

    iget-object v6, p0, Lradiant/swipe/VerticalMediaQueueAction;->callback:Lam0/l;

    if-eqz v6, :done

    iget-object v4, p0, Lradiant/swipe/VerticalMediaQueueAction;->itemId:Ljava/lang/String;

    if-eqz v4, :done

    iget v5, p0, Lradiant/swipe/VerticalMediaQueueAction;->mediaType:I

    if-eqz v5, :done

    const/4 v1, 0x4

    if-ne v5, v1, :queue_event

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-nez v1, :queue_event

    new-instance v1, Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b$a;

    iget-object v2, p0, Lradiant/swipe/VerticalMediaQueueAction;->pageId:Ljava/lang/String;

    iget-object v3, p0, Lradiant/swipe/VerticalMediaQueueAction;->moduleUuid:Ljava/lang/String;

    invoke-direct {v1, v2, v3, v4}, Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b$a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :emit

    :queue_event

    iget-object v1, p0, Lradiant/swipe/VerticalMediaQueueAction;->context:Landroid/content/Context;

    if-eqz v1, :done

    new-instance v0, Lradiant/swipe/DynamicMediaQueueEvent;

    iget-object v2, p0, Lradiant/swipe/VerticalMediaQueueAction;->pageId:Ljava/lang/String;

    iget-object v3, p0, Lradiant/swipe/VerticalMediaQueueAction;->moduleUuid:Ljava/lang/String;

    invoke-direct/range {v0 .. v5}, Lradiant/swipe/DynamicMediaQueueEvent;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    move-object v1, v0

    :emit
    invoke-interface {v6, v1}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lradiant/swipe/VerticalMediaQueueAction;->context:Landroid/content/Context;

    return-void
.end method

.method public stableKey()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lradiant/swipe/VerticalMediaQueueAction;->itemId:Ljava/lang/String;

    if-eqz v0, :invalid

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "vlc:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lradiant/swipe/VerticalMediaQueueAction;->moduleUuid:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget v2, p0, Lradiant/swipe/VerticalMediaQueueAction;->mediaType:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method
