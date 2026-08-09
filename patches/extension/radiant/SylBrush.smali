.class public final Lradiant/SylBrush;
.super Landroidx/compose/ui/graphics/ShaderBrush;

# Paints the syllable wipe gradient
# x0 = wipe edge, x1 = end of the soft trail


# instance state

.field public final x0:F

.field public final x1:F

.field public final c0:I

.field public final c1:I


.method public constructor <init>(FFII)V
    .locals 0

    invoke-direct {p0}, Landroidx/compose/ui/graphics/ShaderBrush;-><init>()V

    iput p1, p0, Lradiant/SylBrush;->x0:F

    iput p2, p0, Lradiant/SylBrush;->x1:F

    iput p3, p0, Lradiant/SylBrush;->c0:I

    iput p4, p0, Lradiant/SylBrush;->c1:I

    return-void
.end method


# Gradient across the whole line
.method public createShader-uvyYCjk(J)Landroid/graphics/Shader;
    .locals 8

    new-instance v0, Landroid/graphics/LinearGradient;

    iget v1, p0, Lradiant/SylBrush;->x0:F

    const/4 v2, 0x0

    iget v3, p0, Lradiant/SylBrush;->x1:F

    const/4 v4, 0x0

    iget v5, p0, Lradiant/SylBrush;->c0:I

    iget v6, p0, Lradiant/SylBrush;->c1:I

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFFIILandroid/graphics/Shader$TileMode;)V

    return-object v0
.end method
