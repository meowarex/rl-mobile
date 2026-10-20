.class public final Lradiant/ArtPlayer;
.super Ljava/lang/Object;

# interfaces
.implements Landroidx/media3/common/Player$Listener;
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# static fields
.field static final NATIVE_FPS:I = 0x19

.field private static final TAG:Ljava/lang/String; = "RLAnimatedCovers"

.field private static lifecycleHooked:Z

.field private static final live:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/ref/WeakReference<",
            "Lradiant/ArtPlayer;",
            ">;>;"
        }
    .end annotation
.end field

.field private static startedActivities:I


# instance fields
.field private exo:Landroidx/media3/exoplayer/ExoPlayer;

.field private nativeFps:F

.field private final onFirstFrame:Ljava/lang/Runnable;

.field private released:Z

.field private final src:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lradiant/ArtPlayer;->live:Ljava/util/ArrayList;

    const/4 v0, 0x1

    sput v0, Lradiant/ArtPlayer;->startedActivities:I

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/Runnable;)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x41c80000    # 25.0f

    iput v0, p0, Lradiant/ArtPlayer;->nativeFps:F

    iput-object p1, p0, Lradiant/ArtPlayer;->src:Ljava/lang/String;

    iput-object p2, p0, Lradiant/ArtPlayer;->onFirstFrame:Ljava/lang/Runnable;

    return-void
.end method

.method private applyRate()V
    .registers 4

    iget-object v0, p0, Lradiant/ArtPlayer;->exo:Landroidx/media3/exoplayer/ExoPlayer;

    if-nez v0, :cond_5

    return-void

    :cond_5
    invoke-static {}, Lradiant/ArtDefaults;->fps()I

    move-result v1

    if-gtz v1, :cond_d

    const/16 v1, 0x19

    :cond_d
    int-to-float v1, v1

    iget v2, p0, Lradiant/ArtPlayer;->nativeFps:F

    div-float/2addr v1, v2

    const v2, 0x3d4ccccd    # 0.05f

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-interface {v0, v1}, Landroidx/media3/exoplayer/ExoPlayer;->setPlaybackSpeed(F)V

    return-void
.end method

