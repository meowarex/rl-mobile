.class public final Lradiant/gestures/miniplayer/MiniPlayerGestures;
.super Ljava/lang/Object;


# static fields
.field private static a:Landroidx/compose/material3/SheetState;

# True while a swipe up drag owns the sheet
.field private static b:Z

# Current drag offset (relative Y)
.field private static c:F

# Amount of drag already dispatched to AnchoredDraggableState
.field private static d:F

# Y where the swipe up drag started
.field private static e:F

# Fallback Y velocity
.field private static f:F

.field private static g:Landroidx/compose/material3/SheetState;

# Material3 settle lambda
.field private static h:Lam0/l;    # MARKER: R8 Lam0/l;

# Latest MotionEvent eventTime for drag updates
.field private static i:J

# Previous drag offset for fallback velocity
.field private static j:F

# Previous eventTime for fallback velocity
.field private static k:J

# Fallback X velocity (used to prevent horizontal swipe triggering drag)
.field private static l:F

# Previous X for fallback velocity
.field private static m:F

# Latest X seen by the drag tracker
.field private static n:F

.field private static o:Landroid/view/VelocityTracker;

.field private static p:I

# Mini player media state
.field private static r:Z

# AppScaffold context
.field private static s:Lam0/l;    # MARKER: R8 Lam0/l;

.field private static t:Landroidx/compose/material3/SheetState;

.field private static u:Z

# Feedback offset
.field public static v:Landroidx/compose/runtime/MutableFloatState;

.field private static w:Landroid/animation/ValueAnimator;

# Gesture axis lock: 0 = none, 1 = vertical, 2 = horizontal
.field private static x:I

# Swipe gesture start Y
.field private static y:F

