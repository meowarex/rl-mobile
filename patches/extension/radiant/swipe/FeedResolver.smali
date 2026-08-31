.class public final Lradiant/swipe/FeedResolver;
.super Ljava/lang/Object;
.source "FeedResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;

.field private final recycler:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lcom/tidal/android/feature/feed/ui/FeedView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/FeedResolver;->fragment:Ljava/lang/ref/WeakReference;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/FeedResolver;->recycler:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private availabilityInteractor()Lcom/aspiro/wamp/model/AvailabilityInteractor;
    .locals 2

    iget-object v0, p0, Lradiant/swipe/FeedResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/tidal/android/feature/feed/ui/FeedView;

    if-eqz v0, :invalid

    iget-object v0, v0, Lcom/tidal/android/feature/feed/ui/FeedView;->d:Lv70/b;

    instance-of v1, v0, Lcom/tidal/android/feature/feed/ui/c;

    if-eqz v1, :invalid

    check-cast v0, Lcom/tidal/android/feature/feed/ui/c;

    iget-object v0, v0, Lcom/tidal/android/feature/feed/ui/c;->c:Lz70/a;

    if-eqz v0, :invalid

    iget-object v0, v0, Lz70/a;->c:Lcom/aspiro/wamp/model/AvailabilityInteractor;

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method private current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    .locals 10

    if-eqz p1, :invalid

    iget-object v8, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    iget-object v0, p0, Lradiant/swipe/FeedResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/tidal/android/feature/feed/ui/FeedView;

    if-eqz v0, :invalid

    iget-object v1, p0, Lradiant/swipe/FeedResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v1, :invalid

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v2

    instance-of v3, v2, La50/b;

    if-eqz v3, :invalid

    check-cast v2, La50/b;

    iget-object v2, v2, La50/b;->b:Ljava/util/ArrayList;

    iget v3, p1, Lradiant/swipe/QueueRequest;->position:I

    if-gez v3, :check_size

    goto :invalid

    :check_size
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lt v3, v4, :read_item

    goto :invalid

    :read_item
    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-direct {p0}, Lradiant/swipe/FeedResolver;->availabilityInteractor()Lcom/aspiro/wamp/model/AvailabilityInteractor;

    move-result-object v4

    if-eqz v4, :invalid

    instance-of v3, v2, Lb80/a;

    if-eqz v3, :mix

    instance-of v3, v8, Lcom/aspiro/wamp/model/Album;

    if-eqz v3, :invalid

    check-cast v2, Lb80/a;

    iget-boolean v3, v2, Lb80/a;->c:Z

    if-eqz v3, :invalid

    check-cast v8, Lcom/aspiro/wamp/model/Album;

    iget-object v5, v2, Lb80/a;->a:Lcom/aspiro/wamp/model/Album;

    invoke-virtual {v8}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v6

    invoke-virtual {v5}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v7

    if-ne v6, v7, :invalid

    iget v6, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v7, v6, :invalid

    invoke-interface {v4, v5}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getAvailability(Lcom/aspiro/wamp/model/Album;)Lcom/aspiro/wamp/model/Availability$Album;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$Album;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    return-object v2

    :mix
    instance-of v3, v2, Lb80/c;

    if-eqz v3, :playlist

    instance-of v3, v8, Lcom/aspiro/wamp/mix/model/Mix;

    if-eqz v3, :invalid

    check-cast v2, Lb80/c;

    check-cast v8, Lcom/aspiro/wamp/mix/model/Mix;

    iget-object v5, v2, Lb80/c;->a:Lcom/aspiro/wamp/mix/model/Mix;

    invoke-virtual {v8}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :invalid

    invoke-virtual {v7}, Ljava/lang/String;->hashCode()I

    move-result v6

    iget v8, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v6, v8, :invalid

    invoke-interface {v4, v7}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getMixAvailability(Ljava/lang/String;)Lcom/aspiro/wamp/model/Availability$Mix;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$Mix;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    return-object v2

    :playlist
    instance-of v3, v2, Lb80/d;

    if-eqz v3, :invalid

    instance-of v3, v8, Lcom/aspiro/wamp/model/Playlist;

    if-eqz v3, :invalid

    check-cast v2, Lb80/d;

    check-cast v8, Lcom/aspiro/wamp/model/Playlist;

    iget-object v5, v2, Lb80/d;->a:Lcom/aspiro/wamp/model/Playlist;

    invoke-virtual {v8}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :invalid

    invoke-virtual {v7}, Ljava/lang/String;->hashCode()I

    move-result v6

    iget v8, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v6, v8, :invalid

    invoke-virtual {v5}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I

    move-result v6

    if-lez v6, :invalid

    const-string v6, "NOT_READY"

    invoke-virtual {v5}, Lcom/aspiro/wamp/model/Playlist;->getStatus()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :invalid

    invoke-static {v7}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v6

    invoke-interface {v4, v6}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getPlaylistAvailability(Ljava/util/UUID;)Lcom/aspiro/wamp/model/Availability$Playlist;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$Playlist;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    return-object v2

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Lcom/tidal/android/feature/feed/ui/FeedView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/swipe/FeedResolver;

    invoke-direct {v0, p0, p1}, Lradiant/swipe/FeedResolver;-><init>(Lcom/tidal/android/feature/feed/ui/FeedView;Landroidx/recyclerview/widget/RecyclerView;)V

    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 9

    invoke-direct {p0, p1}, Lradiant/swipe/FeedResolver;->current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :done

    iget-object v1, p0, Lradiant/swipe/FeedResolver;->fragment:Ljava/lang/ref/WeakReference;

    iget p0, p1, Lradiant/swipe/QueueRequest;->action:I

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/tidal/android/feature/feed/ui/FeedView;

    if-eqz v1, :done

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v3

    if-eqz v3, :done

    iget-object v2, v1, Lcom/tidal/android/feature/feed/ui/FeedView;->c:La80/c;

    if-eqz v2, :done

    instance-of v4, v0, Lb80/a;

    if-eqz v4, :mix

    check-cast v0, Lb80/a;

    iget-object v7, v0, Lb80/a;->a:Lcom/aspiro/wamp/model/Album;

    iget v8, v0, Lb80/a;->g:I

    const/4 v4, 0x1

    goto :metadata

    :mix
    instance-of v4, v0, Lb80/c;

    if-eqz v4, :playlist

    check-cast v0, Lb80/c;

    iget-object v7, v0, Lb80/c;->a:Lcom/aspiro/wamp/mix/model/Mix;

    iget v8, v0, Lb80/c;->c:I

    const/4 v4, 0x2

    goto :metadata

    :playlist
    check-cast v0, Lb80/d;

    iget-object v7, v0, Lb80/d;->a:Lcom/aspiro/wamp/model/Playlist;

    iget v8, v0, Lb80/d;->c:I

    const/4 v4, 0x3

    :metadata
    invoke-static {v8}, Lcom/tidal/android/feature/feed/ui/viewstates/UpdatedIntervals$a;->a(I)Ljava/lang/String;

    move-result-object v8

    iget-object v0, v2, La80/c;->a:Ljava/lang/String;

    new-instance p1, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    invoke-direct {p1, v0, v8}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v5, v2, La80/c;->e:Lcom/tidal/android/navigation/NavigationInfo;

    const/4 v0, 0x3

    if-ne v4, v0, :collection

    check-cast v7, Lcom/aspiro/wamp/model/Playlist;

    const/4 v0, 0x1

    if-ne p0, v0, :append_playlist

    invoke-static {v3, v7, p1, v5}, Lradiant/swipe/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append_playlist
    invoke-static {v3, v7, p1, v5}, Lradiant/swipe/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :collection
    iget-object v6, v2, La80/c;->b:Lx40/a;

    instance-of v0, v6, Lh4/a;

    if-eqz v0, :done

    check-cast v6, Lh4/a;

    const/4 v0, 0x1

    if-ne v4, v0, :queue_mix

    check-cast v7, Lcom/aspiro/wamp/model/Album;

    const/4 v0, 0x1

    if-ne p0, v0, :append_album

    invoke-static {v3, v7, p1, v5, v6}, Lradiant/swipe/QueueExecutor;->playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;

    move-result-object v7

    goto :retain

    :append_album
    invoke-static {v3, v7, p1, v5, v6}, Lradiant/swipe/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;

    move-result-object v7

    goto :retain

    :queue_mix
    check-cast v7, Lcom/aspiro/wamp/mix/model/Mix;

    const/4 v0, 0x1

    if-ne p0, v0, :append_mix

    invoke-static {v3, v7, p1, v5, v6}, Lradiant/swipe/QueueExecutor;->playNextMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;

    move-result-object v7

    goto :retain

    :append_mix
    invoke-static {v3, v7, p1, v5, v6}, Lradiant/swipe/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;

    move-result-object v7

    :retain
    if-eqz v7, :done

    iget-object v0, v1, Lcom/tidal/android/feature/feed/ui/FeedView;->f:Lio/reactivex/disposables/CompositeDisposable;

    invoke-virtual {v0, v7}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 7

    iget-object v0, p0, Lradiant/swipe/FeedResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :invalid

    instance-of v0, p2, Lw70/c$a;

    if-eqz v0, :mix_holder

    const/4 v5, 0x1

    goto :has_holder

    :mix_holder

    instance-of v0, p2, Lw70/h$a;

    if-eqz v0, :playlist_holder

    const/4 v5, 0x2

    goto :has_holder

    :playlist_holder

    instance-of v0, p2, Lw70/k$a;

    if-eqz v0, :invalid

    const/4 v5, 0x3

    :has_holder
    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p2

    if-gez p2, :has_position

    goto :invalid

    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object p1

    instance-of v0, p1, La50/b;

    if-eqz v0, :invalid

    check-cast p1, La50/b;

    iget-object p1, p1, La50/b;->b:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p2, v0, :read_item

    goto :invalid

    :read_item
    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lb80/a;

    if-eqz v0, :mix

    const/4 v0, 0x1

    if-ne v5, v0, :invalid

    check-cast p1, Lb80/a;

    iget-object v1, p1, Lb80/a;->a:Lcom/aspiro/wamp/model/Album;

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v2

    goto :request

    :mix
    instance-of v0, p1, Lb80/c;

    if-eqz v0, :playlist

    const/4 v0, 0x2

    if-ne v5, v0, :invalid

    check-cast p1, Lb80/c;

    iget-object v1, p1, Lb80/c;->a:Lcom/aspiro/wamp/mix/model/Mix;

    invoke-virtual {v1}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    goto :request

    :playlist
    instance-of v0, p1, Lb80/d;

    if-eqz v0, :invalid

    const/4 v0, 0x3

    if-ne v5, v0, :invalid

    check-cast p1, Lb80/d;

    iget-object v1, p1, Lb80/d;->a:Lcom/aspiro/wamp/model/Playlist;

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    :request
    new-instance v3, Lradiant/swipe/QueueRequest;

    invoke-direct {v3, p2, v1, v2}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    invoke-direct {p0, v3}, Lradiant/swipe/FeedResolver;->current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :invalid

    return-object v3

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
