.class public final Lradiant/swipe/ComposeSwipeState$Draw;
.super Ljava/lang/Object;
.implements Lam0/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/swipe/ComposeSwipeState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Draw"
.end annotation


# instance fields
.field private final state:Lradiant/swipe/ComposeSwipeState;


# direct methods
.method public constructor <init>(Lradiant/swipe/ComposeSwipeState;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/ComposeSwipeState$Draw;->state:Lradiant/swipe/ComposeSwipeState;

    return-void
.end method


# virtual methods
.method public invoke(Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;)Lkotlin/u;
    .locals 16

    move-object/from16 v0, p1

    move-object/from16 v5, p0

    invoke-interface {v0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J

    move-result-wide v1

    invoke-static {v1, v2}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F

    move-result v3

    invoke-static {v1, v2}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F

    move-result v4

    iget-object v5, v5, Lradiant/swipe/ComposeSwipeState$Draw;->state:Lradiant/swipe/ComposeSwipeState;

    iput v3, v5, Lradiant/swipe/ComposeSwipeState;->rowWidth:F

    iget-object v1, v5, Lradiant/swipe/ComposeSwipeState;->translation:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v6

    const/4 v1, 0x0

    cmpl-float v2, v6, v1

    if-eqz v2, :draw_plain

    invoke-interface {v0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object v2

    invoke-interface {v2}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v2

    invoke-static {v2}, Landroidx/compose/ui/graphics/AndroidCanvas_androidKt;->getNativeCanvas(Landroidx/compose/ui/graphics/Canvas;)Landroid/graphics/Canvas;

    move-result-object v7

    invoke-virtual {v7}, Landroid/graphics/Canvas;->save()I

    move-result v8

    cmpg-float v9, v6, v1

    if-gez v9, :right_exposure

    add-float v9, v3, v6

    invoke-static {v1, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    move v10, v3

    goto :exposure_ready

    :right_exposure
    move v9, v1

    invoke-static {v3, v6}, Ljava/lang/Math;->min(FF)F

    move-result v10

    :exposure_ready
    invoke-virtual {v7, v9, v1, v10, v4}, Landroid/graphics/Canvas;->clipRect(FFFF)Z

    invoke-virtual {v5, v6}, Lradiant/swipe/ComposeSwipeState;->actionForOffset(F)I

    move-result v11

    const/4 v12, 0x1

    if-ne v11, v12, :add_color

    const v11, __RL_SWIPE_TO_QUEUE_PLAY_NEXT_COLOR__

    goto :color_ready

    :add_color
    const/4 v12, 0x3

    if-ne v11, v12, :add_to_queue_color

    const v11, __RL_SWIPE_TO_QUEUE_ADD_TO_PLAYLIST_COLOR__

    goto :color_ready

    :add_to_queue_color
    const v11, __RL_SWIPE_TO_QUEUE_ADD_COLOR__

    :color_ready

    invoke-virtual {v7, v11}, Landroid/graphics/Canvas;->drawColor(I)V

    invoke-virtual {v5, v6}, Lradiant/swipe/ComposeSwipeState;->actionForOffset(F)I

    move-result v11

    const/4 v12, 0x1

    if-ne v11, v12, :add_icon

    iget-object v11, v5, Lradiant/swipe/ComposeSwipeState;->playNextIcon:Landroid/graphics/drawable/Drawable;

    goto :icon_ready

    :add_icon
    const/4 v12, 0x3

    if-ne v11, v12, :add_to_queue_icon

    iget-object v11, v5, Lradiant/swipe/ComposeSwipeState;->addToPlaylistIcon:Landroid/graphics/drawable/Drawable;

    goto :icon_ready

    :add_to_queue_icon
    iget-object v11, v5, Lradiant/swipe/ComposeSwipeState;->addIcon:Landroid/graphics/drawable/Drawable;

    :icon_ready

    if-eqz v11, :background_done

    invoke-virtual {v11}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v12

    invoke-virtual {v11}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v13

    if-lez v12, :background_done

    if-lez v13, :background_done

    const/high16 v14, 0x41800000 # 16.0f

    invoke-virtual {v5, v14}, Lradiant/swipe/ComposeSwipeState;->dp(F)F

    move-result v14

    const/4 v15, 0x0

    int-to-float v15, v15

    cmpg-float v15, v6, v15

    if-gez v15, :right_icon

    int-to-float v1, v12

    sub-float v1, v3, v1

    sub-float/2addr v1, v14

    goto :icon_x_ready

    :right_icon
    move v1, v14

    :icon_x_ready
    int-to-float v14, v13

    sub-float v14, v4, v14

    const/high16 v15, 0x40000000 # 2.0f

    div-float/2addr v14, v15

    float-to-int v15, v1

    float-to-int v14, v14

    add-int v1, v15, v12

    add-int v12, v14, v13

    invoke-virtual {v11, v15, v14, v1, v12}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    const/16 v1, 0xff

    invoke-virtual {v11, v1}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    invoke-virtual {v11, v7}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    :background_done
    invoke-virtual {v7, v8}, Landroid/graphics/Canvas;->restoreToCount(I)V

    invoke-virtual {v7}, Landroid/graphics/Canvas;->save()I

    move-result v8

    const/4 v1, 0x0

    invoke-virtual {v7, v1, v1, v3, v4}, Landroid/graphics/Canvas;->clipRect(FFFF)Z

    invoke-virtual {v7, v6, v1}, Landroid/graphics/Canvas;->translate(FF)V

    :try_start_0
    invoke-interface {v0}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->drawContent()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v7, v8}, Landroid/graphics/Canvas;->restoreToCount(I)V

    goto :done

    :catchall_0
    move-exception v0

    invoke-virtual {v7, v8}, Landroid/graphics/Canvas;->restoreToCount(I)V

    throw v0

    :draw_plain
    invoke-interface {v0}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->drawContent()V

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;

    invoke-virtual {p0, p1}, Lradiant/swipe/ComposeSwipeState$Draw;->invoke(Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;)Lkotlin/u;

    move-result-object v0

    return-object v0
.end method
