.class public final Lradiant/AnimatedCoverView;
.super Landroid/view/TextureView;

# interfaces
.implements Landroid/view/TextureView$SurfaceTextureListener;
.implements Landroid/view/View$OnLayoutChangeListener;
.implements Landroid/view/View$OnAttachStateChangeListener;
.implements Ljava/lang/Runnable;


# static fields
.field private static final live:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/ref/WeakReference<",
            "Lradiant/AnimatedCoverView;",
            ">;>;"
        }
    .end annotation
.end field


# instance fields
.field private albumId:I

.field private final fadeIn:Lradiant/FadeIn;

.field private final host:Landroid/view/ViewGroup;

.field private outlined:Z

.field private player:Lradiant/ArtPlayer;

.field private surface:Landroid/view/Surface;

.field private final target:Landroid/widget/ImageView;

.field private url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lradiant/AnimatedCoverView;->live:Ljava/util/ArrayList;

    return-void
.end method

.method private constructor <init>(Landroid/widget/ImageView;Landroid/view/ViewGroup;)V
    .registers 4

    invoke-virtual {p1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/view/TextureView;-><init>(Landroid/content/Context;)V

    const/4 v0, -0x1

    iput v0, p0, Lradiant/AnimatedCoverView;->albumId:I

    new-instance v0, Lradiant/FadeIn;

    invoke-direct {v0, p0}, Lradiant/FadeIn;-><init>(Lradiant/AnimatedCoverView;)V

    iput-object v0, p0, Lradiant/AnimatedCoverView;->fadeIn:Lradiant/FadeIn;

    iput-object p1, p0, Lradiant/AnimatedCoverView;->target:Landroid/widget/ImageView;

    iput-object p2, p0, Lradiant/AnimatedCoverView;->host:Landroid/view/ViewGroup;

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lradiant/AnimatedCoverView;->setOpaque(Z)V

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lradiant/AnimatedCoverView;->setAlpha(F)V

    const/4 p1, 0x4

    invoke-virtual {p0, p1}, Lradiant/AnimatedCoverView;->setVisibility(I)V

    invoke-virtual {p0, p0}, Lradiant/AnimatedCoverView;->setSurfaceTextureListener(Landroid/view/TextureView$SurfaceTextureListener;)V

    const/4 p1, 0x2

    invoke-virtual {p0, p1}, Lradiant/AnimatedCoverView;->setImportantForAccessibility(I)V

    return-void
.end method

.method public static attach(Landroid/widget/ImageView;I)V
    .registers 8

    if-nez p0, :cond_3

    return-void

    :cond_3
    :try_start_3
    invoke-static {p0}, Lradiant/AnimatedCoverView;->find(Landroid/widget/ImageView;)Lradiant/AnimatedCoverView;

    move-result-object v0

    if-nez v0, :cond_60

    invoke-static {p0}, Lradiant/AnimatedCoverView;->frameAncestor(Landroid/view/View;)Landroid/view/ViewGroup;

    move-result-object v0

    if-nez v0, :cond_10

    return-void

    :cond_10
    new-instance v1, Lradiant/AnimatedCoverView;

    invoke-direct {v1, p0, v0}, Lradiant/AnimatedCoverView;-><init>(Landroid/widget/ImageView;Landroid/view/ViewGroup;)V

    invoke-static {}, Landroid/view/View;->generateViewId()I

    move-result v2

    invoke-virtual {v1, v2}, Lradiant/AnimatedCoverView;->setId(I)V

    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p0}, Landroid/widget/ImageView;->getWidth()I

    move-result v3

    const/4 v4, 0x1

    invoke-static {v4, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {p0}, Landroid/widget/ImageView;->getHeight()I

    move-result v5

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0, v1}, Landroid/widget/ImageView;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    invoke-virtual {p0, v1}, Landroid/widget/ImageView;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    invoke-virtual {p0}, Landroid/widget/ImageView;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    instance-of v2, v2, Landroid/view/View;

    if-eqz v2, :cond_52

    invoke-virtual {p0}, Landroid/widget/ImageView;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-eq v2, v0, :cond_52

    invoke-virtual {p0}, Landroid/widget/ImageView;->getParent()Landroid/view/ViewParent;

    move-result-object p0

    check-cast p0, Landroid/view/View;

    invoke-virtual {p0, v1}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    :cond_52
    sget-object p0, Lradiant/AnimatedCoverView;->live:Ljava/util/ArrayList;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-direct {v1}, Lradiant/AnimatedCoverView;->sync()V

    move-object v0, v1

    :cond_60
    iput p1, v0, Lradiant/AnimatedCoverView;->albumId:I

    invoke-direct {v0}, Lradiant/AnimatedCoverView;->refresh()V
    :try_end_65
    .catchall {:try_start_3 .. :try_end_65} :catchall_66

    goto :goto_67

    :catchall_66
    move-exception p0

    :goto_67
    return-void
