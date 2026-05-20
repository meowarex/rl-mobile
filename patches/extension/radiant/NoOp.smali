.class public final Lradiant/NoOp;
.super Ljava/lang/Object;
.implements Ltl0/a;


# static fields
.field public static final a:Lradiant/NoOp;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/NoOp;

    invoke-direct {v0}, Lradiant/NoOp;-><init>()V

    sput-object v0, Lradiant/NoOp;->a:Lradiant/NoOp;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final invoke()Ljava/lang/Object;
    .locals 1

    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method
