.class public final Lradiant/HomeBackdrop;
.super Ljava/lang/Object;


# static fields
.field public static volatile currentAlbumId:I

.field public static coverUuidState:Landroidx/compose/runtime/MutableState;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/compose/runtime/MutableState<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 4

    const/4 v0, 0x0

    sput v0, Lradiant/HomeBackdrop;->currentAlbumId:I

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/HomeBackdrop;->coverUuidState:Landroidx/compose/runtime/MutableState;

    return-void
.end method


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


.method public static dlog(Ljava/lang/String;)V
    .locals 1

    const-string v0, "RLHomeBackdrop"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


.method private static isDebugMenuStack()Z
    .locals 6

    new-instance v0, Ljava/lang/Throwable;

    invoke-direct {v0}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :loop_start
    if-ge v2, v1, :loop_end

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "debugmenu"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :next

    const/4 v0, 0x1

    return v0

    :next
    add-int/lit8 v2, v2, 0x1

    goto :loop_start

    :loop_end
    const/4 v0, 0x0

    return v0
.end method


.method public static fromMiniPlayer(ILjava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "fromMiniPlayer: id="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " cover="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V

    sput p0, Lradiant/HomeBackdrop;->currentAlbumId:I

    sget-object v0, Lradiant/HomeBackdrop;->coverUuidState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0, p1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    return-void
.end method


.method public static onTrack(Lcom/aspiro/wamp/model/Track;)V
    .locals 3

    const-string v0, "onTrack: entered"

    invoke-static {v0}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V

    if-eqz p0, :clear

    :try_start
    invoke-virtual {p0}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v0

    if-eqz v0, :clear

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v1

    sput v1, Lradiant/HomeBackdrop;->currentAlbumId:I

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getCover()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lradiant/HomeBackdrop;->coverUuidState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "onTrack: set uuid="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :swallow

    return-void

    :clear
    const-string v0, "onTrack: clearing (null track/album)"

    invoke-static {v0}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V

    const/4 v0, 0x0

    sput v0, Lradiant/HomeBackdrop;->currentAlbumId:I

    sget-object v1, Lradiant/HomeBackdrop;->coverUuidState:Landroidx/compose/runtime/MutableState;

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    return-void

    :swallow
    const-string v0, "onTrack: caught throwable"

    invoke-static {v0}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V

    return-void
.end method


.method public static render(Landroidx/compose/runtime/Composer;I)V
    .locals 16
    .annotation build Landroidx/compose/runtime/Composable;
    .end annotation

    invoke-static {}, Lradiant/HomeBackdrop;->isDebugMenuStack()Z

    move-result v0

    if-eqz v0, :proceed

    return-void

    :proceed
    move-object/from16 v0, p0

    const-string v1, "render: entered"

    invoke-static {v1}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V

    const v1, 0x52414449

    invoke-interface {v0, v1}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    sget-object v1, Lradiant/HomeBackdrop;->coverUuidState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/State;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "render: uuid="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lradiant/HomeBackdrop;->dlog(Ljava/lang/String;)V

    if-eqz v1, :skip

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :skip

    sget v2, Lradiant/HomeBackdrop;->currentAlbumId:I

    new-instance v3, Lcom/tidal/android/feature/playerscreen/ui/composables/n0;

    invoke-direct {v3, v2, v1}, Lcom/tidal/android/feature/playerscreen/ui/composables/n0;-><init>(ILjava/lang/String;)V

    sget-object v4, Landroidx/compose/ui/Modifier;->Companion:Landroidx/compose/ui/Modifier$Companion;

    const/4 v5, 0x0

    const/4 v6, 0x1

    const/4 v7, 0x0

    invoke-static {v4, v5, v6, v7}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxSize$default(Landroidx/compose/ui/Modifier;FILjava/lang/Object;)Landroidx/compose/ui/Modifier;

    move-result-object v4

    const/high16 v5, 0x42200000

    invoke-static {v5}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v5

    sget-object v6, Landroidx/compose/ui/draw/BlurredEdgeTreatment;->Companion:Landroidx/compose/ui/draw/BlurredEdgeTreatment$Companion;

    invoke-virtual {v6}, Landroidx/compose/ui/draw/BlurredEdgeTreatment$Companion;->getRectangle---Goahg()Landroidx/compose/ui/graphics/Shape;

    move-result-object v6

    invoke-static {v4, v5, v6}, Landroidx/compose/ui/draw/BlurKt;->blur-F8QBwvs(Landroidx/compose/ui/Modifier;FLandroidx/compose/ui/graphics/Shape;)Landroidx/compose/ui/Modifier;

    move-result-object v4

    sget-object v5, Landroidx/compose/ui/layout/ContentScale;->Companion:Landroidx/compose/ui/layout/ContentScale$Companion;

    invoke-virtual {v5}, Landroidx/compose/ui/layout/ContentScale$Companion;->getCrop()Landroidx/compose/ui/layout/ContentScale;

    move-result-object v5

    move-object/from16 v6, v3

    const/4 v7, 0x0

    move-object/from16 v8, v4

    const/4 v9, 0x0

    move-object/from16 v10, v5

    move-object/from16 v11, v1    # uuid as cache key

    const/4 v12, 0x0

    move-object/from16 v13, v0

    const/4 v14, 0x0

    const/16 v15, 0x48

    invoke-static/range {v6 .. v15}, Lxd0/f;->a(Lyl0/l;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/ui/layout/ContentScale;Ljava/lang/Object;Lyl0/a;Landroidx/compose/runtime/Composer;II)V

    sget-object v3, Landroidx/compose/ui/Modifier;->Companion:Landroidx/compose/ui/Modifier$Companion;

    const/4 v4, 0x0

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-static {v3, v4, v5, v6}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxSize$default(Landroidx/compose/ui/Modifier;FILjava/lang/Object;)Landroidx/compose/ui/Modifier;

    move-result-object v3

    const v4, -0x80000000

    invoke-static {v4}, Landroidx/compose/ui/graphics/ColorKt;->Color(I)J

    move-result-wide v4

    invoke-static {}, Landroidx/compose/ui/graphics/RectangleShapeKt;->getRectangleShape()Landroidx/compose/ui/graphics/Shape;

    move-result-object v6

    invoke-static {v3, v4, v5, v6}, Landroidx/compose/foundation/BackgroundKt;->background-bw27NRU(Landroidx/compose/ui/Modifier;JLandroidx/compose/ui/graphics/Shape;)Landroidx/compose/ui/Modifier;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {v3, v0, v4}, Landroidx/compose/foundation/layout/SpacerKt;->Spacer(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V

    :skip
    invoke-interface {v0}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-void
.end method