.end method

.method private static find(Landroid/widget/ImageView;)Lradiant/AnimatedCoverView;
    .registers 4

    sget-object v0, Lradiant/AnimatedCoverView;->live:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_6
    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_23

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lradiant/AnimatedCoverView;

    if-nez v1, :cond_1e

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_6

    :cond_1e
    iget-object v2, v1, Lradiant/AnimatedCoverView;->target:Landroid/widget/ImageView;

    if-ne v2, p0, :cond_6

    return-object v1

    :cond_23
    const/4 p0, 0x0

    return-object p0
.end method

.method private static frameAncestor(Landroid/view/View;)Landroid/view/ViewGroup;
    .registers 2

    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p0

    :goto_4
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_14

    instance-of v0, p0, Landroid/widget/FrameLayout;

    if-eqz v0, :cond_f

    check-cast p0, Landroid/view/ViewGroup;

    return-object p0

    :cond_f
    invoke-interface {p0}, Landroid/view/ViewParent;->getParent()Landroid/view/ViewParent;

    move-result-object p0

    goto :goto_4

    :cond_14
    const/4 p0, 0x0

    return-object p0
.end method

.method private refresh()V
    .registers 3

    iget v0, p0, Lradiant/AnimatedCoverView;->albumId:I

    invoke-static {v0}, Lradiant/AnimatedCovers;->urlFor(I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lradiant/AnimatedCoverView;->url:Ljava/lang/String;

    if-nez v0, :cond_d

    if-nez v1, :cond_14

    goto :goto_13

    :cond_d
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_14

    :goto_13
    return-void

    :cond_14
    invoke-direct {p0}, Lradiant/AnimatedCoverView;->release()V

    iput-object v0, p0, Lradiant/AnimatedCoverView;->url:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lradiant/AnimatedCoverView;->setAlpha(F)V

    if-nez v0, :cond_24

    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Lradiant/AnimatedCoverView;->setVisibility(I)V

    return-void

    :cond_24
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lradiant/AnimatedCoverView;->setVisibility(I)V

    invoke-direct {p0}, Lradiant/AnimatedCoverView;->start()V

    return-void
.end method

.method static refreshAll()V
    .registers 2

    :try_start_0
    sget-object v0, Lradiant/AnimatedCoverView;->live:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_23

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lradiant/AnimatedCoverView;

    if-nez v1, :cond_1e

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_6

    :cond_1e
    invoke-direct {v1}, Lradiant/AnimatedCoverView;->refresh()V
    :try_end_21
    .catchall {:try_start_0 .. :try_end_21} :catchall_22

    goto :goto_6

    :catchall_22
    move-exception v0

    :cond_23
    return-void
.end method

.method private release()V
    .registers 3

    iget-object v0, p0, Lradiant/AnimatedCoverView;->player:Lradiant/ArtPlayer;

    const/4 v1, 0x0

    iput-object v1, p0, Lradiant/AnimatedCoverView;->player:Lradiant/ArtPlayer;

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Lradiant/ArtPlayer;->release()V

    :cond_a
    return-void
.end method

.method private start()V
    .registers 8

    iget-object v0, p0, Lradiant/AnimatedCoverView;->url:Ljava/lang/String;

    if-eqz v0, :cond_25

    iget-object v0, p0, Lradiant/AnimatedCoverView;->surface:Landroid/view/Surface;

    if-eqz v0, :cond_25

    iget-object v0, p0, Lradiant/AnimatedCoverView;->player:Lradiant/ArtPlayer;

    if-eqz v0, :cond_d

    goto :goto_25

    :cond_d
    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lradiant/AnimatedCoverView;->url:Ljava/lang/String;

    iget-object v3, p0, Lradiant/AnimatedCoverView;->surface:Landroid/view/Surface;

    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getWidth()I

    move-result v4

    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getHeight()I

    move-result v5

    iget-object v6, p0, Lradiant/AnimatedCoverView;->fadeIn:Lradiant/FadeIn;

    invoke-static/range {v1 .. v6}, Lradiant/ArtPlayer;->start(Landroid/content/Context;Ljava/lang/String;Landroid/view/Surface;IILjava/lang/Runnable;)Lradiant/ArtPlayer;

    move-result-object v0

    iput-object v0, p0, Lradiant/AnimatedCoverView;->player:Lradiant/ArtPlayer;

    :cond_25
    :goto_25
    return-void
.end method

.method private sync()V
    .registers 8

    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lradiant/AnimatedCoverView;->target:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getWidth()I

    move-result v1

    const/4 v2, 0x1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iget-object v3, p0, Lradiant/AnimatedCoverView;->target:Landroid/widget/ImageView;

    invoke-virtual {v3}, Landroid/widget/ImageView;->getHeight()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    if-eqz v0, :cond_2a

    iget v4, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    if-ne v4, v1, :cond_23

    iget v4, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-eq v4, v3, :cond_2a

    :cond_23
    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v3, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {p0, v0}, Lradiant/AnimatedCoverView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_2a
    iget-object v0, p0, Lradiant/AnimatedCoverView;->target:Landroid/widget/ImageView;

    const/4 v1, 0x0

    move v3, v1

    move v4, v3

    :goto_2f
    if-eqz v0, :cond_58

    iget-object v5, p0, Lradiant/AnimatedCoverView;->host:Landroid/view/ViewGroup;

    if-eq v0, v5, :cond_58

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v5

    int-to-float v5, v5

    invoke-virtual {v0}, Landroid/view/View;->getTranslationX()F

    move-result v6

    add-float/2addr v5, v6

    add-float/2addr v3, v5

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v5

    int-to-float v5, v5

    invoke-virtual {v0}, Landroid/view/View;->getTranslationY()F

    move-result v6

    add-float/2addr v5, v6

    add-float/2addr v4, v5

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    instance-of v5, v0, Landroid/view/View;

    if-eqz v5, :cond_56

    check-cast v0, Landroid/view/View;

    goto :goto_2f

    :cond_56
    const/4 v0, 0x0

    goto :goto_2f

    :cond_58
    if-nez v0, :cond_5b

    return-void

    :cond_5b
    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getLeft()I

    move-result v0

    int-to-float v0, v0

    sub-float/2addr v3, v0

    invoke-virtual {p0, v3}, Lradiant/AnimatedCoverView;->setTranslationX(F)V

    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getTop()I

    move-result v0

    int-to-float v0, v0

    sub-float/2addr v4, v0

    invoke-virtual {p0, v4}, Lradiant/AnimatedCoverView;->setTranslationY(F)V

    iget-boolean v0, p0, Lradiant/AnimatedCoverView;->outlined:Z

    if-nez v0, :cond_8a

    iput-boolean v2, p0, Lradiant/AnimatedCoverView;->outlined:Z

    :try_start_73
    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v3, Lcom/aspiro/wamp/R$dimen;->image_header_corner_radius:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v1
    :try_end_7d
    .catchall {:try_start_73 .. :try_end_7d} :catchall_7e

    goto :goto_7f

    :catchall_7e
    move-exception v0

    :goto_7f
    new-instance v0, Lradiant/RoundOutline;

    invoke-direct {v0, v1}, Lradiant/RoundOutline;-><init>(F)V

    invoke-virtual {p0, v0}, Lradiant/AnimatedCoverView;->setOutlineProvider(Landroid/view/ViewOutlineProvider;)V

    invoke-virtual {p0, v2}, Lradiant/AnimatedCoverView;->setClipToOutline(Z)V

    :cond_8a
    iget-object v0, p0, Lradiant/AnimatedCoverView;->target:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_9c

    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->getVisibility()I

    move-result v0

    if-nez v0, :cond_9c

    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Lradiant/AnimatedCoverView;->setVisibility(I)V

    :cond_9c
    return-void
.end method


# virtual methods
.method onFirstFrame()V
    .registers 4

    invoke-virtual {p0}, Lradiant/AnimatedCoverView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v1, 0x12c

    invoke-virtual {v0, v1, v2}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    return-void
.end method

.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .registers 10

    invoke-virtual {p0, p0}, Lradiant/AnimatedCoverView;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onSurfaceTextureAvailable(Landroid/graphics/SurfaceTexture;II)V
    .registers 4

    new-instance p2, Landroid/view/Surface;

    invoke-direct {p2, p1}, Landroid/view/Surface;-><init>(Landroid/graphics/SurfaceTexture;)V

    iput-object p2, p0, Lradiant/AnimatedCoverView;->surface:Landroid/view/Surface;

    invoke-direct {p0}, Lradiant/AnimatedCoverView;->start()V

    return-void
.end method

.method public onSurfaceTextureDestroyed(Landroid/graphics/SurfaceTexture;)Z
    .registers 3

    invoke-direct {p0}, Lradiant/AnimatedCoverView;->release()V

    const/4 p1, 0x0

    iput-object p1, p0, Lradiant/AnimatedCoverView;->url:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCoverView;->surface:Landroid/view/Surface;

    if-eqz v0, :cond_f

    iget-object v0, p0, Lradiant/AnimatedCoverView;->surface:Landroid/view/Surface;

    invoke-virtual {v0}, Landroid/view/Surface;->release()V

    :cond_f
    iput-object p1, p0, Lradiant/AnimatedCoverView;->surface:Landroid/view/Surface;

    const/4 p1, 0x1

    return p1
.end method

.method public onSurfaceTextureSizeChanged(Landroid/graphics/SurfaceTexture;II)V
    .registers 4

    return-void
.end method

.method public onSurfaceTextureUpdated(Landroid/graphics/SurfaceTexture;)V
    .registers 2

    return-void
.end method

.method public onViewAttachedToWindow(Landroid/view/View;)V
    .registers 2

    :try_start_0
    invoke-direct {p0}, Lradiant/AnimatedCoverView;->refresh()V
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_4

    goto :goto_5

    :catchall_4
    move-exception p1

    :goto_5
    return-void
.end method

.method public onViewDetachedFromWindow(Landroid/view/View;)V
    .registers 2

    invoke-direct {p0}, Lradiant/AnimatedCoverView;->release()V

    const/4 p1, 0x0

    iput-object p1, p0, Lradiant/AnimatedCoverView;->url:Ljava/lang/String;

    return-void
.end method

.method public run()V
    .registers 2

    :try_start_0
    invoke-direct {p0}, Lradiant/AnimatedCoverView;->sync()V
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_4

    goto :goto_5

    :catchall_4
    move-exception v0

    :goto_5
    return-void
.end method
