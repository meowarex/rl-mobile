.class Lradiant/PebbleBridge$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lradiant/PebbleBridge;->onLyrics(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    # getter for: Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;
    invoke-static {}, Lradiant/PebbleBridge;->access$100()Lradiant/PebbleBridge;

    move-result-object v0

    if-eqz v0, :cond_d

    # getter for: Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;
    invoke-static {}, Lradiant/PebbleBridge;->access$100()Lradiant/PebbleBridge;

    move-result-object v0

    # invokes: Lradiant/PebbleBridge;->sendLyrics()V
    invoke-static {v0}, Lradiant/PebbleBridge;->access$200(Lradiant/PebbleBridge;)V

    :cond_d
    return-void
.end method
