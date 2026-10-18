.class public final Lradiant/RLTopButton;
.super Ljava/lang/Object;

# interfaces
.implements Lyl0/l;
.implements Ljava/lang/Runnable;


# static fields
.field private static final LONG:I = 0x2

.field private static final LONG_FN:Lradiant/RLTopButton;

.field private static final TOUCH:I = 0x1

.field private static final TOUCH_FN:Lradiant/RLTopButton;

.field private static click:Lyl0/a;

.field private static downX:F

.field private static downY:F

.field private static main:Landroid/os/Handler;

.field private static pending:Z


# instance fields
.field private final mode:I


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lradiant/RLTopButton;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lradiant/RLTopButton;-><init>(I)V

    sput-object v0, Lradiant/RLTopButton;->TOUCH_FN:Lradiant/RLTopButton;

    new-instance v0, Lradiant/RLTopButton;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Lradiant/RLTopButton;-><init>(I)V

    sput-object v0, Lradiant/RLTopButton;->LONG_FN:Lradiant/RLTopButton;

    return-void
.end method

.method private constructor <init>(I)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/RLTopButton;->mode:I

    return-void
.end method

.method private static handler()Landroid/os/Handler;
    .registers 2

    sget-object v0, Lradiant/RLTopButton;->main:Landroid/os/Handler;

    if-nez v0, :cond_f

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/RLTopButton;->main:Landroid/os/Handler;

    :cond_f
    return-object v0
.end method

.method private static onTouch(Landroid/view/MotionEvent;)Z
    .registers 7

    invoke-static {}, Lradiant/RLTopButton;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    packed-switch v1, :pswitch_data_7e

    return v3

    :pswitch_e
    sget-object p0, Lradiant/RLTopButton;->LONG_FN:Lradiant/RLTopButton;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    sput-boolean v2, Lradiant/RLTopButton;->pending:Z

    return v3

    :pswitch_16
    sget-boolean v1, Lradiant/RLTopButton;->pending:Z

    if-eqz v1, :cond_49

    invoke-static {}, Lradiant/RLSettings;->app()Landroid/content/Context;

    move-result-object v1

    if-nez v1, :cond_23

    const/16 v1, 0x18

    goto :goto_2b

    :cond_23
    invoke-static {v1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v1

    :goto_2b
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    sget v5, Lradiant/RLTopButton;->downX:F

    sub-float/2addr v4, v5

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getY()F

    move-result p0

    sget v5, Lradiant/RLTopButton;->downY:F

    sub-float/2addr p0, v5

    mul-float/2addr v4, v4

    mul-float/2addr p0, p0

    add-float/2addr v4, p0

    int-to-float p0, v1

    mul-float/2addr p0, p0

    cmpl-float p0, v4, p0

    if-lez p0, :cond_49

    sput-boolean v2, Lradiant/RLTopButton;->pending:Z

    sget-object p0, Lradiant/RLTopButton;->LONG_FN:Lradiant/RLTopButton;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_49
    return v3

    :pswitch_4a
    sget-object p0, Lradiant/RLTopButton;->LONG_FN:Lradiant/RLTopButton;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    sget-boolean p0, Lradiant/RLTopButton;->pending:Z

    if-eqz p0, :cond_5c

    sget-object p0, Lradiant/RLTopButton;->click:Lyl0/a;

    if-eqz p0, :cond_5c

    sget-object p0, Lradiant/RLTopButton;->click:Lyl0/a;

    invoke-interface {p0}, Lyl0/a;->invoke()Ljava/lang/Object;

    :cond_5c
    sput-boolean v2, Lradiant/RLTopButton;->pending:Z

    return v3

    :pswitch_5f
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    sput v1, Lradiant/RLTopButton;->downX:F

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getY()F

    move-result p0

    sput p0, Lradiant/RLTopButton;->downY:F

    sput-boolean v3, Lradiant/RLTopButton;->pending:Z

    sget-object p0, Lradiant/RLTopButton;->LONG_FN:Lradiant/RLTopButton;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    sget-object p0, Lradiant/RLTopButton;->LONG_FN:Lradiant/RLTopButton;

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v1

    int-to-long v1, v1

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return v3

    nop

    :pswitch_data_7e
    .packed-switch 0x0
        :pswitch_5f
        :pswitch_4a
        :pswitch_16
        :pswitch_e
    .end packed-switch
.end method

.method public static wrap(Landroidx/compose/ui/Modifier;Lyl0/a;Landroidx/compose/runtime/Composer;)Landroidx/compose/ui/Modifier;
    .registers 4

    sput-object p1, Lradiant/RLTopButton;->click:Lyl0/a;

    invoke-static {p2}, Lradiant/RLMenu;->longClick(Landroidx/compose/runtime/Composer;)Lyl0/a;

    move-result-object p1

    if-nez p1, :cond_9

    return-object p0

    :cond_9
    sget-object p1, Lradiant/RLTopButton;->TOUCH_FN:Lradiant/RLTopButton;

    const/4 p2, 0x1

    const/4 v0, 0x0

    invoke-static {p0, v0, p1, p2, v0}, Landroidx/compose/ui/input/pointer/PointerInteropFilter_androidKt;->pointerInteropFilter$default(Landroidx/compose/ui/Modifier;Landroidx/compose/ui/input/pointer/RequestDisallowInterceptTouchEvent;Lyl0/l;ILjava/lang/Object;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2

    check-cast p1, Landroid/view/MotionEvent;

    invoke-static {p1}, Lradiant/RLTopButton;->onTouch(Landroid/view/MotionEvent;)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method public run()V
    .registers 2

    sget-boolean v0, Lradiant/RLTopButton;->pending:Z

    if-nez v0, :cond_5

    return-void

    :cond_5
    const/4 v0, 0x0

    sput-boolean v0, Lradiant/RLTopButton;->pending:Z

    invoke-static {}, Lradiant/RLMenu;->openFromButton()V

    return-void
.end method
