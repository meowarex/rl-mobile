.class Lradiant/PebbleBridge$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lradiant/PebbleBridge;->onPosition(J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$at:J

.field final synthetic val$position:J


# direct methods
.method constructor <init>(JJ)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-wide p1, p0, Lradiant/PebbleBridge$1;->val$position:J

    iput-wide p3, p0, Lradiant/PebbleBridge$1;->val$at:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 5

    iget-wide v0, p0, Lradiant/PebbleBridge$1;->val$position:J

    iget-wide v2, p0, Lradiant/PebbleBridge$1;->val$at:J

    # invokes: Lradiant/PebbleBridge;->onSample(JJ)V
    invoke-static {v0, v1, v2, v3}, Lradiant/PebbleBridge;->access$000(JJ)V

    return-void
.end method
