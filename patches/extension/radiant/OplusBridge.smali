.class public final Lradiant/OplusBridge;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static final FAVORITE_ACTION:Ljava/lang/String; = "TOGGLE_FAVORITE"

.field private static final FETCH_DELAY_MS:J = 0x5dcL

.field private static final KEY_ARTIST:Ljava/lang/String; = "android.media.metadata.ARTIST"

.field private static final KEY_CONFIG:Ljava/lang/String; = "oplus.media.config"

.field private static final KEY_FAVORITE:Ljava/lang/String; = "isFavorite"

.field private static final KEY_LYRIC:Ljava/lang/String; = "lyricInfo"

.field private static final KEY_MEDIA_ID:Ljava/lang/String; = "android.media.metadata.MEDIA_ID"

.field private static final KEY_RATING:Ljava/lang/String; = "android.media.metadata.USER_RATING"

.field private static final KEY_TITLE:Ljava/lang/String; = "android.media.metadata.TITLE"

.field private static final LOCK:Ljava/lang/Object;

.field private static final MAIN:Landroid/os/Handler;

.field private static final TAG:Ljava/lang/String; = "RLOplus"

.field private static fetchKey:Ljava/lang/String;

.field private static lyricsKey:Ljava/lang/String;

.field private static lyricsLines:Ljava/lang/String;

.field private static lyricsTitle:Ljava/lang/String;

.field private static ratingType:Z

.field private static raw:Landroid/support/v4/media/MediaMetadataCompat;

.field private static session:Landroid/support/v4/media/session/MediaSessionCompat;


# instance fields
.field private final artist:Ljava/lang/String;

.field private final id:Ljava/lang/String;

.field private final title:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/OplusBridge;->MAIN:Landroid/os/Handler;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/OplusBridge;->id:Ljava/lang/String;

    iput-object p2, p0, Lradiant/OplusBridge;->title:Ljava/lang/String;

    iput-object p3, p0, Lradiant/OplusBridge;->artist:Ljava/lang/String;

    return-void
.end method

