.class public final Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;
.super Ljava/lang/Object;
.implements Lam0/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lradiant/gestures/MiniPlayerGestures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FeedbackLayer"
.end annotation


# static fields
.field public static final INSTANCE:Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;

    invoke-direct {v0}, Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;-><init>()V

    sput-object v0, Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;->INSTANCE:Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;

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

    sget-object v0, Lradiant/gestures/MiniPlayerGestures;->v:Landroidx/compose/runtime/MutableFloatState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F

    move-result v0

    invoke-interface {p1, v0}, Landroidx/compose/ui/graphics/GraphicsLayerScope;->setTranslationY(F)V

    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroidx/compose/ui/graphics/GraphicsLayerScope;

    invoke-virtual {p0, p1}, Lradiant/gestures/MiniPlayerGestures$FeedbackLayer;->invoke(Landroidx/compose/ui/graphics/GraphicsLayerScope;)Lkotlin/u;

    move-result-object p1

    return-object p1
.end method
