.class public final Lradiant/swipe/UnifiedSearchResolver;
.super Ljava/lang/Object;
.source "UnifiedSearchResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;

# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;
.field private final recycler:Ljava/lang/ref/WeakReference;

# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/search/v2/UnifiedSearchView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lradiant/swipe/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lradiant/swipe/UnifiedSearchResolver;->recycler:Ljava/lang/ref/WeakReference;
    return-void
.end method

.method private current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    .locals 7

    if-eqz p1, :invalid
    iget-object v0, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    iget-object v1, p0, Lradiant/swipe/UnifiedSearchResolver;->recycler:Ljava/lang/ref/WeakReference;
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;
    if-eqz v1, :invalid
    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;
    move-result-object v1
    instance-of v2, v1, La50/d;
    if-eqz v2, :invalid
    check-cast v1, La50/d;
    invoke-virtual {v1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;
    move-result-object v1

    iget v2, p1, Lradiant/swipe/QueueRequest;->position:I
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

    instance-of v2, v0, Lbm/k;
    if-eqz v2, :album
    instance-of v2, v1, Lbm/k;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/k;
    move-object v3, v1
    check-cast v3, Lbm/k;
    iget-object v4, v3, Lbm/k;->e:Lcom/aspiro/wamp/model/Availability$MediaItem;
    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z
    move-result v4
    if-eqz v4, :invalid
    iget-object v2, v2, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;
    iget-object v3, v3, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v3
    if-ne v2, v3, :invalid
    iget v4, p1, Lradiant/swipe/QueueRequest;->id:I
    if-ne v3, v4, :invalid
    return-object v1

    :album
    instance-of v2, v0, Lbm/a;
    if-eqz v2, :playlist
    instance-of v2, v1, Lbm/a;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/a;
    move-object v3, v1
    check-cast v3, Lbm/a;
    iget-object v4, v3, Lbm/a;->c:Lcom/aspiro/wamp/model/Availability$Album;
    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$Album;->isAvailable()Z
    move-result v4
    if-eqz v4, :invalid
    iget-object v2, v2, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;
    iget-object v3, v3, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Album;->getId()I
    move-result v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/Album;->getId()I
    move-result v3
    if-ne v2, v3, :invalid
    iget v4, p1, Lradiant/swipe/QueueRequest;->id:I
    if-ne v3, v4, :invalid
    return-object v1

    :playlist
    instance-of v2, v0, Lbm/g;
    if-eqz v2, :mix
    instance-of v2, v1, Lbm/g;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/g;
    move-object v3, v1
    check-cast v3, Lbm/g;
    iget-object v2, v2, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;
    iget-object v3, v3, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;
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
    iget v4, p1, Lradiant/swipe/QueueRequest;->id:I
    if-ne v2, v4, :invalid

    iget-object v2, p0, Lradiant/swipe/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;
    if-eqz v2, :invalid
    invoke-virtual {v2}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;
    move-result-object v2
    instance-of v4, v2, Lcom/aspiro/wamp/search/v2/d;
    if-eqz v4, :invalid
    check-cast v2, Lcom/aspiro/wamp/search/v2/d;
    iget-object v2, v2, Lcom/aspiro/wamp/search/v2/d;->e:Lcom/aspiro/wamp/model/AvailabilityInteractor;
    invoke-static {v3}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;
    move-result-object v3
    invoke-interface {v2, v3}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getPlaylistAvailability(Ljava/util/UUID;)Lcom/aspiro/wamp/model/Availability$Playlist;
    move-result-object v2
    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Availability$Playlist;->isAvailable()Z
    move-result v2
    if-eqz v2, :invalid
    return-object v1

    :mix
    instance-of v2, v0, Lbm/f;
    if-eqz v2, :invalid
    instance-of v2, v1, Lbm/f;
    if-eqz v2, :invalid
    move-object v2, v0
    check-cast v2, Lbm/f;
    move-object v3, v1
    check-cast v3, Lbm/f;
    iget-object v2, v2, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;
    iget-object v3, v3, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;
    invoke-virtual {v2}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v3}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :invalid
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I
    move-result v2
    iget v4, p1, Lradiant/swipe/QueueRequest;->id:I
    if-ne v2, v4, :invalid

    iget-object v2, p0, Lradiant/swipe/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;
    if-eqz v2, :invalid
    invoke-virtual {v2}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;
    move-result-object v2
    instance-of v4, v2, Lcom/aspiro/wamp/search/v2/d;
    if-eqz v4, :invalid
    check-cast v2, Lcom/aspiro/wamp/search/v2/d;
    iget-object v2, v2, Lcom/aspiro/wamp/search/v2/d;->e:Lcom/aspiro/wamp/model/AvailabilityInteractor;
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
    new-instance v0, Lradiant/swipe/UnifiedSearchResolver;
    invoke-direct {v0, p0, p1}, Lradiant/swipe/UnifiedSearchResolver;-><init>(Lcom/aspiro/wamp/search/v2/UnifiedSearchView;Landroidx/recyclerview/widget/RecyclerView;)V
    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V
    :done
    return-void
