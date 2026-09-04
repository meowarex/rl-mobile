.class public final Lradiant/MiniSeekerLine;
.super Ljava/lang/Object;


# static fields
.field public static progressState:Landroidx/compose/runtime/MutableFloatState;

.field public static volatile vm:Lgh/j;    # MARKER: R8 Lgh/j;

.field public static volatile sub:Lio/reactivex/disposables/Disposable;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0    # initial progress

    invoke-static {v0}, Landroidx/compose/runtime/PrimitiveSnapshotStateKt;->mutableFloatStateOf(F)Landroidx/compose/runtime/MutableFloatState;    # state holder

    move-result-object v0    # state instance

    sput-object v0, Lradiant/MiniSeekerLine;->progressState:Landroidx/compose/runtime/MutableFloatState;    # publish state

    return-void
.end method


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


.method private static dlog(Ljava/lang/String;)V
    .locals 1

    const-string v0, "RLProgressLine"    # log tag

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I    # info log

    return-void
.end method


.method public static start()V
    .locals 3

    sget-object v0, Lradiant/MiniSeekerLine;->sub:Lio/reactivex/disposables/Disposable;    # current sub

    if-eqz v0, :start_block    # only run once

    return-void

    :start_block
    :try_start
    sget-object v0, Lradiant/MiniSeekerLine;->vm:Lgh/j;    # cached vm  MARKER: R8 Lgh/j;

    if-nez v0, :got_vm    # reuse if present

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # app singleton  MARKER: R8 a

    move-result-object v0    # app

    invoke-virtual {v0}, Lcom/aspiro/wamp/App;->e()Le5/c;    # dagger component  MARKER: R8 Le5/c; e

    move-result-object v0    # component

    check-cast v0, Le5/z$n2;    # narrow type  MARKER: R8 Le5/z$n2;

    iget-object v0, v0, Le5/z$n2;->z0:Ldagger/internal/j;    # playqueue provider  MARKER: R8 Le5/z$n2; Ldagger/internal/j; z0

    invoke-interface {v0}, Lql0/a;->get()Ljava/lang/Object;    # resolve  MARKER: R8 Lql0/a;

    move-result-object v0    # playqueue

    check-cast v0, Lcom/aspiro/wamp/playqueue/d1;    # narrow type  MARKER: R8 Lcom/aspiro/wamp/playqueue/d1;

    new-instance v1, Lgh/j;    # build vm  MARKER: R8 Lgh/j;

    invoke-direct {v1, v0}, Lgh/j;-><init>(Lcom/aspiro/wamp/playqueue/d1;)V    # ctor  MARKER: R8 Lgh/j; Lcom/aspiro/wamp/playqueue/d1;

    sput-object v1, Lradiant/MiniSeekerLine;->vm:Lgh/j;    # cache  MARKER: R8 Lgh/j;

    :got_vm
    sget-object v0, Lradiant/MiniSeekerLine;->vm:Lgh/j;    # vm ref  MARKER: R8 Lgh/j;

    invoke-virtual {v0}, Lgh/j;->a()V    # activate emission  MARKER: R8 Lgh/j; a

    iget-object v0, v0, Lgh/j;->d:Lio/reactivex/subjects/BehaviorSubject;    # position subject  MARKER: R8 Lgh/j; d

    invoke-static {}, Lio/reactivex/android/schedulers/AndroidSchedulers;->mainThread()Lio/reactivex/Scheduler;    # main scheduler

    move-result-object v1    # scheduler

    invoke-virtual {v0, v1}, Lio/reactivex/Observable;->observeOn(Lio/reactivex/Scheduler;)Lio/reactivex/Observable;    # observe main

    move-result-object v0    # observable

    new-instance v1, Lradiant/SeekerConsumer;    # consumer

    invoke-direct {v1}, Lradiant/SeekerConsumer;-><init>()V    # ctor

    invoke-virtual {v0, v1}, Lio/reactivex/Observable;->subscribe(Lio/reactivex/functions/Consumer;)Lio/reactivex/disposables/Disposable;    # subscribe

    move-result-object v0    # disposable

    sput-object v0, Lradiant/MiniSeekerLine;->sub:Lio/reactivex/disposables/Disposable;    # cache

    const-string v0, "started"    # log msg

    invoke-static {v0}, Lradiant/MiniSeekerLine;->dlog(Ljava/lang/String;)V    # info log

    return-void
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :swallow

    :swallow
    move-exception v0    # error

    const-string v1, "start failed"    # log msg

    invoke-static {v1}, Lradiant/MiniSeekerLine;->dlog(Ljava/lang/String;)V    # info log

    return-void
.end method


.method public static render(Landroidx/compose/runtime/Composer;I)V
    .locals 5
    .annotation build Landroidx/compose/runtime/Composable;
    .end annotation

    invoke-static {}, Lradiant/MiniSeekerLine;->start()V    # lazy subscribe

    sget-object v0, Lradiant/MiniSeekerLine;->progressState:Landroidx/compose/runtime/MutableFloatState;    # state

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F    # read tracked

    move-result v0    # raw progress

    const/4 v1, 0x0    # lower bound

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F    # clamp low

    move-result v0    # clamped low

    const/high16 v1, 0x3f800000    # 1.0f upper

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F    # clamp high

    move-result v0    # final progress

    const v1, 0x52414c49    # 'RALI' slot key

    invoke-interface {p0, v1}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V    # open group

    sget-object v1, Landroidx/compose/ui/Modifier;->Companion:Landroidx/compose/ui/Modifier$Companion;    # base modifier

    invoke-static {v1, v0}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxWidth(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;    # width fraction

    move-result-object v0    # filled modifier

    const/4 v1, 0x2    # 2 dp

    int-to-float v1, v1    # to float

    invoke-static {v1}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F    # box as Dp

    move-result v1    # dp value

    invoke-static {v0, v1}, Landroidx/compose/foundation/layout/SizeKt;->height-3ABfNKs(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;    # 2dp tall

    move-result-object v0    # sized modifier

    const v1, -0x1    # 0xFFFFFFFF white

    invoke-static {v1}, Landroidx/compose/ui/graphics/ColorKt;->Color(I)J    # pack color

    move-result-wide v1    # color long

    invoke-static {}, Landroidx/compose/ui/graphics/RectangleShapeKt;->getRectangleShape()Landroidx/compose/ui/graphics/Shape;    # rect shape

    move-result-object v3    # shape

    invoke-static {v0, v1, v2, v3}, Landroidx/compose/foundation/BackgroundKt;->background-bw27NRU(Landroidx/compose/ui/Modifier;JLandroidx/compose/ui/graphics/Shape;)Landroidx/compose/ui/Modifier;    # white bg

    move-result-object v0    # final modifier

    const/4 v1, 0x0    # composer $changed

    invoke-static {v0, p0, v1}, Landroidx/compose/foundation/layout/SpacerKt;->Spacer(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V    # draw line

    invoke-interface {p0}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V    # close group

    return-void
.end method
