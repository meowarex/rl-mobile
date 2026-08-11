.class public final Lradiant/gestures/MiniPlayerTrackGestures;
.super Ljava/lang/Object;


# static fields
.field private static a:J

.field public static b:Landroidx/compose/runtime/MutableFloatState;

.field private static c:Landroid/animation/ValueAnimator;

.field private static d:Ljava/lang/Object;

# X at ACTION_DOWN
.field private static e:F

# Y at ACTION_DOWN
.field private static f:F

.field private static g:Z

.field private static h:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Landroidx/compose/runtime/PrimitiveSnapshotStateKt;->mutableFloatStateOf(F)Landroidx/compose/runtime/MutableFloatState;

    move-result-object v0

    sput-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->b:Landroidx/compose/runtime/MutableFloatState;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static animateReset()V
    .locals 7

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    if-eqz v0, :read_offset

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    :read_offset
    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->b:Landroidx/compose/runtime/MutableFloatState;

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

    new-instance v0, Lradiant/gestures/MiniPlayerTrackGestures$ResetAnimator;

    invoke-direct {v0}, Lradiant/gestures/MiniPlayerTrackGestures$ResetAnimator;-><init>()V

    invoke-virtual {v1, v0}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    sput-object v1, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    invoke-virtual {v1}, Landroid/animation/ValueAnimator;->start()V

    return-void

    :snap_zero
    invoke-static {v3}, Lradiant/gestures/MiniPlayerTrackGestures;->setDragOffsetDirect(F)V

    return-void
.end method

.method public static beginDrag(FF)V
    .locals 2

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->resetGestureLock()V

    sput p0, Lradiant/gestures/MiniPlayerTrackGestures;->e:F

    sput p1, Lradiant/gestures/MiniPlayerTrackGestures;->f:F

    const/4 v0, 0x1

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    if-eqz v0, :zero

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    :zero
    const/4 v0, 0x0

    invoke-static {v0}, Lradiant/gestures/MiniPlayerTrackGestures;->setDragOffsetDirect(F)V

    return-void
.end method

.method public static cancelDrag()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->animateReset()V

    return-void
.end method

.method public static clearResetAnimator(Landroid/animation/ValueAnimator;)V
    .locals 1

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    if-ne v0, p0, :done

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    :done
    return-void
.end method

.method public static finishDrag(FF)I
    .locals 5

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->isAnyDragging()Z

    move-result v0

    if-eqz v0, :check_active

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->animateReset()V

    return v0

    :check_active

    sget-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    if-nez v0, :active

    const/4 v0, 0x0

    return v0

    :active
    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    sget-boolean v1, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    sget v2, Lradiant/gestures/MiniPlayerTrackGestures;->e:F

    sub-float/2addr p0, v2

    sget v2, Lradiant/gestures/MiniPlayerTrackGestures;->f:F

    sub-float/2addr p1, v2

    if-eqz v1, :reset

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->suppressTapOpen()V

    :reset
    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->animateReset()V

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v1

    const/high16 v2, 0x42400000    # 48.0f -> at least 48dp horizontal swipe

    invoke-static {v2}, Lradiant/gestures/MiniPlayerTrackGestures;->dp(F)F

    move-result v2

    cmpg-float v3, v1, v2

    if-gez v3, :check_axis

    return v0

    :check_axis
    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    const/high16 v2, 0x3fc00000    # 1.5f -> horizontal distance must dominate vertical mov. by 1.5x

    mul-float/2addr p1, v2

    cmpg-float v1, v1, p1

    if-lez v1, :no_swipe

    const/4 p1, 0x0

    cmpg-float p0, p0, p1

    if-ltz p0, :next

    const/4 v0, 0x1

    return v0

    :next
    const/4 v0, -0x1

    return v0

    :no_swipe
    return v0
.end method

