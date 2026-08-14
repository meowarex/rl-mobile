.class public final Lradiant/HomeBackdrop;
.super Ljava/lang/Object;


# static fields
.field public static volatile currentAlbumId:I

# Live play state from the mini-player (t.c PlayState = Playing)
.field public static isPlayingState:Landroidx/compose/runtime/MutableState;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/compose/runtime/MutableState<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

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

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/HomeBackdrop;->isPlayingState:Landroidx/compose/runtime/MutableState;

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/HomeBackdrop;->coverUuidState:Landroidx/compose/runtime/MutableState;

    return-void
.end method

# from the mini-player state ctor (t.<init>) whenever play state changes.
.method public static onPlayState(Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$PlayState;)V
    .locals 2

    sget-object v0, Lradiant/HomeBackdrop;->isPlayingState:Landroidx/compose/runtime/MutableState;

    if-nez v0, :cond_ready

    return-void

    :cond_ready
    sget-object v1, Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$PlayState;->Playing:Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$PlayState;

    if-ne p0, v1, :cond_paused

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_set

    :cond_paused
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    :goto_set
    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

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

    # Render TIDAL's NATIVE DarkBlurBackground (p3.a)
    sget-object v8, Landroidx/compose/ui/Modifier;->Companion:Landroidx/compose/ui/Modifier$Companion;

    const/4 v9, 0x0

    const/4 v10, 0x1

    const/4 v11, 0x0

    invoke-static {v8, v9, v10, v11}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxSize$default(Landroidx/compose/ui/Modifier;FILjava/lang/Object;)Landroidx/compose/ui/Modifier;

    move-result-object v13    # v13 = fillMaxSize modifier

    sget v8, Lradiant/HomeBackdrop;->currentAlbumId:I    # v8 = album id

    move-object v9, v1    # v9 = cover uuid

    # v10 = isPlaying, straight from the live mini-player state (both modes follow it)
    sget-object v10, Lradiant/HomeBackdrop;->isPlayingState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v10}, Landroidx/compose/runtime/State;->getValue()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Boolean;

    invoke-virtual {v10}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v10

    const/4 v11, 0x0    # v11 = isSeeking = false

    const/4 v12, 0x0    # v12 = progress callback = null (unused while not seeking)

    move-object v14, v0    # v14 = composer

    const/4 v15, 0x0    # v15 = changed flags

    invoke-static/range {v8 .. v15}, Lcom/tidal/android/feature/playerscreen/ui/composables/p3;->a(ILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V

    :skip
    invoke-interface {v0}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-void
.end method
