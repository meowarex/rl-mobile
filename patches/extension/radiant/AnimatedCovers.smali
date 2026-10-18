.class public final Lradiant/AnimatedCovers;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;
.implements Lyl0/p;


# static fields
.field private static final API:Ljava/lang/String; = "https://ama.trainswift.net/api/v1/artwork/search?"

.field private static final APPLY:I = 0x3

.field private static final CACHE_MAX:I = 0xc8

.field private static final FAILED:I = 0x4

.field private static final FETCH:I = 0x2

.field private static final FETCH_TIMEOUT_MS:J = 0x2710L

.field private static final NONE:Ljava/lang/Object;

.field private static final PLACEHOLDER:I = 0x5

.field private static final RESOLVE:I = 0x0

.field private static final SET_TRACK:I = 0x1

.field private static final TAG:Ljava/lang/String; = "RLAnimatedCovers"

.field static final albumState:Landroidx/compose/runtime/MutableState;

.field private static artworkKey:Ljava/lang/String;

.field private static artworkUrl:Ljava/lang/String;

.field private static final cache:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static failedSrc:Ljava/lang/String;

.field private static volatile lastState:Ljava/lang/String;

.field private static loadToken:I

.field private static main:Landroid/os/Handler;

.field private static volatile queue:Ljava/lang/Object;

.field private static trackId:Ljava/lang/String;

.field static final urlState:Landroidx/compose/runtime/MutableState;


# instance fields
.field private album:Ljava/lang/String;

.field private albumId:I

.field private artist:Ljava/lang/String;

.field private colorFilter:Landroidx/compose/ui/graphics/ColorFilter;

.field private contentScale:Landroidx/compose/ui/layout/ContentScale;

.field private defaults:I

.field private description:Ljava/lang/String;

.field private id:Ljava/lang/String;

.field private isrc:Ljava/lang/String;

.field private key:Ljava/lang/String;

.field private final mode:I

.field private onError:Lyl0/a;

.field private placeholder:Ljava/lang/Object;

.field private request:Lyl0/l;

.field private title:Ljava/lang/String;

.field private token:I

.field private url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    const/4 v0, 0x0

    const/4 v1, 0x2

    invoke-static {v0, v0, v1, v0}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v2

    sput-object v2, Lradiant/AnimatedCovers;->urlState:Landroidx/compose/runtime/MutableState;

    const/4 v2, -0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v2, v0, v1, v0}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/AnimatedCovers;->albumState:Landroidx/compose/runtime/MutableState;

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    sput-object v0, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lradiant/AnimatedCovers;->NONE:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>(I)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/AnimatedCovers;->mode:I

    return-void
.end method

