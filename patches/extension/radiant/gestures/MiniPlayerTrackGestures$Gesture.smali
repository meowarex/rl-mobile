.class public final Lradiant/gestures/MiniPlayerTrackGestures$Gesture;
.super Ljava/lang/Object;
.implements Lam0/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/MiniPlayerTrackGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Gesture"
.end annotation


# instance fields
.field public final a:Lam0/l;


# direct methods
.method public constructor <init>(Lam0/l;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;->a:Lam0/l;

    return-void
.end method

.method private nextTrack()V
    .locals 2

    iget-object v0, p0, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;->a:Lam0/l;

    sget-object v1, Lcom/tidal/android/feature/appscaffold/ui/r$a;->a:Lcom/tidal/android/feature/appscaffold/ui/r$a; # Tidal's built-in next track mini-player event

    invoke-interface {v0, v1}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private previousTrack()V
    .locals 2

    iget-object v0, p0, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;->a:Lam0/l;

    sget-object v1, Lcom/tidal/android/feature/appscaffold/ui/r$c;->a:Lcom/tidal/android/feature/appscaffold/ui/r$c; # Our synthetic previous track event

    invoke-interface {v0, v1}, Lam0/l;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final invoke(Landroid/view/MotionEvent;)Lkotlin/u;
    .locals 3

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
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1
    invoke-static {v0, v1}, Lradiant/gestures/MiniPlayerTrackGestures;->beginDrag(FF)V
    goto :done

    # ACTION_MOVE
    :move
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1
    invoke-static {v0, v1}, Lradiant/gestures/MiniPlayerTrackGestures;->moveDrag(FF)V
    goto :done

    # ACTION_UP
    :up
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1
    invoke-static {v0, v1}, Lradiant/gestures/MiniPlayerTrackGestures;->finishDrag(FF)I

    move-result v0

    if-eqz v0, :done

    # Negative result = swipe left -> next. Positive result = swipe right -> previous
    if-gez v0, :previous

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->suppressTapOpen()V
    invoke-direct {p0}, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;->nextTrack()V
    goto :done

    :previous

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->suppressTapOpen()V
    invoke-direct {p0}, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;->previousTrack()V
    goto :done

    # ACTION_CANCEL
    :cancel
    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->cancelDrag()V

    :done
    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroid/view/MotionEvent;

    invoke-virtual {p0, p1}, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;->invoke(Landroid/view/MotionEvent;)Lkotlin/u;

    move-result-object p1

    return-object p1
.end method
