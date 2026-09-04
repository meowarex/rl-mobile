.class public final Lradiant/gestures/queue/ComposeSwipeState$Gesture;
.super Landroidx/compose/ui/input/pointer/PointerInputFilter;
.implements Lam0/l;    # MARKER: R8 Lam0/l;
.implements Landroidx/compose/ui/input/pointer/PointerInputModifier;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/queue/ComposeSwipeState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Gesture"
.end annotation


# instance fields
.field private consumeAfterDispatch:Z

.field private final state:Lradiant/gestures/queue/ComposeSwipeState;


# direct methods
.method public constructor <init>(Lradiant/gestures/queue/ComposeSwipeState;)V
    .locals 0

    invoke-direct {p0}, Landroidx/compose/ui/input/pointer/PointerInputFilter;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    return-void
.end method


# virtual methods
.method public getInterceptOutOfBoundsChildEvents()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public getPointerInputFilter()Landroidx/compose/ui/input/pointer/PointerInputFilter;
    .locals 0

    return-object p0
.end method

.method public invoke(Landroid/view/MotionEvent;)Lkotlin/u;    # MARKER: R8 Lkotlin/u;
    .locals 3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/4 v1, 0x0

    iput-boolean v1, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->consumeAfterDispatch:Z

    if-eqz v0, :down

    const/4 v1, 0x1

    if-eq v0, v1, :up

    const/4 v1, 0x2

    if-eq v0, v1, :move

    const/4 v1, 0x3

    if-eq v0, v1, :cancel

    const/4 v1, 0x5

    if-eq v0, v1, :cancel

    const/4 v1, 0x6

    if-eq v0, v1, :cancel

    goto :done

    :down
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    iget-object v2, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    invoke-virtual {v2, v0, v1}, Lradiant/gestures/queue/ComposeSwipeState;->begin(FF)V

    goto :done

    :move
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    iget-object v2, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    invoke-virtual {v2, v0, v1}, Lradiant/gestures/queue/ComposeSwipeState;->move(FF)V

    goto :done

    :up
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    iget-object v2, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    invoke-virtual {v2, v0, v1}, Lradiant/gestures/queue/ComposeSwipeState;->move(FF)V

    iget-boolean v0, v2, Lradiant/gestures/queue/ComposeSwipeState;->locked:Z

    iput-boolean v0, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->consumeAfterDispatch:Z

    invoke-virtual {v2}, Lradiant/gestures/queue/ComposeSwipeState;->finish()V

    goto :done

    :cancel
    iget-object v0, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    invoke-virtual {v0}, Lradiant/gestures/queue/ComposeSwipeState;->cancelGesture()V

    :done
    sget-object p1, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Landroid/view/MotionEvent;

    invoke-virtual {p0, p1}, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->invoke(Landroid/view/MotionEvent;)Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    move-result-object v0

    return-object v0
.end method

.method public onCancel()V
    .locals 1

    iget-object v0, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    invoke-virtual {v0}, Lradiant/gestures/queue/ComposeSwipeState;->cancelGesture()V

    return-void
.end method

.method public onPointerEvent-H0pRuoY(Landroidx/compose/ui/input/pointer/PointerEvent;Landroidx/compose/ui/input/pointer/PointerEventPass;J)V
    .locals 4

    sget-object v0, Landroidx/compose/ui/input/pointer/PointerEventPass;->Initial:Landroidx/compose/ui/input/pointer/PointerEventPass;

    if-ne p2, v0, :done

    iget-object v0, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->state:Lradiant/gestures/queue/ComposeSwipeState;

    iget-boolean v1, v0, Lradiant/gestures/queue/ComposeSwipeState;->locked:Z

    const/4 v2, 0x0

    iput-boolean v2, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->consumeAfterDispatch:Z

    invoke-virtual {p1}, Landroidx/compose/ui/input/pointer/PointerEvent;->getMotionEvent()Landroid/view/MotionEvent;

    move-result-object v2

    if-eqz v2, :after_dispatch

    invoke-virtual {p0, v2}, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->invoke(Landroid/view/MotionEvent;)Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    :after_dispatch
    iget-boolean v2, p0, Lradiant/gestures/queue/ComposeSwipeState$Gesture;->consumeAfterDispatch:Z

    or-int/2addr v1, v2

    iget-boolean v2, v0, Lradiant/gestures/queue/ComposeSwipeState;->locked:Z

    or-int/2addr v1, v2

    if-eqz v1, :done

    invoke-virtual {p1}, Landroidx/compose/ui/input/pointer/PointerEvent;->getChanges()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    :consume_loop
    if-ge v2, v1, :done

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/compose/ui/input/pointer/PointerInputChange;

    invoke-virtual {v3}, Landroidx/compose/ui/input/pointer/PointerInputChange;->consume()V

    add-int/lit8 v2, v2, 0x1

    goto :consume_loop

    :done
    return-void
.end method
