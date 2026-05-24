.class public final Lradiant/SpvFactory;
.super Ljava/lang/Object;
.implements Lyl0/l;


# static fields
.field public static final a:Lradiant/SpvFactory;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/SpvFactory;

    invoke-direct {v0}, Lradiant/SpvFactory;-><init>()V

    sput-object v0, Lradiant/SpvFactory;->a:Lradiant/SpvFactory;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    check-cast p1, Landroid/content/Context;

    new-instance v0, Lcom/aspiro/wamp/nowplaying/widgets/secondaryProgressView/SecondaryProgressView;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/aspiro/wamp/nowplaying/widgets/secondaryProgressView/SecondaryProgressView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/view/View;->setClickable(Z)V

    return-object v0
.end method
