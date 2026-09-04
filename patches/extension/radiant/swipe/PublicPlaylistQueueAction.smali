.class public final Lradiant/swipe/PublicPlaylistQueueAction;
.super Ljava/lang/Object;
.source "PublicPlaylistQueueAction.smali"

# interfaces
.implements Lradiant/swipe/ComposeSwipeAction;


# instance fields
.field private final callback:Lam0/l;

.field private context:Landroid/content/Context;

.field private final itemId:Ljava/lang/String;

.field private final moduleUuid:Ljava/lang/String;

.field private final pageId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lam0/l;Ljava/lang/String;Ljava/lang/String;Lm40/e$d;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->callback:Lam0/l;

    iput-object p2, p0, Lradiant/swipe/PublicPlaylistQueueAction;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/swipe/PublicPlaylistQueueAction;->moduleUuid:Ljava/lang/String;

    iget-object p1, p4, Lm40/e$d;->a:Ljava/lang/String;

    iput-object p1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->itemId:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public invoke(I)Ljava/lang/Object;
    .locals 7

    iget-object v0, p0, Lradiant/swipe/PublicPlaylistQueueAction;->callback:Lam0/l;

    if-eqz v0, :done

    iget-object v1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->context:Landroid/content/Context;

    if-eqz v1, :done

    iget-object v4, p0, Lradiant/swipe/PublicPlaylistQueueAction;->itemId:Ljava/lang/String;

    if-eqz v4, :done

    new-instance v0, Lradiant/swipe/DynamicMediaQueueEvent;

    iget-object v2, p0, Lradiant/swipe/PublicPlaylistQueueAction;->pageId:Ljava/lang/String;

    iget-object v3, p0, Lradiant/swipe/PublicPlaylistQueueAction;->moduleUuid:Ljava/lang/String;

    const/4 v5, 0x3

    move v6, p1

    invoke-direct/range {v0 .. v6}, Lradiant/swipe/DynamicMediaQueueEvent;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    iget-object v1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->callback:Lam0/l;

    invoke-interface {v1, v0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public invoke()Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lradiant/swipe/PublicPlaylistQueueAction;->invoke(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->context:Landroid/content/Context;

    return-void
.end method

.method public stableKey()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "ppl:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->moduleUuid:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lradiant/swipe/PublicPlaylistQueueAction;->itemId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
