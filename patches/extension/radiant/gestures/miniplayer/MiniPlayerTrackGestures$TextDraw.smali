.class public final Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;
.super Ljava/lang/Object;
.implements Lam0/l;    # MARKER: R8 Lam0/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/miniplayer/MiniPlayerTrackGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TextDraw"
.end annotation


# static fields
.field public static final INSTANCE:Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;

    invoke-direct {v0}, Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;-><init>()V

    sput-object v0, Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;->INSTANCE:Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final invoke(Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;)Lkotlin/u;    # MARKER: R8 Lkotlin/u;
    .locals 12

    sget-object v0, Lradiant/gestures/miniplayer/MiniPlayerTrackGestures;->b:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v10

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object v7

    invoke-interface {v7}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getSize-NH-jbRc()J

    move-result-wide v8

    const/16 v0, 0x20

    shr-long v1, v8, v0

    long-to-int v1, v1

    invoke-static {v1}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v4

    invoke-interface {v7}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/ui/graphics/Canvas;->save()V

    :try_start_0
    sget-object v0, Landroidx/compose/ui/graphics/ClipOp;->Companion:Landroidx/compose/ui/graphics/ClipOp$Companion;

    invoke-virtual {v0}, Landroidx/compose/ui/graphics/ClipOp$Companion;->getIntersect-rtfAjoo()I

    move-result v6

    invoke-interface {v7}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getTransform()Landroidx/compose/ui/graphics/drawscope/DrawTransform;

    move-result-object v1

    const v2, -0x800001 # -Float.MAX_VALUE -> unbounded left

    const v3, -0x800001 # -Float.MAX_VALUE -> unbounded top

    const v5, 0x7f7fffff # Float.MAX_VALUE -> unbounded bottom

    invoke-interface/range {v1 .. v6}, Landroidx/compose/ui/graphics/drawscope/DrawTransform;->clipRect-N_I0leg(FFFFI)V

    const/4 v0, 0x0

    invoke-interface {v1, v10, v0}, Landroidx/compose/ui/graphics/drawscope/DrawTransform;->translate(FF)V

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->drawContent()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-interface {v7}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v0

    invoke-interface {v0}, Landroidx/compose/ui/graphics/Canvas;->restore()V

    invoke-interface {v7, v8, v9}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->setSize-uvyYCjk(J)V

    sget-object p1, Lkotlin/u;->a:Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    return-object p1

    :catchall_0
    move-exception v0

    invoke-interface {v7}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v1

    invoke-interface {v1}, Landroidx/compose/ui/graphics/Canvas;->restore()V

    invoke-interface {v7, v8, v9}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->setSize-uvyYCjk(J)V

    throw v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;

    invoke-virtual {p0, p1}, Lradiant/gestures/miniplayer/MiniPlayerTrackGestures$TextDraw;->invoke(Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;)Lkotlin/u;    # MARKER: R8 Lkotlin/u;

    move-result-object p1

    return-object p1
.end method
