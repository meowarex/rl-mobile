.class public final Lradiant/CoverWaveView;
.super Landroid/graphics/drawable/Drawable;

# interfaces
.implements Landroid/view/View$OnLayoutChangeListener;


# instance fields
.field cover:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .registers 5

    invoke-virtual {p0}, Lradiant/CoverWaveView;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    invoke-virtual {p0}, Lradiant/CoverWaveView;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v1

    const/4 v2, 0x1

    if-le v0, v2, :cond_1c

    if-le v1, v2, :cond_1c

    iget-object v2, p0, Lradiant/CoverWaveView;->cover:Ljava/lang/String;

    int-to-float v0, v0

    int-to-float v1, v1

    invoke-static {p1, v2, v0, v1}, Lradiant/CoverWave;->drawView(Landroid/graphics/Canvas;Ljava/lang/String;FF)V

    :cond_1c
    return-void
.end method

.method public getOpacity()I
    .registers 2

    const/4 v0, -0x3

    return v0
.end method

.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .registers 10

    sub-int/2addr p4, p2

    sub-int/2addr p5, p3

    const/4 p1, 0x0

    invoke-virtual {p0, p1, p1, p4, p5}, Lradiant/CoverWaveView;->setBounds(IIII)V

    return-void
.end method

.method public setAlpha(I)V
    .registers 2

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .registers 2

    return-void
.end method