.method public static decorate(Landroid/support/v4/media/session/MediaSessionCompat;Landroid/support/v4/media/MediaMetadataCompat;)Landroid/support/v4/media/MediaMetadataCompat;
    .registers 9

    if-eqz p0, :cond_b6

    if-eqz p1, :cond_b6

    const-string v0, "android.media.metadata.MEDIA_ID"

    invoke-virtual {p1, v0}, Landroid/support/v4/media/MediaMetadataCompat;->containsKey(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_e

    goto/16 :goto_b6

    :cond_e
    :try_start_e
    const-string v0, "android.media.metadata.MEDIA_ID"

    invoke-virtual {p1, v0}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v1
    :try_end_17
    .catchall {:try_start_e .. :try_end_17} :catchall_ae

    :try_start_17
    sput-object p0, Lradiant/OplusBridge;->session:Landroid/support/v4/media/session/MediaSessionCompat;

    sput-object p1, Lradiant/OplusBridge;->raw:Landroid/support/v4/media/MediaMetadataCompat;

    invoke-static {}, Lradiant/OplusBridge;->lyricsFlag()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eqz v2, :cond_39

    if-eqz v0, :cond_39

    sget-object v2, Lradiant/OplusBridge;->lyricsKey:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_39

    sget-object v2, Lradiant/OplusBridge;->fetchKey:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_39

    sput-object v0, Lradiant/OplusBridge;->fetchKey:Ljava/lang/String;

    move v2, v4

    goto :goto_3a

    :cond_39
    move v2, v3

    :goto_3a
    monitor-exit v1
    :try_end_3b
    .catchall {:try_start_17 .. :try_end_3b} :catchall_ab

    if-eqz v2, :cond_5b

    :try_start_3d
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lradiant/OplusBridge;

    const-string v5, "android.media.metadata.TITLE"

    invoke-virtual {p1, v5}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "android.media.metadata.ARTIST"

    invoke-virtual {p1, v6}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v2, v0, v5, v6}, Lradiant/OplusBridge;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "RLOplus"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    :cond_5b
    invoke-static {}, Lradiant/OplusBridge;->heartFlag()I

    move-result v0

    if-eqz v0, :cond_63

    move v0, v4

    goto :goto_64

    :cond_63
    move v0, v3

    :goto_64
    if-eqz v0, :cond_6f

    sget-boolean v1, Lradiant/OplusBridge;->ratingType:Z

    if-nez v1, :cond_6f

    sput-boolean v4, Lradiant/OplusBridge;->ratingType:Z

    invoke-virtual {p0, v4}, Landroid/support/v4/media/session/MediaSessionCompat;->setRatingType(I)V

    :cond_6f
    new-instance p0, Landroid/support/v4/media/MediaMetadataCompat$Builder;

    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaMetadataCompat$Builder;-><init>(Landroid/support/v4/media/MediaMetadataCompat;)V

    const-string v1, "oplus.media.config"

    const-string v2, "1"

    invoke-virtual {p0, v1, v2}, Landroid/support/v4/media/MediaMetadataCompat$Builder;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/support/v4/media/MediaMetadataCompat$Builder;

    if-eqz v0, :cond_9b

    const-string v0, "isFavorite"

    invoke-virtual {p1, v0}, Landroid/support/v4/media/MediaMetadataCompat;->containsKey(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9b

    const-string v0, "android.media.metadata.USER_RATING"

    const-string v1, "isFavorite"

    invoke-virtual {p1, v1}, Landroid/support/v4/media/MediaMetadataCompat;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    const-wide/16 v5, 0x0

    cmp-long v1, v1, v5

    if-eqz v1, :cond_94

    move v3, v4

    :cond_94
    invoke-static {v3}, Landroid/support/v4/media/RatingCompat;->newHeartRating(Z)Landroid/support/v4/media/RatingCompat;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Landroid/support/v4/media/MediaMetadataCompat$Builder;->putRating(Ljava/lang/String;Landroid/support/v4/media/RatingCompat;)Landroid/support/v4/media/MediaMetadataCompat$Builder;

    :cond_9b
    invoke-static {p1}, Lradiant/OplusBridge;->lyricInfo(Landroid/support/v4/media/MediaMetadataCompat;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_a6

    const-string v1, "lyricInfo"

    invoke-virtual {p0, v1, v0}, Landroid/support/v4/media/MediaMetadataCompat$Builder;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/support/v4/media/MediaMetadataCompat$Builder;

    :cond_a6
    invoke-virtual {p0}, Landroid/support/v4/media/MediaMetadataCompat$Builder;->build()Landroid/support/v4/media/MediaMetadataCompat;

    move-result-object p0
    :try_end_aa
    .catchall {:try_start_3d .. :try_end_aa} :catchall_ae

    return-object p0

    :catchall_ab
    move-exception p0

    :try_start_ac
    monitor-exit v1
    :try_end_ad
    .catchall {:try_start_ac .. :try_end_ad} :catchall_ab

    :try_start_ad
    throw p0
    :try_end_ae
    .catchall {:try_start_ad .. :try_end_ae} :catchall_ae

    :catchall_ae
    move-exception p0

    const-string v0, "RLOplus"

    const-string v1, "decorate failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_b6
    :goto_b6
    return-object p1
.end method

.method private fetch()V
    .registers 5

    const-wide/16 v0, 0x5dc

    :try_start_2
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    invoke-direct {p0}, Lradiant/OplusBridge;->stillWanted()Z

    move-result v0

    if-nez v0, :cond_c

    return-void

    :cond_c
    iget-object v0, p0, Lradiant/OplusBridge;->title:Ljava/lang/String;

    if-eqz v0, :cond_c6

    iget-object v0, p0, Lradiant/OplusBridge;->title:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1e

    goto/16 :goto_c6

    :cond_1e
    iget-object v0, p0, Lradiant/OplusBridge;->artist:Ljava/lang/String;

    if-nez v0, :cond_25

    const-string v0, ""

    goto :goto_27

    :cond_25
    iget-object v0, p0, Lradiant/OplusBridge;->artist:Ljava/lang/String;

    :goto_27
    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/4 v2, 0x0

    if-lez v1, :cond_34

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    :cond_34
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "?title="

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lradiant/OplusBridge;->title:Ljava/lang/String;

    invoke-static {v3}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "&artist="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v0}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lradiant/OplusBridge;->id:Ljava/lang/String;

    invoke-static {v0}, Lradiant/IsrcCache;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_74

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_74

    const-string v3, "&isrc="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_74
    invoke-static {}, Lradiant/RLLyrics;->queryExtras()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "&platform=rl-mobile"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "https://api.radiant-lyrics.org/rl-api"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x1

    invoke-static {v0, v3}, Lradiant/RLAPILyricsWorker;->fetch(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_b1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "https://rl-api.kineticsand.net/lyrics"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v2}, Lradiant/RLAPILyricsWorker;->fetch(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    :cond_b1
    if-eqz v0, :cond_c6

    invoke-direct {p0}, Lradiant/OplusBridge;->stillWanted()Z

    move-result v1

    if-nez v1, :cond_ba

    goto :goto_c6

    :cond_ba
    iget-object v1, p0, Lradiant/OplusBridge;->id:Ljava/lang/String;

    iget-object v2, p0, Lradiant/OplusBridge;->title:Ljava/lang/String;

    invoke-static {v0}, Lradiant/RLLyrics;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lradiant/OplusBridge;->onLyrics(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_c5
    .catchall {:try_start_2 .. :try_end_c5} :catchall_c7

    goto :goto_cf

    :cond_c6
    :goto_c6
    return-void

    :catchall_c7
    move-exception v0

    const-string v1, "RLOplus"

    const-string v2, "fetch failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_cf
    return-void
.end method

.method private static heartFlag()I
    .registers 1

    const v0, __RL_OPLUS_HEART__

    return v0
.end method

.method private static lyricInfo(Landroid/support/v4/media/MediaMetadataCompat;)Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    sget-object v0, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/OplusBridge;->lyricsKey:Ljava/lang/String;

    sget-object v2, Lradiant/OplusBridge;->lyricsLines:Ljava/lang/String;

    monitor-exit v0
    :try_end_8
    .catchall {:try_start_3 .. :try_end_8} :catchall_3d

    if-eqz v2, :cond_3b

    invoke-static {p0}, Lradiant/OplusBridge;->matches(Landroid/support/v4/media/MediaMetadataCompat;)Z

    move-result v0

    if-nez v0, :cond_11

    goto :goto_3b

    :cond_11
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v3, "songId"

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "songName"

    const-string v3, "android.media.metadata.TITLE"

    invoke-virtual {p0, v3}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "artist"

    const-string v3, "android.media.metadata.ARTIST"

    invoke-virtual {p0, v3}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p0, "lyric"

    invoke-virtual {v0, p0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_3b
    :goto_3b
    const/4 p0, 0x0

    return-object p0

    :catchall_3d
    move-exception p0

    :try_start_3e
    monitor-exit v0
    :try_end_3f
    .catchall {:try_start_3e .. :try_end_3f} :catchall_3d

    throw p0
.end method

.method private static lyricsFlag()I
    .registers 1

    const v0, __RL_OPLUS_LYRICS__

    return v0
.end method

.method private static matches(Landroid/support/v4/media/MediaMetadataCompat;)Z
    .registers 5

    sget-object v0, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/OplusBridge;->lyricsKey:Ljava/lang/String;

    sget-object v2, Lradiant/OplusBridge;->lyricsTitle:Ljava/lang/String;

    monitor-exit v0
    :try_end_8
    .catchall {:try_start_3 .. :try_end_8} :catchall_29

    const/4 v0, 0x0

    if-nez v1, :cond_c

    return v0

    :cond_c
    const-string v3, "android.media.metadata.MEDIA_ID"

    invoke-virtual {p0, v3}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_19

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    return p0

    :cond_19
    if-eqz v2, :cond_28

    const-string v1, "android.media.metadata.TITLE"

    invoke-virtual {p0, v1}, Landroid/support/v4/media/MediaMetadataCompat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_28

    const/4 v0, 0x1

    :cond_28
    return v0

    :catchall_29
    move-exception p0

    :try_start_2a
    monitor-exit v0
    :try_end_2b
    .catchall {:try_start_2a .. :try_end_2b} :catchall_29

    throw p0
.end method

.method public static onLyrics(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 6

    invoke-static {}, Lradiant/OplusBridge;->lyricsFlag()I

    move-result v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    const/4 v0, 0x0

    :try_start_8
    invoke-static {p2}, Lradiant/OplusBridge;->toLines(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2
    :try_end_c
    .catchall {:try_start_8 .. :try_end_c} :catchall_d

    goto :goto_16

    :catchall_d
    move-exception p2

    const-string v1, "RLOplus"

    const-string v2, "lyrics parse failed"

    invoke-static {v1, v2, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object p2, v0

    :goto_16
    sget-object v1, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    :try_start_19
    sput-object p0, Lradiant/OplusBridge;->lyricsKey:Ljava/lang/String;

    sput-object p1, Lradiant/OplusBridge;->lyricsTitle:Ljava/lang/String;

    sput-object p2, Lradiant/OplusBridge;->lyricsLines:Ljava/lang/String;

    monitor-exit v1
    :try_end_20
    .catchall {:try_start_19 .. :try_end_20} :catchall_2b

    sget-object p0, Lradiant/OplusBridge;->MAIN:Landroid/os/Handler;

    new-instance p1, Lradiant/OplusBridge;

    invoke-direct {p1, v0, v0, v0}, Lradiant/OplusBridge;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :catchall_2b
    move-exception p0

    :try_start_2c
    monitor-exit v1
    :try_end_2d
    .catchall {:try_start_2c .. :try_end_2d} :catchall_2b

    throw p0
.end method

.method public static onSetRating(Landroid/support/v4/media/session/MediaSessionCompat$Callback;Landroid/support/v4/media/RatingCompat;)V
    .registers 10

    :try_start_0
    invoke-static {}, Lradiant/OplusBridge;->heartFlag()I

    move-result v0

    if-eqz v0, :cond_72

    if-eqz p0, :cond_72

    if-eqz p1, :cond_72

    invoke-virtual {p1}, Landroid/support/v4/media/RatingCompat;->getRatingStyle()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_12

    goto :goto_72

    :cond_12
    sget-object v0, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v0
    :try_end_15
    .catchall {:try_start_0 .. :try_end_15} :catchall_73

    :try_start_15
    sget-object v2, Lradiant/OplusBridge;->session:Landroid/support/v4/media/session/MediaSessionCompat;

    monitor-exit v0
    :try_end_18
    .catchall {:try_start_15 .. :try_end_18} :catchall_6f

    if-nez v2, :cond_1b

    return-void

    :cond_1b
    :try_start_1b
    invoke-virtual {v2}, Landroid/support/v4/media/session/MediaSessionCompat;->getController()Landroid/support/v4/media/session/MediaControllerCompat;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/media/session/MediaControllerCompat;->getMetadata()Landroid/support/v4/media/MediaMetadataCompat;

    move-result-object v2

    const/4 v3, 0x0

    if-eqz v2, :cond_33

    const-string v4, "isFavorite"

    invoke-virtual {v2, v4}, Landroid/support/v4/media/MediaMetadataCompat;->getLong(Ljava/lang/String;)J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v2, v4, v6

    if-eqz v2, :cond_33

    goto :goto_34

    :cond_33
    move v1, v3

    :goto_34
    invoke-virtual {p1}, Landroid/support/v4/media/RatingCompat;->hasHeart()Z

    move-result p1

    if-ne v1, p1, :cond_3b

    return-void

    :cond_3b
    invoke-virtual {v0}, Landroid/support/v4/media/session/MediaControllerCompat;->getPlaybackState()Landroid/support/v4/media/session/PlaybackStateCompat;

    move-result-object p1

    const/4 v0, 0x0

    if-nez p1, :cond_44

    move-object p1, v0

    goto :goto_48

    :cond_44
    invoke-virtual {p1}, Landroid/support/v4/media/session/PlaybackStateCompat;->getCustomActions()Ljava/util/List;

    move-result-object p1

    :goto_48
    if-nez p1, :cond_4b

    return-void

    :cond_4b
    :goto_4b
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v3, v1, :cond_7b

    invoke-interface {p1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/support/v4/media/session/PlaybackStateCompat$CustomAction;

    invoke-virtual {v1}, Landroid/support/v4/media/session/PlaybackStateCompat$CustomAction;->getAction()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_6c

    const-string v2, "TOGGLE_FAVORITE"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6c

    move-object p1, v0

    check-cast p1, Landroid/os/Bundle;

    invoke-virtual {p0, v1, v0}, Landroid/support/v4/media/session/MediaSessionCompat$Callback;->onCustomAction(Ljava/lang/String;Landroid/os/Bundle;)V
    :try_end_6b
    .catchall {:try_start_1b .. :try_end_6b} :catchall_73

    return-void

    :cond_6c
    add-int/lit8 v3, v3, 0x1

    goto :goto_4b

    :catchall_6f
    move-exception p0

    :try_start_70
    monitor-exit v0
    :try_end_71
    .catchall {:try_start_70 .. :try_end_71} :catchall_6f

    :try_start_71
    throw p0
    :try_end_72
    .catchall {:try_start_71 .. :try_end_72} :catchall_73

    :cond_72
    :goto_72
    return-void

    :catchall_73
    move-exception p0

    const-string p1, "RLOplus"

    const-string v0, "rating failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_7b
    return-void
.end method

.method private republish()V
    .registers 4

    sget-object v0, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/OplusBridge;->session:Landroid/support/v4/media/session/MediaSessionCompat;

    sget-object v2, Lradiant/OplusBridge;->raw:Landroid/support/v4/media/MediaMetadataCompat;

    monitor-exit v0
    :try_end_8
    .catchall {:try_start_3 .. :try_end_8} :catchall_20

    if-eqz v1, :cond_1f

    if-eqz v2, :cond_1f

    invoke-static {v2}, Lradiant/OplusBridge;->matches(Landroid/support/v4/media/MediaMetadataCompat;)Z

    move-result v0

    if-nez v0, :cond_13

    goto :goto_1f

    :cond_13
    :try_start_13
    invoke-virtual {v1, v2}, Landroid/support/v4/media/session/MediaSessionCompat;->setMetadata(Landroid/support/v4/media/MediaMetadataCompat;)V
    :try_end_16
    .catchall {:try_start_13 .. :try_end_16} :catchall_17

    goto :goto_1f

    :catchall_17
    move-exception v0

    const-string v1, "RLOplus"

    const-string v2, "republish failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1f
    :goto_1f
    return-void

    :catchall_20
    move-exception v1

    :try_start_21
    monitor-exit v0
    :try_end_22
    .catchall {:try_start_21 .. :try_end_22} :catchall_20

    throw v1
.end method

.method private stillWanted()Z
    .registers 4

    sget-object v0, Lradiant/OplusBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_3
    iget-object v1, p0, Lradiant/OplusBridge;->id:Ljava/lang/String;

    sget-object v2, Lradiant/OplusBridge;->fetchKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_19

    iget-object v1, p0, Lradiant/OplusBridge;->id:Ljava/lang/String;

    sget-object v2, Lradiant/OplusBridge;->lyricsKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_19

    const/4 v1, 0x1

    goto :goto_1a

    :cond_19
    const/4 v1, 0x0

    :goto_1a
    monitor-exit v0

    return v1

    :catchall_1c
    move-exception v1

    monitor-exit v0
    :try_end_1e
    .catchall {:try_start_3 .. :try_end_1e} :catchall_1c

    throw v1
.end method

.method private static toLines(Ljava/lang/String;)Ljava/lang/String;
    .registers 15
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_4

    return-object v0

    :cond_4
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "data"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    if-eqz p0, :cond_e0

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-nez v1, :cond_19

    goto/16 :goto_e0

    :cond_19
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    move v3, v2

    :goto_20
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v3, v4, :cond_b2

    invoke-virtual {p0, v3}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    if-nez v4, :cond_2e

    goto/16 :goto_ae

    :cond_2e
    invoke-static {v4}, Lradiant/WordLyrics;->lineText(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_36

    goto/16 :goto_ae

    :cond_36
    const/16 v6, 0x20

    const/16 v7, 0xa

    invoke-virtual {v5, v7, v6}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-nez v6, :cond_49

    goto :goto_ae

    :cond_49
    const-string v6, "startTime"

    const-wide/16 v8, 0x0

    invoke-virtual {v4, v6, v8, v9}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v8

    const-wide v10, 0x408f400000000000L    # 1000.0

    mul-double/2addr v8, v10

    double-to-long v8, v8

    const-string v6, "syllabus"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    if-eqz v4, :cond_7c

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_7c

    invoke-virtual {v4, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    const-wide/16 v10, -0x1

    if-nez v4, :cond_6f

    goto :goto_75

    :cond_6f
    const-string v6, "time"

    invoke-virtual {v4, v6, v10, v11}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v10

    :goto_75
    const-wide/16 v12, 0x0

    cmp-long v4, v10, v12

    if-ltz v4, :cond_7c

    move-wide v8, v10

    :cond_7c
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    const-string v6, "tx"

    invoke-virtual {v4, v6, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    const-string v6, "t"

    invoke-virtual {v5, v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {v6, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-result-object v4

    const-string v6, "c"

    invoke-virtual {v5, v6, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v4

    if-lez v4, :cond_a7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :cond_a7
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_ae
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_20

    :cond_b2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-nez v2, :cond_b9

    return-object v0

    :cond_b9
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lyrics ready: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " lines"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v0, "RLOplus"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_e0
    :goto_e0
    return-object v0
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Lradiant/OplusBridge;->id:Ljava/lang/String;

    if-eqz v0, :cond_8

    invoke-direct {p0}, Lradiant/OplusBridge;->fetch()V

    return-void

    :cond_8
    invoke-direct {p0}, Lradiant/OplusBridge;->republish()V

    return-void
.end method
