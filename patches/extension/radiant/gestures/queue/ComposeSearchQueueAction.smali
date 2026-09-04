.class public final Lradiant/gestures/queue/ComposeSearchQueueAction;
.super Ljava/lang/Object;
.source "ComposeSearchQueueAction.smali"

# interfaces
.implements Lradiant/gestures/queue/ComposeSwipeAction;


# instance fields
.field private final callback:Lam0/l;    # MARKER: R8 Lam0/l;

.field private context:Landroid/content/Context;

.field private final id:Ljava/lang/String;

.field private final type:I


# direct methods
.method public constructor <init>(Lam0/l;Lpb0/b;)V    # MARKER: R8 Lam0/l; Lpb0/b;
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->callback:Lam0/l;    # MARKER: R8 Lam0/l;

    invoke-static {p2}, Lradiant/gestures/queue/ComposeSearchQueueAction;->key(Lpb0/b;)Ljava/lang/String;    # MARKER: R8 Lpb0/b;

    move-result-object v0

    iput-object v0, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->id:Ljava/lang/String;

    invoke-static {p2}, Lradiant/gestures/queue/ComposeSearchQueueAction;->type(Lpb0/b;)I    # MARKER: R8 Lpb0/b;

    move-result p1

    iput p1, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->type:I

    return-void
.end method

.method public static key(Lpb0/b;)Ljava/lang/String;    # MARKER: R8 Lpb0/b;
    .locals 2

    instance-of v0, p0, Lpb0/b$i;    # MARKER: R8 Lpb0/b$i;

    if-eqz v0, :album

    check-cast p0, Lpb0/b$i;    # MARKER: R8 Lpb0/b$i;

    iget-wide v0, p0, Lpb0/b$i;->a:J    # MARKER: R8 Lpb0/b$i; a

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :album
    instance-of v0, p0, Lpb0/b$a;    # MARKER: R8 Lpb0/b$a;

    if-eqz v0, :playlist

    check-cast p0, Lpb0/b$a;    # MARKER: R8 Lpb0/b$a;

    iget-wide v0, p0, Lpb0/b$a;->a:J    # MARKER: R8 Lpb0/b$a; a

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :playlist
    instance-of v0, p0, Lpb0/b$f;    # MARKER: R8 Lpb0/b$f;

    if-eqz v0, :mix

    check-cast p0, Lpb0/b$f;    # MARKER: R8 Lpb0/b$f;

    iget-object p0, p0, Lpb0/b$f;->a:Ljava/lang/String;    # MARKER: R8 Lpb0/b$f; a

    return-object p0

    :mix
    instance-of v0, p0, Lpb0/b$e;    # MARKER: R8 Lpb0/b$e;

    if-eqz v0, :invalid

    check-cast p0, Lpb0/b$e;    # MARKER: R8 Lpb0/b$e;

    iget-object p0, p0, Lpb0/b$e;->a:Ljava/lang/String;    # MARKER: R8 Lpb0/b$e; a

    return-object p0

    :invalid
    const/4 p0, 0x0

    return-object p0
.end method

.method public stableKey()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->id:Ljava/lang/String;

    if-eqz v0, :invalid

    iget v1, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->type:I

    if-eqz v1, :invalid

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v1, 0x3a

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method private static type(Lpb0/b;)I    # MARKER: R8 Lpb0/b;
    .locals 1

    instance-of v0, p0, Lpb0/b$i;    # MARKER: R8 Lpb0/b$i;

    if-eqz v0, :album

    const/4 p0, 0x1

    return p0

    :album
    instance-of v0, p0, Lpb0/b$a;    # MARKER: R8 Lpb0/b$a;

    if-eqz v0, :playlist

    const/4 p0, 0x2

    return p0

    :playlist
    instance-of v0, p0, Lpb0/b$f;    # MARKER: R8 Lpb0/b$f;

    if-eqz v0, :mix

    const/4 p0, 0x3

    return p0

    :mix
    instance-of p0, p0, Lpb0/b$e;    # MARKER: R8 Lpb0/b$e;

    if-eqz p0, :invalid

    const/4 p0, 0x4

    return p0

    :invalid
    const/4 p0, 0x0

    return p0
.end method


# virtual methods
.method public invoke(I)Ljava/lang/Object;
    .locals 4

    iget-object v0, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->callback:Lam0/l;    # MARKER: R8 Lam0/l;

    if-eqz v0, :done

    iget-object v1, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->context:Landroid/content/Context;

    if-eqz v1, :done

    iget-object v2, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->id:Ljava/lang/String;

    if-eqz v2, :done

    iget v3, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->type:I

    if-eqz v3, :done

    new-instance p0, Lradiant/gestures/queue/ComposeSearchQueueEvent;

    invoke-direct {p0, v1, v2, v3, p1}, Lradiant/gestures/queue/ComposeSearchQueueEvent;-><init>(Landroid/content/Context;Ljava/lang/String;II)V

    invoke-interface {v0, p0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;    # MARKER: R8 Lam0/l;

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object v0
.end method

.method public invoke()Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lradiant/gestures/queue/ComposeSearchQueueAction;->invoke(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lradiant/gestures/queue/ComposeSearchQueueAction;->context:Landroid/content/Context;

    return-void
.end method
