.class public final Lradiant/gestures/queue/QueueSwipeRemove;
.super Ljava/lang/Object;
.source "QueueSwipeRemove.smali"


# direct methods
.method public static draw(Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;Landroid/graphics/Canvas;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;FIZ)V
    .locals 10

    const/4 v0, 0x1

    if-ne p4, v0, :done

    iget-object v0, p2, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    const/4 v1, 0x0

    int-to-float v1, v1

    cmpg-float v2, p3, v1

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v3

    invoke-virtual {v0}, Landroid/view/View;->getBottom()I

    move-result v4

    if-gez v2, :right_swipe

    # left swipe
    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v1

    float-to-int v2, p3

    add-int/2addr v2, v1

    goto :bounds_ready

    :right_swipe
    cmpl-float v1, p3, v1

    if-lez v1, :done

    # right swipe
    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v2

    float-to-int v1, p3

    add-int/2addr v1, v2

    :bounds_ready
    sub-int v5, v1, v2

    if-lez v5, :done

    iget-object v6, p0, Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;->c:Landroid/graphics/drawable/ColorDrawable;    # MARKER: R8 c

    invoke-virtual {v6, v2, v3, v1, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v7

    if-lez v7, :draw_background

    # 30% threshold
    mul-int/lit8 v8, v7, 0x3

    div-int/lit8 v8, v8, 0xa

    if-lez v8, :draw_background

    if-eqz p5, :draw_alpha

    if-lt v5, v8, :below_threshold

    const/4 v9, 0x1

    goto :update_haptic

    :below_threshold
    const/4 v9, 0x0

    :update_haptic
    iget-boolean p2, p0, Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;->i:Z    # MARKER: R8 i

    if-eq v9, p2, :draw_alpha

    iput-boolean v9, p0, Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;->i:Z    # MARKER: R8 i

    # CLOCK_TICK
    const/4 p2, 0x4

    invoke-virtual {v0, p2}, Landroid/view/View;->performHapticFeedback(I)Z

    :draw_alpha
    const/16 v9, 0x40

    mul-int/2addr v9, v5

    div-int/2addr v9, v8

    const/16 v8, 0x40

    invoke-static {v9, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    add-int/lit16 v8, v8, 0xbf

    invoke-virtual {v6, v8}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    :draw_background
    invoke-virtual {v6, p1}, Landroid/graphics/drawable/ColorDrawable;->draw(Landroid/graphics/Canvas;)V

    iget-object v6, p0, Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;->h:Landroid/graphics/drawable/Drawable;    # MARKER: R8 h

    if-eqz v6, :done

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v7

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v8

    if-lez v7, :done

    if-lez v8, :done

    sub-int v9, v4, v3

    sub-int/2addr v9, v8

    div-int/lit8 v9, v9, 0x2

    const/4 p2, 0x0

    int-to-float p2, p2

    cmpg-float p2, p3, p2

    if-gez p2, :right_icon

    sub-int p2, v1, v9

    sub-int p4, p2, v7

    add-int p2, v5, v7

    div-int/lit8 p2, p2, 0x2

    sub-int p2, v1, p2

    invoke-static {p2, p4}, Ljava/lang/Math;->max(II)I

    move-result p2

    goto :icon_positioned

    :right_icon
    add-int p2, v2, v9

    sub-int p4, v5, v7

    div-int/lit8 p4, p4, 0x2

    add-int/2addr p4, v2

    invoke-static {p4, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    :icon_positioned
    add-int p4, p2, v7

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v7

    invoke-virtual {p1, v2, v3, v1, v4}, Landroid/graphics/Canvas;->clipRect(IIII)Z

    add-int v2, v3, v9

    add-int v3, v2, v8

    invoke-virtual {v6, p2, v2, p4, v3}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    const/16 v8, 0xff

    invoke-virtual {v6, v8}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    invoke-virtual {v6, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1, v7}, Landroid/graphics/Canvas;->restoreToCount(I)V

    :done
    return-void
.end method

.method public static setRemoveDuration(Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 2

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView;->getItemAnimator()Landroidx/recyclerview/widget/RecyclerView$ItemAnimator;

    move-result-object p0

    if-eqz p0, :done

    # 80ms (faster animation, native is 120ms)
    const-wide/16 v0, 0x50

    invoke-virtual {p0, v0, v1}, Landroidx/recyclerview/widget/RecyclerView$ItemAnimator;->setRemoveDuration(J)V

    :done
    return-void
.end method
