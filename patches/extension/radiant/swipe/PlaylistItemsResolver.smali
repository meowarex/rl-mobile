.class public final Lradiant/swipe/PlaylistItemsResolver;
.super Ljava/lang/Object;
.source "PlaylistItemsResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;

# instance fields
.field private final recycler:Ljava/lang/ref/WeakReference;

# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lradiant/swipe/PlaylistItemsResolver;->recycler:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    .locals 7

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    iget-object v1, p0, Lradiant/swipe/PlaylistItemsResolver;->recycler:Ljava/lang/ref/WeakReference;
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;
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

    instance-of v3, v0, Lcom/aspiro/wamp/playlist/viewmodel/item/TrackViewModel;
    if-eqz v3, :captured_podcast
    instance-of v3, v2, Lcom/aspiro/wamp/playlist/viewmodel/item/TrackViewModel;
    if-eqz v3, :invalid
    goto :member

    :captured_podcast
    instance-of v3, v0, Lcom/aspiro/wamp/playlist/viewmodel/item/PodcastTrackViewModel;
    if-eqz v3, :captured_suggestion
    instance-of v3, v2, Lcom/aspiro/wamp/playlist/viewmodel/item/PodcastTrackViewModel;
    if-eqz v3, :invalid

    :member
    move-object v3, v0
    check-cast v3, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;
    move-object v4, v2
    check-cast v4, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;

    invoke-interface {v4}, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;->getShouldHideItem()Z
    move-result v5
    if-nez v5, :invalid

    invoke-interface {v4}, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;->getAvailability()Lcom/aspiro/wamp/model/Availability$MediaItem;
    move-result-object v5
    invoke-virtual {v5}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z
    move-result v5
    if-eqz v5, :invalid

    invoke-interface {v3}, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;->getUuid()Ljava/lang/String;
    move-result-object v5
    invoke-interface {v4}, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;->getUuid()Ljava/lang/String;
    move-result-object v6
    if-eq v5, v6, :member_identity
    if-eqz v5, :invalid
    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :invalid

    :member_identity
    invoke-static {v0}, Lradiant/swipe/PlaylistItemsResolver;->track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    move-result-object v0
    invoke-static {v2}, Lradiant/swipe/PlaylistItemsResolver;->track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    move-result-object v3
    if-eqz v0, :invalid
    if-eqz v3, :invalid

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/MediaItem;->getIndex()I
    move-result v4
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getIndex()I
    move-result v5
    if-ne v4, v5, :invalid
    goto :check_track

    :captured_suggestion
    instance-of v3, v0, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    if-eqz v3, :invalid
    instance-of v3, v2, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    if-eqz v3, :invalid

    move-object v3, v2
    check-cast v3, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    invoke-virtual {v3}, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;->getAvailability()Lcom/aspiro/wamp/model/Availability;
    move-result-object v3
    invoke-interface {v3}, Lcom/aspiro/wamp/model/Availability;->isAvailable()Z
    move-result v3
    if-eqz v3, :invalid

    invoke-static {v0}, Lradiant/swipe/PlaylistItemsResolver;->track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    move-result-object v0
    invoke-static {v2}, Lradiant/swipe/PlaylistItemsResolver;->track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    move-result-object v3
    if-eqz v0, :invalid
    if-eqz v3, :invalid

    :check_track
    invoke-virtual {v0}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v4
    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v5
    if-ne v4, v5, :invalid
    iget v6, p1, Lradiant/swipe/QueueRequest;->id:I
    if-ne v5, v6, :invalid

    iget-object v4, v1, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;->d:Lcom/aspiro/wamp/model/AvailabilityInteractor;
    if-eqz v4, :invalid
    invoke-interface {v4, v3}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getAvailability(Lcom/aspiro/wamp/model/MediaItem;)Lcom/aspiro/wamp/model/Availability$MediaItem;
    move-result-object v4
    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z
    move-result v4
    if-eqz v4, :invalid

    return-object v2

    :invalid
    const/4 v0, 0x0
    return-object v0
.end method

