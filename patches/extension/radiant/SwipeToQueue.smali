.class public final Lradiant/SwipeToQueue;
.super Landroidx/recyclerview/widget/ItemTouchHelper$SimpleCallback;
.source "SwipeToQueue.smali"


# static fields
.field private static final installed:Ljava/util/WeakHashMap;


# instance fields
.field private final background:Landroid/graphics/drawable/ColorDrawable;

.field private final fragment:Ljava/lang/ref/WeakReference;

.field private final icon:Landroid/graphics/drawable/Drawable;

.field private pendingPosition:I

.field private pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lradiant/SwipeToQueue;->installed:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>(Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 3

    const/4 v0, 0x0

    # ItemTouchHelper.LEFT (0x4) or ItemTouchHelper.RIGHT (0x8)
    const/16 v1, __RL_SWIPE_TO_QUEUE_DIRECTION__

    invoke-direct {p0, v0, v1}, Landroidx/recyclerview/widget/ItemTouchHelper$SimpleCallback;-><init>(II)V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/SwipeToQueue;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {p2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    sget v2, Lcom/aspiro/wamp/R$color;->green:I

    invoke-virtual {v0, v2}, Landroid/content/Context;->getColor(I)I

    move-result v2

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    iput-object v1, p0, Lradiant/SwipeToQueue;->background:Landroid/graphics/drawable/ColorDrawable;

    sget v1, Lcom/aspiro/wamp/R$drawable;->ic_add_to_queue_last:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :store_icon

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    :store_icon
    iput-object v0, p0, Lradiant/SwipeToQueue;->icon:Landroid/graphics/drawable/Drawable;

    return-void
.end method

.method public static install(Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 4

    if-eqz p0, :done

    if-eqz p1, :done

    sget-object v0, Lradiant/SwipeToQueue;->installed:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p1}, Ljava/util/WeakHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :done

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, p1, v1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lradiant/SwipeToQueue;

    invoke-direct {v0, p0, p1}, Lradiant/SwipeToQueue;-><init>(Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;Landroidx/recyclerview/widget/RecyclerView;)V

    new-instance v1, Landroidx/recyclerview/widget/ItemTouchHelper;

    invoke-direct {v1, v0}, Landroidx/recyclerview/widget/ItemTouchHelper;-><init>(Landroidx/recyclerview/widget/ItemTouchHelper$Callback;)V

    invoke-virtual {v1, p1}, Landroidx/recyclerview/widget/ItemTouchHelper;->attachToRecyclerView(Landroidx/recyclerview/widget/RecyclerView;)V

    :done
    return-void
.end method

# virtual methods
.method public getSwipeDirs(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)I
    .locals 4

    iget-object v0, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    if-nez v0, :not_swipeable

    instance-of v0, p2, Ln8/d;

    if-eqz v0, :not_swipeable

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :has_position

    const/4 v0, 0x0

    return v0

    :has_position
    check-cast p2, Ln8/d;

    iget-object v1, p2, Ln8/d;->f:Lcom/aspiro/wamp/model/MediaItem;

    instance-of v2, v1, Lcom/aspiro/wamp/model/FavoriteTrack;

    if-eqz v2, :not_swipeable

    iget-object v2, p0, Lradiant/SwipeToQueue;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;

    if-eqz v2, :not_swipeable

    check-cast v1, Lcom/aspiro/wamp/model/FavoriteTrack;

    invoke-virtual {v2, v0, v1}, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;->Y(ILcom/aspiro/wamp/model/FavoriteTrack;)Z

    move-result v0

    if-eqz v0, :not_swipeable

    const/16 v0, __RL_SWIPE_TO_QUEUE_DIRECTION__

    return v0

    :not_swipeable
    const/4 v0, 0x0

    return v0
.end method

.method public onChildDraw(Landroid/graphics/Canvas;Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;FFIZ)V
    .locals 12

    invoke-super/range {p0 .. p7}, Landroidx/recyclerview/widget/ItemTouchHelper$SimpleCallback;->onChildDraw(Landroid/graphics/Canvas;Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;FFIZ)V

    move/from16 v10, p6

    move/from16 v11, p4

    const/4 v0, 0x1

    if-ne v10, v0, :done

    const/4 v0, 0x0

    int-to-float v0, v0

    const/16 v8, __RL_SWIPE_TO_QUEUE_DIRECTION__

    const/4 v9, 0x4

    if-ne v8, v9, :expect_right

    cmpg-float v8, v11, v0

    if-gez v8, :wrong_direction

    goto :clear_active

    :expect_right
    cmpl-float v8, v11, v0

    if-lez v8, :wrong_direction

    goto :clear_active

    :wrong_direction

    if-eqz p7, :done

    const/4 v0, 0x0

    iput-object v0, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    goto :done

    :clear_active

    iget-object v0, p3, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v3

    invoke-virtual {v0}, Landroid/view/View;->getBottom()I

    move-result v4

    const/16 v8, __RL_SWIPE_TO_QUEUE_DIRECTION__

    const/4 v9, 0x4

    if-ne v8, v9, :right_bounds

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v1

    float-to-int v2, v11

    add-int/2addr v2, v1

    goto :bounds_ready

    :right_bounds
    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v2

    float-to-int v1, v11

    add-int/2addr v1, v2

    :bounds_ready

    sub-int v5, v1, v2

    if-lez v5, :done

    iget-object v6, p0, Lradiant/SwipeToQueue;->background:Landroid/graphics/drawable/ColorDrawable;

    invoke-virtual {v6, v2, v3, v1, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v7

    if-eqz p7, :draw_alpha

    # row width * 3
    mul-int/lit8 v8, v7, 0x3

    # / 10 = 30% of row width (30% threshold)
    div-int/lit8 v8, v8, 0xa

    if-lt v5, v8, :disarm

    invoke-virtual {p3}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result v8

    # RecyclerView.NO_POSITION.
    const/4 v9, -0x1

    if-ne v8, v9, :resolve_action

    goto :draw_alpha

    :resolve_action
    move-object v9, p3

    check-cast v9, Ln8/d;

    iget-object v10, v9, Ln8/d;->f:Lcom/aspiro/wamp/model/MediaItem;

    instance-of v11, v10, Lcom/aspiro/wamp/model/FavoriteTrack;

    if-eqz v11, :draw_alpha

    check-cast v10, Lcom/aspiro/wamp/model/FavoriteTrack;

    iput v8, p0, Lradiant/SwipeToQueue;->pendingPosition:I

    iget-object v8, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    iput-object v10, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    if-nez v8, :draw_alpha

    # HapticFeedbackConstants.CLOCK_TICK
    const/4 v8, 0x4

    invoke-virtual {v0, v8}, Landroid/view/View;->performHapticFeedback(I)Z

    goto :draw_alpha

    :disarm
    iget-object v8, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    if-eqz v8, :clear_pending

    # HapticFeedbackConstants.CLOCK_TICK
    const/4 v8, 0x4

    invoke-virtual {v0, v8}, Landroid/view/View;->performHapticFeedback(I)Z

    :clear_pending
    const/4 v8, 0x0

    iput-object v8, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    goto :draw_alpha

    :draw_alpha
    if-lez v7, :draw_background

    mul-int/lit8 v8, v7, 0x3

    div-int/lit8 v8, v8, 0xa

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

    iget-object v6, p0, Lradiant/SwipeToQueue;->icon:Landroid/graphics/drawable/Drawable;

    if-eqz v6, :done

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v7

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v8

    if-lez v7, :done

    if-lez v8, :done

    # center icon until fixed inset
    sub-int v9, v4, v3

    sub-int/2addr v9, v8

    div-int/lit8 v9, v9, 0x2

    const/16 v10, __RL_SWIPE_TO_QUEUE_DIRECTION__

    const/4 v11, 0x4

    if-ne v10, v11, :right_icon

    sub-int v10, v1, v9

    sub-int v11, v10, v7

    add-int v10, v5, v7

    div-int/lit8 v10, v10, 0x2

    sub-int v10, v1, v10

    invoke-static {v10, v11}, Ljava/lang/Math;->max(II)I

    move-result v10

    goto :icon_positioned

    :right_icon
    add-int v10, v2, v9

    sub-int v11, v5, v7

    div-int/lit8 v11, v11, 0x2

    add-int/2addr v11, v2

    invoke-static {v11, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    :icon_positioned

    add-int v11, v10, v7

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v7

    invoke-virtual {p1, v2, v3, v1, v4}, Landroid/graphics/Canvas;->clipRect(IIII)Z

    add-int v2, v3, v9

    add-int v5, v2, v8

    invoke-virtual {v6, v10, v2, v11, v5}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    const/16 v8, 0xff

    invoke-virtual {v6, v8}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    invoke-virtual {v6, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1, v7}, Landroid/graphics/Canvas;->restoreToCount(I)V

    :done
    return-void
.end method

.method public onMove(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getSwipeEscapeVelocity(F)F
    .locals 1

    # Float.MAX_VALUE
    const v0, 0x7f7fffff

    return v0
.end method

.method public getSwipeThreshold(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)F
    .locals 1

    # 2.0f
    const/high16 v0, 0x40000000

    return v0
.end method

.method public onSelectedChanged(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 3

    const/4 v0, 0x1

    if-ne p2, v0, :release

    if-eqz p1, :dispatch

    const/4 v0, 0x0

    iput-object v0, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    goto :dispatch

    :release
    if-nez p2, :dispatch

    iget v0, p0, Lradiant/SwipeToQueue;->pendingPosition:I

    iget-object v1, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    const/4 v2, 0x0

    iput-object v2, p0, Lradiant/SwipeToQueue;->pendingTrack:Lcom/aspiro/wamp/model/FavoriteTrack;

    if-eqz v1, :dispatch

    iget-object v2, p0, Lradiant/SwipeToQueue;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;

    if-eqz v2, :dispatch

    invoke-virtual {v2, v0, v1}, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;->Z(ILcom/aspiro/wamp/model/FavoriteTrack;)V

    :dispatch
    invoke-super {p0, p1, p2}, Landroidx/recyclerview/widget/ItemTouchHelper$SimpleCallback;->onSelectedChanged(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V

    return-void
.end method

.method public onSwiped(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 1

    # fallback
    iget-object p1, p1, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    const/4 p2, 0x0

    int-to-float v0, p2

    invoke-virtual {p1, v0}, Landroid/view/View;->setTranslationX(F)V

    return-void
.end method
