.class public final Lradiant/RLSwitch;
.super Landroid/graphics/drawable/Drawable;


# instance fields
.field private final enabled:Z

.field private final h:I

.field private final on:Z

.field private final paint:Landroid/graphics/Paint;

.field private final rect:Landroid/graphics/RectF;

.field private final w:I


# direct methods
.method constructor <init>(ZZF)V
    .registers 6

    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lradiant/RLSwitch;->rect:Landroid/graphics/RectF;

    iput-boolean p1, p0, Lradiant/RLSwitch;->on:Z

    iput-boolean p2, p0, Lradiant/RLSwitch;->enabled:Z

    const/high16 p1, 0x42200000    # 40.0f

    mul-float/2addr p1, p3

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    iput p1, p0, Lradiant/RLSwitch;->w:I

    const/high16 p1, 0x41c00000    # 24.0f

    mul-float/2addr p3, p1

    invoke-static {p3}, Ljava/lang/Math;->round(F)I

    move-result p1

    iput p1, p0, Lradiant/RLSwitch;->h:I

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .registers 12

    invoke-virtual {p0}, Lradiant/RLSwitch;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x40000000    # 2.0f

    div-float v3, v2, v3

    iget-boolean v4, p0, Lradiant/RLSwitch;->enabled:Z

    if-eqz v4, :cond_19

    const/16 v4, 0xff

    goto :goto_1b

    :cond_19
    const/16 v4, 0x66

    :goto_1b
    iget-object v5, p0, Lradiant/RLSwitch;->rect:Landroid/graphics/RectF;

    iget v6, v0, Landroid/graphics/Rect;->left:I

    int-to-float v6, v6

    iget v7, v0, Landroid/graphics/Rect;->top:I

    int-to-float v7, v7

    iget v8, v0, Landroid/graphics/Rect;->left:I

    int-to-float v8, v8

    add-float/2addr v8, v1

    iget v9, v0, Landroid/graphics/Rect;->top:I

    int-to-float v9, v9

    add-float/2addr v9, v2

    invoke-virtual {v5, v6, v7, v8, v9}, Landroid/graphics/RectF;->set(FFFF)V

    iget-object v5, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    iget-boolean v6, p0, Lradiant/RLSwitch;->on:Z

    const/4 v7, -0x1

    if-eqz v6, :cond_37

    move v6, v7

    goto :goto_3a

    :cond_37
    const v6, 0x33ffffff

    :goto_3a
    invoke-virtual {v5, v6}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v5, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    iget-boolean v6, p0, Lradiant/RLSwitch;->on:Z

    if-eqz v6, :cond_45

    move v6, v4

    goto :goto_4b

    :cond_45
    const/16 v6, 0x33

    invoke-static {v4, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    :goto_4b
    invoke-virtual {v5, v6}, Landroid/graphics/Paint;->setAlpha(I)V

    iget-object v5, p0, Lradiant/RLSwitch;->rect:Landroid/graphics/RectF;

    iget-object v6, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v5, v3, v3, v6}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    const v5, 0x3e19999a    # 0.15f

    mul-float/2addr v2, v5

    sub-float v2, v3, v2

    iget-boolean v5, p0, Lradiant/RLSwitch;->on:Z

    if-eqz v5, :cond_65

    iget v5, v0, Landroid/graphics/Rect;->left:I

    int-to-float v5, v5

    add-float/2addr v5, v1

    sub-float/2addr v5, v3

    goto :goto_6a

    :cond_65
    iget v1, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    add-float v5, v1, v3

    :goto_6a
    iget-object v1, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    iget-boolean v6, p0, Lradiant/RLSwitch;->on:Z

    if-eqz v6, :cond_72

    const/high16 v7, -0x1000000

    :cond_72
    invoke-virtual {v1, v7}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    iget-boolean v6, p0, Lradiant/RLSwitch;->on:Z

    if-eqz v6, :cond_7c

    goto :goto_85

    :cond_7c
    iget-boolean v4, p0, Lradiant/RLSwitch;->enabled:Z

    if-eqz v4, :cond_83

    const/16 v4, 0xcc

    goto :goto_85

    :cond_83
    const/16 v4, 0x55

    :goto_85
    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setAlpha(I)V

    iget v0, v0, Landroid/graphics/Rect;->top:I

    int-to-float v0, v0

    add-float/2addr v0, v3

    iget-object v1, p0, Lradiant/RLSwitch;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v5, v0, v2, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method

.method public getIntrinsicHeight()I
    .registers 2

    iget v0, p0, Lradiant/RLSwitch;->h:I

    return v0
.end method

.method public getIntrinsicWidth()I
    .registers 2

    iget v0, p0, Lradiant/RLSwitch;->w:I

    return v0
.end method

.method public getOpacity()I
    .registers 2

    const/4 v0, -0x3

    return v0
.end method

.method public setAlpha(I)V
    .registers 2

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .registers 2

    return-void
.end method
