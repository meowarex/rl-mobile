.class public final Lradiant/PlayerAction;
.super Ljava/lang/Object;
.implements Lyl0/a;    # MARKER: R8 Lyl0/a;

# Click lambda that sends a player action


# instance fields
.field public final a:Lyl0/l;    # MARKER: R8 Lyl0/l;

.field public final b:Ljava/lang/Object;


# direct methods
.method public constructor <init>(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    check-cast p1, Lyl0/l;    # MARKER: R8 Lyl0/l;

    iput-object p1, p0, Lradiant/PlayerAction;->a:Lyl0/l;    # MARKER: R8 Lyl0/l;

    iput-object p2, p0, Lradiant/PlayerAction;->b:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final invoke()Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lradiant/PlayerAction;->a:Lyl0/l;    # MARKER: R8 Lyl0/l;

    iget-object v1, p0, Lradiant/PlayerAction;->b:Ljava/lang/Object;

    invoke-interface {v0, v1}, Lyl0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;    # MARKER: R8 Lyl0/l;

    sget-object v0, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object v0
.end method
