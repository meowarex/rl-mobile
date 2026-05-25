.class public final Lradiant/RLAPILyricsHook;
.super Ljava/lang/Object;


# static fields
.field public static volatile currentKey:Ljava/lang/String;

.field public static volatile isRlState:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    sput-boolean v0, Lradiant/RLAPILyricsHook;->isRlState:Z

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

.method public static onWampTrack(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;Lcom/aspiro/wamp/model/Track;)V
    .locals 11

    invoke-static {p1}, Lradiant/HomeBackdrop;->onTrack(Lcom/aspiro/wamp/model/Track;)V

    const/4 v3, 0x0

    sput-boolean v3, Lradiant/RLAPILyricsHook;->isRlState:Z

    const-string v3, "onWampTrack: hook entered"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    if-eqz p1, :null_track

    if-eqz p0, :done

    goto :have_track

    :null_track
    const-string v3, "onWampTrack: wamp Track is null, skip"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :have_track
    invoke-virtual {p1}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :title_present

    const-string v3, "bail: getTitle() returned null"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :title_present
    invoke-static {v1}, Lradiant/RLAPILyricsHook;->isBlank(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :title_ok

    const-string v3, "bail: title is blank"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :title_ok
    invoke-virtual {p1}, Lcom/aspiro/wamp/model/MediaItem;->getArtistNames()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :artist_present

    const-string v3, "bail: getArtistNames() returned null"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :artist_present
    invoke-static {v2}, Lradiant/RLAPILyricsHook;->isBlank(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :artist_ok

    const-string v3, "bail: artist is blank"

    invoke-static {v3}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :artist_ok
    const-string v3, ""

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "|"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    sput-object v4, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

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

    :done
    return-void
.end method
