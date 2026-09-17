.class public final Lradiant/PebbleBridge;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/ServiceConnection;


# static fields
.field private static final KEEPALIVE_MS:J = 0x1388L

.field private static final LOCK:Ljava/lang/Object;

.field private static final MAIN:Landroid/os/Handler;

.field private static final MANAGER_PACKAGE:Ljava/lang/String; = "com.meowarex.rlmobile"

.field private static final MSG_LYRICS:I = 0x3

.field private static final MSG_POSITION:I = 0x2

.field private static final MSG_SESSION:I = 0x1

.field private static final RELAY_SERVICE:Ljava/lang/String; = "com.meowarex.rlmobile.pebble.PebbleRelayService"

.field private static final TAG:Ljava/lang/String; = "RLPebble"

.field private static final TOLERANCE_MS:J = 0xfL

.field private static instance:Lradiant/PebbleBridge;

.field private static lyricsBody:Ljava/lang/String;

.field private static lyricsFailed:Z

.field private static lyricsKey:Ljava/lang/String;

.field private static lyricsTitle:Ljava/lang/String;

.field private static rawAt:J

.field private static rawPosition:J


# instance fields
.field private bound:Z

.field private final context:Landroid/content/Context;

.field private controller:Landroid/media/session/MediaController;

.field private lastSendAt:J

.field private mediaId:Ljava/lang/String;

.field private playing:Z

.field private relay:Landroid/os/Messenger;

.field private retryBindAt:J

.field private sentAt:J

.field private sentPlaying:Z

.field private sentPosition:J

.field private token:Landroid/media/session/MediaSession$Token;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/PebbleBridge;->MAIN:Landroid/os/Handler;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lradiant/PebbleBridge;->LOCK:Ljava/lang/Object;

    const-wide/16 v0, -0x1

    sput-wide v0, Lradiant/PebbleBridge;->rawPosition:J

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lradiant/PebbleBridge;->sentPosition:J

    iput-object p1, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    return-void
.end method

.method static synthetic access$000(JJ)V
    .registers 4

    invoke-static {p0, p1, p2, p3}, Lradiant/PebbleBridge;->onSample(JJ)V

    return-void
.end method

.method static synthetic access$100()Lradiant/PebbleBridge;
    .registers 1

    sget-object v0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    return-object v0
.end method

.method static synthetic access$200(Lradiant/PebbleBridge;)V
    .registers 1

    invoke-direct {p0}, Lradiant/PebbleBridge;->sendLyrics()V

    return-void
.end method

.method private consider(JJZ)V
    .registers 13

    iget-boolean v0, p0, Lradiant/PebbleBridge;->sentPlaying:Z

    iget-wide v1, p0, Lradiant/PebbleBridge;->sentPosition:J

    if-eqz v0, :cond_b

    iget-wide v3, p0, Lradiant/PebbleBridge;->sentAt:J

    sub-long v3, p3, v3

    add-long/2addr v1, v3

    :cond_b
    iget-wide v3, p0, Lradiant/PebbleBridge;->sentPosition:J

    const-wide/16 v5, 0x0

    cmp-long v0, v3, v5

    if-ltz v0, :cond_22

    sub-long v0, p1, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(J)J

    move-result-wide v0

    const-wide/16 v2, 0xf

    cmp-long v0, v0, v2

    if-lez v0, :cond_20

    goto :goto_22

    :cond_20
    const/4 v0, 0x0

    goto :goto_23

    :cond_22
    :goto_22
    const/4 v0, 0x1

    :goto_23
    if-nez p5, :cond_38

    if-nez v0, :cond_38

    iget-boolean p5, p0, Lradiant/PebbleBridge;->sentPlaying:Z

    iget-boolean v0, p0, Lradiant/PebbleBridge;->playing:Z

    if-ne p5, v0, :cond_38

    iget-wide v0, p0, Lradiant/PebbleBridge;->lastSendAt:J

    sub-long v0, p3, v0

    const-wide/16 v2, 0x1388

    cmp-long p5, v0, v2

    if-gez p5, :cond_38

    return-void

    :cond_38
    invoke-direct {p0, p1, p2, p3, p4}, Lradiant/PebbleBridge;->sendPosition(JJ)Z

    move-result p5

    if-eqz p5, :cond_48

    iput-wide p1, p0, Lradiant/PebbleBridge;->sentPosition:J

    iput-wide p3, p0, Lradiant/PebbleBridge;->sentAt:J

    iget-boolean p1, p0, Lradiant/PebbleBridge;->playing:Z

    iput-boolean p1, p0, Lradiant/PebbleBridge;->sentPlaying:Z

    iput-wide p3, p0, Lradiant/PebbleBridge;->lastSendAt:J

    :cond_48
    return-void
