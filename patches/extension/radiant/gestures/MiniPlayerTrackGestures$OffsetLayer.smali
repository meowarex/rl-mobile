.class public final Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;
.super Ljava/lang/Object;
.implements Lam0/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/MiniPlayerTrackGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "OffsetLayer"
.end annotation


# static fields
.field public static final INSTANCE:Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;

    invoke-direct {v0}, Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;-><init>()V

    sput-object v0, Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;->INSTANCE:Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final invoke(Landroidx/compose/ui/graphics/GraphicsLayerScope;)Lkotlin/u;
    .locals 1

    sget-object v0, Lradiant/gestures/MiniPlayerTrackGestures;->b:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v0

    invoke-interface {p1, v0}, Landroidx/compose/ui/graphics/GraphicsLayerScope;->setTranslationX(F)V

    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroidx/compose/ui/graphics/GraphicsLayerScope;

    invoke-virtual {p0, p1}, Lradiant/gestures/MiniPlayerTrackGestures$OffsetLayer;->invoke(Landroidx/compose/ui/graphics/GraphicsLayerScope;)Lkotlin/u;

    move-result-object p1

    return-object p1
.end method
