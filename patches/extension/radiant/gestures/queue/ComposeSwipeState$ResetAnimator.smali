.class public final Lradiant/gestures/queue/ComposeSwipeState$ResetAnimator;
.super Ljava/lang/Object;
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/queue/ComposeSwipeState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ResetAnimator"
.end annotation


# instance fields
.field private final state:Lradiant/gestures/queue/ComposeSwipeState;


# direct methods
.method public constructor <init>(Lradiant/gestures/queue/ComposeSwipeState;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/ComposeSwipeState$ResetAnimator;->state:Lradiant/gestures/queue/ComposeSwipeState;

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 3

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iget-object v1, p0, Lradiant/gestures/queue/ComposeSwipeState$ResetAnimator;->state:Lradiant/gestures/queue/ComposeSwipeState;

    invoke-virtual {v1, v0}, Lradiant/gestures/queue/ComposeSwipeState;->setOffset(F)V

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedFraction()F

    move-result v0

    const/high16 v2, 0x3f800000 # 1.0f

    cmpg-float v0, v0, v2

    if-gez v0, :finished

    return-void

    :finished
    invoke-virtual {v1, p1}, Lradiant/gestures/queue/ComposeSwipeState;->clearAnimator(Landroid/animation/ValueAnimator;)V

    return-void
.end method
