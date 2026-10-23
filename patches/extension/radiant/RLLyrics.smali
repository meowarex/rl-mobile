.class public final Lradiant/RLLyrics;
.super Ljava/lang/Object;


# static fields
.field private static final API:Ljava/lang/String; = "https://api.radiant-lyrics.org/"

.field private static final LYRICS_SETTLE_MS:J = 0x5dcL

.field private static final SKIP_WINDOW_MS:J = 0x1388L

.field private static final SYLLA_SETTLE_MS:J = 0x1388L

.field static volatile aiType:Ljava/lang/String;

.field private static volatile autoSyllaJob:Ljava/lang/Object;

.field static volatile autoSyllaRunning:Z

.field private static volatile autoSyllaTrack:Ljava/lang/String;

.field static volatile body:Ljava/lang/String;

.field static volatile bodyIsLine:Z

.field static volatile busy:Z

.field private static lastState:Ljava/lang/Object;

.field private static lastStateKey:Ljava/lang/String;

.field private static main:Landroid/os/Handler;

.field private static final rawBody:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field static volatile retimeTrack:Ljava/lang/String;

.field private static volatile skipping:Z

.field static volatile syllaEpoch:I

.field private static final syllaRefused:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field static volatile track:Lcom/aspiro/wamp/model/Track;

.field static volatile trackKey:Ljava/lang/String;

.field private static volatile trackStartedAt:J