.end method

# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 8

    invoke-direct {p0, p1}, Lradiant/swipe/UnifiedSearchResolver;->current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done

    iget-object v1, p0, Lradiant/swipe/UnifiedSearchResolver;->fragment:Ljava/lang/ref/WeakReference;
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;
    if-eqz v1, :done
    iget-object v2, v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->c:Ltl/q;
    if-eqz v2, :done

    invoke-static {v0}, Lbm/i;->a(Lbm/h;)Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;
    move-result-object v3
    iget-object v4, v2, Ltl/q;->c:Lcom/tidal/android/navigation/NavigationInfo;

    instance-of v5, v0, Lbm/k;
    if-eqz v5, :album
    move-object v5, v0
    check-cast v5, Lbm/k;
    iget-object v6, v5, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;
    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z
    move-result v7
    if-nez v7, :append_track
    new-instance v2, Lcom/aspiro/wamp/search/v2/a$g;
    iget v3, p1, Lradiant/swipe/QueueRequest;->position:I
    invoke-direct {v2, v0, v3}, Lcom/aspiro/wamp/search/v2/a$g;-><init>(Lbm/h;I)V
    invoke-virtual {v1}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;
    move-result-object v0
    invoke-interface {v0, v2}, Ltl/f;->e(Lcom/aspiro/wamp/search/v2/a;)V
    goto :done

    :append_track
    const-string v7, ""
    iget-object p1, v5, Lbm/k;->n:Lcom/aspiro/wamp/search/SearchDataSource;
    sget-object v0, Lcom/aspiro/wamp/search/SearchDataSource;->REMOTE:Lcom/aspiro/wamp/search/SearchDataSource;
    if-ne p1, v0, :query_ready
    invoke-virtual {v1}, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->N()Ltl/h;
    move-result-object p1
    invoke-interface {p1}, Ltl/h;->c()Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;
    move-result-object p1
    iget-object v7, p1, Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;->a:Ljava/lang/String;
    :query_ready
    invoke-virtual {v6}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result p1
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object p1
    const/4 v0, 0x0
    if-eqz v4, :nav_ready
    invoke-static {v4}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;
    move-result-object v0
    :nav_ready
    invoke-static {p1, v7, v0}, Lcom/aspiro/wamp/playqueue/source/model/b;->o(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;
    move-result-object p1
    invoke-virtual {p1, v6}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v0
    invoke-static {v0, v6, v3, p1}, Lradiant/swipe/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z
    goto :done

    :album
    instance-of v5, v0, Lbm/a;
    if-eqz v5, :playlist
    iget-object v5, v2, Ltl/q;->a:Lx40/a;
    instance-of v6, v5, Lh4/a;
    if-eqz v6, :done
    check-cast v5, Lh4/a;
    check-cast v0, Lbm/a;
    iget-object v6, v0, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v7
    invoke-static {v7, v6, v3, v4, v5}, Lradiant/swipe/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;
    move-result-object v0
    if-eqz v0, :done
    iget-object v1, v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->g:Lio/reactivex/disposables/CompositeDisposable;
    invoke-virtual {v1, v0}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z
    goto :done

    :playlist
    instance-of v5, v0, Lbm/g;
    if-eqz v5, :mix
    check-cast v0, Lbm/g;
    iget-object v5, v0, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v6
    invoke-static {v6, v5, v3, v4}, Lradiant/swipe/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    goto :done

    :mix
    instance-of v5, v0, Lbm/f;
    if-eqz v5, :done
    iget-object v5, v2, Ltl/q;->a:Lx40/a;
    instance-of v6, v5, Lh4/a;
    if-eqz v6, :done
    check-cast v5, Lh4/a;
    check-cast v0, Lbm/f;
    iget-object v6, v0, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v7
    invoke-static {v7, v6, v3, v4, v5}, Lradiant/swipe/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;
    move-result-object v0
    if-eqz v0, :done
    iget-object v1, v1, Lcom/aspiro/wamp/search/v2/UnifiedSearchView;->g:Lio/reactivex/disposables/CompositeDisposable;
    invoke-virtual {v1, v0}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 6

    iget-object v0, p0, Lradiant/swipe/UnifiedSearchResolver;->recycler:Ljava/lang/ref/WeakReference;
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
    instance-of v1, p1, La50/d;
    if-eqz v1, :invalid
    check-cast p1, La50/d;
    invoke-virtual {p1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;
    move-result-object p1
    invoke-interface {p1}, Ljava/util/List;->size()I
    move-result v1
    if-lt v0, v1, :read_item
    goto :invalid
    :read_item
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object p1

    instance-of v1, p2, Lul/n0$a;
    if-eqz v1, :album_holder
    instance-of v1, p1, Lbm/k;
    if-eqz v1, :invalid
    move-object v1, p1
    check-cast v1, Lbm/k;
    iget-object v1, v1, Lbm/k;->a:Lcom/aspiro/wamp/model/Track;
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v1
    goto :create

    :album_holder
    instance-of v1, p2, Lul/d$a;
    if-eqz v1, :playlist_holder
    instance-of v1, p1, Lbm/a;
    if-eqz v1, :invalid
    move-object v1, p1
    check-cast v1, Lbm/a;
    iget-object v1, v1, Lbm/a;->a:Lcom/aspiro/wamp/model/Album;
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Album;->getId()I
    move-result v1
    goto :create

    :playlist_holder
    instance-of v1, p2, Lul/a0$a;
    if-eqz v1, :mix_holder
    instance-of v1, p1, Lbm/g;
    if-eqz v1, :invalid
    move-object v1, p1
    check-cast v1, Lbm/g;
    iget-object v1, v1, Lbm/g;->a:Lcom/aspiro/wamp/model/Playlist;
    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I
    move-result v1
    goto :create

    :mix_holder
    instance-of p2, p2, Lul/w$a;
    if-eqz p2, :invalid
    instance-of p2, p1, Lbm/f;
    if-eqz p2, :invalid
    move-object p2, p1
    check-cast p2, Lbm/f;
    iget-object p2, p2, Lbm/f;->a:Lcom/aspiro/wamp/mix/model/Mix;
    invoke-virtual {p2}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;
    move-result-object p2
    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I
    move-result v1

    :create
    new-instance v2, Lradiant/swipe/QueueRequest;
    invoke-direct {v2, v0, p1, v1}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V
    invoke-direct {p0, v2}, Lradiant/swipe/UnifiedSearchResolver;->current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    move-result-object p1
    if-eqz p1, :invalid
    return-object v2

    :invalid
    const/4 p1, 0x0
    return-object p1
.end method
