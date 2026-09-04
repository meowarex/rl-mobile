.class public final Lradiant/RLAPILyricsHook;
.super Ljava/lang/Object;


# static fields
.field public static volatile currentKey:Ljava/lang/String;

.field public static volatile currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

.field public static volatile isRlState:Z

.field public static volatile keepOpen:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    sput-object v0, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    sput-boolean v0, Lradiant/RLAPILyricsHook;->isRlState:Z

    sput-boolean v0, Lradiant/RLAPILyricsHook;->keepOpen:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static dlog(Ljava/lang/String;)V
    .locals 1

    const-string v0, "RLLyrics"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private static isBlank(Ljava/lang/String;)Z
    .locals 2

    if-nez p0, :not_null

    const/4 v0, 0x1

    return v0

    :not_null
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    return v1
.end method

.method public static isOwner(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;)Z
    .locals 2

    sget-object v0, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    if-ne p0, v0, :not_owner

    sget-boolean v1, Lradiant/RLAPILyricsHook;->isRlState:Z

    return v1

    :not_owner
    const/4 v1, 0x0

    return v1
.end method

.method public static shouldKeepOpen(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;)Z
    .locals 2

    sget-object v0, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    if-ne p0, v0, :do_not_keep

    sget-boolean v1, Lradiant/RLAPILyricsHook;->keepOpen:Z

    if-nez v1, :keep

    sget-boolean v1, Lradiant/RLAPILyricsHook;->isRlState:Z

    :keep
    return v1

    :do_not_keep
    const/4 v1, 0x0

    return v1
.end method

.method public static onWampTrack(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;Lcom/aspiro/wamp/model/Track;)V
    .locals 11

    invoke-static {p1}, Lradiant/HomeBackdrop;->onTrack(Lcom/aspiro/wamp/model/Track;)V

    const-string v3, "onWampTrack: hook entered"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    if-eqz p1, :null_track

    if-eqz p0, :done

    goto :have_track

    :null_track
    const-string v3, "onWampTrack: wamp Track is null, skip"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    goto :invalid_track

    :have_track
    invoke-virtual {p1}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :title_present

    const-string v3, "bail: getTitle() returned null"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    goto :invalid_track

    :title_present
    invoke-static {v1}, Lradiant/RLAPILyricsHook;->isBlank(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :title_ok

    const-string v3, "bail: title is blank"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    goto :invalid_track

    :title_ok
    # match desktop: primary artist name (artist?.name), fall back to the joined list
    invoke-virtual {p1}, Lcom/aspiro/wamp/model/MediaItem;->getArtist()Lcom/aspiro/wamp/model/Artist;

    move-result-object v3

    if-eqz v3, :use_artist_names

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Artist;->getName()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :artist_present

    :use_artist_names
    invoke-virtual {p1}, Lcom/aspiro/wamp/model/MediaItem;->getArtistNames()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :artist_present

    const-string v3, "bail: artist name null"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    goto :invalid_track

    :artist_present
    invoke-static {v2}, Lradiant/RLAPILyricsHook;->isBlank(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :artist_ok

    const-string v3, "bail: artist is blank"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    goto :invalid_track

    :artist_ok
    invoke-virtual {p1}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :rl_new_track

    sget-object v5, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    if-ne p0, v5, :rl_new_track

    const-string v5, "onWampTrack: same track re-fired, skipping duplicate fetch"

    invoke-static {v5}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :rl_new_track
    iget-object v5, p0, Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;->P:Lkotlinx/coroutines/flow/MutableStateFlow;    # MARKER: R8 P

    invoke-interface {v5}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    if-nez v5, :store_keep_open

    sget-object v6, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    if-eqz v6, :store_keep_open

    if-eq p0, v6, :store_keep_open

    iget-object v7, v6, Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;->P:Lkotlinx/coroutines/flow/MutableStateFlow;    # MARKER: R8 P

    invoke-interface {v7}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    :store_keep_open
    sput-boolean v5, Lradiant/RLAPILyricsHook;->keepOpen:Z

    const/4 v5, 0x0

    sput-boolean v5, Lradiant/RLAPILyricsHook;->isRlState:Z

    sput-object v4, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    sput-object p0, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    move-object v3, v4

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "onWampTrack: fetching for title='"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "' artist='"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    new-instance v5, Lradiant/RLAPILyricsWorker;

    move-object v6, p0

    move-object v7, v1

    move-object v8, v2

    move-object v9, v4

    move-object v10, v3

    invoke-direct/range {v5 .. v10}, Lradiant/RLAPILyricsWorker;-><init>(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/Thread;

    invoke-direct {v6, v5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    const/4 v7, 0x1

    invoke-virtual {v6, v7}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v6}, Ljava/lang/Thread;->start()V

    goto :done

    :invalid_track
    const/4 v3, 0x0

    sput-boolean v3, Lradiant/RLAPILyricsHook;->isRlState:Z

    sput-boolean v3, Lradiant/RLAPILyricsHook;->keepOpen:Z

    sput-object v3, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    sput-object p0, Lradiant/RLAPILyricsHook;->currentVm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    :done
    return-void
.end method