.method private static apply(Ljava/lang/String;Ljava/lang/String;I)V
    .registers 3

    sput-object p1, Lradiant/AnimatedCovers;->artworkKey:Ljava/lang/String;

    if-eqz p0, :cond_c

    sget-object p1, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_f

    :cond_c
    const/4 p1, 0x0

    sput-object p1, Lradiant/AnimatedCovers;->failedSrc:Ljava/lang/String;

    :cond_f
    sput-object p0, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    sget-object p0, Lradiant/AnimatedCovers;->albumState:Landroidx/compose/runtime/MutableState;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {p0, p1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    invoke-static {}, Lradiant/AnimatedCovers;->publish()V

    return-void
.end method

.method private static background(Ljava/lang/Runnable;)V
    .registers 3

    new-instance v0, Ljava/lang/Thread;

    const-string v1, "RL-AnimatedCovers"

    invoke-direct {v0, p0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public static cover(Lyl0/l;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/ui/layout/ContentScale;Ljava/lang/Object;Lyl0/a;Landroidx/compose/runtime/Composer;III)V
    .registers 12

    invoke-static {p10}, Lradiant/AnimatedCovers;->urlFor(I)Ljava/lang/String;

    move-result-object p10

    if-eqz p10, :cond_25

    const p8, 0x52414143

    invoke-interface {p7, p8}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    new-instance p8, Lradiant/AnimatedCovers;

    const/4 v0, 0x5

    invoke-direct {p8, v0}, Lradiant/AnimatedCovers;-><init>(I)V

    iput-object p0, p8, Lradiant/AnimatedCovers;->request:Lyl0/l;

    iput-object p1, p8, Lradiant/AnimatedCovers;->description:Ljava/lang/String;

    iput-object p3, p8, Lradiant/AnimatedCovers;->colorFilter:Landroidx/compose/ui/graphics/ColorFilter;

    iput-object p4, p8, Lradiant/AnimatedCovers;->contentScale:Landroidx/compose/ui/layout/ContentScale;

    iput-object p5, p8, Lradiant/AnimatedCovers;->placeholder:Ljava/lang/Object;

    iput-object p6, p8, Lradiant/AnimatedCovers;->onError:Lyl0/a;

    iput p9, p8, Lradiant/AnimatedCovers;->defaults:I

    const/4 p0, 0x0

    invoke-static {p10, p2, p8, p7, p0}, Lcom/tidal/android/core/compose/components/l;->a(Ljava/lang/String;Landroidx/compose/ui/Modifier;Lyl0/p;Landroidx/compose/runtime/Composer;I)V

    goto :goto_2e

    :cond_25
    const p10, 0x52414144

    invoke-interface {p7, p10}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    invoke-static/range {p0 .. p9}, Lsd0/f;->a(Lyl0/l;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/ui/layout/ContentScale;Ljava/lang/Object;Lyl0/a;Landroidx/compose/runtime/Composer;II)V

    :goto_2e
    invoke-interface {p7}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-void
.end method

.method private static currentMedia(Ljava/lang/String;)Lcom/aspiro/wamp/model/MediaItem;
    .registers 4

    const/4 v0, 0x0

    :try_start_1
    sget-object v1, Lradiant/AnimatedCovers;->queue:Ljava/lang/Object;

    if-nez v1, :cond_6

    return-object v0

    :cond_6
    check-cast v1, Lzh/e;

    invoke-interface {v1}, Lzh/e;->getCurrentItem()Lcom/aspiro/wamp/playqueue/q0;

    move-result-object v1

    if-nez v1, :cond_f

    return-object v0

    :cond_f
    invoke-interface {v1}, Lcom/aspiro/wamp/playqueue/q0;->getMediaItem()Lcom/aspiro/wamp/model/MediaItem;

    move-result-object v1

    if-eqz v1, :cond_27

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_27

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0
    :try_end_23
    .catchall {:try_start_1 .. :try_end_23} :catchall_28

    if-nez p0, :cond_26

    goto :goto_27

    :cond_26
    return-object v1

    :cond_27
    :goto_27
    return-object v0

    :catchall_28
    move-exception p0

    return-object v0
.end method

.method private done(Ljava/lang/String;Ljava/lang/String;)V
    .registers 5

    new-instance v0, Lradiant/AnimatedCovers;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Lradiant/AnimatedCovers;-><init>(I)V

    iget v1, p0, Lradiant/AnimatedCovers;->token:I

    iput v1, v0, Lradiant/AnimatedCovers;->token:I

    iput-object p1, v0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    iput-object p2, v0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    iget p1, p0, Lradiant/AnimatedCovers;->albumId:I

    iput p1, v0, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {v0}, Lradiant/AnimatedCovers;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static enc(Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    :try_start_0
    const-string v0, "UTF-8"

    invoke-static {p0, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "+"

    const-string v2, "%20"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%21"

    const-string v2, "!"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%27"

    const-string v2, "\'"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%28"

    const-string v2, "("

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%29"

    const-string v2, ")"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%7E"

    const-string v2, "~"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0
    :try_end_36
    .catchall {:try_start_0 .. :try_end_36} :catchall_37

    return-object p0

    :catchall_37
    move-exception v0

    return-object p0
.end method

.method private fetch()V
    .registers 10

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x2710

    add-long/2addr v0, v2

    iget-object v2, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    if-eqz v2, :cond_d

    const/4 v2, 0x1

    goto :goto_e

    :cond_d
    const/4 v2, 0x0

    :goto_e
    iget-object v3, p0, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    if-nez v3, :cond_15

    const-string v3, ""

    goto :goto_1b

    :cond_15
    iget-object v3, p0, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    :goto_1b
    if-eqz v2, :cond_39

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\u0000"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_41

    :cond_39
    iget-object v4, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v5, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-static {v4, v5}, Lradiant/AnimatedCovers;->titleKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_41
    sget-object v5, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    monitor-enter v5

    :try_start_44
    sget-object v6, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v6, v4}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    const/4 v7, 0x0

    if-eqz v6, :cond_5f

    sget-object v6, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v6, v4}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    if-nez v6, :cond_58

    sget-object v6, Lradiant/AnimatedCovers;->NONE:Ljava/lang/Object;

    goto :goto_60

    :cond_58
    sget-object v6, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v6, v4}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    goto :goto_60

    :cond_5f
    move-object v6, v7

    :goto_60
    if-nez v6, :cond_64

    :goto_62
    move-object v8, v7

    goto :goto_6c

    :cond_64
    sget-object v8, Lradiant/AnimatedCovers;->NONE:Ljava/lang/Object;

    if-ne v6, v8, :cond_69

    goto :goto_62

    :cond_69
    move-object v8, v6

    check-cast v8, Ljava/lang/String;

    :goto_6c
    if-eqz v6, :cond_73

    invoke-direct {p0, v8, v4}, Lradiant/AnimatedCovers;->done(Ljava/lang/String;Ljava/lang/String;)V

    monitor-exit v5

    return-void

    :cond_73
    monitor-exit v5
    :try_end_74
    .catchall {:try_start_44 .. :try_end_74} :catchall_f6

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_7c

    move-object v3, v7

    goto :goto_97

    :cond_7c
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "https://ama.trainswift.net/api/v1/artwork/search?isrc="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v3}, Lradiant/AnimatedCovers;->enc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, v1}, Lradiant/AnimatedCovers;->tryFetch(Ljava/lang/String;J)Ljava/lang/String;

    move-result-object v3

    :goto_97
    if-eqz v3, :cond_9d

    :goto_99
    invoke-static {v4, v3}, Lradiant/AnimatedCovers;->remember(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_d0

    :cond_9d
    iget-object v3, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iget-object v5, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v6, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    invoke-static {v3, v5, v6}, Lradiant/AnimatedCovers;->searchUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, v1}, Lradiant/AnimatedCovers;->tryFetch(Ljava/lang/String;J)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_ae

    goto :goto_99

    :cond_ae
    if-eqz v2, :cond_c5

    iget-object v2, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iget-object v3, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-static {v2, v3, v7}, Lradiant/AnimatedCovers;->searchUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0, v1}, Lradiant/AnimatedCovers;->tryFetch(Ljava/lang/String;J)Ljava/lang/String;

    move-result-object v3

    iget-object v0, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v1, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-static {v0, v1}, Lradiant/AnimatedCovers;->titleKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_d0

    :cond_c5
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    cmp-long v0, v5, v0

    if-gez v0, :cond_d0

    invoke-static {v4, v7}, Lradiant/AnimatedCovers;->remember(Ljava/lang/String;Ljava/lang/String;)V

    :cond_d0
    :goto_d0
    if-nez v3, :cond_f2

    const-string v0, "RLAnimatedCovers"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "no animated art for \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_f2
    invoke-direct {p0, v3, v4}, Lradiant/AnimatedCovers;->done(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :catchall_f6
    move-exception v0

    :try_start_f7
    monitor-exit v5
    :try_end_f8
    .catchall {:try_start_f7 .. :try_end_f8} :catchall_f6

    throw v0
.end method

.method private static isrcOf(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    const/4 v0, 0x0

    :try_start_1
    invoke-static {p0}, Lradiant/IsrcCache;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_16

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_12

    goto :goto_16

    :cond_12
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0
    :try_end_16
    .catchall {:try_start_1 .. :try_end_16} :catchall_17

    :cond_16
    :goto_16
    return-object v0

    :catchall_17
    move-exception p0

    return-object v0
.end method

.method public static onMediaState(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .registers 5

    if-eqz p0, :cond_44

    if-eqz p1, :cond_44

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p3

    if-eqz p3, :cond_b

    goto :goto_44

    :cond_b
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v0, "\u0000"

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    sget-object v0, Lradiant/AnimatedCovers;->lastState:Ljava/lang/String;

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_33

    return-void

    :cond_33
    sput-object p3, Lradiant/AnimatedCovers;->lastState:Ljava/lang/String;

    new-instance p3, Lradiant/AnimatedCovers;

    const/4 v0, 0x0

    invoke-direct {p3, v0}, Lradiant/AnimatedCovers;-><init>(I)V

    iput-object p0, p3, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iput-object p1, p3, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iput p2, p3, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {p3}, Lradiant/AnimatedCovers;->background(Ljava/lang/Runnable;)V

    :cond_44
    :goto_44
    return-void
.end method

.method static onPlaybackFailed(Ljava/lang/String;)V
    .registers 3

    new-instance v0, Lradiant/AnimatedCovers;

    const/4 v1, 0x4

    invoke-direct {v0, v1}, Lradiant/AnimatedCovers;-><init>(I)V

    iput-object p0, v0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    invoke-static {v0}, Lradiant/AnimatedCovers;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static post(Ljava/lang/Runnable;)V
    .registers 3

    sget-object v0, Lradiant/AnimatedCovers;->main:Landroid/os/Handler;

    if-nez v0, :cond_f

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/AnimatedCovers;->main:Landroid/os/Handler;

    :cond_f
    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private static publish()V
    .registers 2

    sget-object v0, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    if-eqz v0, :cond_11

    sget-object v0, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    sget-object v1, Lradiant/AnimatedCovers;->failedSrc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_11

    sget-object v0, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    goto :goto_12

    :cond_11
    const/4 v0, 0x0

    :goto_12
    sget-object v1, Lradiant/AnimatedCovers;->urlState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    if-nez v0, :cond_1d

    if-eqz v1, :cond_28

    goto :goto_23

    :cond_1d
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_28

    :goto_23
    sget-object v1, Lradiant/AnimatedCovers;->urlState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1, v0}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    :cond_28
    invoke-static {}, Lradiant/AnimatedCoverView;->refreshAll()V

    return-void
.end method

.method private static remember(Ljava/lang/String;Ljava/lang/String;)V
    .registers 5

    sget-object v0, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v1, p0}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2b

    sget-object v1, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->size()I

    move-result v1

    const/16 v2, 0xc8

    if-lt v1, v2, :cond_2b

    sget-object v1, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2b

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    :cond_2b
    sget-object v1, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v1, p0, p1}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v0

    return-void

    :catchall_32
    move-exception p0

    monitor-exit v0
    :try_end_34
    .catchall {:try_start_3 .. :try_end_34} :catchall_32

    throw p0