.field private static volatile trans:[Ljava/lang/String;

.field private static volatile twDur:[[J

.field private static volatile twStart:[[J

.field private static volatile twText:[[Ljava/lang/String;

.field static final version:Landroidx/compose/runtime/MutableState;

.field private static volatile versionPending:I

.field private static final vms:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Ljava/lang/Object;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .registers 3

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-static {v0, v1, v2, v1}, Landroidx/compose/runtime/SnapshotStateKt;->mutableStateOf$default(Ljava/lang/Object;Landroidx/compose/runtime/SnapshotMutationPolicy;ILjava/lang/Object;)Landroidx/compose/runtime/MutableState;

    move-result-object v0

    sput-object v0, Lradiant/RLLyrics;->version:Landroidx/compose/runtime/MutableState;

    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lradiant/RLLyrics;->syllaRefused:Ljava/lang/ThreadLocal;

    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lradiant/RLLyrics;->rawBody:Ljava/lang/ThreadLocal;

    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lradiant/RLLyrics;->vms:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static align(Lradiant/RLAPILyricsWorker;Ljava/lang/String;)Ljava/lang/Object;
    .registers 7

    const-string v0, "metadata"

    const-string v1, "data"

    const-string v2, "type"

    :try_start_6
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {p1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v3, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-static {p0}, Lradiant/RLLyrics;->trackJson(Lradiant/RLAPILyricsWorker;)Lorg/json/JSONObject;

    move-result-object p0

    const-string v0, "lyrics"

    invoke-virtual {p0, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "sylla-align"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Lradiant/RLLyrics;->syllaQs()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Sylla Align"

    invoke-static {p1, v0, p0}, Lradiant/RLLyrics;->postSylla(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Ljava/lang/Object;

    move-result-object p0
    :try_end_4b
    .catchall {:try_start_6 .. :try_end_4b} :catchall_4c

    return-object p0

    :catchall_4c
    move-exception p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static autoSylla(Lradiant/RLAPILyricsWorker;Ljava/lang/String;Ljava/lang/String;)Z
    .registers 11

    const/4 v0, 0x0

    if-eqz p0, :cond_41

    invoke-static {}, Lradiant/RLSettings;->radiantAI()Z

    move-result v1

    if-nez v1, :cond_a

    goto :goto_41

    :cond_a
    iget-object v1, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sget-object v2, Lradiant/RLLyrics;->trackKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_15

    return v0

    :cond_15
    iget-object v0, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sget-object v1, Lradiant/RLLyrics;->autoSyllaTrack:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_22

    sget-boolean p0, Lradiant/RLLyrics;->autoSyllaRunning:Z

    return p0

    :cond_22
    iget-object v0, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sput-object v0, Lradiant/RLLyrics;->autoSyllaTrack:Ljava/lang/String;

    const/4 v0, 0x1

    sput-boolean v0, Lradiant/RLLyrics;->autoSyllaRunning:Z

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    sput-object v1, Lradiant/RLLyrics;->autoSyllaJob:Ljava/lang/Object;

    invoke-static {v1, v0, v0}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    new-instance v2, Lradiant/RLTask;

    const/4 v3, 0x0

    sget v7, Lradiant/RLLyrics;->syllaEpoch:I

    move-object v4, p0

    move-object v5, p1

    move-object v6, p2

    invoke-direct/range {v2 .. v7}, Lradiant/RLTask;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-static {v2}, Lradiant/RLLyrics;->background(Ljava/lang/Runnable;)V

    :cond_41
    :goto_41
    return v0
.end method

.method private static background(Ljava/lang/Runnable;)V
    .registers 2

    new-instance v0, Ljava/lang/Thread;

    invoke-direct {v0, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public static broadcast(Lradiant/RLAPILyricsWorker;Ljava/lang/Object;)V
    .registers 8

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const-class v1, Lradiant/RLLyrics;

    monitor-enter v1

    :try_start_8
    sput-object p1, Lradiant/RLLyrics;->lastState:Ljava/lang/Object;

    iget-object v2, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sput-object v2, Lradiant/RLLyrics;->lastStateKey:Ljava/lang/String;

    sget-object v2, Lradiant/RLLyrics;->vms:Ljava/util/WeakHashMap;

    invoke-virtual {v2}, Ljava/util/WeakHashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_18
    :goto_18
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_40

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    iget-object v5, p0, Lradiant/RLAPILyricsWorker;->vm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    if-eq v4, v5, :cond_18

    iget-object v4, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_18

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_18

    :cond_40
    monitor-exit v1
    :try_end_41
    .catchall {:try_start_8 .. :try_end_41} :catchall_94

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_45
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6d

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    :try_start_4f
    check-cast v1, Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    invoke-static {v1, p1}, Lradiant/RLAPILyricsWorker;->pushTo(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;Ljava/lang/Object;)V
    :try_end_54
    .catchall {:try_start_4f .. :try_end_54} :catchall_55

    goto :goto_45

    :catchall_55
    move-exception v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "broadcast failed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    goto :goto_45

    :cond_6d
    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result p0

    if-nez p0, :cond_93

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "lyrics shared with "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " more player instance(s)"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    :cond_93
    return-void

    :catchall_94
    move-exception p0

    :try_start_95
    monitor-exit v1
    :try_end_96
    .catchall {:try_start_95 .. :try_end_96} :catchall_94

    throw p0
.end method

.method static bump()V
    .registers 7

    sget v0, Lradiant/RLLyrics;->versionPending:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lradiant/RLLyrics;->versionPending:I

    new-instance v1, Lradiant/RLTask;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x4

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct/range {v1 .. v6}, Lradiant/RLTask;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-static {v1}, Lradiant/RLLyrics;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method static bumpNow()V
    .registers 2

    sget-object v0, Lradiant/RLLyrics;->version:Landroidx/compose/runtime/MutableState;

    sget v1, Lradiant/RLLyrics;->versionPending:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Landroidx/compose/runtime/MutableState;->setValue(Ljava/lang/Object;)V

    return-void
.end method

.method static cancelAutoSylla()V
    .registers 3

    sget-boolean v0, Lradiant/RLLyrics;->autoSyllaRunning:Z

    if-nez v0, :cond_5

    return-void

    :cond_5
    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    sput v0, Lradiant/RLLyrics;->syllaEpoch:I

    const/4 v0, 0x0

    sput-boolean v0, Lradiant/RLLyrics;->autoSyllaRunning:Z

    const/4 v2, 0x0

    sput-object v2, Lradiant/RLLyrics;->autoSyllaTrack:Ljava/lang/String;

    sput-boolean v0, Lradiant/RLLyrics;->busy:Z

    sget-object v2, Lradiant/RLLyrics;->autoSyllaJob:Ljava/lang/Object;

    invoke-static {v2, v1, v0}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    return-void
.end method

.method public static catchUp(Ljava/lang/Object;Ljava/lang/String;)V
    .registers 4

    const-class v0, Lradiant/RLLyrics;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/RLLyrics;->lastStateKey:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_e

    sget-object p1, Lradiant/RLLyrics;->lastState:Ljava/lang/Object;

    goto :goto_f

    :cond_e
    const/4 p1, 0x0

    :goto_f
    monitor-exit v0
    :try_end_10
    .catchall {:try_start_3 .. :try_end_10} :catchall_35

    if-eqz p1, :cond_34

    sget-boolean v0, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-nez v0, :cond_17

    goto :goto_34

    :cond_17
    :try_start_17
    check-cast p0, Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    invoke-static {p0, p1}, Lradiant/RLAPILyricsWorker;->pushTo(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;Ljava/lang/Object;)V
    :try_end_1c
    .catchall {:try_start_17 .. :try_end_1c} :catchall_1d

    goto :goto_34

    :catchall_1d
    move-exception p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "catchUp failed: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    :cond_34
    :goto_34
    return-void

    :catchall_35
    move-exception p0

    :try_start_36
    monitor-exit v0
    :try_end_37
    .catchall {:try_start_36 .. :try_end_37} :catchall_35

    throw p0
.end method

.method public static declared-synchronized claimTrack(Ljava/lang/String;)Z
    .registers 3

    const-class v0, Lradiant/RLLyrics;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_9
    .catchall {:try_start_3 .. :try_end_9} :catchall_13

    if-eqz v1, :cond_e

    monitor-exit v0

    const/4 p0, 0x0

    return p0

    :cond_e
    :try_start_e
    sput-object p0, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;
    :try_end_10
    .catchall {:try_start_e .. :try_end_10} :catchall_13

    monitor-exit v0

    const/4 p0, 0x1

    return p0

    :catchall_13
    move-exception p0

    :try_start_14
    monitor-exit v0
    :try_end_15
    .catchall {:try_start_14 .. :try_end_15} :catchall_13

    throw p0
.end method

.method static currentWorker()Lradiant/RLAPILyricsWorker;
    .registers 2

    sget-object v0, Lradiant/RLAPILyricsWorker;->last:Lradiant/RLAPILyricsWorker;

    if-eqz v0, :cond_c

    invoke-virtual {v0}, Lradiant/RLAPILyricsWorker;->isLive()Z

    move-result v1

    if-nez v1, :cond_b

    goto :goto_c

    :cond_b
    return-object v0

    :cond_c
    :goto_c
    const/4 v0, 0x0

    return-object v0
.end method

.method private static endsSpace(Ljava/lang/String;)Z
    .registers 3

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_17

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result p0

    invoke-static {p0}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result p0

    if-eqz p0, :cond_17

    goto :goto_18

    :cond_17
    const/4 v1, 0x0

    :goto_18
    return v1
.end method

.method static flush()V
    .registers 7

    sget-boolean v0, Lradiant/RLLyrics;->busy:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    const/4 v0, 0x1

    sput-boolean v0, Lradiant/RLLyrics;->busy:Z

    new-instance v1, Lradiant/RLTask;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct/range {v1 .. v6}, Lradiant/RLTask;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-static {v1}, Lradiant/RLLyrics;->background(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static gen(Lradiant/RLAPILyricsWorker;)Ljava/lang/Object;
    .registers 3

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sylla-gen"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lradiant/RLLyrics;->syllaQs()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Sylla Gen"

    invoke-static {p0}, Lradiant/RLLyrics;->trackJson(Lradiant/RLAPILyricsWorker;)Lorg/json/JSONObject;

    move-result-object p0

    invoke-static {v0, v1, p0}, Lradiant/RLLyrics;->postSylla(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Ljava/lang/Object;

    move-result-object p0
    :try_end_21
    .catchall {:try_start_0 .. :try_end_21} :catchall_22

    return-object p0

    :catchall_22
    move-exception p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static hasSpace(Ljava/lang/String;)Z
    .registers 4

    const/4 v0, 0x0

    move v1, v0

    :goto_2
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_17

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v2

    if-eqz v2, :cond_14

    const/4 p0, 0x1

    return p0

    :cond_14
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_17
    return v0
.end method

.method private static isUntimed(Ljava/lang/String;)Z
    .registers 5

    const/4 v0, 0x0

    if-nez p0, :cond_4

    return v0

    :cond_4
    :try_start_4
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "data"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    const-string v2, "None"

    const-string v3, "type"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_26

    if-eqz p0, :cond_26

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result p0
    :try_end_23
    .catchall {:try_start_4 .. :try_end_23} :catchall_27

    if-lez p0, :cond_26

    const/4 v0, 0x1

    :cond_26
    return v0

    :catchall_27
    move-exception p0

    return v0
.end method

.method private static isrc(Lradiant/RLAPILyricsWorker;)Ljava/lang/String;
    .registers 1

    iget-object p0, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    invoke-static {p0}, Lradiant/IsrcCache;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-nez p0, :cond_b

    const-string p0, ""

    goto :goto_f

    :cond_b
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    :goto_f
    return-object p0
.end method

.method private static lettersOnly(Ljava/lang/String;)Ljava/lang/String;
    .registers 5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    const/4 v1, 0x0

    :goto_e
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_27

    invoke-virtual {p0, v1}, Ljava/lang/String;->codePointAt(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isLetterOrDigit(I)Z

    move-result v3

    if-eqz v3, :cond_21

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    :cond_21
    invoke-static {v2}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    add-int/2addr v1, v2

    goto :goto_e

    :cond_27
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static lightWords(Landroidx/compose/ui/text/AnnotatedString$Builder;Ljava/lang/String;IIII[I[I[J[JJJ)V
    .registers 36

    move-object/from16 v0, p0

    move/from16 v1, p3

    move/from16 v2, p4

    move/from16 v3, p5

    move-object/from16 v4, p8

    move-wide/from16 v5, p10

    move-wide/from16 v7, p12

    const/4 v9, 0x2

    if-ne v1, v9, :cond_1f

    invoke-static/range {p2 .. p2}, Lradiant/WordLyrics;->isPastLine(I)Z

    move-result v9

    if-eqz v9, :cond_1f

    invoke-static {v5, v6}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v1

    invoke-virtual {v0, v1, v2, v3}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    return-void

    :cond_1f
    invoke-static/range {p2 .. p2}, Lradiant/WordLyrics;->isActiveLine(I)Z

    move-result v9

    if-nez v9, :cond_26

    return-void

    :cond_26
    invoke-static {}, Lradiant/WordLyrics;->state()Landroidx/compose/runtime/MutableState;

    move-result-object v9

    invoke-interface {v9}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Lradiant/WordLyrics;->computeNow()J

    move-result-wide v14

    const/4 v9, 0x0

    :goto_32
    array-length v10, v4

    if-ge v9, v10, :cond_f4

    aget v10, p6, v9

    add-int/2addr v10, v2

    aget v11, p7, v9

    add-int/2addr v11, v2

    if-gt v11, v10, :cond_45

    move-object/from16 v1, p1

    move/from16 v10, p2

    move/from16 v16, v9

    goto/16 :goto_ee

    :cond_45
    aget-wide v12, v4, v9

    move/from16 v16, v9

    move/from16 v17, v10

    const-wide/16 v9, 0x1

    move/from16 v18, v11

    move-wide/from16 v19, v12

    aget-wide v11, p9, v16

    invoke-static {v9, v10, v11, v12}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v9

    add-long v12, v19, v9

    const/4 v9, 0x1

    if-ne v1, v9, :cond_7c

    move/from16 v9, v17

    move/from16 v1, v18

    move-wide/from16 v10, v19

    invoke-static/range {v10 .. v15}, Lradiant/WordLyrics;->bump(JJJ)F

    move-result v10

    const v11, 0x3c23d70a    # 0.01f

    cmpl-float v11, v10, v11

    if-lez v11, :cond_76

    invoke-static {v7, v8, v5, v6, v10}, Landroidx/compose/ui/graphics/ColorKt;->lerp-jxsXWHM(JJF)J

    move-result-wide v10

    invoke-static {v10, v11}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v10

    goto :goto_8a

    :cond_76
    :goto_76
    move-object/from16 v1, p1

    move/from16 v10, p2

    goto/16 :goto_ee

    :cond_7c
    move/from16 v21, v9

    move/from16 v9, v17

    move/from16 v1, v18

    cmp-long v10, v14, v12

    if-ltz v10, :cond_8e

    invoke-static {v5, v6}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v10

    :goto_8a
    invoke-virtual {v0, v10, v9, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    goto :goto_76

    :cond_8e
    cmp-long v10, v14, v19

    if-ltz v10, :cond_76

    sub-long v10, v14, v19

    long-to-float v10, v10

    sub-long v12, v12, v19

    long-to-float v11, v12

    div-float/2addr v10, v11

    sub-int v11, v1, v9

    int-to-float v12, v11

    mul-float/2addr v10, v12

    float-to-int v12, v10

    add-int/lit8 v11, v11, -0x1

    invoke-static {v12, v11}, Ljava/lang/Math;->min(II)I

    move-result v11

    add-int/2addr v11, v9

    add-int/lit8 v12, v11, 0x1

    if-ge v12, v1, :cond_b8

    move-object/from16 v1, p1

    invoke-virtual {v1, v11}, Ljava/lang/String;->charAt(I)C

    move-result v13

    invoke-static {v13}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v13

    if-eqz v13, :cond_ba

    add-int/lit8 v12, v12, 0x1

    goto :goto_ba

    :cond_b8
    move-object/from16 v1, p1

    :cond_ba
    :goto_ba
    if-le v11, v9, :cond_c3

    invoke-static {v5, v6}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v13

    invoke-virtual {v0, v13, v9, v11}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :cond_c3
    sub-int v9, v11, v9

    int-to-float v9, v9

    sub-float/2addr v10, v9

    sub-int v9, v12, v11

    int-to-float v9, v9

    div-float/2addr v10, v9

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-static {v9, v10}, Ljava/lang/Math;->min(FF)F

    move-result v9

    const/4 v10, 0x0

    invoke-static {v10, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    move/from16 v10, p2

    invoke-static {v10, v11, v12, v9, v3}, Lradiant/WordLyrics;->sylWipe(IIIFI)Landroidx/compose/ui/graphics/Brush;

    move-result-object v13

    if-eqz v13, :cond_e3

    invoke-static {v13}, Lradiant/WordLyrics;->brushSpan(Landroidx/compose/ui/graphics/Brush;)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v9

    goto :goto_eb

    :cond_e3
    invoke-static {v7, v8, v5, v6, v9}, Landroidx/compose/ui/graphics/ColorKt;->lerp-jxsXWHM(JJF)J

    move-result-wide v17

    invoke-static/range {v17 .. v18}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v9

    :goto_eb
    invoke-virtual {v0, v9, v11, v12}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    :goto_ee
    add-int/lit8 v9, v16, 0x1

    move/from16 v1, p3

    goto/16 :goto_32

    :cond_f4
    return-void
.end method

.method private static loadSylla(Lradiant/RLAPILyricsWorker;Lorg/json/JSONObject;Ljava/lang/String;)V
    .registers 8

    :try_start_0
    const-string v0, "lyrics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "confidence"

    const-wide/16 v2, 0x0

    invoke-virtual {p1, v1, v2, v3}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v1

    const-string v3, "_synthesized"

    const/4 v4, 0x1

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v3, "_synthesisType"

    const-string v4, "generated"

    invoke-virtual {v4, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_21

    const-string v4, "Generate"

    goto :goto_23

    :cond_21
    const-string v4, "Align"

    :goto_23
    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v3, "_confidence"

    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    invoke-static {p1, v0}, Lradiant/RLLyrics;->respace(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    invoke-static {}, Lradiant/RLLyrics;->currentWorker()Lradiant/RLAPILyricsWorker;

    move-result-object p1

    if-eqz p1, :cond_3e

    iget-object v3, p1, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    iget-object v4, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_47

    :cond_3e
    invoke-virtual {p0}, Lradiant/RLAPILyricsWorker;->isLive()Z

    move-result p1

    if-eqz p1, :cond_45

    goto :goto_46

    :cond_45
    const/4 p0, 0x0

    :goto_46
    move-object p1, p0

    :cond_47
    if-nez p1, :cond_66

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "Sylla: track changed, dropped the "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " lyrics"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :cond_66
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLLyrics;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Lradiant/RLAPILyricsWorker;->publish(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_a2

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "Lyrics "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " with AI ("

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-wide/high16 p1, 0x4059000000000000L    # 100.0

    mul-double/2addr v1, p1

    invoke-static {v1, v2}, Ljava/lang/Math;->round(D)J

    move-result-wide p1

    invoke-virtual {p0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "% confidence)"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V

    goto :goto_ae

    :cond_a2
    const-string p0, "Sylla: lyrics could not be shown"

    invoke-static {p0}, Lradiant/RLLyrics;->toastErr(Ljava/lang/String;)V
    :try_end_a7
    .catchall {:try_start_0 .. :try_end_a7} :catchall_a8

    goto :goto_ae

    :catchall_a8
    move-exception p0

    const-string p0, "Sylla: bad response"

    invoke-static {p0}, Lradiant/RLLyrics;->toastErr(Ljava/lang/String;)V

    :goto_ae
    return-void
.end method

.method public static normalize(Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    sget-object v0, Lradiant/RLLyrics;->rawBody:Ljava/lang/ThreadLocal;

    invoke-virtual {v0, p0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    :try_start_5
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "Word"

    const-string v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_19

    return-object p0

    :cond_19
    const-string v1, "data"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    if-eqz v1, :cond_2c

    invoke-static {v1}, Lradiant/RLLyrics;->syncRomanized(Lorg/json/JSONArray;)Z

    move-result v1

    if-nez v1, :cond_28

    goto :goto_2c

    :cond_28
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_2c
    .catchall {:try_start_5 .. :try_end_2c} :catchall_2d

    :cond_2c
    :goto_2c
    return-object p0

    :catchall_2d
    move-exception v0

    return-object p0
.end method

.method public static onBody(Lradiant/RLAPILyricsWorker;Ljava/lang/String;)V
    .registers 9

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_0 .. :try_end_5} :catchall_db

    const-string v1, "type"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sput-object p1, Lradiant/RLLyrics;->body:Ljava/lang/String;

    const-string v3, "Line"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    sput-boolean v1, Lradiant/RLLyrics;->bodyIsLine:Z

    const-string v1, "_synthesized"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_27

    const-string v1, "_synthesisType"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_28

    :cond_27
    move-object v1, v2

    :goto_28
    const-string v4, "Align"

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3a

    const-string v4, "Generate"

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_39

    goto :goto_3a

    :cond_39
    const/4 v1, 0x0

    :cond_3a
    :goto_3a
    sput-object v1, Lradiant/RLLyrics;->aiType:Ljava/lang/String;

    sget-object v1, Lradiant/RLLyrics;->aiType:Ljava/lang/String;

    const/4 v4, 0x1

    if-eqz v1, :cond_48

    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v1

    if-eqz v1, :cond_48

    move v3, v4

    :cond_48
    invoke-static {v3}, Lradiant/AiSparkle;->set(Z)V

    sget-object v1, Lradiant/RLLyrics;->aiType:Ljava/lang/String;

    if-eqz v1, :cond_95

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Sylla "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v3, Lradiant/RLLyrics;->aiType:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " lyrics ("

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_model"

    const-string v5, "?"

    invoke-virtual {v0, v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v6, "_modelVersion"

    invoke-virtual {v0, v6, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ", conf "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_confidence"

    invoke-virtual {v0, v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ")"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    :cond_95
    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v1

    if-eqz v1, :cond_c5

    const-string v1, "_translated"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c5

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_c5

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RL API: translation failed | "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_translationError"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    :cond_c5
    const-string v1, "data"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    invoke-static {v0}, Lradiant/RLLyrics;->readTranslations(Lorg/json/JSONArray;)V

    invoke-static {}, Lradiant/RLLyrics;->bump()V

    sget-boolean v0, Lradiant/RLLyrics;->bodyIsLine:Z

    if-eqz v0, :cond_da

    const-string v0, "align"

    invoke-static {p0, v0, p1}, Lradiant/RLLyrics;->autoSylla(Lradiant/RLAPILyricsWorker;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_da
    return-void

    :catchall_db
    move-exception p0

    return-void
.end method

.method public static onNoLyrics(Lradiant/RLAPILyricsWorker;)Z
    .registers 3

    sget-object v0, Lradiant/RLLyrics;->rawBody:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sget-object v1, Lradiant/RLLyrics;->rawBody:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->remove()V

    invoke-static {p0}, Lradiant/RLLyrics;->republish(Lradiant/RLAPILyricsWorker;)Z

    move-result v1

    if-eqz v1, :cond_15

    const/4 p0, 0x1

    return p0

    :cond_15
    invoke-static {v0}, Lradiant/RLLyrics;->isUntimed(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_21

    const-string v1, "untimed"

    invoke-static {p0, v1, v0}, Lradiant/RLLyrics;->autoSylla(Lradiant/RLAPILyricsWorker;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_27

    :cond_21
    const-string v0, "gen"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lradiant/RLLyrics;->autoSylla(Lradiant/RLAPILyricsWorker;Ljava/lang/String;Ljava/lang/String;)Z

    :goto_27
    const/4 p0, 0x0

    return p0
.end method

.method static onRadiantAIChanged()V
    .registers 1

    invoke-static {}, Lradiant/RLLyrics;->cancelAutoSylla()V

    const/4 v0, 0x0

    sput-object v0, Lradiant/RLLyrics;->autoSyllaTrack:Ljava/lang/String;

    invoke-static {}, Lradiant/RLLyrics;->refetch()V

    return-void
.end method

.method static onSyncChanged()V
    .registers 0

    invoke-static {}, Lradiant/RLLyrics;->bump()V

    return-void
.end method

.method static onTextModeChanged()V
    .registers 0

    invoke-static {}, Lradiant/RLLyrics;->refetch()V

    return-void
.end method

.method public static onTrack(Lcom/aspiro/wamp/model/Track;Ljava/lang/String;)V
    .registers 7

    const/4 v0, 0x1

    sput-boolean v0, Lradiant/RLSettings;->rlActive:Z

    sput-object p0, Lradiant/RLLyrics;->track:Lcom/aspiro/wamp/model/Track;

    if-eqz p1, :cond_59

    sget-object p0, Lradiant/RLLyrics;->trackKey:Ljava/lang/String;

    invoke-virtual {p1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_10

    goto :goto_59

    :cond_10
    sput-object p1, Lradiant/RLLyrics;->trackKey:Ljava/lang/String;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide p0

    sget-wide v1, Lradiant/RLLyrics;->trackStartedAt:J

    sub-long v1, p0, v1

    const-wide/16 v3, 0x1388

    cmp-long v1, v1, v3

    const/4 v2, 0x0

    if-gez v1, :cond_23

    move v1, v0

    goto :goto_24

    :cond_23
    move v1, v2

    :goto_24
    sput-boolean v1, Lradiant/RLLyrics;->skipping:Z

    sput-wide p0, Lradiant/RLLyrics;->trackStartedAt:J

    const-class p0, Lradiant/RLLyrics;

    monitor-enter p0

    const/4 p1, 0x0

    :try_start_2c
    sput-object p1, Lradiant/RLLyrics;->lastState:Ljava/lang/Object;

    sput-object p1, Lradiant/RLLyrics;->lastStateKey:Ljava/lang/String;

    monitor-exit p0
    :try_end_31
    .catchall {:try_start_2c .. :try_end_31} :catchall_56

    sget p0, Lradiant/RLLyrics;->syllaEpoch:I

    add-int/2addr p0, v0

    sput p0, Lradiant/RLLyrics;->syllaEpoch:I

    sput-object p1, Lradiant/RLLyrics;->autoSyllaTrack:Ljava/lang/String;

    sput-boolean v2, Lradiant/RLLyrics;->autoSyllaRunning:Z

    sput-object p1, Lradiant/RLLyrics;->retimeTrack:Ljava/lang/String;

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    sput-object p1, Lradiant/RLLyrics;->body:Ljava/lang/String;

    sput-boolean v2, Lradiant/RLLyrics;->bodyIsLine:Z

    sput-object p1, Lradiant/RLLyrics;->aiType:Ljava/lang/String;

    sput-object p1, Lradiant/RLLyrics;->trans:[Ljava/lang/String;

    sput-object p1, Lradiant/RLLyrics;->twText:[[Ljava/lang/String;

    sput-object p1, Lradiant/RLLyrics;->twStart:[[J

    sput-object p1, Lradiant/RLLyrics;->twDur:[[J

    invoke-static {}, Lradiant/SparkleIcons;->resetWork()V

    invoke-static {v2}, Lradiant/AiSparkle;->set(Z)V

    invoke-static {}, Lradiant/RLLyrics;->bump()V

    return-void

    :catchall_56
    move-exception p1

    :try_start_57
    monitor-exit p0
    :try_end_58
    .catchall {:try_start_57 .. :try_end_58} :catchall_56

    throw p1

    :cond_59
    :goto_59
    return-void
.end method

.method public static declared-synchronized ownsVm(Ljava/lang/Object;)Z
    .registers 3

    const-class v0, Lradiant/RLLyrics;

    monitor-enter v0

    if-nez p0, :cond_7

    const/4 p0, 0x0

    goto :goto_f

    :cond_7
    :try_start_7
    sget-object v1, Lradiant/RLLyrics;->vms:Ljava/util/WeakHashMap;

    invoke-virtual {v1, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    :goto_f
    if-eqz p0, :cond_1b

    sget-object v1, Lradiant/RLAPILyricsHook;->currentKey:Ljava/lang/String;

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_17
    .catchall {:try_start_7 .. :try_end_17} :catchall_1e

    if-eqz p0, :cond_1b

    const/4 p0, 0x1

    goto :goto_1c

    :cond_1b
    const/4 p0, 0x0

    :goto_1c
    monitor-exit v0

    return p0

    :catchall_1e
    move-exception p0

    :try_start_1f
    monitor-exit v0
    :try_end_20
    .catchall {:try_start_1f .. :try_end_20} :catchall_1e

    throw p0
.end method

.method static post(Ljava/lang/Runnable;)V
    .registers 3

    sget-object v0, Lradiant/RLLyrics;->main:Landroid/os/Handler;

    if-nez v0, :cond_f

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lradiant/RLLyrics;->main:Landroid/os/Handler;

    :cond_f
    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private static postSylla(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Ljava/lang/Object;
    .registers 13

    sget-object v0, Lradiant/RLLyrics;->syllaRefused:Ljava/lang/ThreadLocal;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://api.radiant-lyrics.org/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    const v0, 0x2bf20

    const-string v1, "POST"

    invoke-static {v1, p0, p2, v0}, Lradiant/RLHttp;->request(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lradiant/RLHttp;

    move-result-object p0

    iget p2, p0, Lradiant/RLHttp;->status:I

    if-nez p2, :cond_4a

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, ": request "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object p2, p0, Lradiant/RLHttp;->error:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    iget-object p0, p0, Lradiant/RLHttp;->error:Ljava/lang/String;

    return-object p0

    :cond_4a
    const/4 p2, 0x0

    :try_start_4b
    new-instance v0, Lorg/json/JSONObject;

    iget-object v1, p0, Lradiant/RLHttp;->body:Ljava/lang/String;

    invoke-direct {v0, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_52
    .catchall {:try_start_4b .. :try_end_52} :catchall_53

    goto :goto_55

    :catchall_53
    move-exception v0

    move-object v0, p2

    :goto_55
    invoke-virtual {p0}, Lradiant/RLHttp;->ok()Z

    move-result v1

    const-string v2, "message"

    const-string v3, "confidence"

    const-string v4, "verdict"

    const-string v5, ""

    if-nez v1, :cond_1a0

    const/16 v1, 0x199

    const-string v6, ")"

    const-string v7, " ("

    if-eqz v0, :cond_11b

    const-string v8, "detail"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    instance-of v9, v9, Ljava/lang/String;

    if-eqz v9, :cond_7e

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_87

    :cond_7e
    instance-of v2, v8, Ljava/lang/String;

    if-eqz v2, :cond_86

    move-object v2, v8

    check-cast v2, Ljava/lang/String;

    goto :goto_87

    :cond_86
    move-object v2, v5

    :goto_87
    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    instance-of v9, v9, Ljava/lang/String;

    if-eqz v9, :cond_93

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    :cond_93
    iget v0, p0, Lradiant/RLHttp;->status:I

    if-ne v0, v1, :cond_11c

    instance-of v0, v8, Lorg/json/JSONObject;

    if-eqz v0, :cond_11c

    check-cast v8, Lorg/json/JSONObject;

    const-string v0, "error"

    invoke-virtual {v8, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v4, "already_aligned"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11c

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ": already aligned ("

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "job"

    invoke-virtual {v8, p1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ", conf "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v8, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "!Already timed by Sylla"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v8, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_112

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-wide/16 v0, 0x0

    invoke-virtual {v8, v3, v0, v1}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v0

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    mul-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "% confidence)"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :cond_112
    invoke-virtual {p0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_11b
    move-object v2, v5

    :cond_11c
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ": request failed "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, p0, Lradiant/RLHttp;->status:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    if-eqz p2, :cond_149

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_14a

    :cond_149
    move-object v0, v5

    :goto_14a
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_167

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " | "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :cond_167
    invoke-virtual {p1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    iget p1, p0, Lradiant/RLHttp;->status:I

    const/16 v0, 0x190

    if-lt p1, v0, :cond_18f

    iget p1, p0, Lradiant/RLHttp;->status:I

    const/16 v0, 0x1f4

    if-ge p1, v0, :cond_18f

    iget p1, p0, Lradiant/RLHttp;->status:I

    if-eq p1, v1, :cond_18f

    iget p1, p0, Lradiant/RLHttp;->status:I

    const/16 v0, 0x1ad

    if-eq p1, v0, :cond_18f

    sget-object p1, Lradiant/RLLyrics;->syllaRefused:Ljava/lang/ThreadLocal;

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    :cond_18f
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result p1

    if-lez p1, :cond_196

    return-object v2

    :cond_196
    if-eqz p2, :cond_199

    goto :goto_19f

    :cond_199
    iget p0, p0, Lradiant/RLHttp;->status:I

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p2

    :goto_19f
    return-object p2

    :cond_1a0
    const-string p0, "invalid response"

    if-nez v0, :cond_1a5

    return-object p0

    :cond_1a5
    const-string p2, "lyrics_do_not_match_audio"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1dc

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ": lyrics do not match the audio"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    sget-object p0, Lradiant/RLLyrics;->syllaRefused:Ljava/lang/ThreadLocal;

    sget-object p1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    invoke-virtual {v0, v2, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p1

    if-lez p1, :cond_1d9

    goto :goto_1db

    :cond_1d9
    const-string p0, "lyrics don\'t match this version of the song"

    :goto_1db
    return-object p0

    :cond_1dc
    const-string p2, "lyrics"

    invoke-virtual {v0, p2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p2

    if-eqz p2, :cond_238

    const-string v1, "type"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Word"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_238

    const-string v1, "data"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p2

    if-nez p2, :cond_1fb

    goto :goto_238

    :cond_1fb
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ": "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "model"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " verdict="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " conf="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-object v0

    :cond_238
    :goto_238
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, ": response had no usable lyrics"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    sget-object p1, Lradiant/RLLyrics;->syllaRefused:Ljava/lang/ThreadLocal;

    sget-object p2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p1, p2}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    return-object p0
.end method

.method public static queryExtras()Ljava/lang/String;
    .registers 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lradiant/RLSettings;->romanize()Z

    move-result v1

    if-eqz v1, :cond_10

    const-string v1, "&romanize=true"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_10
    const-string v1, "&ai-preference="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v1

    if-eqz v1, :cond_34

    const-string v1, "&translate=true&language="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lradiant/RLSettings;->language()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_34
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static readTranslations(Lorg/json/JSONArray;)V
    .registers 23

    move-object/from16 v0, p0

    const/4 v1, 0x0

    if-nez v0, :cond_e

    sput-object v1, Lradiant/RLLyrics;->trans:[Ljava/lang/String;

    sput-object v1, Lradiant/RLLyrics;->twText:[[Ljava/lang/String;

    sput-object v1, Lradiant/RLLyrics;->twStart:[[J

    sput-object v1, Lradiant/RLLyrics;->twDur:[[J

    return-void

    :cond_e
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v2

    new-array v3, v2, [Ljava/lang/String;

    new-array v4, v2, [[Ljava/lang/String;

    new-array v5, v2, [[J

    new-array v6, v2, [[J

    const/4 v8, 0x0

    const/4 v9, 0x0

    :goto_1c
    if-ge v8, v2, :cond_ff

    invoke-virtual {v0, v8}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v10

    if-nez v10, :cond_26

    goto/16 :goto_f2

    :cond_26
    const-string v11, "translation"

    const-string v12, ""

    invoke-virtual {v10, v11, v12}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v10, v11}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_f2

    invoke-virtual {v13}, Ljava/lang/String;->length()I

    move-result v11

    if-nez v11, :cond_3c

    goto/16 :goto_f2

    :cond_3c
    invoke-static {v13}, Lradiant/RLLyrics;->lettersOnly(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const-string v14, "text"

    invoke-virtual {v10, v14, v12}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15}, Lradiant/RLLyrics;->lettersOnly(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v11, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_52

    goto/16 :goto_f2

    :cond_52
    aput-object v13, v3, v8

    const-string v9, "translationSyllabus"

    invoke-virtual {v10, v9}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v9

    if-eqz v9, :cond_eb

    invoke-virtual {v9}, Lorg/json/JSONArray;->length()I

    move-result v13

    if-nez v13, :cond_64

    goto/16 :goto_eb

    :cond_64
    invoke-virtual {v9}, Lorg/json/JSONArray;->length()I

    move-result v13

    new-array v15, v13, [Ljava/lang/String;

    aput-object v15, v4, v8

    new-array v15, v13, [J

    aput-object v15, v5, v8

    new-array v15, v13, [J

    aput-object v15, v6, v8

    move/from16 v16, v2

    const/4 v15, 0x0

    :goto_77
    const-wide/16 v1, 0x0

    const/16 v17, 0x0

    if-ge v15, v13, :cond_af

    invoke-virtual {v9, v15}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    aget-object v18, v4, v8

    if-nez v7, :cond_88

    move-object/from16 v19, v12

    goto :goto_8c

    :cond_88
    invoke-virtual {v7, v14, v12}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    :goto_8c
    aput-object v19, v18, v15

    aget-object v18, v5, v8

    if-nez v7, :cond_95

    move-wide/from16 v20, v1

    goto :goto_9b

    :cond_95
    const-string v11, "time"

    invoke-virtual {v7, v11, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v20

    :goto_9b
    aput-wide v20, v18, v15

    aget-object v11, v6, v8

    if-nez v7, :cond_a2

    goto :goto_a8

    :cond_a2
    const-string v0, "duration"

    invoke-virtual {v7, v0, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    :goto_a8
    aput-wide v1, v11, v15

    add-int/lit8 v15, v15, 0x1

    move-object/from16 v0, p0

    goto :goto_77

    :cond_af
    const-string v0, "startTime"

    const-wide/high16 v11, -0x4010000000000000L    # -1.0

    invoke-virtual {v10, v0, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v14

    const-wide v20, 0x408f400000000000L    # 1000.0

    mul-double v14, v14, v20

    invoke-static {v14, v15}, Ljava/lang/Math;->round(D)J

    move-result-wide v14

    const-string v0, "endTime"

    invoke-virtual {v10, v0, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v9

    mul-double v9, v9, v20

    invoke-static {v9, v10}, Ljava/lang/Math;->round(D)J

    move-result-wide v9

    const/4 v0, 0x1

    if-ne v13, v0, :cond_f0

    cmp-long v1, v14, v1

    if-ltz v1, :cond_f0

    cmp-long v1, v9, v14

    if-lez v1, :cond_f0

    sub-long/2addr v9, v14

    aget-object v1, v6, v8

    aget-wide v11, v1, v17

    cmp-long v1, v9, v11

    if-lez v1, :cond_f0

    aget-object v1, v5, v8

    aput-wide v14, v1, v17

    aget-object v1, v6, v8

    aput-wide v9, v1, v17

    goto :goto_f0

    :cond_eb
    :goto_eb
    move/from16 v16, v2

    const/4 v0, 0x1

    const/16 v17, 0x0

    :cond_f0
    :goto_f0
    move v9, v0

    goto :goto_f6

    :cond_f2
    :goto_f2
    move/from16 v16, v2

    const/16 v17, 0x0

    :goto_f6
    add-int/lit8 v8, v8, 0x1

    move-object/from16 v0, p0

    move/from16 v2, v16

    const/4 v1, 0x0

    goto/16 :goto_1c

    :cond_ff
    if-eqz v9, :cond_102

    goto :goto_103

    :cond_102
    const/4 v4, 0x0

    :goto_103
    sput-object v4, Lradiant/RLLyrics;->twText:[[Ljava/lang/String;

    if-eqz v9, :cond_108

    goto :goto_109

    :cond_108
    const/4 v5, 0x0

    :goto_109
    sput-object v5, Lradiant/RLLyrics;->twStart:[[J

    if-eqz v9, :cond_10e

    goto :goto_10f

    :cond_10e
    const/4 v6, 0x0

    :goto_10f
    sput-object v6, Lradiant/RLLyrics;->twDur:[[J

    if-eqz v9, :cond_115

    move-object v1, v3

    goto :goto_116

    :cond_115
    const/4 v1, 0x0

    :goto_116
    sput-object v1, Lradiant/RLLyrics;->trans:[Ljava/lang/String;

    return-void
.end method

.method static refetch()V
    .registers 8

    invoke-static {}, Lradiant/RLLyrics;->currentWorker()Lradiant/RLAPILyricsWorker;

    move-result-object v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    new-instance v1, Lradiant/RLTask;

    new-instance v2, Lradiant/RLAPILyricsWorker;

    iget-object v3, v0, Lradiant/RLAPILyricsWorker;->vm:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;

    iget-object v4, v0, Lradiant/RLAPILyricsWorker;->title:Ljava/lang/String;

    iget-object v5, v0, Lradiant/RLAPILyricsWorker;->artist:Ljava/lang/String;

    iget-object v6, v0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    iget-object v7, v0, Lradiant/RLAPILyricsWorker;->lyricsId:Ljava/lang/String;

    invoke-direct/range {v2 .. v7}, Lradiant/RLAPILyricsWorker;-><init>(Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v3, v2

    const/4 v2, 0x5

    const/4 v4, 0x0

    invoke-direct/range {v1 .. v6}, Lradiant/RLTask;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-static {v1}, Lradiant/RLLyrics;->background(Ljava/lang/Runnable;)V

    return-void
.end method

.method public static declared-synchronized registerVm(Ljava/lang/Object;Ljava/lang/String;)V
    .registers 4

    const-class v0, Lradiant/RLLyrics;

    monitor-enter v0

    if-eqz p0, :cond_10

    if-eqz p1, :cond_10

    :try_start_7
    sget-object v1, Lradiant/RLLyrics;->vms:Ljava/util/WeakHashMap;

    invoke-virtual {v1, p0, p1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_10

    :catchall_d
    move-exception p0

    monitor-exit v0
    :try_end_f
    .catchall {:try_start_7 .. :try_end_f} :catchall_d

    throw p0

    :cond_10
    :goto_10
    monitor-exit v0

    return-void
.end method

.method public static render(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;
    .registers 21

    sget-object v0, Lradiant/RLLyrics;->version:Landroidx/compose/runtime/MutableState;

    invoke-interface {v0}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    invoke-static {}, Lradiant/RLSettings;->sync()I

    move-result v3

    sget-object v0, Lradiant/RLLyrics;->trans:[Ljava/lang/String;

    sget-boolean v1, Lradiant/RLAPILyricsHook;->isRlState:Z

    if-eqz v1, :cond_dd

    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v1

    if-eqz v1, :cond_dd

    if-eqz v0, :cond_dd

    if-ltz p0, :cond_dd

    array-length v1, v0

    if-ge p0, v1, :cond_dd

    aget-object v1, v0, p0

    if-eqz v1, :cond_dd

    sget-object v1, Lradiant/RLLyrics;->twText:[[Ljava/lang/String;

    sget-object v4, Lradiant/RLLyrics;->twStart:[[J

    sget-object v5, Lradiant/RLLyrics;->twDur:[[J

    const/4 v6, 0x0

    if-eqz v3, :cond_31

    if-eqz v1, :cond_31

    array-length v7, v1

    if-ge p0, v7, :cond_31

    aget-object v1, v1, p0

    goto :goto_32

    :cond_31
    move-object v1, v6

    :goto_32
    if-eqz v1, :cond_3d

    if-eqz v4, :cond_3d

    array-length v7, v4

    if-ge p0, v7, :cond_3d

    aget-object v4, v4, p0

    move-object v8, v4

    goto :goto_3e

    :cond_3d
    move-object v8, v6

    :goto_3e
    if-eqz v1, :cond_47

    if-eqz v5, :cond_47

    array-length v4, v5

    if-ge p0, v4, :cond_47

    aget-object v6, v5, p0

    :cond_47
    move-object v9, v6

    if-eqz v1, :cond_d1

    if-eqz v8, :cond_d1

    if-eqz v9, :cond_d1

    array-length v4, v8

    array-length v5, v1

    if-ne v4, v5, :cond_d1

    array-length v4, v9

    array-length v5, v1

    if-eq v4, v5, :cond_58

    goto/16 :goto_d1

    :cond_58
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    array-length v4, v1

    new-array v6, v4, [I

    array-length v4, v1

    new-array v7, v4, [I

    const/4 v4, 0x0

    move v5, v4

    :goto_65
    array-length v10, v1

    if-ge v5, v10, :cond_8b

    aget-object v10, v1, v5

    invoke-static {v10}, Lradiant/RLLyrics;->trimEndLen(Ljava/lang/String;)I

    move-result v11

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v12

    aput v12, v6, v5

    invoke-virtual {v0, v10, v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;II)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v12

    aput v12, v7, v5

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v10

    if-eq v11, v10, :cond_88

    const/16 v10, 0x20

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :cond_88
    add-int/lit8 v5, v5, 0x1

    goto :goto_65

    :cond_8b
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-wide p3, Lradiant/WordLyrics;->tmpSung:J

    sput-wide p5, Lradiant/WordLyrics;->tmpUnsung:J

    new-instance v0, Landroidx/compose/ui/text/AnnotatedString$Builder;

    invoke-direct {v0, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    invoke-static {}, Lradiant/WordLyrics;->ctxSingers()Z

    move-result v10

    if-eqz v10, :cond_ab

    sget-boolean v10, Lradiant/WordLyrics;->dualSide:Z

    if-eqz v10, :cond_ab

    invoke-static {p0}, Lradiant/WordLyrics;->sideOf(I)I

    move-result v10

    goto :goto_ac

    :cond_ab
    const/4 v10, -0x1

    :goto_ac
    if-ltz v10, :cond_b5

    invoke-static {v10, v4}, Lradiant/WordLyrics;->paraStyle(IZ)Landroidx/compose/ui/text/ParagraphStyle;

    move-result-object v10

    invoke-virtual {v0, v10, v4, v5}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/ParagraphStyle;II)V

    :cond_b5
    invoke-static/range {p5 .. p6}, Lradiant/WordLyrics;->makeSpan(J)Landroidx/compose/ui/text/SpanStyle;

    move-result-object v10

    invoke-virtual {v0, v10, v4, v5}, Landroidx/compose/ui/text/AnnotatedString$Builder;->addStyle(Landroidx/compose/ui/text/SpanStyle;II)V

    invoke-static {}, Lradiant/WordLyrics;->lineState()Landroidx/compose/runtime/MutableState;

    move-result-object v4

    invoke-interface {v4}, Landroidx/compose/runtime/MutableState;->getValue()Ljava/lang/Object;

    const/4 v4, 0x0

    move v2, p0

    move-wide/from16 v10, p3

    move-wide/from16 v12, p5

    invoke-static/range {v0 .. v13}, Lradiant/RLLyrics;->lightWords(Landroidx/compose/ui/text/AnnotatedString$Builder;Ljava/lang/String;IIII[I[I[J[JJJ)V

    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_d1
    :goto_d1
    new-instance v1, Landroidx/compose/ui/text/AnnotatedString$Builder;

    aget-object v0, v0, p0

    invoke-direct {v1, v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_dd
    const/4 v0, 0x2

    if-ne v3, v0, :cond_e5

    invoke-static/range {p0 .. p6}, Lradiant/WordLyrics;->renderSyl(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_e5
    const/4 v0, 0x1

    if-ne v3, v0, :cond_ed

    invoke-static/range {p0 .. p6}, Lradiant/WordLyrics;->render(IILjava/lang/String;JJ)Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0

    :cond_ed
    new-instance v0, Landroidx/compose/ui/text/AnnotatedString$Builder;

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Landroidx/compose/ui/text/AnnotatedString$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroidx/compose/ui/text/AnnotatedString$Builder;->toAnnotatedString()Landroidx/compose/ui/text/AnnotatedString;

    move-result-object v0

    return-object v0
.end method

.method static republish(Lradiant/RLAPILyricsWorker;)Z
    .registers 4

    sget-object v0, Lradiant/RLLyrics;->body:Ljava/lang/String;

    if-eqz v0, :cond_34

    if-eqz p0, :cond_34

    iget-object v1, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sget-object v2, Lradiant/RLLyrics;->trackKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_11

    goto :goto_34

    :cond_11
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "rl-api empty for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", keeping the last lyrics"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lradiant/RLAPILyricsWorker;->publish(Ljava/lang/String;)Z

    move-result p0

    return p0

    :cond_34
    :goto_34
    const/4 p0, 0x0

    return p0
.end method

.method static respace(Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .registers 23

    move-object/from16 v0, p0

    const-string v1, "data"

    move-object/from16 v2, p1

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    if-nez v1, :cond_d

    return-void

    :cond_d
    const-string v2, "transcript"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "text"

    const-string v4, ""

    if-nez v2, :cond_1b

    move-object v2, v4

    goto :goto_1f

    :cond_1b
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :goto_1f
    invoke-static {v2}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_27

    const/4 v5, 0x0

    goto :goto_28

    :cond_27
    const/4 v5, -0x1

    :goto_28
    const-string v8, "lines"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v8

    const/4 v9, 0x0

    :goto_2f
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-ge v9, v0, :cond_1b4

    invoke-virtual {v1, v9}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v0

    if-nez v0, :cond_3d

    const/4 v10, 0x0

    goto :goto_43

    :cond_3d
    const-string v10, "syllabus"

    invoke-virtual {v0, v10}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v10

    :goto_43
    if-eqz v10, :cond_1a2

    invoke-virtual {v10}, Lorg/json/JSONArray;->length()I

    move-result v11

    if-nez v11, :cond_4d

    goto/16 :goto_1a2

    :cond_4d
    invoke-virtual {v10}, Lorg/json/JSONArray;->length()I

    move-result v11

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    new-array v13, v11, [Z

    const/4 v14, 0x0

    const/4 v15, 0x0

    :goto_59
    add-int/lit8 v6, v11, -0x1

    const/16 v16, 0x1

    if-ge v14, v6, :cond_88

    invoke-virtual {v10, v14}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-nez v6, :cond_67

    move-object v6, v4

    goto :goto_6b

    :cond_67
    invoke-virtual {v6, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    :goto_6b
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v17

    if-lez v17, :cond_85

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v17

    add-int/lit8 v7, v17, -0x1

    invoke-virtual {v6, v7}, Ljava/lang/String;->charAt(I)C

    move-result v6

    invoke-static {v6}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v6

    if-eqz v6, :cond_85

    aput-boolean v16, v13, v14

    move/from16 v15, v16

    :cond_85
    add-int/lit8 v14, v14, 0x1

    goto :goto_59

    :cond_88
    if-nez v15, :cond_a8

    invoke-static {v12}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_92

    move-object v7, v12

    goto :goto_96

    :cond_92
    invoke-static {v8, v9}, Lradiant/RLLyrics;->summaryText(Lorg/json/JSONArray;I)Ljava/lang/String;

    move-result-object v7

    :goto_96
    invoke-static {v7}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_a8

    const/4 v14, 0x0

    invoke-static {v10, v7, v14, v13}, Lradiant/RLLyrics;->walk(Lorg/json/JSONArray;Ljava/lang/String;I[Z)I

    move-result v7

    if-ltz v7, :cond_a6

    move/from16 v15, v16

    goto :goto_a9

    :cond_a6
    move v15, v14

    goto :goto_a9

    :cond_a8
    const/4 v14, 0x0

    :goto_a9
    if-nez v15, :cond_bc

    if-ltz v5, :cond_bc

    new-array v13, v11, [Z

    invoke-static {v10, v2, v5, v13}, Lradiant/RLLyrics;->walk(Lorg/json/JSONArray;Ljava/lang/String;I[Z)I

    move-result v5

    if-ltz v5, :cond_b6

    goto :goto_b9

    :cond_b6
    move/from16 v16, v15

    const/4 v5, -0x1

    :goto_b9
    move/from16 v15, v16

    goto :goto_c4

    :cond_bc
    if-ltz v5, :cond_c4

    new-array v7, v11, [Z

    invoke-static {v10, v2, v5, v7}, Lradiant/RLLyrics;->walk(Lorg/json/JSONArray;Ljava/lang/String;I[Z)I

    move-result v5

    :cond_c4
    :goto_c4
    if-nez v15, :cond_d2

    :goto_c6
    move-object/from16 v16, v1

    move-object/from16 v17, v2

    :goto_ca
    move/from16 p0, v5

    :goto_cc
    move-object/from16 v18, v8

    :goto_ce
    move/from16 v19, v9

    goto/16 :goto_19f

    :cond_d2
    :try_start_d2
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_dc
    .catchall {:try_start_d2 .. :try_end_dc} :catchall_19c

    move-object/from16 v16, v1

    :goto_de
    const-string v1, "romanized"

    if-ge v14, v11, :cond_165

    move-object/from16 v17, v2

    :try_start_e4
    invoke-virtual {v10, v14}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2
    :try_end_e8
    .catchall {:try_start_e4 .. :try_end_e8} :catchall_162

    move/from16 p0, v5

    :try_start_ea
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5
    :try_end_ee
    .catchall {:try_start_ea .. :try_end_ee} :catchall_15f

    move-object/from16 v18, v8

    :try_start_f0
    invoke-virtual {v2, v1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    aget-boolean v19, v13, v14

    if-eqz v19, :cond_13e

    if-ge v14, v6, :cond_13e

    invoke-static {v5}, Lradiant/RLLyrics;->endsSpace(Ljava/lang/String;)Z

    move-result v19
    :try_end_fe
    .catchall {:try_start_f0 .. :try_end_fe} :catchall_15c

    move/from16 v20, v6

    const-string v6, " "

    if-nez v19, :cond_11b

    move/from16 v19, v9

    :try_start_106
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v3, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_11d

    :cond_11b
    move/from16 v19, v9

    :goto_11d
    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_142

    invoke-static {v8}, Lradiant/RLLyrics;->endsSpace(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_142

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v1, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_142

    :cond_13e
    move/from16 v20, v6

    move/from16 v19, v9

    :cond_142
    :goto_142
    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_14c

    move-object v5, v8

    :cond_14c
    invoke-virtual {v15, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v14, v14, 0x1

    move/from16 v5, p0

    move-object/from16 v2, v17

    move-object/from16 v8, v18

    move/from16 v9, v19

    move/from16 v6, v20

    goto :goto_de

    :catchall_15c
    move-exception v0

    goto/16 :goto_ce

    :catchall_15f
    move-exception v0

    goto/16 :goto_cc

    :catchall_162
    move-exception v0

    goto/16 :goto_ca

    :cond_165
    move-object/from16 v17, v2

    move/from16 p0, v5

    move-object/from16 v18, v8

    move/from16 v19, v9

    invoke-static {v12}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_17e

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_17e
    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_19f

    invoke-static {v2}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_19f

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_199
    .catchall {:try_start_106 .. :try_end_199} :catchall_19a

    goto :goto_19f

    :catchall_19a
    move-exception v0

    goto :goto_19f

    :catchall_19c
    move-exception v0

    goto/16 :goto_c6

    :cond_19f
    :goto_19f
    move/from16 v5, p0

    goto :goto_1aa

    :cond_1a2
    :goto_1a2
    move-object/from16 v16, v1

    move-object/from16 v17, v2

    move-object/from16 v18, v8

    move/from16 v19, v9

    :goto_1aa
    add-int/lit8 v9, v19, 0x1

    move-object/from16 v1, v16

    move-object/from16 v2, v17

    move-object/from16 v8, v18

    goto/16 :goto_2f

    :cond_1b4
    return-void
.end method

.method static runAutoSylla(Lradiant/RLAPILyricsWorker;Ljava/lang/String;Ljava/lang/String;I)V
    .registers 8

    sget-wide v0, Lradiant/RLLyrics;->trackStartedAt:J

    const-wide/16 v2, 0x1388

    add-long/2addr v0, v2

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    sub-long/2addr v0, v2

    invoke-static {v0, v1}, Lradiant/RLLyrics;->sleep(J)V

    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-eq p3, v0, :cond_12

    return-void

    :cond_12
    const-string v0, "untimed"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_20

    if-eqz p2, :cond_20

    move v0, v1

    goto :goto_21

    :cond_20
    move v0, v2

    :goto_21
    if-nez v0, :cond_2b

    const-string v3, "align"

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2f

    :cond_2b
    if-eqz p2, :cond_2f

    move p1, v1

    goto :goto_30

    :cond_2f
    move p1, v2

    :goto_30
    if-eqz p1, :cond_37

    invoke-static {p0, p2}, Lradiant/RLLyrics;->align(Lradiant/RLAPILyricsWorker;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p2

    goto :goto_3b

    :cond_37
    invoke-static {p0}, Lradiant/RLLyrics;->gen(Lradiant/RLAPILyricsWorker;)Ljava/lang/Object;

    move-result-object p2

    :goto_3b
    if-eqz v0, :cond_74

    instance-of v0, p2, Lorg/json/JSONObject;

    if-nez v0, :cond_74

    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne p3, v0, :cond_74

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v3, Lradiant/RLLyrics;->syllaRefused:Ljava/lang/ThreadLocal;

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_74

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Sylla Align (untimed) failed ("

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "), trying Gen"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    invoke-static {p0}, Lradiant/RLLyrics;->gen(Lradiant/RLAPILyricsWorker;)Ljava/lang/Object;

    move-result-object p2

    move p1, v2

    :cond_74
    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-eq p3, v0, :cond_79

    return-void

    :cond_79
    sput-boolean v2, Lradiant/RLLyrics;->autoSyllaRunning:Z

    sget-object p3, Lradiant/RLLyrics;->autoSyllaJob:Ljava/lang/Object;

    invoke-static {p3, v1, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    instance-of p3, p2, Lorg/json/JSONObject;

    if-nez p3, :cond_c3

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "Sylla "

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    if-eqz p1, :cond_94

    const-string p3, "Align"

    goto :goto_96

    :cond_94
    const-string p3, "Gen"

    :goto_96
    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p3, ": kept "

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    if-eqz p1, :cond_a5

    const-string p1, "line lyrics"

    goto :goto_a7

    :cond_a5
    const-string p1, "no lyrics"

    :goto_a7
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " ("

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ")"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    return-void

    :cond_c3
    check-cast p2, Lorg/json/JSONObject;

    if-eqz p1, :cond_ca

    const-string p1, "retimed"

    goto :goto_cc

    :cond_ca
    const-string p1, "generated"

    :goto_cc
    invoke-static {p0, p2, p1}, Lradiant/RLLyrics;->loadSylla(Lradiant/RLAPILyricsWorker;Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void
.end method

.method static runFlush()V
    .registers 10

    const-string v0, ""

    invoke-static {}, Lradiant/RLLyrics;->currentWorker()Lradiant/RLAPILyricsWorker;

    move-result-object v1

    const/4 v2, 0x0

    if-nez v1, :cond_11

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    const-string v0, "Flush: could not get track info"

    invoke-static {v0}, Lradiant/RLLyrics;->toastErr(Ljava/lang/String;)V

    return-void

    :cond_11
    iget-object v3, v1, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sget-object v4, Lradiant/RLLyrics;->retimeTrack:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_25

    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v3

    if-eqz v3, :cond_25

    invoke-static {v1, v2}, Lradiant/RLLyrics;->runRetime(Lradiant/RLAPILyricsWorker;Z)V

    return-void

    :cond_25
    new-instance v3, Ljava/lang/Object;

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    const/4 v4, 0x1

    invoke-static {v3, v2, v4}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    sget v5, Lradiant/RLLyrics;->syllaEpoch:I

    :try_start_30
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "https://api.radiant-lyrics.org/"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, "rl-api?title="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v1, Lradiant/RLAPILyricsWorker;->title:Ljava/lang/String;

    invoke-static {v7}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "&artist="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v1, Lradiant/RLAPILyricsWorker;->artist:Ljava/lang/String;

    invoke-static {v7}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v1}, Lradiant/RLLyrics;->isrc(Lradiant/RLAPILyricsWorker;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v8

    if-lez v8, :cond_6e

    const-string v8, "&isrc="

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-static {v7}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_6e
    const-string v7, "&flush=true&ai-preference="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v7

    if-eqz v7, :cond_92

    const-string v7, "&translate=true&language="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static {}, Lradiant/RLSettings;->language()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_92
    const-string v7, "&platform=rl-mobile"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, "GET"

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v8, 0x0

    const v9, 0xafc8

    invoke-static {v7, v6, v8, v9}, Lradiant/RLHttp;->request(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lradiant/RLHttp;

    move-result-object v6

    sget v7, Lradiant/RLLyrics;->syllaEpoch:I
    :try_end_a7
    .catchall {:try_start_30 .. :try_end_a7} :catchall_185

    if-eq v5, v7, :cond_b3

    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v5, v0, :cond_af

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    :cond_af
    invoke-static {v3, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    return-void

    :cond_b3
    :try_start_b3
    iget v7, v6, Lradiant/RLHttp;->status:I

    const/16 v8, 0x194

    if-ne v7, v8, :cond_d7

    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v0

    if-eqz v0, :cond_c8

    const-string v0, "No lyrics found for this track\nGenerating them with Sylla\u2026"

    invoke-static {v0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V

    invoke-static {v1, v4}, Lradiant/RLLyrics;->runRetime(Lradiant/RLAPILyricsWorker;Z)V

    goto :goto_cd

    :cond_c8
    const-string v0, "No lyrics found for this track"

    invoke-static {v0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V
    :try_end_cd
    .catchall {:try_start_b3 .. :try_end_cd} :catchall_185

    :goto_cd
    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v5, v0, :cond_d3

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    :cond_d3
    invoke-static {v3, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    return-void

    :cond_d7
    :try_start_d7
    invoke-virtual {v6}, Lradiant/RLHttp;->ok()Z

    move-result v4

    if-nez v4, :cond_118

    iget v0, v6, Lradiant/RLHttp;->status:I

    if-nez v0, :cond_f7

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Flush error: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, v6, Lradiant/RLHttp;->error:Ljava/lang/String;

    :goto_ee
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_10b

    :cond_f7
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Flush failed ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, v6, Lradiant/RLHttp;->status:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    goto :goto_ee

    :goto_10b
    invoke-static {v0}, Lradiant/RLLyrics;->toastErr(Ljava/lang/String;)V
    :try_end_10e
    .catchall {:try_start_d7 .. :try_end_10e} :catchall_185

    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v5, v0, :cond_114

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    :cond_114
    invoke-static {v3, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    return-void

    :cond_118
    :try_start_118
    new-instance v4, Lorg/json/JSONObject;

    iget-object v6, v6, Lradiant/RLHttp;->body:Ljava/lang/String;

    invoke-direct {v4, v6}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v6, "_flush"

    invoke-virtual {v4, v6, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_125
    .catchall {:try_start_118 .. :try_end_125} :catchall_126

    goto :goto_127

    :catchall_126
    move-exception v4

    :goto_127
    :try_start_127
    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v4

    if-eqz v4, :cond_131

    iget-object v4, v1, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sput-object v4, Lradiant/RLLyrics;->retimeTrack:Ljava/lang/String;

    :cond_131
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    if-eqz v4, :cond_16c

    const-string v4, "Created"

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_16c

    const-string v4, "Updated"

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_148

    goto :goto_16c

    :cond_148
    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v4

    if-eqz v4, :cond_168

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "\nRetiming with Sylla\u2026"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V

    invoke-static {v1, v2}, Lradiant/RLLyrics;->runRetime(Lradiant/RLAPILyricsWorker;Z)V

    goto :goto_17b

    :cond_168
    invoke-static {v0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V

    goto :goto_17b

    :cond_16c
    :goto_16c
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_173

    goto :goto_175

    :cond_173
    const-string v0, "Lyrics flushed"

    :goto_175
    invoke-static {v0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V

    invoke-static {}, Lradiant/RLLyrics;->refetch()V
    :try_end_17b
    .catchall {:try_start_127 .. :try_end_17b} :catchall_185

    :goto_17b
    sget v0, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v5, v0, :cond_181

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    :cond_181
    invoke-static {v3, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    return-void

    :catchall_185
    move-exception v0

    sget v1, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v5, v1, :cond_18c

    sput-boolean v2, Lradiant/RLLyrics;->busy:Z

    :cond_18c
    invoke-static {v3, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    throw v0
.end method

.method static runRefetch(Lradiant/RLAPILyricsWorker;)V
    .registers 4

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    :try_start_a
    invoke-virtual {p0}, Lradiant/RLAPILyricsWorker;->run()V
    :try_end_d
    .catchall {:try_start_a .. :try_end_d} :catchall_11

    invoke-static {v0, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    return-void

    :catchall_11
    move-exception p0

    invoke-static {v0, v2, v2}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    throw p0
.end method

.method private static runRetime(Lradiant/RLAPILyricsWorker;Z)V
    .registers 10

    sget-object v0, Lradiant/RLLyrics;->body:Ljava/lang/String;

    const/4 v1, 0x1

    if-nez v0, :cond_6

    move p1, v1

    :cond_6
    new-instance v2, Ljava/lang/Object;

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    invoke-static {v2, v1, v1}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    sget v3, Lradiant/RLLyrics;->syllaEpoch:I

    const/4 v4, 0x0

    if-eqz p1, :cond_18

    :try_start_13
    invoke-static {p0}, Lradiant/RLLyrics;->gen(Lradiant/RLAPILyricsWorker;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_1c

    :cond_18
    invoke-static {p0, v0}, Lradiant/RLLyrics;->align(Lradiant/RLAPILyricsWorker;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    :goto_1c
    instance-of v5, v0, Lorg/json/JSONObject;

    const/4 v6, 0x0

    if-eqz v5, :cond_27

    check-cast v0, Lorg/json/JSONObject;

    move-object v7, v6

    move-object v6, v0

    move-object v0, v7

    goto :goto_29

    :cond_27
    check-cast v0, Ljava/lang/String;
    :try_end_29
    .catchall {:try_start_13 .. :try_end_29} :catchall_76

    :goto_29
    sget v5, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v3, v5, :cond_2f

    sput-boolean v4, Lradiant/RLLyrics;->busy:Z

    :cond_2f
    invoke-static {v2, v1, v4}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    sget v2, Lradiant/RLLyrics;->syllaEpoch:I

    if-eq v3, v2, :cond_37

    return-void

    :cond_37
    if-nez v6, :cond_6b

    const-string p0, "!"

    invoke-virtual {v0, p0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_49

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLLyrics;->toast(Ljava/lang/String;)V

    goto :goto_6a

    :cond_49
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p1, :cond_53

    const-string p1, "AI generation failed ("

    goto :goto_55

    :cond_53
    const-string p1, "AI retime failed ("

    :goto_55
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ")"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLLyrics;->toastErr(Ljava/lang/String;)V

    :goto_6a
    return-void

    :cond_6b
    if-eqz p1, :cond_70

    const-string p1, "generated"

    goto :goto_72

    :cond_70
    const-string p1, "retimed"

    :goto_72
    invoke-static {p0, v6, p1}, Lradiant/RLLyrics;->loadSylla(Lradiant/RLAPILyricsWorker;Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void

    :catchall_76
    move-exception p0

    sget p1, Lradiant/RLLyrics;->syllaEpoch:I

    if-ne v3, p1, :cond_7d

    sput-boolean v4, Lradiant/RLLyrics;->busy:Z

    :cond_7d
    invoke-static {v2, v1, v4}, Lradiant/SparkleIcons;->work(Ljava/lang/Object;ZZ)V

    throw p0
.end method

.method public static settleLookup(Lradiant/RLAPILyricsWorker;)Z
    .registers 5

    sget-boolean v0, Lradiant/RLLyrics;->skipping:Z

    const/4 v1, 0x1

    if-nez v0, :cond_6

    return v1

    :cond_6
    const-wide/16 v2, 0x5dc

    invoke-static {v2, v3}, Lradiant/RLLyrics;->sleep(J)V

    iget-object p0, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    sget-object v0, Lradiant/RLLyrics;->trackKey:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    const/4 v0, 0x0

    if-nez p0, :cond_17

    return v0

    :cond_17
    sput-boolean v0, Lradiant/RLLyrics;->skipping:Z

    return v1
.end method

.method static showToast(Ljava/lang/String;Z)V
    .registers 3

    invoke-static {}, Lradiant/RLSettings;->app()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_d

    invoke-static {v0, p0, p1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    :cond_d
    return-void
.end method

.method private static sleep(J)V
    .registers 4

    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gtz v0, :cond_7

    return-void

    :cond_7
    :try_start_7
    invoke-static {p0, p1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_a
    .catch Ljava/lang/InterruptedException; {:try_start_7 .. :try_end_a} :catch_b

    goto :goto_c

    :catch_b
    move-exception p0

    :goto_c
    return-void
.end method

.method private static summaryText(Lorg/json/JSONArray;I)Ljava/lang/String;
    .registers 8

    const-string v0, ""

    if-nez p0, :cond_5

    return-object v0

    :cond_5
    const/4 v1, 0x0

    :goto_6
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v2

    const-string v3, "text"

    if-ge v1, v2, :cond_25

    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    if-eqz v2, :cond_22

    const-string v4, "index"

    const/4 v5, -0x1

    invoke-virtual {v2, v4, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v4

    if-ne v4, p1, :cond_22

    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_22
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    :cond_25
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-ge p1, v1, :cond_30

    invoke-virtual {p0, p1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object p0

    goto :goto_31

    :cond_30
    const/4 p0, 0x0

    :goto_31
    if-nez p0, :cond_34

    goto :goto_38

    :cond_34
    invoke-virtual {p0, v3, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_38
    return-object v0
.end method

.method private static syllaQs()Ljava/lang/String;
    .registers 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "?romanize="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lradiant/RLSettings;->romanize()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&translate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&language="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lradiant/RLSettings;->language()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lradiant/RLAPILyricsWorker;->uric(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&ai-preference="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static syncRomanized(Lorg/json/JSONArray;)Z
    .registers 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    const/4 v0, 0x0

    move v1, v0

    move v2, v1

    :goto_3
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v1, v3, :cond_a8

    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    if-nez v3, :cond_11

    const/4 v4, 0x0

    goto :goto_17

    :cond_11
    const-string v4, "syllabus"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    :goto_17
    if-nez v4, :cond_1b

    goto/16 :goto_a4

    :cond_1b
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    move v7, v0

    move v8, v7

    :goto_26
    const-string v9, "text"

    const-string v10, ""

    const-string v11, "romanized"

    const/4 v12, 0x1

    if-ge v7, v5, :cond_7c

    invoke-virtual {v4, v7}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v13

    invoke-virtual {v13, v9, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v13, v11, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v14

    if-lez v14, :cond_42

    move v8, v12

    :cond_42
    add-int/lit8 v14, v5, -0x1

    if-ge v7, v14, :cond_6f

    invoke-static {v9}, Lradiant/RLLyrics;->endsSpace(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_6f

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v14

    if-lez v14, :cond_6f

    invoke-static {v10}, Lradiant/RLLyrics;->endsSpace(Ljava/lang/String;)Z

    move-result v14

    if-nez v14, :cond_6f

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v10, " "

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v13, v11, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move v2, v12

    :cond_6f
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v11

    if-lez v11, :cond_76

    move-object v9, v10

    :cond_76
    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v7, v7, 0x1

    goto :goto_26

    :cond_7c
    invoke-virtual {v3, v11, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v8, :cond_a4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_a4

    invoke-static {v4}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_a4

    invoke-virtual {v3, v9, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lradiant/RLLyrics;->hasSpace(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_a4

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v11, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move v2, v12

    :cond_a4
    :goto_a4
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_3

    :cond_a8
    return v2
.end method

.method static toast(Ljava/lang/String;)V
    .registers 9

    invoke-static {}, Lradiant/RLSettings;->toasts()I

    move-result v0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_8

    return-void

    :cond_8
    new-instance v2, Lradiant/RLTask;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x3

    const/4 v5, 0x0

    move-object v4, p0

    invoke-direct/range {v2 .. v7}, Lradiant/RLTask;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-static {v2}, Lradiant/RLLyrics;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method static toastErr(Ljava/lang/String;)V
    .registers 9

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    invoke-static {}, Lradiant/RLSettings;->toasts()I

    move-result v0

    const/4 v1, 0x1

    if-ge v0, v1, :cond_b

    return-void

    :cond_b
    new-instance v2, Lradiant/RLTask;

    const/4 v6, 0x0

    const/4 v7, 0x1

    const/4 v3, 0x3

    const/4 v5, 0x0

    move-object v4, p0

    invoke-direct/range {v2 .. v7}, Lradiant/RLTask;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-static {v2}, Lradiant/RLLyrics;->post(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static trackJson(Lradiant/RLAPILyricsWorker;)Lorg/json/JSONObject;
    .registers 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "tidal_id"

    iget-object v2, p0, Lradiant/RLAPILyricsWorker;->key:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "isrc"

    invoke-static {p0}, Lradiant/RLLyrics;->isrc(Lradiant/RLAPILyricsWorker;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "title"

    iget-object v2, p0, Lradiant/RLAPILyricsWorker;->title:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "artist"

    iget-object p0, p0, Lradiant/RLAPILyricsWorker;->artist:Ljava/lang/String;

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    return-object v0
.end method

.method private static trimEndLen(Ljava/lang/String;)I
    .registers 4

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    :goto_4
    if-lez v0, :cond_13

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x20

    if-gt v1, v2, :cond_13

    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    :cond_13
    return v0
.end method

.method private static walk(Lorg/json/JSONArray;Ljava/lang/String;I[Z)I
    .registers 10

    const/4 v0, 0x0

    move v1, v0

    :goto_2
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_7a

    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, ""

    if-nez v2, :cond_11

    goto :goto_17

    :cond_11
    const-string v4, "text"

    invoke-virtual {v2, v4, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_17
    move v2, v0

    :goto_18
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v2, v4, :cond_58

    invoke-virtual {v3, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v5

    if-nez v5, :cond_29

    goto :goto_53

    :cond_29
    :goto_29
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge p2, v5, :cond_3c

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v5}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v5

    if-nez v5, :cond_3c

    add-int/lit8 p2, p2, 0x1

    goto :goto_29

    :cond_3c
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge p2, v5, :cond_56

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v5}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v5

    invoke-static {v4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    if-eq v5, v4, :cond_51

    goto :goto_56

    :cond_51
    add-int/lit8 p2, p2, 0x1

    :goto_53
    add-int/lit8 v2, v2, 0x1

    goto :goto_18

    :cond_56
    :goto_56
    const/4 p0, -0x1

    return p0

    :cond_58
    move v2, p2

    :goto_59
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_77

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v4

    if-eqz v4, :cond_6d

    const/4 v2, 0x1

    aput-boolean v2, p3, v1

    goto :goto_77

    :cond_6d
    invoke-static {v3}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v3

    if-eqz v3, :cond_74

    goto :goto_77

    :cond_74
    add-int/lit8 v2, v2, 0x1

    goto :goto_59

    :cond_77
    :goto_77
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_7a
    return p2
.end method
