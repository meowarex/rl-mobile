.class public final Lradiant/gestures/MiniPlayerGestures$Gesture;
.super Ljava/lang/Object;
.implements Lam0/l;

# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/MiniPlayerGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Gesture"
.end annotation


# instance fields
.field public final a:Lam0/l;

# Y at ACTION_DOWN
.field public b:F

# Last Y seen (on this pointer stream)
.field public c:F

# True while this listener owns an active pointer stream
.field public d:Z

# True when sheet drag has started
.field public e:Z

.field public final f:Landroidx/compose/material3/SheetState;

.field public g:F

# X at ACTION_DOWN
.field public i:F

# True once horizontal movement wins (prevents later vertical start)
.field public j:Z

# Drag option enabled
.field public final k:Z


# direct methods
.method public constructor <init>(Lam0/l;Landroidx/compose/material3/SheetState;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->a:Lam0/l;

    iput-object p2, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->f:Landroidx/compose/material3/SheetState;

    iput-boolean p3, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->k:Z

    return-void
.end method

.method private static dp(F)F
    .locals 1

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p0, v0

    return p0
.end method

.method private dragSheet(FJ)V
    .locals 1

    iget-object v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->f:Landroidx/compose/material3/SheetState;

    invoke-static {v0, p1, p2, p3}, Lradiant/gestures/MiniPlayerGestures;->updateDragTimed(Landroidx/compose/material3/SheetState;FJ)V

    return-void
.end method

.method private finishSheet(F)V
    .locals 2

    iget-object v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->f:Landroidx/compose/material3/SheetState;

    iget-object v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->a:Lam0/l;

    invoke-static {v0, v1, p1}, Lradiant/gestures/MiniPlayerGestures;->finishDrag(Landroidx/compose/material3/SheetState;Lam0/l;F)V

    return-void
.end method

.method private openPlayer()V
    .locals 2

    iget-object v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->a:Lam0/l;

    sget-object v1, Lcom/tidal/android/feature/appscaffold/ui/b$b;->a:Lcom/tidal/android/feature/appscaffold/ui/b$b;

    invoke-interface {v0, v1}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private reset()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->d:Z

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->j:Z

    const/4 v0, 0x0

    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->i:F

    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->g:F

    return-void
.end method

.method private startSheet(FJ)V
    .locals 2

    # empty player guard
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->hasMiniPlayerMedia()Z

    move-result v0

    if-nez v0, :start_guard

    return-void

    :start_guard

    # avoid starting twice
    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    if-eqz v0, :start

    return-void

    :start
    const/4 v0, 0x1

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->k:Z

    if-eqz v0, :done

    iget-object v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->f:Landroidx/compose/material3/SheetState;

    iget v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->b:F

    invoke-static {v1, p1, v0, p2, p3}, Lradiant/gestures/MiniPlayerGestures;->beginDrag(Landroidx/compose/material3/SheetState;FFJ)V

    invoke-direct {p0}, Lradiant/gestures/MiniPlayerGestures$Gesture;->openPlayer()V

    :done
    return-void
.end method


# virtual methods
# Listens for MotionEvents
.method public final invoke(Landroid/view/MotionEvent;)Lkotlin/u;
    .locals 11

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    if-eqz v0, :down

    const/4 v1, 0x1

    if-eq v0, v1, :up

    const/4 v1, 0x2

    if-eq v0, v1, :move

    const/4 v1, 0x3

    if-eq v0, v1, :cancel

    goto :done

    # ACTION_DOWN
    :down
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->resetGestureLock()V

    invoke-static {p1}, Lradiant/gestures/MiniPlayerGestures;->beginMotion(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v0

    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->b:F

    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->c:F

    const/4 v0, 0x1

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->d:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    const/4 v0, 0x0

    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->g:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->i:F

    const/4 v0, 0x0

    iput-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->j:Z

    iget v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->b:F

    invoke-static {v0}, Lradiant/gestures/MiniPlayerGestures;->beginSwipeGesture(F)V

    :skip_feedback_down

    goto :done

    # ACTION_MOVE
    :move
    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->d:Z

    if-eqz v0, :done

    invoke-static {p1}, Lradiant/gestures/MiniPlayerGestures;->trackMotion(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v5

    iget v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->c:F

    sub-float v1, v0, v1

    iput v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->g:F

    iget v2, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->b:F

    sub-float v2, v0, v2

    iget-boolean v3, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    if-eqz v3, :maybe_start

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->suppressHorizontalGestures()V

    iget-boolean v3, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->k:Z

    if-eqz v3, :feedback_active

    invoke-direct {p0, v2, v5, v6}, Lradiant/gestures/MiniPlayerGestures$Gesture;->dragSheet(FJ)V

    :feedback_active
    invoke-static {v2}, Lradiant/gestures/MiniPlayerGestures;->setSwipeFeedbackFromDrag(F)V

    goto :store_last

    :maybe_start
    iget-boolean v3, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->j:Z

    if-eqz v3, :axis_check

    goto :store_last

    :axis_check
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    iget v8, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->i:F

    sub-float/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v8

    const/high16 v9, 0x40c00000    # 6.0f axis deadzone

    invoke-static {v9}, Lradiant/gestures/MiniPlayerGestures$Gesture;->dp(F)F

    move-result v9

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->isHorizontalGestureLocked()Z

    move-result v10

    if-eqz v10, :horizontal_check

    const/4 v10, 0x0

    invoke-static {v10}, Lradiant/gestures/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    goto :store_last

    :horizontal_check

    cmpg-float v10, v7, v9

    if-gez v10, :horizontal_dominance

    goto :vertical_check

    :horizontal_dominance

    const v10, 0x3f8ccccd    # 1.1f

    mul-float/2addr v10, v8

    cmpg-float v10, v7, v10

    if-gez v10, :horizontal_wins

    goto :vertical_check

    :horizontal_wins

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->lockHorizontalGesture()Z

    move-result v10

    if-eqz v10, :store_last

    const/4 v10, 0x1

    iput-boolean v10, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->j:Z

    const/4 v10, 0x0

    invoke-static {v10}, Lradiant/gestures/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    goto :store_last

    # At least 16dp up to open the player
    :vertical_check
    neg-float v9, v9

    cmpg-float v10, v2, v9

    if-lez v10, :vertical_dominance

    invoke-static {v2}, Lradiant/gestures/MiniPlayerGestures;->setSwipeFeedbackFromDrag(F)V

    goto :store_last

    :vertical_dominance
    const v10, 0x3f8ccccd    # 1.1f -> early vertical axis lock

    mul-float/2addr v7, v10

    cmpl-float v10, v8, v7

    if-gtz v10, :begin

    goto :store_last

    :begin
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->lockVerticalGesture()Z

    move-result v10

    if-eqz v10, :store_last

    invoke-direct {p0, v2, v5, v6}, Lradiant/gestures/MiniPlayerGestures$Gesture;->startSheet(FJ)V

    iget-boolean v10, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    if-eqz v10, :store_last

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->suppressHorizontalGestures()V

    iget-boolean v10, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->k:Z

    if-eqz v10, :feedback_begin

    invoke-direct {p0, v2, v5, v6}, Lradiant/gestures/MiniPlayerGestures$Gesture;->dragSheet(FJ)V

    :feedback_begin
    invoke-static {v2}, Lradiant/gestures/MiniPlayerGestures;->setSwipeFeedbackFromDrag(F)V


    :store_last
    iput v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->c:F

    goto :done

    # ACTION_UP
    :up
    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->d:Z

    if-eqz v0, :done

    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    if-eqz v0, :up_no_drag

    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->k:Z

    if-eqz v0, :open_simple

    invoke-static {p1}, Lradiant/gestures/MiniPlayerGestures;->trackMotion(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v5

    iget-object v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->f:Landroidx/compose/material3/SheetState;

    invoke-static {v1, v0, v5, v6}, Lradiant/gestures/MiniPlayerGestures;->updateDragToYTimed(Landroidx/compose/material3/SheetState;FJ)V

    invoke-static {v1}, Lradiant/gestures/MiniPlayerGestures;->releaseVelocity(Landroidx/compose/material3/SheetState;)F

    move-result v0

    invoke-direct {p0, v0}, Lradiant/gestures/MiniPlayerGestures$Gesture;->finishSheet(F)V

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    goto :finish

    :up_no_drag
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    goto :finish

    :open_simple
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->suppressHorizontalGestures()V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v0

    iget-object v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->a:Lam0/l;

    invoke-static {v1, v0}, Lradiant/gestures/MiniPlayerGestures;->completeSimpleSwipe(Lam0/l;F)Z

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V


    :finish
    invoke-direct {p0}, Lradiant/gestures/MiniPlayerGestures$Gesture;->reset()V

    goto :done

    # ACTION_CANCEL
    :cancel
    iget-boolean v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->e:Z

    if-eqz v0, :cancel_no_active

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    iget-object v0, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->f:Landroidx/compose/material3/SheetState;

    iget-object v1, p0, Lradiant/gestures/MiniPlayerGestures$Gesture;->a:Lam0/l;

    invoke-static {v0, v1}, Lradiant/gestures/MiniPlayerGestures;->cancelDrag(Landroidx/compose/material3/SheetState;Lam0/l;)V

    goto :cancel_reset

    :cancel_no_active
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->animateSwipeFeedbackReset()V

    :cancel_reset
    invoke-direct {p0}, Lradiant/gestures/MiniPlayerGestures$Gesture;->reset()V


    :done
    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroid/view/MotionEvent;

    invoke-virtual {p0, p1}, Lradiant/gestures/MiniPlayerGestures$Gesture;->invoke(Landroid/view/MotionEvent;)Lkotlin/u;

    move-result-object p1

    return-object p1
.end method