.end method

.method private resolve()V
    .registers 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/InterruptedException;
        }
    .end annotation

    const/4 v0, 0x0

    const/4 v1, 0x0

    move-object v3, v0

    move v2, v1

    :goto_4
    const/16 v4, 0xf

    const-wide/16 v5, 0x64

    if-ge v2, v4, :cond_1a

    if-nez v3, :cond_1a

    iget-object v3, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-static {v3}, Lradiant/AnimatedCovers;->currentMedia(Ljava/lang/String;)Lcom/aspiro/wamp/model/MediaItem;

    move-result-object v3

    if-nez v3, :cond_17

    invoke-static {v5, v6}, Ljava/lang/Thread;->sleep(J)V

    :cond_17
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_1a
    new-instance v2, Lradiant/AnimatedCovers;

    const/4 v4, 0x1

    invoke-direct {v2, v4}, Lradiant/AnimatedCovers;-><init>(I)V

    iget v4, p0, Lradiant/AnimatedCovers;->albumId:I

    iput v4, v2, Lradiant/AnimatedCovers;->albumId:I

    if-nez v3, :cond_5d

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "m:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u0000"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lradiant/AnimatedCovers;->albumId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iput-object v0, v2, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iput-object v0, v2, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    goto/16 :goto_104

    :cond_5d
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v2, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_70

    iget-object v4, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    goto :goto_74

    :cond_70
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v4

    :goto_74
    instance-of v7, v3, Lcom/aspiro/wamp/model/Track;

    if-eqz v7, :cond_80

    move-object v7, v3

    check-cast v7, Lcom/aspiro/wamp/model/Track;

    invoke-virtual {v7}, Lcom/aspiro/wamp/model/Track;->getVersion()Ljava/lang/String;

    move-result-object v7

    goto :goto_81

    :cond_80
    move-object v7, v0

    :goto_81
    if-eqz v7, :cond_aa

    invoke-virtual {v7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_aa

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, " ("

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, ")"

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    :cond_aa
    iput-object v4, v2, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getArtist()Lcom/aspiro/wamp/model/Artist;

    move-result-object v4

    if-eqz v4, :cond_bb

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getArtist()Lcom/aspiro/wamp/model/Artist;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Artist;->getName()Ljava/lang/String;

    move-result-object v4

    goto :goto_bc

    :cond_bb
    move-object v4, v0

    :goto_bc
    if-eqz v4, :cond_c5

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_c5

    goto :goto_c7

    :cond_c5
    iget-object v4, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    :goto_c7
    iput-object v4, v2, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v4

    if-eqz v4, :cond_ea

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v3

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Album;->getTitle()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e8

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_e4

    goto :goto_e8

    :cond_e4
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    :cond_e8
    :goto_e8
    iput-object v0, v2, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    :cond_ea
    :goto_ea
    const/16 v0, 0x14

    if-ge v1, v0, :cond_104

    iget-object v0, v2, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    if-nez v0, :cond_104

    iget-object v0, v2, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    invoke-static {v0}, Lradiant/AnimatedCovers;->isrcOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    iget-object v0, v2, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    if-nez v0, :cond_101

    invoke-static {v5, v6}, Ljava/lang/Thread;->sleep(J)V

    :cond_101
    add-int/lit8 v1, v1, 0x1

    goto :goto_ea

    :cond_104
    :goto_104
    invoke-static {v2}, Lradiant/AnimatedCovers;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static searchUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://ama.trainswift.net/api/v1/artwork/search?title="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Lradiant/AnimatedCovers;->enc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "&artist="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {p1}, Lradiant/AnimatedCovers;->enc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    if-eqz p2, :cond_50

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_50

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "&album="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lradiant/AnimatedCovers;->enc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_50
    return-object p0
.end method

.method public static setQueue(Ljava/lang/Object;)V
    .registers 1

    sput-object p0, Lradiant/AnimatedCovers;->queue:Ljava/lang/Object;

    return-void
.end method

.method private setTrack()V
    .registers 4

    iget-object v0, p0, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    sget-object v1, Lradiant/AnimatedCovers;->trackId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    return-void

    :cond_b
    iget-object v0, p0, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    sput-object v0, Lradiant/AnimatedCovers;->trackId:Ljava/lang/String;

    sget v0, Lradiant/AnimatedCovers;->loadToken:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lradiant/AnimatedCovers;->loadToken:I

    iget-object v1, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    if-eqz v1, :cond_35

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\u0000"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_3d

    :cond_35
    iget-object v1, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v2, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-static {v1, v2}, Lradiant/AnimatedCovers;->titleKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_3d
    sget-object v2, Lradiant/AnimatedCovers;->artworkKey:Ljava/lang/String;

    if-eqz v2, :cond_6c

    sget-object v2, Lradiant/AnimatedCovers;->artworkKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_59

    iget-object v1, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v2, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-static {v1, v2}, Lradiant/AnimatedCovers;->titleKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lradiant/AnimatedCovers;->artworkKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6c

    :cond_59
    sget-object v0, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    if-eqz v0, :cond_6b

    sget-object v0, Lradiant/AnimatedCovers;->albumState:Landroidx/compose/runtime/MutableState;

    iget v1, p0, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    invoke-static {}, Lradiant/AnimatedCoverView;->refreshAll()V

    :cond_6b
    return-void

    :cond_6c
    iget v1, p0, Lradiant/AnimatedCovers;->albumId:I

    const/4 v2, 0x0

    invoke-static {v2, v2, v1}, Lradiant/AnimatedCovers;->apply(Ljava/lang/String;Ljava/lang/String;I)V

    new-instance v1, Lradiant/AnimatedCovers;

    const/4 v2, 0x2

    invoke-direct {v1, v2}, Lradiant/AnimatedCovers;-><init>(I)V

    iput v0, v1, Lradiant/AnimatedCovers;->token:I

    iget-object v0, p0, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    iput-object v0, v1, Lradiant/AnimatedCovers;->id:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iput-object v0, v1, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iput-object v0, v1, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    iput-object v0, v1, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    iget-object v0, p0, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    iput-object v0, v1, Lradiant/AnimatedCovers;->isrc:Ljava/lang/String;

    iget v0, p0, Lradiant/AnimatedCovers;->albumId:I

    iput v0, v1, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {v1}, Lradiant/AnimatedCovers;->background(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static titleKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "\u0000\u0000"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static tryFetch(Ljava/lang/String;J)Ljava/lang/String;
    .registers 11

    const-string v0, ""

    const-string v1, " | "

    const-string v2, "RLAnimatedCovers"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sub-long/2addr p1, v3

    const-wide/16 v3, 0x0

    cmp-long v3, p1, v3

    const/4 v4, 0x0

    if-gtz v3, :cond_13

    return-object v4

    :cond_13
    :try_start_13
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "fetching "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v3, Ljava/net/URL;

    invoke-direct {v3, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v3

    check-cast v3, Ljava/net/HttpURLConnection;
    :try_end_34
    .catch Ljava/net/SocketTimeoutException; {:try_start_13 .. :try_end_34} :catch_fb
    .catchall {:try_start_13 .. :try_end_34} :catchall_d5

    long-to-int p1, p1

    :try_start_35
    invoke-virtual {v3, p1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v3, p1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result p1

    const/16 p2, 0xc8

    if-eq p1, p2, :cond_67

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "fetch failed "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_61
    .catch Ljava/net/SocketTimeoutException; {:try_start_35 .. :try_end_61} :catch_d3
    .catchall {:try_start_35 .. :try_end_61} :catchall_d1

    if-eqz v3, :cond_66

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_66
    return-object v4

    :cond_67
    :try_start_67
    new-instance p1, Ljava/io/BufferedReader;

    new-instance p2, Ljava/io/InputStreamReader;

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    const-string v6, "UTF-8"

    invoke-direct {p2, v5, v6}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {p1, p2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v5, 0x1000

    new-array v5, v5, [C

    :goto_80
    invoke-virtual {p1, v5}, Ljava/io/BufferedReader;->read([C)I

    move-result v6

    if-lez v6, :cond_8b

    const/4 v7, 0x0

    invoke-virtual {p2, v5, v7, v6}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    goto :goto_80

    :cond_8b
    invoke-virtual {p1}, Ljava/io/BufferedReader;->close()V

    new-instance p1, Lorg/json/JSONObject;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p2, "url"

    invoke-virtual {p1, p2, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const-string v5, "url_tall"

    invoke-virtual {p1, v5, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_b5

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1
    :try_end_ad
    .catch Ljava/net/SocketTimeoutException; {:try_start_67 .. :try_end_ad} :catch_d3
    .catchall {:try_start_67 .. :try_end_ad} :catchall_d1

    if-lez p1, :cond_b5

    if-eqz v3, :cond_b4

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_b4
    return-object p2

    :cond_b5
    :try_start_b5
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "none found | "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_cb
    .catch Ljava/net/SocketTimeoutException; {:try_start_b5 .. :try_end_cb} :catch_d3
    .catchall {:try_start_b5 .. :try_end_cb} :catchall_d1

    if-eqz v3, :cond_d0

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_d0
    return-object v4

    :catchall_d1
    move-exception p1

    goto :goto_d7

    :catch_d3
    move-exception p1

    goto :goto_fd

    :catchall_d5
    move-exception p1

    move-object v3, v4

    :goto_d7
    :try_start_d7
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "request error | "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v2, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_f5
    .catchall {:try_start_d7 .. :try_end_f5} :catchall_119

    if-eqz v3, :cond_fa

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_fa
    return-object v4

    :catch_fb
    move-exception p1

    move-object v3, v4

    :goto_fd
    :try_start_fd
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "request timed out | "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v2, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_113
    .catchall {:try_start_fd .. :try_end_113} :catchall_119

    if-eqz v3, :cond_118

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_118
    return-object v4

    :catchall_119
    move-exception p0

    if-eqz v3, :cond_11f

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_11f
    throw p0
.end method

.method static urlFor(I)Ljava/lang/String;
    .registers 3

    sget-object v0, Lradiant/AnimatedCovers;->urlState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_19

    sget-object v1, Lradiant/AnimatedCovers;->albumState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    if-ne v1, p0, :cond_19

    goto :goto_1a

    :cond_19
    const/4 v0, 0x0

    :goto_1a
    return-object v0
.end method


# virtual methods
.method public invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 14

    sget-object p2, Landroidx/compose/ui/Modifier;->Companion:Landroidx/compose/ui/Modifier$Companion;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p2, v0}, Landroidx/compose/foundation/layout/SizeKt;->fillMaxSize(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;

    move-result-object v3

    iget-object v1, p0, Lradiant/AnimatedCovers;->request:Lyl0/l;

    iget-object v2, p0, Lradiant/AnimatedCovers;->description:Ljava/lang/String;

    iget-object v4, p0, Lradiant/AnimatedCovers;->colorFilter:Landroidx/compose/ui/graphics/ColorFilter;

    iget-object v5, p0, Lradiant/AnimatedCovers;->contentScale:Landroidx/compose/ui/layout/ContentScale;

    iget-object v6, p0, Lradiant/AnimatedCovers;->placeholder:Ljava/lang/Object;

    iget-object v7, p0, Lradiant/AnimatedCovers;->onError:Lyl0/a;

    move-object v8, p1

    check-cast v8, Landroidx/compose/runtime/Composer;

    const/4 v9, 0x0

    iget v10, p0, Lradiant/AnimatedCovers;->defaults:I

    invoke-static/range {v1 .. v10}, Lsd0/f;->a(Lyl0/l;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/ui/layout/ContentScale;Ljava/lang/Object;Lyl0/a;Landroidx/compose/runtime/Composer;II)V

    sget-object p1, Lkotlin/u;->a:Lkotlin/u;

    return-object p1
.end method

.method public run()V
    .registers 5

    const-string v0, "RLAnimatedCovers"

    :try_start_2
    iget v1, p0, Lradiant/AnimatedCovers;->mode:I

    packed-switch v1, :pswitch_data_7e

    goto/16 :goto_7c

    :pswitch_9
    iget-object v1, p0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    if-eqz v1, :cond_7c

    iget-object v1, p0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    sget-object v2, Lradiant/AnimatedCovers;->artworkUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7c

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "hiding video (src: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    sput-object v1, Lradiant/AnimatedCovers;->failedSrc:Ljava/lang/String;

    invoke-static {}, Lradiant/AnimatedCovers;->publish()V

    goto :goto_7c

    :pswitch_3d
    iget v1, p0, Lradiant/AnimatedCovers;->token:I

    sget v2, Lradiant/AnimatedCovers;->loadToken:I

    if-ne v1, v2, :cond_7c

    iget-object v1, p0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    iget-object v2, p0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    iget v3, p0, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {v1, v2, v3}, Lradiant/AnimatedCovers;->apply(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_7c

    :pswitch_4d
    invoke-direct {p0}, Lradiant/AnimatedCovers;->fetch()V

    goto :goto_7c

    :pswitch_51
    invoke-direct {p0}, Lradiant/AnimatedCovers;->setTrack()V

    goto :goto_7c

    :pswitch_55
    invoke-direct {p0}, Lradiant/AnimatedCovers;->resolve()V
    :try_end_58
    .catchall {:try_start_2 .. :try_end_58} :catchall_59

    goto :goto_7c

    :catchall_59
    move-exception v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "job "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lradiant/AnimatedCovers;->mode:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " failed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7c
    :goto_7c
    return-void

    nop

    :pswitch_data_7e
    .packed-switch 0x0
        :pswitch_55
        :pswitch_51
        :pswitch_4d
        :pswitch_3d
        :pswitch_9
    .end packed-switch
.end method