.method public static moveDrag(FF)V
    .locals 6

    sget-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    if-eqz v0, :done

    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->isAnyDragging()Z

    move-result v0

    if-eqz v0, :move_continue

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->animateReset()V

    goto :done

    :move_continue
    sget v0, Lradiant/gestures/MiniPlayerTrackGestures;->e:F

    sub-float/2addr p0, v0

    sget v0, Lradiant/gestures/MiniPlayerTrackGestures;->f:F

    sub-float/2addr p1, v0

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    sget-boolean v2, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    if-nez v2, :publish

    const/high16 v2, 0x40c00000    # 6.0f dp dead zone

    invoke-static {v2}, Lradiant/gestures/MiniPlayerTrackGestures;->dp(F)F

    move-result v2

    cmpg-float v3, v0, v2

    if-gez v3, :move_axis

    goto :done

    :move_axis
    const v2, 0x3f8ccccd    # 1.1f horizontal dominance while dragging

    mul-float/2addr v1, v2

    cmpg-float v2, v0, v1

    if-gez v2, :accept

    goto :done

    :accept
    invoke-static {}, Lradiant/gestures/MiniPlayerGestures;->lockHorizontalGesture()Z

    move-result v2

    if-eqz v2, :cancel_locked

    const/4 v2, 0x1

    sput-boolean v2, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    :publish
    const/4 v2, 0x0

    invoke-static {v2}, Lradiant/gestures/MiniPlayerGestures;->setSwipeFeedbackDirect(F)V

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->suppressTapOpen()V

    invoke-static {p0}, Lradiant/gestures/MiniPlayerTrackGestures;->setDragOffset(F)V

    :done
    return-void

    :cancel_locked
    const/4 v0, 0x0

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->g:Z

    sput-boolean v0, Lradiant/gestures/MiniPlayerTrackGestures;->h:Z

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->animateReset()V

    goto :done
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
    .locals 2

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p0, v0}, Landroidx/compose/ui/ZIndexModifierKt;->zIndex(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;

    move-result-object p0

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;->INSTANCE:Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;

    invoke-static {p0, v0}, Landroidx/compose/ui/graphics/GraphicsLayerModifierKt;->graphicsLayer(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    return-object p0
.end method

.method public static textFeedbackModifier(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;
    .locals 1

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures$TextDraw;->INSTANCE:Lradiant/gestures/MiniPlayerTrackGestures$TextDraw; # text clip on right only

    invoke-static {p0, v0}, Landroidx/compose/ui/draw/DrawModifierKt;->drawWithContent(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    return-object p0
.end method

.method public static onRenderedItem(Ljava/lang/Object;)V
    .locals 2

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->d:Ljava/lang/Object;

    if-eqz v0, :store_initial

    invoke-virtual {v0, p0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :done

    sput-object p0, Lradiant/gestures/MiniPlayerTrackGestures;->d:Ljava/lang/Object;

    invoke-static {}, Lradiant/gestures/MiniPlayerTrackGestures;->animateReset()V

    return-void

    :store_initial
    sput-object p0, Lradiant/gestures/MiniPlayerTrackGestures;->d:Ljava/lang/Object;

    :done
    return-void
.end method

.method public static consumeTapOpenSuppression()Z
    .locals 5

    sget-wide v0, Lradiant/gestures/MiniPlayerTrackGestures;->a:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-nez v4, :check_time

    const/4 v0, 0x0

    return v0

    :check_time
    sput-wide v2, Lradiant/gestures/MiniPlayerTrackGestures;->a:J

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    cmp-long v4, v2, v0

    if-lez v4, :yes

    const/4 v0, 0x0

    return v0

    :yes
    const/4 v0, 0x1

    return v0
.end method

.method public static suppressTapOpen()V
    .locals 4

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x258

    add-long/2addr v0, v2

    sput-wide v0, Lradiant/gestures/MiniPlayerTrackGestures;->a:J

    return-void
.end method

.method public static setDragOffset(F)V
    .locals 5

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    if-eqz v0, :rubber_band

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->c:Landroid/animation/ValueAnimator;

    :rubber_band
    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v1, 0x42800000    # 64.0f dp free travel

    invoke-static {v1}, Lradiant/gestures/MiniPlayerTrackGestures;->dp(F)F

    move-result v1

    cmpg-float v2, v0, v1

    if-lez v2, :publish

    sub-float/2addr v0, v1

    const/high16 v2, 0x3e800000    # 0.25f resistance after 64dp

    mul-float/2addr v0, v2

    const v2, 0x3eb33333    # 0.35f max extra travel

    mul-float/2addr v2, v1

    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v0

    add-float/2addr v0, v1

    const/4 v1, 0x0

    cmpg-float v2, p0, v1

    if-gez v2, :positive

    neg-float p0, v0

    goto :publish

    :positive
    move p0, v0


    :publish
    invoke-static {p0}, Lradiant/gestures/MiniPlayerTrackGestures;->setDragOffsetDirect(F)V

    return-void
.end method

.method public static setDragOffsetDirect(F)V
    .locals 1

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->b:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0, p0}, Landroidx/compose/runtime/MutableFloatState;->setFloatValue(F)V

    return-void
.end method

.method public static trackModifier(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;
    .locals 1

    new-instance v0, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;

    invoke-direct {v0, p1}, Lradiant/gestures/MiniPlayerTrackGestures$Gesture;-><init>(Lam0/l;)V

    invoke-static {p0, v0}, Landroidx/compose/ui/input/pointer/PointerInteropFilter_androidKt;->motionEventSpy(Landroidx/compose/ui/Modifier;Lam0/l;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    return-object p0
.end method
