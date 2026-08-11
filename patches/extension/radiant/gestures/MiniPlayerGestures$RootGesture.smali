.class public final Lradiant/gestures/MiniPlayerGestures$RootGesture;
.super Ljava/lang/Object;
.implements Lam0/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/MiniPlayerGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "RootGesture"
.end annotation


# instance fields
.field public final a:Lam0/l;

.field public final b:Landroidx/compose/material3/SheetState;


# direct methods
.method public constructor <init>(Lam0/l;Landroidx/compose/material3/SheetState;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/MiniPlayerGestures$RootGesture;->a:Lam0/l;

    iput-object p2, p0, Lradiant/gestures/MiniPlayerGestures$RootGesture;->b:Landroidx/compose/material3/SheetState;

    return-void
.end method


# virtual methods
.method public final invoke(Landroid/view/MotionEvent;)Lkotlin/u;
    .locals 6

    iget-object v0, p0, Lradiant/gestures/MiniPlayerGestures$RootGesture;->b:Landroidx/compose/material3/SheetState;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    invoke-static {v0}, Lradiant/gestures/MiniPlayerGestures;->isDragging(Landroidx/compose/material3/SheetState;)Z

    move-result v2

    if-eqz v2, :maybe_reset_only

    const/4 v2, 0x1

    if-eq v1, v2, :up

    const/4 v2, 0x2

    if-eq v1, v2, :move

    const/4 v2, 0x3

    if-eq v1, v2, :cancel

    goto :done

    :maybe_reset_only
    const/4 v2, 0x1

    if-eq v1, v2, :simple_up

    const/4 v2, 0x3

    if-eq v1, v2, :reset_only

    const/4 v2, 0x2

    if-eq v1, v2, :simple_move

    goto :done

    :reset_only
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->resetGestureLock()V

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    goto :done

    :simple_move
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    invoke-static {v1}, Lradiant/gestures/MiniPlayerGestures;->updateSimpleSwipe(F)Z

    goto :done

    :simple_up
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    iget-object v2, p0, Lradiant/gestures/MiniPlayerGestures$RootGesture;->a:Lam0/l;

    invoke-static {v2, v1}, Lradiant/gestures/MiniPlayerGestures;->completeSimpleSwipe(Lam0/l;F)Z

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    goto :done


    # ACTION_MOVE
    :move
    invoke-static {p1}, Lradiant/gestures/MiniPlayerGestures;->trackMotion(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v4

    invoke-static {v0, v2, v4, v5}, Lradiant/gestures/MiniPlayerGestures;->updateDragToYTimed(Landroidx/compose/material3/SheetState;FJ)V

    goto :done

    # ACTION_UP
    :up
    invoke-static {p1}, Lradiant/gestures/MiniPlayerGestures;->trackMotion(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v4

    invoke-static {v0, v1, v4, v5}, Lradiant/gestures/MiniPlayerGestures;->updateDragToYTimed(Landroidx/compose/material3/SheetState;FJ)V

    invoke-static {v0}, Lradiant/gestures/MiniPlayerGestures;->releaseVelocity(Landroidx/compose/material3/SheetState;)F

    move-result v1

    iget-object v2, p0, Lradiant/gestures/MiniPlayerGestures$RootGesture;->a:Lam0/l;

    invoke-static {v0, v2, v1}, Lradiant/gestures/MiniPlayerGestures;->finishDrag(Landroidx/compose/material3/SheetState;Lam0/l;F)V

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    goto :done

    # ACTION_CANCEL
    :cancel
    iget-object v2, p0, Lradiant/gestures/MiniPlayerGestures$RootGesture;->a:Lam0/l;

    invoke-static {v0, v2}, Lradiant/gestures/MiniPlayerGestures;->cancelDrag(Landroidx/compose/material3/SheetState;Lam0/l;)V

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    :done
    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroid/view/MotionEvent;

    invoke-virtual {p0, p1}, Lradiant/gestures/MiniPlayerGestures$RootGesture;->invoke(Landroid/view/MotionEvent;)Lkotlin/u;

    move-result-object p1

    return-object p1
.end method
