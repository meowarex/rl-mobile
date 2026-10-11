.class public final Lradiant/AnimatedCovers;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;
.implements Lyl0/p;


# static fields
.field private static final CACHE_MAX:I = 0xc8

.field private static final MODE_LOOKUP:I = 0x0

.field private static final MODE_PLACEHOLDER:I = 0x2

.field private static final MODE_PUBLISH:I = 0x1

.field private static final SEARCH:Ljava/lang/String; = "https://ama.trainswift.net/api/v1/artwork/search?"

.field private static final TAG:Ljava/lang/String; = "RLAnimatedCovers"

.field private static final TARGET_PX:I = 0x2bc

.field static final albumState:Landroidx/compose/runtime/MutableState;

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

.field private static volatile currentKey:Ljava/lang/String;

.field private static volatile queue:Ljava/lang/Object;

.field static final urlState:Landroidx/compose/runtime/MutableState;


# instance fields
.field private album:Ljava/lang/String;

.field private albumId:I

.field private artist:Ljava/lang/String;

.field private colorFilter:Landroidx/compose/ui/graphics/ColorFilter;

.field private contentScale:Landroidx/compose/ui/layout/ContentScale;

.field private defaults:I

.field private description:Ljava/lang/String;

.field private key:Ljava/lang/String;

.field private final mode:I

.field private onError:Lyl0/a;

.field private placeholder:Ljava/lang/Object;

.field private request:Lyl0/l;

.field private title:Ljava/lang/String;

.field private url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 4

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

    const/high16 v1, 0x3f400000    # 0.75f

    const/4 v2, 0x1

    const/16 v3, 0x40

    invoke-direct {v0, v3, v1, v2}, Ljava/util/LinkedHashMap;-><init>(IFZ)V

    sput-object v0, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    return-void
.end method

.method private constructor <init>(I)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/AnimatedCovers;->mode:I

    return-void
.end method

.method public static cover(Lyl0/l;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/ui/layout/ContentScale;Ljava/lang/Object;Lyl0/a;Landroidx/compose/runtime/Composer;III)V
    .registers 13

    sget-object v0, Lradiant/AnimatedCovers;->urlState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sget-object v1, Lradiant/AnimatedCovers;->albumState:Landroidx/compose/runtime/MutableState;

    invoke-interface {v1}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    if-eqz v0, :cond_37

    if-ne v1, p10, :cond_37

    const p8, 0x52414143

    invoke-interface {p7, p8}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    new-instance p8, Lradiant/AnimatedCovers;

    const/4 p10, 0x2

    invoke-direct {p8, p10}, Lradiant/AnimatedCovers;-><init>(I)V

    iput-object p0, p8, Lradiant/AnimatedCovers;->request:Lyl0/l;

    iput-object p1, p8, Lradiant/AnimatedCovers;->description:Ljava/lang/String;

    iput-object p3, p8, Lradiant/AnimatedCovers;->colorFilter:Landroidx/compose/ui/graphics/ColorFilter;

    iput-object p4, p8, Lradiant/AnimatedCovers;->contentScale:Landroidx/compose/ui/layout/ContentScale;

    iput-object p5, p8, Lradiant/AnimatedCovers;->placeholder:Ljava/lang/Object;

    iput-object p6, p8, Lradiant/AnimatedCovers;->onError:Lyl0/a;

    iput p9, p8, Lradiant/AnimatedCovers;->defaults:I

    const/4 p0, 0x0

    invoke-static {v0, p2, p8, p7, p0}, Lcom/tidal/android/core/compose/components/l;->a(Ljava/lang/String;Landroidx/compose/ui/Modifier;Lyl0/p;Landroidx/compose/runtime/Composer;I)V

    goto :goto_40

    :cond_37
    const p10, 0x52414144

    invoke-interface {p7, p10}, Landroidx/compose/runtime/Composer;->startReplaceGroup(I)V

    invoke-static/range {p0 .. p9}, Lsd0/f;->a(Lyl0/l;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/ui/layout/ContentScale;Ljava/lang/Object;Lyl0/a;Landroidx/compose/runtime/Composer;II)V

    :goto_40
    invoke-interface {p7}, Landroidx/compose/runtime/Composer;->endReplaceGroup()V

    return-void