.end method

.method public static onDestroy()V
    .registers 3

    :try_start_0
    sget-object v0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    if-eqz v0, :cond_15

    sget-object v0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    invoke-direct {v0}, Lradiant/PebbleBridge;->release()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;
    :try_end_c
    .catchall {:try_start_0 .. :try_end_c} :catchall_d

    goto :goto_15

    :catchall_d
    move-exception v0

    const-string v1, "RLPebble"

    const-string v2, "onDestroy failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_15
    :goto_15
    return-void
.end method

.method public static onLyrics(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 5

    sget-object v0, Lradiant/PebbleBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    if-nez p2, :cond_15

    if-eqz p0, :cond_15

    :try_start_7
    sget-object v1, Lradiant/PebbleBridge;->lyricsKey:Ljava/lang/String;

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_15

    sget-object v1, Lradiant/PebbleBridge;->lyricsBody:Ljava/lang/String;

    if-eqz v1, :cond_15

    monitor-exit v0

    return-void

    :cond_15
    sput-object p0, Lradiant/PebbleBridge;->lyricsKey:Ljava/lang/String;

    sput-object p1, Lradiant/PebbleBridge;->lyricsTitle:Ljava/lang/String;

    sput-object p2, Lradiant/PebbleBridge;->lyricsBody:Ljava/lang/String;

    if-nez p2, :cond_1f

    const/4 p0, 0x1

    goto :goto_20

    :cond_1f
    const/4 p0, 0x0

    :goto_20
    sput-boolean p0, Lradiant/PebbleBridge;->lyricsFailed:Z

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_7 .. :try_end_23} :catchall_2e

    sget-object p0, Lradiant/PebbleBridge;->MAIN:Landroid/os/Handler;

    new-instance p1, Lradiant/PebbleBridge$2;

    invoke-direct {p1}, Lradiant/PebbleBridge$2;-><init>()V

    invoke-virtual {p0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :catchall_2e
    move-exception p0

    :try_start_2f
    monitor-exit v0
    :try_end_30
    .catchall {:try_start_2f .. :try_end_30} :catchall_2e

    throw p0
.end method

.method public static onPosition(J)V
    .registers 6

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sget-object v2, Lradiant/PebbleBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v2

    :try_start_7
    sput-wide p0, Lradiant/PebbleBridge;->rawPosition:J

    sput-wide v0, Lradiant/PebbleBridge;->rawAt:J

    monitor-exit v2
    :try_end_c
    .catchall {:try_start_7 .. :try_end_c} :catchall_2a

    sget-object v2, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    if-nez v2, :cond_11

    return-void

    :cond_11
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    if-ne v2, v3, :cond_1f

    invoke-static {p0, p1, v0, v1}, Lradiant/PebbleBridge;->onSample(JJ)V

    goto :goto_29

    :cond_1f
    sget-object v2, Lradiant/PebbleBridge;->MAIN:Landroid/os/Handler;

    new-instance v3, Lradiant/PebbleBridge$1;

    invoke-direct {v3, p0, p1, v0, v1}, Lradiant/PebbleBridge$1;-><init>(JJ)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :goto_29
    return-void

    :catchall_2a
    move-exception p0

    :try_start_2b
    monitor-exit v2
    :try_end_2c
    .catchall {:try_start_2b .. :try_end_2c} :catchall_2a

    throw p0
.end method

.method private static onSample(JJ)V
    .registers 10

    sget-object v0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    if-eqz v0, :cond_a

    const/4 v5, 0x0

    move-wide v1, p0

    move-wide v3, p2

    invoke-direct/range {v0 .. v5}, Lradiant/PebbleBridge;->consider(JJZ)V

    :cond_a
    return-void
.end method

.method public static onState(Landroid/content/Context;Landroid/support/v4/media/session/MediaSessionCompat;)V
    .registers 4

    :try_start_0
    sget-object v0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    if-nez v0, :cond_12

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lradiant/PebbleBridge;

    if-eqz v0, :cond_d

    move-object p0, v0

    :cond_d
    invoke-direct {v1, p0}, Lradiant/PebbleBridge;-><init>(Landroid/content/Context;)V

    sput-object v1, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    :cond_12
    sget-object p0, Lradiant/PebbleBridge;->instance:Lradiant/PebbleBridge;

    invoke-direct {p0, p1}, Lradiant/PebbleBridge;->update(Landroid/support/v4/media/session/MediaSessionCompat;)V
    :try_end_17
    .catchall {:try_start_0 .. :try_end_17} :catchall_18

    goto :goto_20

    :catchall_18
    move-exception p0

    const-string p1, "RLPebble"

    const-string v0, "onState failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_20
    return-void
.end method

.method private readPlaying()Z
    .registers 3

    iget-object v0, p0, Lradiant/PebbleBridge;->controller:Landroid/media/session/MediaController;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lradiant/PebbleBridge;->controller:Landroid/media/session/MediaController;

    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v0

    goto :goto_c

    :cond_b
    const/4 v0, 0x0

    :goto_c
    if-eqz v0, :cond_17

    invoke-virtual {v0}, Landroid/media/session/PlaybackState;->getState()I

    move-result v0

    const/4 v1, 0x3

    if-ne v0, v1, :cond_17

    const/4 v0, 0x1

    goto :goto_18

    :cond_17
    const/4 v0, 0x0

    :goto_18
    return v0
.end method

.method private release()V
    .registers 2

    iget-boolean v0, p0, Lradiant/PebbleBridge;->bound:Z

    if-eqz v0, :cond_b

    :try_start_4
    iget-object v0, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    invoke-virtual {v0, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_9
    .catchall {:try_start_4 .. :try_end_9} :catchall_a

    goto :goto_b

    :catchall_a
    move-exception v0

    :cond_b
    :goto_b
    const/4 v0, 0x0

    iput-boolean v0, p0, Lradiant/PebbleBridge;->bound:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    return-void
.end method

.method private send(ILandroid/os/Bundle;)Z
    .registers 6

    iget-object v0, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    return v1

    :cond_6
    const/4 v2, 0x0

    :try_start_7
    invoke-static {v2, p1}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/os/Message;->setData(Landroid/os/Bundle;)V

    invoke-virtual {v0, p1}, Landroid/os/Messenger;->send(Landroid/os/Message;)V
    :try_end_11
    .catchall {:try_start_7 .. :try_end_11} :catchall_13

    const/4 p1, 0x1

    return p1

    :catchall_13
    move-exception p1

    iput-object v2, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    return v1
.end method

.method private sendLatest(Z)V
    .registers 14

    sget-object v1, Lradiant/PebbleBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    :try_start_3
    sget-wide v2, Lradiant/PebbleBridge;->rawPosition:J

    sget-wide v4, Lradiant/PebbleBridge;->rawAt:J

    monitor-exit v1
    :try_end_8
    .catchall {:try_start_3 .. :try_end_8} :catchall_1f

    const-wide/16 v0, 0x0

    cmp-long v0, v2, v0

    if-gez v0, :cond_f

    return-void

    :cond_f
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v9

    if-eqz p1, :cond_18

    sub-long v0, v9, v4

    add-long/2addr v2, v0

    :cond_18
    move-wide v7, v2

    const/4 v11, 0x1

    move-object v6, p0

    invoke-direct/range {v6 .. v11}, Lradiant/PebbleBridge;->consider(JJZ)V

    return-void

    :catchall_1f
    move-exception v0

    move-object p1, v0

    :try_start_21
    monitor-exit v1
    :try_end_22
    .catchall {:try_start_21 .. :try_end_22} :catchall_1f

    throw p1
.end method

.method private sendLyrics()V
    .registers 5

    iget-object v0, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    if-nez v0, :cond_5

    return-void

    :cond_5
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    sget-object v1, Lradiant/PebbleBridge;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    :try_start_d
    sget-object v2, Lradiant/PebbleBridge;->lyricsKey:Ljava/lang/String;

    if-nez v2, :cond_13

    monitor-exit v1

    return-void

    :cond_13
    const-string v2, "key"

    sget-object v3, Lradiant/PebbleBridge;->lyricsKey:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "title"

    sget-object v3, Lradiant/PebbleBridge;->lyricsTitle:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v2, Lradiant/PebbleBridge;->lyricsBody:Ljava/lang/String;

    if-eqz v2, :cond_2c

    const-string v2, "body"

    sget-object v3, Lradiant/PebbleBridge;->lyricsBody:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2c
    const-string v2, "failed"

    sget-boolean v3, Lradiant/PebbleBridge;->lyricsFailed:Z

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    monitor-exit v1
    :try_end_34
    .catchall {:try_start_d .. :try_end_34} :catchall_39

    const/4 v1, 0x3

    invoke-direct {p0, v1, v0}, Lradiant/PebbleBridge;->send(ILandroid/os/Bundle;)Z

    return-void

    :catchall_39
    move-exception v0

    :try_start_3a
    monitor-exit v1
    :try_end_3b
    .catchall {:try_start_3a .. :try_end_3b} :catchall_39

    throw v0
.end method

.method private sendPosition(JJ)Z
    .registers 7

    iget-object v0, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    if-nez v0, :cond_6

    const/4 p1, 0x0

    return p1

    :cond_6
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "position"

    invoke-virtual {v0, v1, p1, p2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    const-string p1, "elapsedRealtime"

    invoke-virtual {v0, p1, p3, p4}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    const-string p1, "playing"

    iget-boolean p2, p0, Lradiant/PebbleBridge;->playing:Z

    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    iget-object p1, p0, Lradiant/PebbleBridge;->mediaId:Ljava/lang/String;

    if-eqz p1, :cond_27

    const-string p1, "mediaId"

    iget-object p2, p0, Lradiant/PebbleBridge;->mediaId:Ljava/lang/String;

    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_27
    const/4 p1, 0x2

    invoke-direct {p0, p1, v0}, Lradiant/PebbleBridge;->send(ILandroid/os/Bundle;)Z

    move-result p1

    return p1
.end method

.method private sendSession()V
    .registers 4

    iget-object v0, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    if-eqz v0, :cond_24

    iget-object v0, p0, Lradiant/PebbleBridge;->token:Landroid/media/session/MediaSession$Token;

    if-nez v0, :cond_9

    goto :goto_24

    :cond_9
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "token"

    iget-object v2, p0, Lradiant/PebbleBridge;->token:Landroid/media/session/MediaSession$Token;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget-object v1, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "package"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x1

    invoke-direct {p0, v1, v0}, Lradiant/PebbleBridge;->send(ILandroid/os/Bundle;)Z

    :cond_24
    :goto_24
    return-void
.end method

.method private update(Landroid/support/v4/media/session/MediaSessionCompat;)V
    .registers 9

    if-nez p1, :cond_3

    return-void

    :cond_3
    invoke-virtual {p1}, Landroid/support/v4/media/session/MediaSessionCompat;->getSessionToken()Landroid/support/v4/media/session/MediaSessionCompat$Token;

    move-result-object p1

    const/4 v0, 0x0

    if-eqz p1, :cond_f

    invoke-virtual {p1}, Landroid/support/v4/media/session/MediaSessionCompat$Token;->getToken()Ljava/lang/Object;

    move-result-object p1

    goto :goto_10

    :cond_f
    move-object p1, v0

    :goto_10
    instance-of v1, p1, Landroid/media/session/MediaSession$Token;

    if-nez v1, :cond_15

    return-void

    :cond_15
    iget-object v1, p0, Lradiant/PebbleBridge;->token:Landroid/media/session/MediaSession$Token;

    invoke-virtual {p1, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2f

    check-cast p1, Landroid/media/session/MediaSession$Token;

    iput-object p1, p0, Lradiant/PebbleBridge;->token:Landroid/media/session/MediaSession$Token;

    new-instance p1, Landroid/media/session/MediaController;

    iget-object v1, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    iget-object v2, p0, Lradiant/PebbleBridge;->token:Landroid/media/session/MediaSession$Token;

    invoke-direct {p1, v1, v2}, Landroid/media/session/MediaController;-><init>(Landroid/content/Context;Landroid/media/session/MediaSession$Token;)V

    iput-object p1, p0, Lradiant/PebbleBridge;->controller:Landroid/media/session/MediaController;

    invoke-direct {p0}, Lradiant/PebbleBridge;->sendSession()V

    :cond_2f
    iget-boolean p1, p0, Lradiant/PebbleBridge;->bound:Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez p1, :cond_79

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    iget-wide v5, p0, Lradiant/PebbleBridge;->retryBindAt:J

    cmp-long p1, v3, v5

    if-ltz p1, :cond_79

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    new-instance v3, Landroid/content/ComponentName;

    const-string v4, "com.meowarex.rlmobile"

    const-string v5, "com.meowarex.rlmobile.pebble.PebbleRelayService"

    invoke-direct {v3, v4, v5}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1, v3}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object p1

    :try_start_51
    iget-object v3, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    invoke-virtual {v3, p1, p0, v2}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result p1

    iput-boolean p1, p0, Lradiant/PebbleBridge;->bound:Z
    :try_end_59
    .catchall {:try_start_51 .. :try_end_59} :catchall_5a

    goto :goto_5d

    :catchall_5a
    move-exception p1

    iput-boolean v1, p0, Lradiant/PebbleBridge;->bound:Z

    :goto_5d
    iget-boolean p1, p0, Lradiant/PebbleBridge;->bound:Z

    if-nez p1, :cond_79

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    const-wide/32 v5, 0xea60

    add-long/2addr v3, v5

    iput-wide v3, p0, Lradiant/PebbleBridge;->retryBindAt:J

    :try_start_6b
    iget-object p1, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    invoke-virtual {p1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_70
    .catchall {:try_start_6b .. :try_end_70} :catchall_71

    goto :goto_72

    :catchall_71
    move-exception p1

    :goto_72
    const-string p1, "RLPebble"

    const-string v3, "RL Manager relay not available"

    invoke-static {p1, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_79
    iget-boolean p1, p0, Lradiant/PebbleBridge;->playing:Z

    invoke-direct {p0}, Lradiant/PebbleBridge;->readPlaying()Z

    move-result v3

    iput-boolean v3, p0, Lradiant/PebbleBridge;->playing:Z

    iget-object v3, p0, Lradiant/PebbleBridge;->controller:Landroid/media/session/MediaController;

    if-eqz v3, :cond_8c

    iget-object v3, p0, Lradiant/PebbleBridge;->controller:Landroid/media/session/MediaController;

    invoke-virtual {v3}, Landroid/media/session/MediaController;->getMetadata()Landroid/media/MediaMetadata;

    move-result-object v3

    goto :goto_8d

    :cond_8c
    move-object v3, v0

    :goto_8d
    if-eqz v3, :cond_95

    const-string v0, "android.media.metadata.MEDIA_ID"

    invoke-virtual {v3, v0}, Landroid/media/MediaMetadata;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_95
    if-eqz v0, :cond_a0

    iget-object v3, p0, Lradiant/PebbleBridge;->mediaId:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a0

    move v1, v2

    :cond_a0
    iput-object v0, p0, Lradiant/PebbleBridge;->mediaId:Ljava/lang/String;

    if-eqz v1, :cond_a9

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lradiant/PebbleBridge;->sentPosition:J

    goto :goto_b0

    :cond_a9
    iget-boolean v0, p0, Lradiant/PebbleBridge;->playing:Z

    if-eq p1, v0, :cond_b0

    invoke-direct {p0, p1}, Lradiant/PebbleBridge;->sendLatest(Z)V

    :cond_b0
    :goto_b0
    return-void
.end method


# virtual methods
.method public onBindingDied(Landroid/content/ComponentName;)V
    .registers 2

    const/4 p1, 0x0

    iput-object p1, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    iget-boolean p1, p0, Lradiant/PebbleBridge;->bound:Z

    if-eqz p1, :cond_11

    :try_start_7
    iget-object p1, p0, Lradiant/PebbleBridge;->context:Landroid/content/Context;

    invoke-virtual {p1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_c
    .catchall {:try_start_7 .. :try_end_c} :catchall_d

    goto :goto_e

    :catchall_d
    move-exception p1

    :goto_e
    const/4 p1, 0x0

    iput-boolean p1, p0, Lradiant/PebbleBridge;->bound:Z

    :cond_11
    return-void
.end method

.method public onNullBinding(Landroid/content/ComponentName;)V
    .registers 2

    invoke-virtual {p0, p1}, Lradiant/PebbleBridge;->onBindingDied(Landroid/content/ComponentName;)V

    return-void
.end method

.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .registers 3

    new-instance p1, Landroid/os/Messenger;

    invoke-direct {p1, p2}, Landroid/os/Messenger;-><init>(Landroid/os/IBinder;)V

    iput-object p1, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    invoke-direct {p0}, Lradiant/PebbleBridge;->sendSession()V

    const-wide/16 p1, -0x1

    iput-wide p1, p0, Lradiant/PebbleBridge;->sentPosition:J

    iget-boolean p1, p0, Lradiant/PebbleBridge;->playing:Z

    invoke-direct {p0, p1}, Lradiant/PebbleBridge;->sendLatest(Z)V

    invoke-direct {p0}, Lradiant/PebbleBridge;->sendLyrics()V

    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .registers 2

    const/4 p1, 0x0

    iput-object p1, p0, Lradiant/PebbleBridge;->relay:Landroid/os/Messenger;

    return-void
.end method
