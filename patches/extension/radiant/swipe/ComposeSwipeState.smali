.class public final Lradiant/swipe/ComposeSwipeState;
.super Ljava/lang/Object;


# instance fields
.field translation:Landroidx/compose/runtime/MutableFloatState;

.field action:Lradiant/swipe/ComposeSwipeAction;

.field context:Landroid/content/Context;

.field view:Landroid/view/View;

.field enabled:Z

.field downX:F

.field downY:F

.field tracking:Z

.field locked:Z

.field armed:Z

.field rowWidth:F

.field animator:Landroid/animation/ValueAnimator;

.field final gesture:Lradiant/swipe/ComposeSwipeState$Gesture;

.field final draw:Lradiant/swipe/ComposeSwipeState$Draw;

.field icon:Landroid/graphics/drawable/Drawable;

.field green:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    invoke-static {v0}, Landroidx/compose/runtime/PrimitiveSnapshotStateKt;->mutableFloatStateOf(F)Landroidx/compose/runtime/MutableFloatState;

    move-result-object v0

    iput-object v0, p0, Lradiant/swipe/ComposeSwipeState;->translation:Landroidx/compose/runtime/MutableFloatState;

    new-instance v0, Lradiant/swipe/ComposeSwipeState$Gesture;

    invoke-direct {v0, p0}, Lradiant/swipe/ComposeSwipeState$Gesture;-><init>(Lradiant/swipe/ComposeSwipeState;)V

    iput-object v0, p0, Lradiant/swipe/ComposeSwipeState;->gesture:Lradiant/swipe/ComposeSwipeState$Gesture;

    new-instance v1, Lradiant/swipe/ComposeSwipeState$Draw;

    invoke-direct {v1, p0}, Lradiant/swipe/ComposeSwipeState$Draw;-><init>(Lradiant/swipe/ComposeSwipeState;)V

    iput-object v1, p0, Lradiant/swipe/ComposeSwipeState;->draw:Lradiant/swipe/ComposeSwipeState$Draw;

    return-void
.end method

