.class public final Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/miniplayer/MiniPlayerGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ApplyPending"
.end annotation


# instance fields
.field public final a:Landroidx/compose/material3/SheetState;

.field public final b:I


# direct methods
.method public constructor <init>(Landroidx/compose/material3/SheetState;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;->a:Landroidx/compose/material3/SheetState;

    iput p2, p0, Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;->b:I

    return-void
.end method


# virtual methods
# Apply once, then re schedule if there is still pending movement
# -> Sheet anchors can appear one (or more) frames after opening the player, so this keeps applying the latest drag until no delta remains
.method public final run()V
    .locals 3

    iget-object v0, p0, Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;->a:Landroidx/compose/material3/SheetState;

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->applyPendingDrag(Landroidx/compose/material3/SheetState;)V

    iget v1, p0, Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;->b:I

    add-int/lit8 v1, v1, -0x1

    if-lez v1, :done

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->needsApply(Landroidx/compose/material3/SheetState;)Z

    move-result v2

    if-eqz v2, :done

    invoke-static {v0, v1}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->scheduleApply(Landroidx/compose/material3/SheetState;I)V

    :done
    return-void
.end method