.method private build(Landroid/content/Context;Landroid/view/Surface;II)V
    .registers 9

    invoke-static {p1}, Lradiant/ArtPlayer;->hookLifecycle(Landroid/content/Context;)V

    new-instance v0, Landroidx/media3/exoplayer/ExoPlayer$Builder;

    invoke-direct {v0, p1}, Landroidx/media3/exoplayer/ExoPlayer$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Landroidx/media3/exoplayer/ExoPlayer$Builder;->build()Landroidx/media3/exoplayer/ExoPlayer;

    move-result-object v0

    iput-object v0, p0, Lradiant/ArtPlayer;->exo:Landroidx/media3/exoplayer/ExoPlayer;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-lez p3, :cond_27

    int-to-float p3, p3

    div-float/2addr p3, v1

    invoke-static {p3}, Ljava/lang/Math;->round(F)I

    move-result p3

    invoke-static {v2, p3}, Ljava/lang/Math;->max(II)I

    move-result p3

    goto :goto_28

    :cond_27
    move p3, v3

    :goto_28
    if-lez p4, :cond_35

    int-to-float p4, p4

    div-float/2addr p4, v1

    invoke-static {p4}, Ljava/lang/Math;->round(F)I

    move-result p4

    invoke-static {v2, p4}, Ljava/lang/Math;->max(II)I

    move-result p4

    goto :goto_36

    :cond_35
    move p4, v3

    :goto_36
    invoke-interface {v0}, Landroidx/media3/exoplayer/ExoPlayer;->getTrackSelectionParameters()Landroidx/media3/common/TrackSelectionParameters;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/media3/common/TrackSelectionParameters;->buildUpon()Landroidx/media3/common/TrackSelectionParameters$Builder;

    move-result-object v1

    const-string v2, "video/avc"

    invoke-virtual {v1, v2}, Landroidx/media3/common/TrackSelectionParameters$Builder;->setPreferredVideoMimeType(Ljava/lang/String;)Landroidx/media3/common/TrackSelectionParameters$Builder;

    move-result-object v1

    if-lez p3, :cond_4b

    if-lez p4, :cond_4b

    invoke-virtual {v1, p3, p4, v3}, Landroidx/media3/common/TrackSelectionParameters$Builder;->setViewportSize(IIZ)Landroidx/media3/common/TrackSelectionParameters$Builder;

    :cond_4b
    invoke-virtual {v1}, Landroidx/media3/common/TrackSelectionParameters$Builder;->build()Landroidx/media3/common/TrackSelectionParameters;

    move-result-object p3

    invoke-interface {v0, p3}, Landroidx/media3/exoplayer/ExoPlayer;->setTrackSelectionParameters(Landroidx/media3/common/TrackSelectionParameters;)V

    invoke-interface {v0, p2}, Landroidx/media3/exoplayer/ExoPlayer;->setVideoSurface(Landroid/view/Surface;)V

    const/4 p2, 0x0

    invoke-interface {v0, p2}, Landroidx/media3/exoplayer/ExoPlayer;->setVolume(F)V

    const/4 p2, 0x2

    invoke-interface {v0, p2}, Landroidx/media3/exoplayer/ExoPlayer;->setRepeatMode(I)V

    invoke-interface {v0, p0}, Landroidx/media3/exoplayer/ExoPlayer;->addListener(Landroidx/media3/common/Player$Listener;)V

    new-instance p2, Landroidx/media3/common/MediaItem$Builder;

    invoke-direct {p2}, Landroidx/media3/common/MediaItem$Builder;-><init>()V

    iget-object p3, p0, Lradiant/ArtPlayer;->src:Ljava/lang/String;

    invoke-virtual {p2, p3}, Landroidx/media3/common/MediaItem$Builder;->setUri(Ljava/lang/String;)Landroidx/media3/common/MediaItem$Builder;

    move-result-object p2

    const-string p3, "application/x-mpegURL"

    invoke-virtual {p2, p3}, Landroidx/media3/common/MediaItem$Builder;->setMimeType(Ljava/lang/String;)Landroidx/media3/common/MediaItem$Builder;

    move-result-object p2

    invoke-virtual {p2}, Landroidx/media3/common/MediaItem$Builder;->build()Landroidx/media3/common/MediaItem;

    move-result-object p2

    new-instance p3, Landroidx/media3/exoplayer/hls/HlsMediaSource$Factory;

    new-instance p4, Landroidx/media3/datasource/DefaultDataSource$Factory;

    invoke-direct {p4, p1}, Landroidx/media3/datasource/DefaultDataSource$Factory;-><init>(Landroid/content/Context;)V

    invoke-direct {p3, p4}, Landroidx/media3/exoplayer/hls/HlsMediaSource$Factory;-><init>(Landroidx/media3/datasource/DataSource$Factory;)V

    invoke-virtual {p3, p2}, Landroidx/media3/exoplayer/hls/HlsMediaSource$Factory;->createMediaSource(Landroidx/media3/common/MediaItem;)Landroidx/media3/exoplayer/hls/HlsMediaSource;

    move-result-object p1

    invoke-interface {v0, p1}, Landroidx/media3/exoplayer/ExoPlayer;->setMediaSource(Landroidx/media3/exoplayer/source/MediaSource;)V

    invoke-interface {v0}, Landroidx/media3/exoplayer/ExoPlayer;->prepare()V

    invoke-direct {p0}, Lradiant/ArtPlayer;->applyRate()V

    sget-object p1, Lradiant/ArtPlayer;->live:Ljava/util/ArrayList;

    monitor-enter p1

    :try_start_8f
    sget-object p2, Lradiant/ArtPlayer;->live:Ljava/util/ArrayList;

    new-instance p3, Ljava/lang/ref/WeakReference;

    invoke-direct {p3, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p2, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    monitor-exit p1
    :try_end_9a
    .catchall {:try_start_8f .. :try_end_9a} :catchall_9e

    invoke-direct {p0}, Lradiant/ArtPlayer;->ensurePlaying()V

    return-void

    :catchall_9e
    move-exception p2

    :try_start_9f
    monitor-exit p1
    :try_end_a0
    .catchall {:try_start_9f .. :try_end_a0} :catchall_9e

    throw p2
.end method

.method private ensurePlaying()V
    .registers 3

    iget-object v0, p0, Lradiant/ArtPlayer;->exo:Landroidx/media3/exoplayer/ExoPlayer;

    if-eqz v0, :cond_14

    iget-boolean v1, p0, Lradiant/ArtPlayer;->released:Z

    if-eqz v1, :cond_9

    goto :goto_14

    :cond_9
    sget v1, Lradiant/ArtPlayer;->startedActivities:I

    if-lez v1, :cond_11

    invoke-interface {v0}, Landroidx/media3/exoplayer/ExoPlayer;->play()V

    goto :goto_14

    :cond_11
    invoke-interface {v0}, Landroidx/media3/exoplayer/ExoPlayer;->pause()V

    :cond_14
    :goto_14
    return-void
.end method

.method private static hookLifecycle(Landroid/content/Context;)V
    .registers 3

    sget-boolean v0, Lradiant/ArtPlayer;->lifecycleHooked:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    instance-of v0, p0, Landroid/app/Application;

    if-nez v0, :cond_e

    return-void

    :cond_e
    const/4 v0, 0x1

    sput-boolean v0, Lradiant/ArtPlayer;->lifecycleHooked:Z

    check-cast p0, Landroid/app/Application;

    new-instance v0, Lradiant/ArtPlayer;

    const/4 v1, 0x0

    invoke-direct {v0, v1, v1}, Lradiant/ArtPlayer;-><init>(Ljava/lang/String;Ljava/lang/Runnable;)V

    invoke-virtual {p0, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    return-void
.end method

.method static isStream(Ljava/lang/String;)Z
    .registers 2

    if-eqz p0, :cond_10

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".m3u8"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_10

    const/4 p0, 0x1

    goto :goto_11

    :cond_10
    const/4 p0, 0x0

    :goto_11
    return p0
.end method

.method static start(Landroid/content/Context;Ljava/lang/String;Landroid/view/Surface;IILjava/lang/Runnable;)Lradiant/ArtPlayer;
    .registers 7

    new-instance v0, Lradiant/ArtPlayer;

    invoke-direct {v0, p1, p5}, Lradiant/ArtPlayer;-><init>(Ljava/lang/String;Ljava/lang/Runnable;)V

    :try_start_5
    invoke-direct {v0, p0, p2, p3, p4}, Lradiant/ArtPlayer;->build(Landroid/content/Context;Landroid/view/Surface;II)V
    :try_end_8
    .catchall {:try_start_5 .. :try_end_8} :catchall_9

    return-object v0

    :catchall_9
    move-exception p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "player failed for "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, ": "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p2, "RLAnimatedCovers"

    invoke-static {p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Lradiant/ArtPlayer;->release()V

    invoke-static {p1}, Lradiant/AnimatedCovers;->onPlaybackFailed(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0
.end method

.method private static syncAll()V
    .registers 4

    sget-object v0, Lradiant/ArtPlayer;->live:Ljava/util/ArrayList;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/ArtPlayer;->live:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_9
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2a

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lradiant/ArtPlayer;

    if-eqz v2, :cond_26

    iget-boolean v3, v2, Lradiant/ArtPlayer;->released:Z

    if-eqz v3, :cond_22

    goto :goto_26

    :cond_22
    invoke-direct {v2}, Lradiant/ArtPlayer;->ensurePlaying()V

    goto :goto_9

    :cond_26
    :goto_26
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :goto_9

    :cond_2a
    monitor-exit v0

    return-void

    :catchall_2c
    move-exception v1

    monitor-exit v0
    :try_end_2e
    .catchall {:try_start_3 .. :try_end_2e} :catchall_2c

    throw v1
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .registers 3

    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .registers 2

    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .registers 2

    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .registers 2

    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .registers 3

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .registers 3

    sget p1, Lradiant/ArtPlayer;->startedActivities:I

    const/4 v0, 0x1

    add-int/2addr p1, v0

    sput p1, Lradiant/ArtPlayer;->startedActivities:I

    sget p1, Lradiant/ArtPlayer;->startedActivities:I

    if-ne p1, v0, :cond_d

    invoke-static {}, Lradiant/ArtPlayer;->syncAll()V

    :cond_d
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .registers 3

    sget p1, Lradiant/ArtPlayer;->startedActivities:I

    add-int/lit8 p1, p1, -0x1

    const/4 v0, 0x0

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    sput p1, Lradiant/ArtPlayer;->startedActivities:I

    sget p1, Lradiant/ArtPlayer;->startedActivities:I

    if-nez p1, :cond_12

    invoke-static {}, Lradiant/ArtPlayer;->syncAll()V

    :cond_12
    return-void
.end method

.method public onPlayerError(Landroidx/media3/common/PlaybackException;)V
    .registers 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "playback error, hiding video (src: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lradiant/ArtPlayer;->src:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "): "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "RLAnimatedCovers"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lradiant/ArtPlayer;->release()V

    iget-object p1, p0, Lradiant/ArtPlayer;->src:Ljava/lang/String;

    invoke-static {p1}, Lradiant/AnimatedCovers;->onPlaybackFailed(Ljava/lang/String;)V

    return-void
.end method

.method public onRenderedFirstFrame()V
    .registers 2

    iget-boolean v0, p0, Lradiant/ArtPlayer;->released:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    iget-object v0, p0, Lradiant/ArtPlayer;->onFirstFrame:Ljava/lang/Runnable;

    if-eqz v0, :cond_e

    iget-object v0, p0, Lradiant/ArtPlayer;->onFirstFrame:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    :cond_e
    return-void
.end method

.method public onTracksChanged(Landroidx/media3/common/Tracks;)V
    .registers 2

    iget-object p1, p0, Lradiant/ArtPlayer;->exo:Landroidx/media3/exoplayer/ExoPlayer;

    if-nez p1, :cond_5

    return-void

    :cond_5
    :try_start_5
    invoke-interface {p1}, Landroidx/media3/exoplayer/ExoPlayer;->getVideoFormat()Landroidx/media3/common/Format;

    move-result-object p1

    if-eqz p1, :cond_10

    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_e
    .catchall {:try_start_5 .. :try_end_e} :catchall_f

    goto :goto_10

    :catchall_f
    move-exception p1

    :cond_10
    :goto_10
    invoke-direct {p0}, Lradiant/ArtPlayer;->applyRate()V

    return-void
.end method

.method release()V
    .registers 3

    iget-boolean v0, p0, Lradiant/ArtPlayer;->released:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    const/4 v0, 0x1

    iput-boolean v0, p0, Lradiant/ArtPlayer;->released:Z

    iget-object v0, p0, Lradiant/ArtPlayer;->exo:Landroidx/media3/exoplayer/ExoPlayer;

    const/4 v1, 0x0

    iput-object v1, p0, Lradiant/ArtPlayer;->exo:Landroidx/media3/exoplayer/ExoPlayer;

    if-eqz v0, :cond_14

    :try_start_f
    invoke-interface {v0}, Landroidx/media3/exoplayer/ExoPlayer;->release()V
    :try_end_12
    .catchall {:try_start_f .. :try_end_12} :catchall_13

    goto :goto_14

    :catchall_13
    move-exception v0

    :cond_14
    :goto_14
    return-void
.end method