.method public static attach(Landroidx/compose/ui/Modifier;Ljava/lang/Object;Lradiant/swipe/ComposeSwipeAction;ZLandroidx/compose/runtime/Composer;)Landroidx/compose/ui/Modifier;
    .locals 5
    .annotation build Landroidx/compose/runtime/Composable;
    .end annotation

    const v0, 0x4a33c921

    invoke-interface {p4, v0}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    invoke-static {}, Landroidx/compose/ui/platform/AndroidCompositionLocals_androidKt;->getLocalView()Landroidx/compose/runtime/ProvidableCompositionLocal;

    move-result-object v0

    invoke-interface {p4, v0}, Landroidx/compose/runtime/Composer;->consume(Landroidx/compose/runtime/CompositionLocal;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-interface {p4, p1}, Landroidx/compose/runtime/Composer;->changed(Ljava/lang/Object;)Z

    move-result v1

    invoke-interface {p4}, Landroidx/compose/runtime/Composer;->rememberedValue()Ljava/lang/Object;

    move-result-object v2

    if-nez v1, :new_state

    sget-object v3, Landroidx/compose/runtime/Composer;->Companion:Landroidx/compose/runtime/Composer$Companion;

    invoke-virtual {v3}, Landroidx/compose/runtime/Composer$Companion;->getEmpty()Ljava/lang/Object;

    move-result-object v3

    if-ne v2, v3, :state_ready

    :new_state
    new-instance v2, Lradiant/swipe/ComposeSwipeState;

    invoke-direct {v2}, Lradiant/swipe/ComposeSwipeState;-><init>()V

    invoke-interface {p4, v2}, Landroidx/compose/runtime/Composer;->updateRememberedValue(Ljava/lang/Object;)V

    :state_ready
    check-cast v2, Lradiant/swipe/ComposeSwipeState;

    invoke-virtual {v2, p2, p3, v0}, Lradiant/swipe/ComposeSwipeState;->update(Lradiant/swipe/ComposeSwipeAction;ZLandroid/view/View;)V

    iget-object v1, v2, Lradiant/swipe/ComposeSwipeState;->gesture:Lradiant/swipe/ComposeSwipeState$Gesture;

    check-cast v1, Landroidx/compose/ui/Modifier;

    invoke-interface {p0, v1}, Landroidx/compose/ui/Modifier;->then(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    iget-object v1, v2, Lradiant/swipe/ComposeSwipeState;->draw:Lradiant/swipe/ComposeSwipeState$Draw;

    invoke-static {p0, v1}, Landroidx/compose/ui/draw/DrawModifierKt;->drawWithContent(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    invoke-interface {p4}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-object p0
.end method


# virtual methods
.method animateReset()V
    .locals 7

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    const/4 v1, 0x0

    if-eqz v0, :read_offset

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    iput-object v1, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    :read_offset
    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->translation:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v2

    const/high16 v3, 0x3f000000 # 0.5f

    cmpg-float v2, v2, v3

    if-lez v2, :snap

    const/4 v2, 0x2

    new-array v2, v2, [F

    const/4 v3, 0x0

    aput v0, v2, v3

    const/4 v0, 0x1

    const/4 v3, 0x0

    aput v3, v2, v0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v0

    const-wide/16 v4, 0xb4

    invoke-virtual {v0, v4, v5}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    new-instance v2, Landroid/view/animation/DecelerateInterpolator;

    const/high16 v4, 0x3fc00000 # 1.5f

    invoke-direct {v2, v4}, Landroid/view/animation/DecelerateInterpolator;-><init>(F)V

    invoke-virtual {v0, v2}, Landroid/animation/ValueAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    new-instance v2, Lradiant/swipe/ComposeSwipeState$ResetAnimator;

    invoke-direct {v2, p0}, Lradiant/swipe/ComposeSwipeState$ResetAnimator;-><init>(Lradiant/swipe/ComposeSwipeState;)V

    invoke-virtual {v0, v2}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    iput-object v0, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    return-void

    :snap
    const/4 v3, 0x0

    invoke-virtual {p0, v3}, Lradiant/swipe/ComposeSwipeState;->setOffset(F)V

    return-void
.end method

.method begin(FF)V
    .locals 3

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->releaseParent()V

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    const/4 v1, 0x0

    if-eqz v0, :initialize

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    iput-object v1, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    :initialize
    iput p1, p0, Lradiant/swipe/ComposeSwipeState;->downX:F

    iput p2, p0, Lradiant/swipe/ComposeSwipeState;->downY:F

    const/4 v0, 0x0

    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->locked:Z

    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    invoke-virtual {p0, v0}, Lradiant/swipe/ComposeSwipeState;->setOffset(F)V

    iget-boolean v2, p0, Lradiant/swipe/ComposeSwipeState;->enabled:Z

    if-eqz v2, :inactive

    iget-object v2, p0, Lradiant/swipe/ComposeSwipeState;->action:Lradiant/swipe/ComposeSwipeAction;

    if-eqz v2, :inactive

    const/4 v0, 0x1

    :inactive
    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->tracking:Z

    return-void
.end method

.method cancelGesture()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->tracking:Z

    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->locked:Z

    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->releaseParent()V

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->animateReset()V

    return-void
.end method

.method clearAnimator(Landroid/animation/ValueAnimator;)V
    .locals 1

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    if-ne v0, p1, :done

    const/4 v0, 0x0

    iput-object v0, p0, Lradiant/swipe/ComposeSwipeState;->animator:Landroid/animation/ValueAnimator;

    :done
    return-void
.end method

.method dp(F)F
    .locals 1

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->context:Landroid/content/Context;

    if-eqz v0, :done

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    :done
    return p1
.end method

.method finish()V
    .locals 3

    iget-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->tracking:Z

    if-eqz v0, :reset_only

    iget-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->locked:Z

    if-eqz v0, :not_complete

    iget-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    if-eqz v0, :not_complete

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->translation:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v0

    invoke-virtual {p0, v0}, Lradiant/swipe/ComposeSwipeState;->isCorrectDirection(F)Z

    move-result v0

    goto :complete_ready

    :not_complete
    const/4 v0, 0x0

    :complete_ready
    const/4 v1, 0x0

    iput-boolean v1, p0, Lradiant/swipe/ComposeSwipeState;->tracking:Z

    iput-boolean v1, p0, Lradiant/swipe/ComposeSwipeState;->locked:Z

    iput-boolean v1, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->releaseParent()V

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->animateReset()V

    if-eqz v0, :done

    invoke-static {}, Lradiant/swipe/ComposeTapGuard;->suppressAfterSwipe()V

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->action:Lradiant/swipe/ComposeSwipeAction;

    if-eqz v0, :done

    invoke-interface {v0}, Lradiant/swipe/ComposeSwipeAction;->invoke()Ljava/lang/Object;

    goto :done

    :reset_only
    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->releaseParent()V

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->animateReset()V

    :done
    return-void
.end method

.method isCorrectDirection(F)Z
    .locals 3

    const/16 v0, __RL_SWIPE_TO_QUEUE_DIRECTION__

    const/4 v1, 0x4

    const/4 v2, 0x0

    if-ne v0, v1, :expect_right

    cmpg-float v0, p1, v2

    if-gez v0, :wrong

    const/4 v0, 0x1

    return v0

    :expect_right
    cmpl-float v0, p1, v2

    if-lez v0, :wrong

    const/4 v0, 0x1

    return v0

    :wrong
    const/4 v0, 0x0

    return v0
.end method

.method move(FF)V
    .locals 8

    iget-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->tracking:Z

    if-eqz v0, :done

    iget v0, p0, Lradiant/swipe/ComposeSwipeState;->downX:F

    sub-float v0, p1, v0

    iget v1, p0, Lradiant/swipe/ComposeSwipeState;->downY:F

    sub-float v1, p2, v1

    iget-boolean v2, p0, Lradiant/swipe/ComposeSwipeState;->locked:Z

    if-nez v2, :publish

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v2

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const/high16 v4, 0x41000000 # 8.0f

    invoke-virtual {p0, v4}, Lradiant/swipe/ComposeSwipeState;->dp(F)F

    move-result v4

    cmpg-float v5, v2, v4

    if-ltz v5, :axis_ready

    cmpg-float v5, v3, v4

    if-gez v5, :done

    :axis_ready
    cmpg-float v5, v2, v3

    if-gtz v5, :horizontal_candidate

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->cancelGesture()V

    return-void

    :horizontal_candidate
    invoke-virtual {p0, v0}, Lradiant/swipe/ComposeSwipeState;->isCorrectDirection(F)Z

    move-result v5

    if-nez v5, :lock

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->cancelGesture()V

    return-void

    :lock
    const/4 v5, 0x1

    iput-boolean v5, p0, Lradiant/swipe/ComposeSwipeState;->locked:Z

    iget-object v6, p0, Lradiant/swipe/ComposeSwipeState;->view:Landroid/view/View;

    if-eqz v6, :publish

    invoke-virtual {v6}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v6

    if-eqz v6, :publish

    invoke-interface {v6, v5}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :publish
    invoke-virtual {p0, v0}, Lradiant/swipe/ComposeSwipeState;->isCorrectDirection(F)Z

    move-result v2

    if-nez v2, :set_offset

    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Lradiant/swipe/ComposeSwipeState;->setOffset(F)V

    iput-boolean v2, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    return-void

    :set_offset
    invoke-virtual {p0, v0}, Lradiant/swipe/ComposeSwipeState;->setOffset(F)V

    iget v2, p0, Lradiant/swipe/ComposeSwipeState;->rowWidth:F

    const/4 v3, 0x0

    cmpg-float v4, v2, v3

    if-lez v4, :done

    const v4, 0x3e99999a # 0.3f

    mul-float/2addr v2, v4

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v2

    if-ltz v0, :below_threshold

    const/4 v0, 0x1

    goto :arm_ready

    :below_threshold
    const/4 v0, 0x0

    :arm_ready
    iget-boolean v1, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    if-eq v0, v1, :done

    iput-boolean v0, p0, Lradiant/swipe/ComposeSwipeState;->armed:Z

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->view:Landroid/view/View;

    if-eqz v0, :done

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->performHapticFeedback(I)Z

    :done
    return-void
.end method

.method releaseParent()V
    .locals 2

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->view:Landroid/view/View;

    if-eqz v0, :done

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :done

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :done
    return-void
.end method

.method setOffset(F)V
    .locals 1

    iget-object v0, p0, Lradiant/swipe/ComposeSwipeState;->translation:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0, p1}, Landroidx/compose/runtime/MutableFloatState;->setFloatValue(F)V

    return-void
.end method

.method update(Lradiant/swipe/ComposeSwipeAction;ZLandroid/view/View;)V
    .locals 4

    iput-object p1, p0, Lradiant/swipe/ComposeSwipeState;->action:Lradiant/swipe/ComposeSwipeAction;

    iput-object p3, p0, Lradiant/swipe/ComposeSwipeState;->view:Landroid/view/View;

    invoke-virtual {p3}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lradiant/swipe/ComposeSwipeState;->context:Landroid/content/Context;

    if-ne v0, v1, :load_resources

    goto :context_ready

    :load_resources
    iput-object v0, p0, Lradiant/swipe/ComposeSwipeState;->context:Landroid/content/Context;

    sget v1, Lcom/aspiro/wamp/R$color;->green:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getColor(I)I

    move-result v1

    iput v1, p0, Lradiant/swipe/ComposeSwipeState;->green:I

    sget v1, Lcom/aspiro/wamp/R$drawable;->ic_add_to_queue_last:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :store_icon

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    :store_icon
    iput-object v1, p0, Lradiant/swipe/ComposeSwipeState;->icon:Landroid/graphics/drawable/Drawable;

    :context_ready
    if-eqz p1, :enabled_ready

    invoke-interface {p1, v0}, Lradiant/swipe/ComposeSwipeAction;->setContext(Landroid/content/Context;)V

    :enabled_ready
    iget-boolean v1, p0, Lradiant/swipe/ComposeSwipeState;->enabled:Z

    iput-boolean p2, p0, Lradiant/swipe/ComposeSwipeState;->enabled:Z

    if-nez v1, :was_enabled

    return-void

    :was_enabled
    if-nez p2, :done

    invoke-virtual {p0}, Lradiant/swipe/ComposeSwipeState;->cancelGesture()V

    :done
    return-void
.end method