.method public static install(Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;)V
    .locals 1

    if-eqz p0, :done
    new-instance v0, Lradiant/swipe/PlaylistItemsResolver;
    invoke-direct {v0, p0}, Lradiant/swipe/PlaylistItemsResolver;-><init>(Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;)V
    invoke-static {p0, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method

.method private playlistIndex(Lradiant/swipe/QueueRequest;)I
    .locals 6

    iget-object v0, p0, Lradiant/swipe/PlaylistItemsResolver;->recycler:Ljava/lang/ref/WeakReference;
    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;
    if-eqz v0, :invalid

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;
    move-result-object v0
    instance-of v1, v0, La50/b;
    if-eqz v1, :invalid
    check-cast v0, La50/b;
    iget-object v0, v0, La50/b;->b:Ljava/util/ArrayList;

    iget v1, p1, Lradiant/swipe/QueueRequest;->position:I
    const/4 v2, 0x0
    const/4 v3, 0x0

    :loop
    if-ge v2, v1, :done
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
    move-result-object v4
    instance-of v5, v4, Lcom/aspiro/wamp/playlist/viewmodel/item/PlaylistItemViewModel;
    if-eqz v5, :next
    add-int/lit8 v3, v3, 0x1

    :next
    add-int/lit8 v2, v2, 0x1
    goto :loop

    :done
    return v3

    :invalid
    const/4 v0, -0x1
    return v0
.end method

.method private static track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    .locals 1

    instance-of v0, p0, Lcom/aspiro/wamp/playlist/viewmodel/item/TrackViewModel;
    if-eqz v0, :podcast
    check-cast p0, Lcom/aspiro/wamp/playlist/viewmodel/item/TrackViewModel;
    invoke-virtual {p0}, Lcom/aspiro/wamp/playlist/viewmodel/item/TrackViewModel;->getTrack()Lcom/aspiro/wamp/model/Track;
    move-result-object p0
    return-object p0

    :podcast
    instance-of v0, p0, Lcom/aspiro/wamp/playlist/viewmodel/item/PodcastTrackViewModel;
    if-eqz v0, :suggestion
    check-cast p0, Lcom/aspiro/wamp/playlist/viewmodel/item/PodcastTrackViewModel;
    invoke-virtual {p0}, Lcom/aspiro/wamp/playlist/viewmodel/item/PodcastTrackViewModel;->getItem()Lcom/aspiro/wamp/model/MediaItemParent;
    move-result-object p0
    invoke-virtual {p0}, Lcom/aspiro/wamp/model/MediaItemParent;->getMediaItem()Lcom/aspiro/wamp/model/MediaItem;
    move-result-object p0
    instance-of v0, p0, Lcom/aspiro/wamp/model/Track;
    if-eqz v0, :invalid
    check-cast p0, Lcom/aspiro/wamp/model/Track;
    return-object p0

    :suggestion
    instance-of v0, p0, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    if-eqz v0, :invalid
    check-cast p0, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    invoke-virtual {p0}, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;->getTrack()Lcom/aspiro/wamp/model/Track;
    move-result-object p0
    return-object p0

    :invalid
    const/4 p0, 0x0
    return-object p0
.end method

# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 9

    iget v8, p1, Lradiant/swipe/QueueRequest;->action:I

    invoke-direct {p0, p1}, Lradiant/swipe/PlaylistItemsResolver;->current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done
    invoke-static {v0}, Lradiant/swipe/PlaylistItemsResolver;->track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    move-result-object v1
    if-eqz v1, :done

    iget-object v2, p0, Lradiant/swipe/PlaylistItemsResolver;->recycler:Ljava/lang/ref/WeakReference;
    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;
    if-eqz v2, :done

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z
    move-result v3
    if-eqz v3, :play

    instance-of v3, v0, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    if-eqz v3, :append_member

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v3
    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v3
    sget v4, Lcom/aspiro/wamp/R$string;->recommended_tracks:I
    invoke-static {v4}, Lcom/aspiro/wamp/util/h0;->c(I)Ljava/lang/String;
    move-result-object v4
    iget-object v5, v2, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;->h:Lcom/tidal/android/navigation/NavigationInfo;
    sget-object v6, Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$None;->INSTANCE:Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$None;
    invoke-static {v3, v4, v5, v6}, Lcom/aspiro/wamp/playqueue/source/model/b;->j(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;
    move-result-object v7
    invoke-virtual {v7, v1}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V
    sget-object v6, Lcom/aspiro/wamp/playlist/ui/items/ModuleMetadata$Suggestions;->INSTANCE:Lcom/aspiro/wamp/playlist/ui/items/ModuleMetadata$Suggestions;
    goto :append

    :append_member
    iget-object v3, v2, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;->c:Lcom/aspiro/wamp/playlist/ui/items/a;
    if-eqz v3, :done
    invoke-interface {v3}, Lcom/aspiro/wamp/playlist/ui/items/a;->k()Lcom/aspiro/wamp/playlist/viewmodel/PlaylistCollectionViewModel;
    move-result-object v3
    invoke-virtual {v3}, Lcom/aspiro/wamp/playlist/viewmodel/PlaylistCollectionViewModel;->getPlaylist()Lcom/aspiro/wamp/model/Playlist;
    move-result-object v3
    if-eqz v3, :done
    iget-object v4, v2, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;->h:Lcom/tidal/android/navigation/NavigationInfo;
    if-eqz v4, :member_nav_ready
    invoke-static {v4}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;
    move-result-object v4
    :member_nav_ready
    invoke-static {v3, v4}, Lcom/aspiro/wamp/playqueue/source/model/b;->f(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/PlaylistSource;
    move-result-object v7
    invoke-virtual {v7, v1}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V
    sget-object v6, Lcom/aspiro/wamp/playlist/ui/items/ModuleMetadata$Items;->INSTANCE:Lcom/aspiro/wamp/playlist/ui/items/ModuleMetadata$Items;

    :append
    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;
    move-result-object v3
    const/4 v0, 0x1

    if-ne v8, v0, :append_track

    invoke-static {v3, v1, v6, v7}, Lradiant/swipe/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :append_track
    invoke-static {v3, v1, v6, v7}, Lradiant/swipe/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z
    goto :done

    :play
    iget-object v3, v2, Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;->c:Lcom/aspiro/wamp/playlist/ui/items/a;
    if-eqz v3, :done
    instance-of v0, v0, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    if-eqz v0, :play_member
    invoke-interface {v3, v1}, Lcom/aspiro/wamp/playlist/ui/items/a;->c(Lcom/aspiro/wamp/model/Track;)V
    goto :done

    :play_member
    invoke-direct {p0, p1}, Lradiant/swipe/PlaylistItemsResolver;->playlistIndex(Lradiant/swipe/QueueRequest;)I
    move-result v0
    if-gez v0, :start_member
    goto :done
    :start_member
    invoke-interface {v3, v0}, Lcom/aspiro/wamp/playlist/ui/items/a;->i(I)V

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    iget-object v0, p0, Lradiant/swipe/PlaylistItemsResolver;->recycler:Ljava/lang/ref/WeakReference;
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
    instance-of v1, p1, La50/b;
    if-eqz v1, :invalid
    check-cast p1, La50/b;
    iget-object p1, p1, La50/b;->b:Ljava/util/ArrayList;
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I
    move-result v1
    if-lt v0, v1, :read_item
    goto :invalid

    :read_item
    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
    move-result-object p1

    instance-of v1, p2, Lij/q$a;
    if-eqz v1, :podcast_holder
    instance-of v1, p1, Lcom/aspiro/wamp/playlist/viewmodel/item/TrackViewModel;
    if-eqz v1, :invalid
    goto :create

    :podcast_holder
    instance-of v1, p2, Lij/a0$a;
    if-eqz v1, :suggestion_holder
    instance-of v1, p1, Lcom/aspiro/wamp/playlist/viewmodel/item/PodcastTrackViewModel;
    if-eqz v1, :invalid
    goto :create

    :suggestion_holder
    instance-of p2, p2, Lij/j0$a;
    if-eqz p2, :invalid
    instance-of p2, p1, Lcom/aspiro/wamp/playlist/viewmodel/item/SuggestedTrackViewModel;
    if-eqz p2, :invalid

    :create
    invoke-static {p1}, Lradiant/swipe/PlaylistItemsResolver;->track(Ljava/lang/Object;)Lcom/aspiro/wamp/model/Track;
    move-result-object p2
    if-eqz p2, :invalid
    invoke-virtual {p2}, Lcom/aspiro/wamp/model/MediaItem;->getId()I
    move-result v1
    new-instance v2, Lradiant/swipe/QueueRequest;
    invoke-direct {v2, v0, p1, v1}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V
    invoke-direct {p0, v2}, Lradiant/swipe/PlaylistItemsResolver;->current(Lradiant/swipe/QueueRequest;)Ljava/lang/Object;
    move-result-object p1
    if-eqz p1, :invalid
    return-object v2

    :invalid
    const/4 p1, 0x0
    return-object p1
.end method
