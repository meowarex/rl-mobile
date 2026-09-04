.class public final Lradiant/gestures/queue/UnifiedSearchResolver;
.super Ljava/lang/Object;
.source "UnifiedSearchResolver.smali"

# interfaces
.implements Lradiant/gestures/queue/QueueRowResolver;

# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;
.field private final recycler:Ljava/lang/ref/WeakReference;

# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/search/v2/UnifiedSearchView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->recycler:Ljava/lang/ref/WeakReference;
    return-void
.end method

.method private current(Lradiant/gestures/queue/QueueRequest;)Ljava/lang/Object;
    .locals 7

    if-eqz p1, :invalid
    iget-object v0, p1, Lradiant/gestures/queue/QueueRequest;->media:Ljava/lang/Object;

    iget-object v1, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->recycler:Ljava/lang/ref/WeakReference;
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;
    if-eqz v1, :invalid
    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;
    move-result-object v1
    instance-of v2, v1, La50/d;    # MARKER: R8 La50/d;
    if-eqz v2, :invalid
    check-cast v1, La50/d;    # MARKER: R8 La50/d;
    invoke-virtual {v1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;
    move-result-object v1

    iget v2, p1, Lradiant/gestures/queue/QueueRequest;->position:I
    if-gez v2, :check_size
    goto :invalid
    :check_size
    invoke-interface {v1}, Ljava/util/List;->size()I
    move-result v3
    if-lt v2, v3, :read_item
    goto :invalid
    :read_item
    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v1

    instance-of v2, v0, Lbm/k;    # MARKER: R8 Lbm/k;
    if-eqz v2, :album
    instance-of v2, v1, Lbm/k;    # MARKER: R8 Lbm/k;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/k;    # MARKER: R8 Lbm/k;
    move-object v3, v1
    check-cast v3, Lbm/k;    # MARKER: R8 Lbm/k;
    iget-object v4, v3, Lbm/k;->e:Lcom/aspiro/wamp/model/Availability$MediaItem;    # MARKER: R8 Lbm/k; e
    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z
    move-result v4
    if-eqz v4, :invalid
    iget-object v2, v2, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lbm/k; a
    iget-object v3, v3, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lbm/k; a
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v3
    if-ne v2, v3, :invalid
    iget v4, p1, Lradiant/gestures/queue/QueueRequest;->id:I
    if-ne v3, v4, :invalid
    return-object v1

    :album
    instance-of v2, v0, Lbm/a;    # MARKER: R8 Lbm/a;
    if-eqz v2, :playlist
    instance-of v2, v1, Lbm/a;    # MARKER: R8 Lbm/a;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/a;    # MARKER: R8 Lbm/a;
    move-object v3, v1
    check-cast v3, Lbm/a;    # MARKER: R8 Lbm/a;
    iget-object v4, v3, Lbm/a;->c:Lcom/aspiro/wamp/model/Availability$Album;    # MARKER: R8 Lbm/a; c
    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$Album;->isAvailable()Z
    move-result v4
    if-eqz v4, :invalid
    iget-object v2, v2, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lbm/a; a
    iget-object v3, v3, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lbm/a; a
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Album;->getId()I
    move-result v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Album;->getId()I
    move-result v3
    if-ne v2, v3, :invalid
    iget v4, p1, Lradiant/gestures/queue/QueueRequest;->id:I
    if-ne v3, v4, :invalid
    return-object v1

    :playlist
    instance-of v2, v0, Lbm/g;    # MARKER: R8 Lbm/g;
    if-eqz v2, :mix
    instance-of v2, v1, Lbm/g;    # MARKER: R8 Lbm/g;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/g;    # MARKER: R8 Lbm/g;
    move-object v3, v1
    check-cast v3, Lbm/g;    # MARKER: R8 Lbm/g;
    iget-object v2, v2, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lbm/g; a
    iget-object v3, v3, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lbm/g; a
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I
    move-result v4
    if-lez v4, :invalid
    const-string v4, "NOT_READY"
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Playlist;->getStatus()Ljava/lang/String;
    move-result-object v5
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v4
    if-nez v4, :invalid
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :invalid
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I
    move-result v2
    iget v4, p1, Lradiant/gestures/queue/QueueRequest;->id:I
    if-ne v2, v4, :invalid

    iget-object v2, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;
    if-eqz v2, :invalid
    invoke-virtual {v2}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;    # MARKER: R8 Ltl/h; N
    move-result-object v2
    instance-of v4, v2, Lcom/aspiro/wamp/search/v2/d;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/d;
    if-eqz v4, :invalid
    check-cast v2, Lcom/aspiro/wamp/search/v2/d;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/d;
    iget-object v2, v2, Lcom/aspiro/wamp/search/v2/d;->e:Lcom/aspiro/wamp/model/AvailabilityInteractor;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/d; e
    invoke-static {v3}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;
    move-result-object v3
    invoke-interface {v2, v3}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getPlaylistAvailability(Ljava/util/UUID;)Lcom/aspiro/wamp/model/Availability$Playlist;
    move-result-object v2
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Availability$Playlist;->isAvailable()Z
    move-result v2
    if-eqz v2, :invalid
    return-object v1

    :mix
    instance-of v2, v0, Lbm/f;    # MARKER: R8 Lbm/f;
    if-eqz v2, :invalid
    instance-of v2, v1, Lbm/f;    # MARKER: R8 Lbm/f;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/f;    # MARKER: R8 Lbm/f;
    move-object v3, v1
    check-cast v3, Lbm/f;    # MARKER: R8 Lbm/f;
    iget-object v2, v2, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lbm/f; a
    iget-object v3, v3, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lbm/f; a
    invoke-virtual {v2}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :invalid
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I
    move-result v2
    iget v4, p1, Lradiant/gestures/queue/QueueRequest;->id:I
    if-ne v2, v4, :invalid

    iget-object v2, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;
    if-eqz v2, :invalid
    invoke-virtual {v2}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;    # MARKER: R8 Ltl/h; N
    move-result-object v2
    instance-of v4, v2, Lcom/aspiro/wamp/search/v2/d;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/d;
    if-eqz v4, :invalid
    check-cast v2, Lcom/aspiro/wamp/search/v2/d;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/d;
    iget-object v2, v2, Lcom/aspiro/wamp/search/v2/d;->e:Lcom/aspiro/wamp/model/AvailabilityInteractor;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/d; e
    invoke-interface {v2, v3}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getMixAvailability(Ljava/lang/String;)Lcom/aspiro/wamp/model/Availability$Mix;
    move-result-object v2
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Availability$Mix;->isAvailable()Z
    move-result v2
    if-eqz v2, :invalid
    return-object v1

    :invalid
    const/4 v0, 0x0
    return-object v0
.end method

.method public static install(Lcom/aspiro/wamp/search/v2/UnifiedSearchView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1
    if-eqz p0, :done
    if-eqz p1, :done
    new-instance v0, Lradiant/gestures/queue/UnifiedSearchResolver;
    invoke-direct {v0, p0, p1}, Lradiant/gestures/queue/UnifiedSearchResolver;-><init>(Lcom/aspiro/wamp/search/v2/UnifiedSearchView;Landroidx/recyclerview/widget/RecyclerView;)V
    invoke-static {p1, v0}, Lradiant/gestures/queue/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/gestures/queue/QueueRowResolver;)V
    :done
    return-void
.end method

# virtual methods
.method public execute(Lradiant/gestures/queue/QueueRequest;)V
    .locals 9

    iget v8, p1, Lradiant/gestures/queue/QueueRequest;->action:I

    invoke-direct {p0, p1}, Lradiant/gestures/queue/UnifiedSearchResolver;->current(Lradiant/gestures/queue/QueueRequest;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done

    iget-object v1, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;
    if-eqz v1, :done
    iget-object v2, v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->c:Ltl/q;    # MARKER: R8 Ltl/q; c
    if-eqz v2, :done

    invoke-static {v0}, Lbm/i;->a(Lbm/h;)Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;    # MARKER: R8 Lbm/i; Lbm/h; a
    move-result-object v3
    iget-object v4, v2, Ltl/q;->c:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Ltl/q; c

    instance-of v5, v0, Lbm/k;    # MARKER: R8 Lbm/k;
    if-eqz v5, :album
    move-object v5, v0
    check-cast v5, Lbm/k;    # MARKER: R8 Lbm/k;
    iget-object v6, v5, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lbm/k; a
    const/4 v7, 0x3
    if-eq v8, v7, :append_track
    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z
    move-result v7
    if-nez v7, :append_track
    new-instance v2, Lcom/aspiro/wamp/search/v2/a$g;    # MARKER: R8 Lcom/aspiro/wamp/search/v2/a$g;
    iget v3, p1, Lradiant/gestures/queue/QueueRequest;->position:I
    invoke-direct {v2, v0, v3}, Lcom/aspiro/wamp/search/v2/a$g;-><init>(Lbm/h;I)V    # MARKER: R8 Lcom/aspiro/wamp/search/v2/a$g; Lbm/h;
    invoke-virtual {v1}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;    # MARKER: R8 Ltl/h; N
    move-result-object v0
    invoke-interface {v0, v2}, Ltl/f;->e(Lcom/aspiro/wamp/search/v2/a;)V    # MARKER: R8 Ltl/f; Lcom/aspiro/wamp/search/v2/a; e
    goto :done

    :append_track
    const-string v7, ""
    iget-object p1, v5, Lbm/k;->n:Lcom/aspiro/wamp/search/SearchDataSource;    # MARKER: R8 Lbm/k; n
    sget-object v0, Lcom/aspiro/wamp/search/SearchDataSource;->REMOTE:Lcom/aspiro/wamp/search/SearchDataSource;
    if-ne p1, v0, :query_ready
    invoke-virtual {v1}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;    # MARKER: R8 Ltl/h; N
    move-result-object p1
    invoke-interface {p1}, Ltl/h;->c()Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;    # MARKER: R8 Ltl/h; c
    move-result-object p1
    iget-object v7, p1, Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;->a:Ljava/lang/String;    # MARKER: R8 a
    :query_ready
    invoke-virtual {v6}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result p1
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object p1
    const/4 v0, 0x0
    if-eqz v4, :nav_ready
    invoke-static {v4}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;    # MARKER: R8 Lcom/tidal/android/navigation/a; b
    move-result-object v0
    :nav_ready
    invoke-static {p1, v7, v0}, Lcom/aspiro/wamp/playqueue/source/model/b;->o(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/source/model/b; o
    move-result-object p1
    invoke-virtual {p1, v6}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v0
    const/4 v2, 0x3

    if-eq v8, v2, :add_to_playlist_track

    const/4 v2, 0x1

    if-ne v8, v2, :queue_append_track

    invoke-static {v0, v6, v3, p1}, Lradiant/gestures/queue/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :queue_append_track
    invoke-static {v0, v6, v3, p1}, Lradiant/gestures/queue/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z
    goto :done

    :add_to_playlist_track
    invoke-static {v0, v6, v3, p1}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V
    goto :done

    :album
    instance-of v5, v0, Lbm/a;    # MARKER: R8 Lbm/a;
    if-eqz v5, :playlist
    iget-object v5, v2, Ltl/q;->a:Lx40/a;    # MARKER: R8 Ltl/q; Lx40/a; a
    instance-of v6, v5, Lh4/a;    # MARKER: R8 Lh4/a;
    if-eqz v6, :done
    check-cast v5, Lh4/a;    # MARKER: R8 Lh4/a;
    check-cast v0, Lbm/a;    # MARKER: R8 Lbm/a;
    iget-object v6, v0, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lbm/a; a
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v7
    const/4 v0, 0x3

    if-eq v8, v0, :add_to_playlist_album

    const/4 v0, 0x1

    if-ne v8, v0, :append_album

    invoke-static {v7, v6, v3, v4, v5}, Lradiant/gestures/queue/QueueExecutor;->playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :append_album
    invoke-static {v7, v6, v3, v4, v5}, Lradiant/gestures/queue/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;
    move-result-object v0
    if-eqz v0, :done
    iget-object v1, v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->g:Lio/reactivex/disposables/CompositeDisposable;    # MARKER: R8 g
    invoke-virtual {v1, v0}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z
    goto :done

    :add_to_playlist_album
    invoke-static {v7, v6, v3, v4, v5}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;
    goto :done

    :playlist
    instance-of v5, v0, Lbm/g;    # MARKER: R8 Lbm/g;
    if-eqz v5, :mix
    check-cast v0, Lbm/g;    # MARKER: R8 Lbm/g;
    iget-object v5, v0, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lbm/g; a
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v6
    const/4 v0, 0x3

    if-eq v8, v0, :add_to_playlist_playlist

    const/4 v0, 0x1

    if-ne v8, v0, :append_playlist

    invoke-static {v6, v5, v3, v4}, Lradiant/gestures/queue/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append_playlist
    invoke-static {v6, v5, v3, v4}, Lradiant/gestures/queue/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    goto :done

    :add_to_playlist_playlist
    invoke-static {v6, v5, v3, v4}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    goto :done

    :mix
    instance-of v5, v0, Lbm/f;    # MARKER: R8 Lbm/f;
    if-eqz v5, :done
    iget-object v5, v2, Ltl/q;->a:Lx40/a;    # MARKER: R8 Ltl/q; Lx40/a; a
    instance-of v6, v5, Lh4/a;    # MARKER: R8 Lh4/a;
    if-eqz v6, :done
    check-cast v5, Lh4/a;    # MARKER: R8 Lh4/a;
    check-cast v0, Lbm/f;    # MARKER: R8 Lbm/f;
    iget-object v6, v0, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lbm/f; a
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v7
    const/4 v0, 0x3

    if-eq v8, v0, :add_to_playlist_mix

    const/4 v0, 0x1

    if-ne v8, v0, :append_mix

    invoke-static {v7, v6, v3, v4, v5}, Lradiant/gestures/queue/QueueExecutor;->playNextMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :append_mix
    invoke-static {v7, v6, v3, v4, v5}, Lradiant/gestures/queue/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;
    move-result-object v0
    if-eqz v0, :done
    iget-object v1, v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->g:Lio/reactivex/disposables/CompositeDisposable;    # MARKER: R8 g
    invoke-virtual {v1, v0}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z

    goto :done

    :add_to_playlist_mix
    invoke-static {v7, v6, v3, v4, v5}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/gestures/queue/QueueRequest;
    .locals 6

    iget-object v0, p0, Lradiant/gestures/queue/UnifiedSearchResolver;->recycler:Ljava/lang/ref/WeakReference;
    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v0
    if-ne v0, p1, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I
    move-result v0
    const/4 v1, -0x1
    if-ne v0, v1, :has_position
    goto :invalid
    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;
    move-result-object p1
    instance-of v1, p1, La50/d;    # MARKER: R8 La50/d;
    if-eqz v1, :invalid
    check-cast p1, La50/d;    # MARKER: R8 La50/d;
    invoke-virtual {p1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;
    move-result-object p1
    invoke-interface {p1}, Ljava/util/List;->size()I
    move-result v1
    if-lt v0, v1, :read_item
    goto :invalid
    :read_item
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object p1

    instance-of v1, p2, Lul/n0$a;    # MARKER: R8 Lul/n0$a;
    if-eqz v1, :album_holder
    instance-of v1, p1, Lbm/k;    # MARKER: R8 Lbm/k;
    if-eqz v1, :invalid
    move-object v1, p1
    check-cast v1, Lbm/k;    # MARKER: R8 Lbm/k;
    iget-object v1, v1, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lbm/k; a
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v1
    goto :create

    :album_holder
    instance-of v1, p2, Lul/d$a;    # MARKER: R8 Lul/d$a;
    if-eqz v1, :playlist_holder
    instance-of v1, p1, Lbm/a;    # MARKER: R8 Lbm/a;
    if-eqz v1, :invalid
    move-object v1, p1
    check-cast v1, Lbm/a;    # MARKER: R8 Lbm/a;
    iget-object v1, v1, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lbm/a; a
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Album;->getId()I
    move-result v1
    goto :create

    :playlist_holder
    instance-of v1, p2, Lul/a0$a;    # MARKER: R8 Lul/a0$a;
    if-eqz v1, :mix_holder
    instance-of v1, p1, Lbm/g;    # MARKER: R8 Lbm/g;
    if-eqz v1, :invalid
    move-object v1, p1
    check-cast v1, Lbm/g;    # MARKER: R8 Lbm/g;
    iget-object v1, v1, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lbm/g; a
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I
    move-result v1
    goto :create

    :mix_holder
    instance-of p2, p2, Lul/w$a;    # MARKER: R8 Lul/w$a;
    if-eqz p2, :invalid
    instance-of p2, p1, Lbm/f;    # MARKER: R8 Lbm/f;
    if-eqz p2, :invalid
    move-object p2, p1
    check-cast p2, Lbm/f;    # MARKER: R8 Lbm/f;
    iget-object p2, p2, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lbm/f; a
    invoke-virtual {p2}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;
    move-result-object p2
    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I
    move-result v1

    :create
    new-instance v2, Lradiant/gestures/queue/QueueRequest;
    invoke-direct {v2, v0, p1, v1}, Lradiant/gestures/queue/QueueRequest;-><init>(ILjava/lang/Object;I)V
    invoke-direct {p0, v2}, Lradiant/gestures/queue/UnifiedSearchResolver;->current(Lradiant/gestures/queue/QueueRequest;)Ljava/lang/Object;
    move-result-object p1
    if-eqz p1, :invalid
    return-object v2

    :invalid
    const/4 p1, 0x0
    return-object p1
.end method
