.class public final Lradiant/FadeIn;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final view:Lradiant/AnimatedCoverView;


# direct methods
.method constructor <init>(Lradiant/AnimatedCoverView;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/FadeIn;->view:Lradiant/AnimatedCoverView;

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Lradiant/FadeIn;->view:Lradiant/AnimatedCoverView;

    invoke-virtual {v0}, Lradiant/AnimatedCoverView;->onFirstFrame()V

    return-void
.end method