# Relative to Y drag offset
.field private static z:F


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Landroidx/compose/runtime/PrimitiveSnapshotStateKt;->mutableFloatStateOf(F)Landroidx/compose/runtime/MutableFloatState;

    move-result-object v0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->v:Landroidx/compose/runtime/MutableFloatState;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static animateSwipeFeedbackReset()V
    .locals 7

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    if-eqz v0, :read_offset

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    :read_offset
    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->v:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v1

    const/4 v3, 0x0

    const/high16 v2, 0x3f000000    # 0.5f

    cmpg-float v1, v1, v2

    if-lez v1, :snap_zero

    const/4 v1, 0x2

    new-array v1, v1, [F

    const/4 v2, 0x0

    aput v0, v1, v2

    const/4 v0, 0x1

    aput v3, v1, v0

    invoke-static {v1}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v1

    const-wide/16 v4, 0xb4    # 180ms

    invoke-virtual {v1, v4, v5}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    new-instance v0, Landroid/view/animation/DecelerateInterpolator;

    const/high16 v4, 0x3fc00000    # 1.5f

    invoke-direct {v0, v4}, Landroid/view/animation/DecelerateInterpolator;-><init>(F)V

    invoke-virtual {v1, v0}, Landroid/animation/ValueAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    new-instance v0, Lradiant/gestures/miniplayer/MiniPlayerGestures$FeedbackResetAnimator;

    invoke-direct {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures$FeedbackResetAnimator;-><init>()V

    invoke-virtual {v1, v0}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    sput-object v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    invoke-virtual {v1}, Landroid/animation/ValueAnimator;->start()V

    return-void

    :snap_zero
    invoke-static {v3}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    return-void
.end method

.method public static beginSwipeFeedback()V
    .locals 1

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    if-eqz v0, :zero

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    :zero
    const/4 v0, 0x0

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    return-void
.end method

.method public static beginSwipeGesture(F)V
    .locals 1

    sput p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->y:F

    const/4 v0, 0x0

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->z:F

    invoke-static {}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->beginSwipeFeedback()V

    return-void
.end method

.method public static applyPendingDrag(Landroidx/compose/material3/SheetState;)V
    .locals 5

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    if-eqz v0, :done

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :done

    invoke-virtual {p0}, Landroidx/compose/material3/SheetState;->getHasExpandedState()Z

    move-result v0

    if-eqz v0, :done

    invoke-virtual {p0}, Landroidx/compose/material3/SheetState;->getAnchoredDraggableState$material3_release()Landroidx/compose/material3/internal/AnchoredDraggableState;

    move-result-object p0

    invoke-virtual {p0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->getAnchors()Landroidx/compose/material3/internal/DraggableAnchors;

    move-result-object v4

    invoke-interface {v4}, Landroidx/compose/material3/internal/DraggableAnchors;->maxAnchor()F

    move-result v4

    # targetOffset = startRawY + dragOffset - hiddenAnchor.
    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->e:F

    sget v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->c:F

    add-float/2addr v0, v1

    sub-float/2addr v0, v4

    sget v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->d:F

    sub-float v2, v0, v1

    const/4 v3, 0x0

    cmpl-float v3, v2, v3

    if-eqz v3, :done

    invoke-virtual {p0, v2}, Landroidx/compose/material3/internal/AnchoredDraggableState;->dispatchRawDelta(F)F

    move-result v2

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->d:F

    add-float/2addr v0, v2

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->d:F

    :done
    return-void
.end method

.method private static addRawMovement(Landroid/view/VelocityTracker;Landroid/view/MotionEvent;)V
    .locals 4

    invoke-static {p1}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    sub-float/2addr v1, v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    sub-float/2addr v2, v3

    invoke-virtual {v0, v1, v2}, Landroid/view/MotionEvent;->offsetLocation(FF)V

    invoke-virtual {p0, v0}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    invoke-virtual {v0}, Landroid/view/MotionEvent;->recycle()V

    return-void
.end method

.method public static beginDrag(Landroidx/compose/material3/SheetState;FFJ)V
    .locals 1

    sput-object p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    const/4 v0, 0x1

    sput-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    sput p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->c:F

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->g:Landroidx/compose/material3/SheetState;

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->h:Lam0/l;    # MARKER: R8 Lam0/l;

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->d:F

    sput p2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->e:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->f:F

    sput p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->j:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->l:F

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->m:F

    sput-wide p3, Lradiant/gestures/miniplayer/MiniPlayerGestures;->i:J

    sput-wide p3, Lradiant/gestures/miniplayer/MiniPlayerGestures;->k:J

    # Try immediately then retry because anchors can be created one frame later
    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->applyPendingDrag(Landroidx/compose/material3/SheetState;)V

    const/16 v0, 0xa

    invoke-static {p0, v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->scheduleApply(Landroidx/compose/material3/SheetState;I)V

    return-void
.end method

.method public static beginMotion(Landroid/view/MotionEvent;)V
    .locals 2

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    if-eqz v0, :obtain

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->recycle()V

    :obtain
    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v1

    sput v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->p:I

    invoke-static {v0, p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->addRawMovement(Landroid/view/VelocityTracker;Landroid/view/MotionEvent;)V

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    sput v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    return-void
.end method

.method public static endDrag(Landroidx/compose/material3/SheetState;)V
    .locals 3

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :done

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->c:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->d:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->e:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->f:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->j:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->l:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->m:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    sget-object v2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    if-eqz v2, :motion_recycled

    invoke-virtual {v2}, Landroid/view/VelocityTracker;->recycle()V

    const/4 v2, 0x0

    sput-object v2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    :motion_recycled

    const/4 v1, 0x0

    sput-object v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    const-wide/16 v0, 0x0

    sput-wide v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->k:J

    :done
    return-void
.end method

.method public static cancelDrag(Landroidx/compose/material3/SheetState;Lam0/l;)V    # MARKER: R8 Lam0/l;
    .locals 1

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->isDragging(Landroidx/compose/material3/SheetState;)Z

    move-result v0

    if-eqz v0, :done

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->endDrag(Landroidx/compose/material3/SheetState;)V

    sget-object p0, Lcom/tidal/android/feature/appscaffold/ui/b$a;->a:Lcom/tidal/android/feature/appscaffold/ui/b$a;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/b$a; a

    invoke-interface {p1, p0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;    # MARKER: R8 Lam0/l;

    :done
    return-void
.end method

.method public static finishDrag(Landroidx/compose/material3/SheetState;Lam0/l;F)V    # MARKER: R8 Lam0/l;
    .locals 6

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->isDragging(Landroidx/compose/material3/SheetState;)Z

    move-result v0

    if-eqz v0, :done

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->g:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :fallback_snap

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->h:Lam0/l;    # MARKER: R8 Lam0/l;

    if-eqz v0, :fallback_snap

    invoke-static {p0, p2}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->prepareSettleVelocity(Landroidx/compose/material3/SheetState;F)F

    move-result p2

    :native_settle

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->endDrag(Landroidx/compose/material3/SheetState;)V

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0

    invoke-interface {v0, p0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;    # MARKER: R8 Lam0/l;

    goto/16 :done

    :fallback_snap

    invoke-virtual {p0}, Landroidx/compose/material3/SheetState;->getAnchoredDraggableState$material3_release()Landroidx/compose/material3/internal/AnchoredDraggableState;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->getAnchors()Landroidx/compose/material3/internal/DraggableAnchors;

    move-result-object v1

    const/4 v5, 0x0

    cmpl-float v3, p2, v5

    if-gtz v3, :target_hidden

    cmpg-float v3, p2, v5

    if-ltz v3, :target_expanded

    invoke-virtual {v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->getOffset()F

    move-result v4

    invoke-interface {v1}, Landroidx/compose/material3/internal/DraggableAnchors;->minAnchor()F

    move-result v5

    invoke-interface {v1}, Landroidx/compose/material3/internal/DraggableAnchors;->maxAnchor()F

    move-result p2

    add-float/2addr v5, p2

    const/high16 p2, 0x40000000    # 2.0f

    div-float/2addr v5, p2

    cmpg-float p2, v4, v5

    if-ltz p2, :target_expanded

    goto :target_hidden

    :target_hidden
    sget-object v2, Landroidx/compose/material3/SheetValue;->Hidden:Landroidx/compose/material3/SheetValue;

    goto :target

    :target_expanded

    sget-object v2, Landroidx/compose/material3/SheetValue;->Expanded:Landroidx/compose/material3/SheetValue;

    :target
    invoke-interface {v1, v2}, Landroidx/compose/material3/internal/DraggableAnchors;->hasAnchorFor(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :close

    invoke-interface {v1, v2}, Landroidx/compose/material3/internal/DraggableAnchors;->positionOf(Ljava/lang/Object;)F

    move-result v3

    invoke-virtual {v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->getOffset()F

    move-result v4

    invoke-static {v4}, Ljava/lang/Float;->isNaN(F)Z

    move-result v5

    if-eqz v5, :have_current

    const/4 v4, 0x0

    :have_current
    sub-float/2addr v3, v4

    invoke-virtual {v0, v3}, Landroidx/compose/material3/internal/AnchoredDraggableState;->dispatchRawDelta(F)F

    invoke-static {v0, v2}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setCurrentValue(Landroidx/compose/material3/internal/AnchoredDraggableState;Ljava/lang/Object;)V

    invoke-static {v0, v2}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setDragTarget(Landroidx/compose/material3/internal/AnchoredDraggableState;Ljava/lang/Object;)V

    const/4 v3, 0x0

    invoke-static {v0, v3}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setLastVelocity(Landroidx/compose/material3/internal/AnchoredDraggableState;F)V

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->endDrag(Landroidx/compose/material3/SheetState;)V

    sget-object v3, Landroidx/compose/material3/SheetValue;->Hidden:Landroidx/compose/material3/SheetValue;

    if-ne v2, v3, :done

    :close
    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->endDrag(Landroidx/compose/material3/SheetState;)V

    sget-object p0, Lcom/tidal/android/feature/appscaffold/ui/b$a;->a:Lcom/tidal/android/feature/appscaffold/ui/b$a;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/b$a; a

    invoke-interface {p1, p0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;    # MARKER: R8 Lam0/l;

    :done
    return-void
.end method

.method public static isDragging(Landroidx/compose/material3/SheetState;)Z
    .locals 1

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    if-eqz v0, :no

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :no

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method

.method public static isAnyDragging()Z
    .locals 1

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    if-nez v0, :yes

    invoke-static {}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->isHorizontalGestureSuppressed()Z

    move-result v0

    return v0

    :yes
    const/4 v0, 0x1

    return v0
.end method

.method public static isHorizontalGestureSuppressed()Z
    .locals 2

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x1

    if-ne v0, v1, :no

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method

.method public static isHorizontalGestureLocked()Z
    .locals 2

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x2

    if-ne v0, v1, :no

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method

.method public static lockHorizontalGesture()Z
    .locals 2

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x1

    if-ne v0, v1, :lock

    const/4 v0, 0x0

    return v0

    :lock
    const/4 v0, 0x2

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v0, 0x1

    return v0

.end method

.method public static resetGestureLock()V
    .locals 1

    const/4 v0, 0x0

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->y:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->z:F

    return-void
.end method

.method public static lockVerticalGesture()Z
    .locals 2

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x2

    if-ne v0, v1, :lock

    const/4 v0, 0x0

    return v0

    :lock
    const/4 v0, 0x1

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    return v0
.end method

.method public static hasMiniPlayerMedia()Z
    .locals 1

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->r:Z

    return v0
.end method

.method public static setHasMiniPlayerMedia(Z)V
    .locals 0

    sput-boolean p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->r:Z

    return-void
.end method

.method public static configure(Lam0/l;Landroidx/compose/material3/SheetState;Z)V    # MARKER: R8 Lam0/l;
    .locals 0

    sput-object p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->s:Lam0/l;    # MARKER: R8 Lam0/l;

    sput-object p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->t:Landroidx/compose/material3/SheetState;

    sput-boolean p2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->u:Z

    return-void
.end method

.method public static clearSwipeFeedbackAnimator(Landroid/animation/ValueAnimator;)V
    .locals 1

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    if-ne v0, p0, :done

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    :done
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

.method public static feedbackModifier(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;
    .locals 1

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures$FeedbackLayer;->INSTANCE:Lradiant/gestures/miniplayer/MiniPlayerGestures$FeedbackLayer;

    invoke-static {p0, v0}, Landroidx/compose/ui/graphics/GraphicsLayerModifierKt;->graphicsLayer(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lam0/l;

    move-result-object p0

    return-object p0
.end method

.method private static clampReleaseVelocity(F)F
    .locals 4

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    invoke-static {}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->minFlingVelocity()F

    move-result v1

    cmpg-float v2, v0, v1

    if-gez v2, :check_max

    const/4 p0, 0x0

    return p0

    :check_max
    const v1, 0x469c4000    # 20000.0f

    cmpl-float v2, v0, v1

    if-lez v2, :return_velocity

    const/4 v2, 0x0

    cmpl-float v3, p0, v2

    if-lez v3, :negative

    move p0, v1

    return p0

    :negative
    neg-float p0, v1

    :return_velocity
    return p0
.end method

.method public static modifier(Landroidx/compose/ui/Modifier;Lam0/l;Landroidx/compose/material3/SheetState;Z)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lam0/l;
    .locals 1

    new-instance v0, Lradiant/gestures/miniplayer/MiniPlayerGestures$Gesture;

    invoke-direct {v0, p1, p2, p3}, Lradiant/gestures/miniplayer/MiniPlayerGestures$Gesture;-><init>(Lam0/l;Landroidx/compose/material3/SheetState;Z)V    # MARKER: R8 Lam0/l;

    invoke-static {p0, v0}, Landroidx/compose/ui/input/pointer/PointerInteropFilter_androidKt;->motionEventSpy(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lam0/l;

    move-result-object p0

    return-object p0
.end method

.method public static trackAreaModifier(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;
    .locals 3

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->s:Lam0/l;    # MARKER: R8 Lam0/l;

    if-eqz v0, :done

    sget-object v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->t:Landroidx/compose/material3/SheetState;

    if-eqz v1, :done

    sget-boolean v2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->u:Z

    invoke-static {p0, v0, v1, v2}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->modifier(Landroidx/compose/ui/Modifier;Lam0/l;Landroidx/compose/material3/SheetState;Z)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lam0/l;

    move-result-object p0

    :done
    return-object p0
.end method

.method public static setSwipeFeedback(F)V
    .locals 5

    const/4 v4, 0x0

    cmpl-float v0, p0, v4

    if-gtz v0, :snap_zero

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    if-eqz v0, :rubber_band

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->w:Landroid/animation/ValueAnimator;

    :rubber_band
    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v1, 0x41800000    # 16.0f dp travel

    invoke-static {v1}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->dp(F)F

    move-result v1

    cmpg-float v2, v0, v1

    if-lez v2, :publish

    sub-float/2addr v0, v1

    const v2, 0x3e19999a    # 0.15f resistance after 16dp

    mul-float/2addr v0, v2

    const/high16 v2, 0x3d800000    # 0.0625f max up travel

    mul-float/2addr v2, v1

    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v0

    add-float/2addr v0, v1

    neg-float p0, v0

    :publish
    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    return-void

    :snap_zero
    invoke-static {v4}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    return-void
.end method

.method public static setSwipeFeedbackFromDrag(F)V
    .locals 3

    sput p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->z:F

    const/4 v0, 0x0

    cmpl-float v1, p0, v0

    if-ltz v1, :maybe_up

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    return-void

    :maybe_up
    const/high16 v0, 0x40c00000    # 6.0f feedback deadzone

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->dp(F)F

    move-result v0

    neg-float v1, v0

    cmpg-float v2, p0, v1

    if-gtz v2, :snap_zero

    add-float/2addr p0, v0

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedback(F)V

    return-void

    :snap_zero
    const/4 v0, 0x0

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    return-void
.end method

.method public static completeSimpleSwipe(Lam0/l;F)Z    # MARKER: R8 Lam0/l;
    .locals 4

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->u:Z

    if-nez v0, :no

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x1

    if-ne v0, v1, :no

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->r:Z

    if-eqz v0, :consume_no

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->y:F

    sub-float/2addr p1, v0

    sput p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->z:F

    const/high16 v0, 0x42400000    # 48.0f release threshold

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->dp(F)F

    move-result v0

    neg-float v0, v0

    cmpg-float v2, p1, v0

    if-lez v2, :open

    :consume_no
    invoke-static {}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->resetGestureLock()V

    const/4 v0, 0x0

    return v0

    :open
    invoke-static {}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->resetGestureLock()V

    sget-object v0, Lcom/tidal/android/feature/appscaffold/ui/b$b;->a:Lcom/tidal/android/feature/appscaffold/ui/b$b;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/b$b; a

    invoke-interface {p0, v0}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;    # MARKER: R8 Lam0/l;

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method

.method public static updateSimpleSwipe(F)Z
    .locals 3

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->u:Z

    if-nez v0, :no

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x1

    if-ne v0, v1, :no

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->y:F

    sub-float/2addr p0, v0

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackFromDrag(F)V

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method

.method public static setSwipeFeedbackDirect(F)V
    .locals 1

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->v:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0, p0}, Landroidx/compose/runtime/MutableFloatState;->setFloatValue(F)V

    return-void
.end method

.method public static suppressHorizontalGestures()V
    .locals 2

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    const/4 v1, 0x2

    if-ne v0, v1, :lock

    return-void

    :lock
    const/4 v0, 0x1

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->x:I

    return-void
.end method

.method private static minFlingVelocity()F
    .locals 2

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    const/high16 v1, 0x42480000    # 50.0f

    mul-float/2addr v0, v1

    return v0
.end method

.method private static prepareSettleVelocity(Landroidx/compose/material3/SheetState;F)F
    .locals 7

    invoke-virtual {p0}, Landroidx/compose/material3/SheetState;->getAnchoredDraggableState$material3_release()Landroidx/compose/material3/internal/AnchoredDraggableState;

    move-result-object p0

    const/4 v6, 0x0

    cmpl-float v0, p1, v6

    if-gtz v0, :target_hidden

    cmpg-float v0, p1, v6

    if-ltz v0, :target_expanded

    invoke-virtual {p0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->getAnchors()Landroidx/compose/material3/internal/DraggableAnchors;

    move-result-object v0

    invoke-virtual {p0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->getOffset()F

    move-result v1

    invoke-interface {v0}, Landroidx/compose/material3/internal/DraggableAnchors;->minAnchor()F

    move-result v2

    invoke-interface {v0}, Landroidx/compose/material3/internal/DraggableAnchors;->maxAnchor()F

    move-result v3

    add-float/2addr v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    cmpg-float v0, v1, v2

    if-ltz v0, :target_expanded

    goto :target_hidden

    :target_expanded
    sget-object v0, Landroidx/compose/material3/SheetValue;->Hidden:Landroidx/compose/material3/SheetValue;

    invoke-static {p0, v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setCurrentValue(Landroidx/compose/material3/internal/AnchoredDraggableState;Ljava/lang/Object;)V

    invoke-static {p0, v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setDragTarget(Landroidx/compose/material3/internal/AnchoredDraggableState;Ljava/lang/Object;)V

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    const v0, 0x453b8000    # 3000.0f

    cmpg-float v1, p1, v0

    if-gez v1, :open_have_min

    move p1, v0

    :open_have_min
    neg-float p1, p1

    invoke-static {p0, p1}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setLastVelocity(Landroidx/compose/material3/internal/AnchoredDraggableState;F)V

    return p1

    :target_hidden
    sget-object v0, Landroidx/compose/material3/SheetValue;->Expanded:Landroidx/compose/material3/SheetValue;

    invoke-static {p0, v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setCurrentValue(Landroidx/compose/material3/internal/AnchoredDraggableState;Ljava/lang/Object;)V

    invoke-static {p0, v0}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setDragTarget(Landroidx/compose/material3/internal/AnchoredDraggableState;Ljava/lang/Object;)V

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    const v0, 0x453b8000    # 3000.0f

    cmpg-float v1, p1, v0

    if-gez v1, :hidden_have_min

    move p1, v0

    :hidden_have_min
    invoke-static {p0, p1}, Landroidx/compose/material3/internal/AnchoredDraggableState;->access$setLastVelocity(Landroidx/compose/material3/internal/AnchoredDraggableState;F)V

    return p1
.end method

.method public static releaseVelocity(Landroidx/compose/material3/SheetState;)F
    .locals 6

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->isDragging(Landroidx/compose/material3/SheetState;)Z

    move-result p0

    if-eqz p0, :zero

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    if-eqz v0, :sampled_velocity

    const/16 v1, 0x3e8

    const v2, 0x469c4000    # 20000.0f

    invoke-virtual {v0, v1, v2}, Landroid/view/VelocityTracker;->computeCurrentVelocity(IF)V

    sget v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->p:I

    invoke-virtual {v0, v1}, Landroid/view/VelocityTracker;->getYVelocity(I)F

    move-result p0

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->clampReleaseVelocity(F)F

    move-result p0

    sget v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->p:I

    invoke-virtual {v0, v1}, Landroid/view/VelocityTracker;->getXVelocity(I)F

    move-result v0

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->clampReleaseVelocity(F)F

    move-result v0

    goto :have_velocity

    :sampled_velocity
    sget p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->f:F

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->clampReleaseVelocity(F)F

    move-result p0

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->l:F

    invoke-static {v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->clampReleaseVelocity(F)F

    move-result v0

    :have_velocity

    const/4 v3, 0x0

    cmpl-float v1, p0, v3

    if-lez v1, :return_done

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v1

    cmpl-float v2, v0, v1

    if-lez v2, :return_done

    const/4 p0, 0x0

    :return_done

    return p0

    :zero
    const/4 p0, 0x0

    return p0
.end method

.method public static rootModifier(Landroidx/compose/ui/Modifier;Lam0/l;Landroidx/compose/material3/SheetState;)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lam0/l;
    .locals 1

    new-instance v0, Lradiant/gestures/miniplayer/MiniPlayerGestures$RootGesture;

    invoke-direct {v0, p1, p2}, Lradiant/gestures/miniplayer/MiniPlayerGestures$RootGesture;-><init>(Lam0/l;Landroidx/compose/material3/SheetState;)V    # MARKER: R8 Lam0/l;

    invoke-static {p0, v0}, Landroidx/compose/ui/input/pointer/PointerInteropFilter_androidKt;->motionEventSpy(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;    # MARKER: R8 Lam0/l;

    move-result-object p0

    return-object p0
.end method

.method public static setSettleCallback(Landroidx/compose/material3/SheetState;Lam0/l;)V    # MARKER: R8 Lam0/l;
    .locals 0

    sput-object p0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->g:Landroidx/compose/material3/SheetState;

    sput-object p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->h:Lam0/l;    # MARKER: R8 Lam0/l;

    return-void
.end method

.method public static trackMotion(Landroid/view/MotionEvent;)V
    .locals 2

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    if-nez v0, :have_tracker

    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->o:Landroid/view/VelocityTracker;

    :have_tracker
    invoke-static {v0, p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->addRawMovement(Landroid/view/VelocityTracker;Landroid/view/MotionEvent;)V

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    sput v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    return-void
.end method

.method public static needsApply(Landroidx/compose/material3/SheetState;)Z
    .locals 3

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    if-eqz v0, :no

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :no

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->c:F

    sget v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->d:F

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v1, 0x3f000000    # 0.5f

    cmpl-float v2, v0, v1

    if-lez v2, :no

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method

.method public static scheduleApply(Landroidx/compose/material3/SheetState;I)V
    .locals 4

    if-lez p1, :done

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;

    invoke-direct {v1, p0, p1}, Lradiant/gestures/miniplayer/MiniPlayerGestures$ApplyPending;-><init>(Landroidx/compose/material3/SheetState;I)V

    const-wide/16 v2, 0x10

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :done
    return-void
.end method

.method public static updateDragTimed(Landroidx/compose/material3/SheetState;FJ)V
    .locals 8

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    if-eqz v0, :done

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :done

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->c:F

    sub-float v0, p1, v0

    const/4 v1, 0x0

    cmpl-float v1, v0, v1

    if-eqz v1, :no_movement

    sput-wide p2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->i:J

    sput p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->c:F

    sget-wide v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->k:J

    sub-long v1, p2, v1

    const-wide/16 v3, 0x28

    cmp-long v5, v1, v3

    if-gez v5, :apply

    :sample_velocity
    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->j:F

    sub-float v0, p1, v0

    long-to-float v1, v1

    const/high16 v2, 0x447a0000    # 1000.0f

    sget v6, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    sget v7, Lradiant/gestures/miniplayer/MiniPlayerGestures;->m:F

    sub-float v6, v6, v7

    mul-float/2addr v6, v2

    div-float/2addr v6, v1

    mul-float/2addr v0, v2

    div-float/2addr v0, v1

    const v1, 0x469c4000    # 20000.0f

    cmpl-float v2, v0, v1

    if-lez v2, :check_min_velocity

    move v0, v1

    goto :store_velocity

    :check_min_velocity

    const v1, -0x3963c000    # -20000.0f

    cmpg-float v2, v0, v1

    if-gez v2, :store_velocity

    move v0, v1

    :store_velocity
    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->f:F

    const v1, 0x469c4000    # 20000.0f

    cmpl-float v2, v6, v1

    if-lez v2, :check_min_x_velocity

    move v6, v1

    goto :store_x_velocity

    :check_min_x_velocity

    const v1, -0x3963c000    # -20000.0f

    cmpg-float v2, v6, v1

    if-gez v2, :store_x_velocity

    move v6, v1

    :store_x_velocity
    sput v6, Lradiant/gestures/miniplayer/MiniPlayerGestures;->l:F

    sput p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->j:F

    sget v6, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    sput v6, Lradiant/gestures/miniplayer/MiniPlayerGestures;->m:F

    sput-wide p2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->k:J

    goto :apply

    :no_movement
    sget-wide v1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->k:J

    sub-long v1, p2, v1

    const-wide/16 v3, 0x50

    cmp-long v5, v1, v3

    if-gtz v5, :reset_velocity

    goto :apply

    :reset_velocity

    const/4 v0, 0x0

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->f:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->l:F

    sput p1, Lradiant/gestures/miniplayer/MiniPlayerGestures;->j:F

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->n:F

    sput v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->m:F

    sput-wide p2, Lradiant/gestures/miniplayer/MiniPlayerGestures;->k:J

    :apply

    invoke-static {p1}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->setSwipeFeedbackFromDrag(F)V

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->applyPendingDrag(Landroidx/compose/material3/SheetState;)V

    const/4 v0, 0x3

    invoke-static {p0, v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->scheduleApply(Landroidx/compose/material3/SheetState;I)V

    :done
    return-void
.end method

.method public static updateDragToYTimed(Landroidx/compose/material3/SheetState;FJ)V
    .locals 1

    sget v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->e:F

    sub-float/2addr p1, v0

    invoke-static {p0, p1, p2, p3}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->updateDragTimed(Landroidx/compose/material3/SheetState;FJ)V

    return-void
.end method

.method public static suppressAutoShow(Landroidx/compose/material3/SheetState;)Z
    .locals 1

    sget-boolean v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->b:Z

    if-eqz v0, :no

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerGestures;->a:Landroidx/compose/material3/SheetState;

    if-ne v0, p0, :no

    invoke-static {p0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->applyPendingDrag(Landroidx/compose/material3/SheetState;)V

    const/4 v0, 0x5

    invoke-static {p0, v0}, Lradiant/gestures/miniplayer/MiniPlayerGestures;->scheduleApply(Landroidx/compose/material3/SheetState;I)V

    const/4 v0, 0x1

    return v0

    :no
    const/4 v0, 0x0

    return v0
.end method