.end method

.method private static currentAlbum(Ljava/lang/String;)Ljava/lang/String;
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

    if-eqz v1, :cond_3f

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getTitle()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_3f

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object p0

    if-nez p0, :cond_26

    goto :goto_3f

    :cond_26
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aspiro/wamp/model/Album;->getTitle()Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_3f

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_3b

    goto :goto_3f

    :cond_3b
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0
    :try_end_3f
    .catchall {:try_start_1 .. :try_end_3f} :catchall_40

    :cond_3f
    :goto_3f
    return-object v0

    :catchall_40
    move-exception p0

    return-object v0
.end method

.method private static enc(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const-string v0, "UTF-8"

    invoke-static {p0, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "+"

    const-string v1, "%20"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static get(Ljava/lang/String;)Ljava/lang/String;
    .registers 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object p0

    check-cast p0, Ljava/net/HttpURLConnection;

    const/16 v0, 0x2710

    invoke-virtual {p0, v0}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {p0, v0}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    :try_start_13
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0
    :try_end_17
    .catchall {:try_start_13 .. :try_end_17} :catchall_4f

    const/16 v1, 0xc8

    if-eq v0, v1, :cond_20

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->disconnect()V

    const/4 p0, 0x0

    return-object p0

    :cond_20
    :try_start_20
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    const-string v3, "UTF-8"

    invoke-direct {v1, v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v2, 0x1000

    new-array v2, v2, [C

    :goto_39
    invoke-virtual {v0, v2}, Ljava/io/BufferedReader;->read([C)I

    move-result v3

    if-lez v3, :cond_44

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v3}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    goto :goto_39

    :cond_44
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_4b
    .catchall {:try_start_20 .. :try_end_4b} :catchall_4f

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->disconnect()V

    return-object v0

    :catchall_4f
    move-exception v0

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->disconnect()V

    throw v0
.end method

.method private static lookup(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

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

    if-eqz p2, :cond_42

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "&album="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {p2}, Lradiant/AnimatedCovers;->enc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_42
    invoke-static {p0}, Lradiant/AnimatedCovers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const/4 p1, 0x0

    if-nez p0, :cond_4a

    return-object p1

    :cond_4a
    new-instance p2, Lorg/json/JSONObject;

    invoke-direct {p2, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "url"

    const-string v0, ""

    invoke-virtual {p2, p0, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_5e

    return-object p1

    :cond_5e
    invoke-static {p0}, Lradiant/AnimatedCovers;->resolveMp4(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static onMediaState(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .registers 7

    if-eqz p0, :cond_71

    if-eqz p1, :cond_71

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p3

    if-eqz p3, :cond_b

    goto :goto_71

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

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    sget-object v0, Lradiant/AnimatedCovers;->currentKey:Ljava/lang/String;

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2b

    return-void

    :cond_2b
    sput-object p3, Lradiant/AnimatedCovers;->currentKey:Ljava/lang/String;

    const/4 v0, 0x0

    invoke-static {p3, v0, p2}, Lradiant/AnimatedCovers;->publish(Ljava/lang/String;Ljava/lang/String;I)V

    sget-object v1, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    monitor-enter v1

    :try_start_34
    sget-object v2, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v2, p3}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    monitor-exit v1
    :try_end_3d
    .catchall {:try_start_34 .. :try_end_3d} :catchall_6e

    if-eqz v2, :cond_4b

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_46

    goto :goto_47

    :cond_46
    move-object v0, v2

    :goto_47
    invoke-static {p3, v0, p2}, Lradiant/AnimatedCovers;->publish(Ljava/lang/String;Ljava/lang/String;I)V

    return-void

    :cond_4b
    new-instance v0, Lradiant/AnimatedCovers;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lradiant/AnimatedCovers;-><init>(I)V

    iput-object p3, v0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    iput-object p0, v0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iput-object p1, v0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-static {p0}, Lradiant/AnimatedCovers;->currentAlbum(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    iput p2, v0, Lradiant/AnimatedCovers;->albumId:I

    new-instance p0, Ljava/lang/Thread;

    const-string p1, "RL-AnimatedCovers"

    invoke-direct {p0, v0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {p0}, Ljava/lang/Thread;->start()V

    return-void

    :catchall_6e
    move-exception p0

    :try_start_6f
    monitor-exit v1
    :try_end_70
    .catchall {:try_start_6f .. :try_end_70} :catchall_6e

    throw p0

    :cond_71
    :goto_71
    return-void
.end method

.method private static publish(Ljava/lang/String;Ljava/lang/String;I)V
    .registers 5

    new-instance v0, Lradiant/AnimatedCovers;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lradiant/AnimatedCovers;-><init>(I)V

    iput-object p0, v0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    iput-object p1, v0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    iput p2, v0, Lradiant/AnimatedCovers;->albumId:I

    new-instance p0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object p1

    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {p0, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private static resolveMp4(Ljava/lang/String;)Ljava/lang/String;
    .registers 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    invoke-static {p0}, Lradiant/AnimatedCovers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_8

    return-object v1

    :cond_8
    const-string v2, "\n"

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    const/4 v3, -0x1

    move-object v5, v1

    move v4, v2

    move v6, v4

    :goto_13
    array-length v7, v0

    const/4 v8, 0x1

    sub-int/2addr v7, v8

    if-ge v4, v7, :cond_9b

    aget-object v7, v0, v4

    invoke-virtual {v7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    const-string v9, "#EXT-X-STREAM-INF:"

    invoke-virtual {v7, v9}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_97

    const-string v9, "avc1"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-gez v9, :cond_30

    goto/16 :goto_97

    :cond_30
    const-string v9, "VIDEO-RANGE=SDR"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-gez v9, :cond_41

    const-string v9, "VIDEO-RANGE"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-ltz v9, :cond_41

    goto :goto_97

    :cond_41
    const-string v9, "RESOLUTION="

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-ltz v9, :cond_5b

    const/16 v10, 0x78

    invoke-virtual {v7, v10, v9}, Ljava/lang/String;->indexOf(II)I

    move-result v10

    add-int/lit8 v9, v9, 0xb

    :try_start_51
    invoke-virtual {v7, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7
    :try_end_59
    .catchall {:try_start_51 .. :try_end_59} :catchall_5a

    goto :goto_5c

    :catchall_5a
    move-exception v7

    :cond_5b
    move v7, v2

    :goto_5c
    add-int/lit8 v9, v4, 0x1

    aget-object v9, v0, v9

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_97

    const-string v10, "#"

    invoke-virtual {v9, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_73

    goto :goto_97

    :cond_73
    const/16 v10, 0x2bc

    if-lt v7, v10, :cond_78

    goto :goto_79

    :cond_78
    move v8, v2

    :goto_79
    if-eqz v5, :cond_87

    if-eqz v8, :cond_81

    if-eqz v6, :cond_87

    if-lt v7, v3, :cond_87

    :cond_81
    if-nez v8, :cond_97

    if-nez v6, :cond_97

    if-le v7, v3, :cond_97

    :cond_87
    new-instance v3, Ljava/net/URL;

    new-instance v5, Ljava/net/URL;

    invoke-direct {v5, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-direct {v3, v5, v9}, Ljava/net/URL;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v5

    move v3, v7

    move v6, v8

    :cond_97
    :goto_97
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_13

    :cond_9b
    if-nez v5, :cond_9e

    return-object v1

    :cond_9e
    invoke-static {v5}, Lradiant/AnimatedCovers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-nez p0, :cond_a5

    return-object v1

    :cond_a5
    const-string v0, "#EXT-X-MAP:URI=\""

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    if-gez v0, :cond_ae

    return-object v1

    :cond_ae
    add-int/lit8 v0, v0, 0x10

    const/16 v2, 0x22

    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    if-gez v2, :cond_b9

    return-object v1

    :cond_b9
    new-instance v1, Ljava/net/URL;

    new-instance v3, Ljava/net/URL;

    invoke-direct {v3, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v1, v3, p0}, Ljava/net/URL;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static setQueue(Ljava/lang/Object;)V
    .registers 1

    sput-object p0, Lradiant/AnimatedCovers;->queue:Ljava/lang/Object;

    return-void
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
    .registers 7

    iget v0, p0, Lradiant/AnimatedCovers;->mode:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_26

    iget-object v0, p0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    sget-object v1, Lradiant/AnimatedCovers;->currentKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_10

    return-void

    :cond_10
    sget-object v0, Lradiant/AnimatedCovers;->urlState:Landroidx/compose/runtime/MutableState;

    iget-object v1, p0, Lradiant/AnimatedCovers;->url:Ljava/lang/String;

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    sget-object v0, Lradiant/AnimatedCovers;->albumState:Landroidx/compose/runtime/MutableState;

    iget v1, p0, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    invoke-static {}, Lradiant/AnimatedCoverView;->refreshAll()V

    return-void

    :cond_26
    const/4 v0, 0x0

    :try_start_27
    iget-object v1, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    if-nez v1, :cond_38

    const-wide/16 v1, 0x320

    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V

    iget-object v1, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-static {v1}, Lradiant/AnimatedCovers;->currentAlbum(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    :cond_38
    iget-object v1, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    if-eqz v1, :cond_47

    iget-object v1, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iget-object v2, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    iget-object v3, p0, Lradiant/AnimatedCovers;->album:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lradiant/AnimatedCovers;->lookup(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_46
    .catchall {:try_start_27 .. :try_end_46} :catchall_58

    goto :goto_48

    :cond_47
    move-object v1, v0

    :goto_48
    if-nez v1, :cond_7e

    :try_start_4a
    iget-object v2, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    iget-object v3, p0, Lradiant/AnimatedCovers;->artist:Ljava/lang/String;

    invoke-static {v2, v3, v0}, Lradiant/AnimatedCovers;->lookup(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_52
    .catchall {:try_start_4a .. :try_end_52} :catchall_53

    goto :goto_7e

    :catchall_53
    move-exception v0

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_59

    :catchall_58
    move-exception v1

    :goto_59
    const-string v2, "RLAnimatedCovers"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "lookup failed for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ": "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    :cond_7e
    :goto_7e
    sget-object v0, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    monitor-enter v0

    :try_start_81
    sget-object v2, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->size()I

    move-result v2

    const/16 v3, 0xc8

    if-lt v2, v3, :cond_a0

    sget-object v2, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    sget-object v3, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    invoke-virtual {v3, v2}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_a0
    sget-object v2, Lradiant/AnimatedCovers;->cache:Ljava/util/LinkedHashMap;

    iget-object v3, p0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    if-nez v1, :cond_a9

    const-string v4, ""

    goto :goto_aa

    :cond_a9
    move-object v4, v1

    :goto_aa
    invoke-virtual {v2, v3, v4}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v0
    :try_end_ae
    .catchall {:try_start_81 .. :try_end_ae} :catchall_d5

    const-string v0, "RLAnimatedCovers"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    if-nez v1, :cond_ba

    const-string v3, "no animated cover for "

    goto :goto_bc

    :cond_ba
    const-string v3, "animated cover for "

    :goto_bc
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lradiant/AnimatedCovers;->title:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lradiant/AnimatedCovers;->key:Ljava/lang/String;

    iget v2, p0, Lradiant/AnimatedCovers;->albumId:I

    invoke-static {v0, v1, v2}, Lradiant/AnimatedCovers;->publish(Ljava/lang/String;Ljava/lang/String;I)V

    return-void

    :catchall_d5
    move-exception v1

    :try_start_d6
    monitor-exit v0
    :try_end_d7
    .catchall {:try_start_d6 .. :try_end_d7} :catchall_d5

    throw v1
.end method
