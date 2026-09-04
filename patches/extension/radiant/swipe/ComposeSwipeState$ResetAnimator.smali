.class public final Lradiant/swipe/ComposeSwipeState$ResetAnimator;
.super Ljava/lang/Object;
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/swipe/ComposeSwipeState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ResetAnimator"
.end annotation


# instance fields
.field private final state:Lradiant/swipe/ComposeSwipeState;


# direct methods
.method public constructor <init>(Lradiant/swipe/ComposeSwipeState;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/ComposeSwipeState$ResetAnimator;->state:Lradiant/swipe/ComposeSwipeState;

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

    iget-object v1, p0, Lradiant/swipe/ComposeSwipeState$ResetAnimator;->state:Lradiant/swipe/ComposeSwipeState;

    invoke-virtual {v1, v0}, Lradiant/swipe/ComposeSwipeState;->setOffset(F)V

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedFraction()F

    move-result v0

    const/high16 v2, 0x3f800000 # 1.0f

    cmpg-float v0, v0, v2

    if-gez v0, :finished

    return-void

    :finished
    invoke-virtual {v1, p1}, Lradiant/swipe/ComposeSwipeState;->clearAnimator(Landroid/animation/ValueAnimator;)V

    return-void
.end method
