.class public final Lradiant/gestures/queue/SuggestionsResolver;
.super Ljava/lang/Object;
.source "SuggestionsResolver.smali"

# interfaces
.implements Lradiant/gestures/queue/QueueRowResolver;


# instance fields
.field private final host:Ljava/lang/ref/WeakReference;

.field private final recycler:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Landroidx/fragment/app/Fragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/gestures/queue/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/gestures/queue/SuggestionsResolver;->recycler:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/gestures/queue/QueueRequest;)Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;
    .locals 8

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/gestures/queue/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    iget-object v1, p0, Lradiant/gestures/queue/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Landroidx/fragment/app/Fragment;

    if-eqz v2, :invalid

    check-cast v1, Landroidx/fragment/app/Fragment;

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :invalid

    iget-object v2, p0, Lradiant/gestures/queue/SuggestionsResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v2, :invalid

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v2

    instance-of v3, v2, La50/b;    # MARKER: R8 La50/b;

    if-eqz v3, :invalid

    check-cast v2, La50/b;    # MARKER: R8 La50/b;

    iget-object v2, v2, La50/b;->b:Ljava/util/ArrayList;    # MARKER: R8 La50/b; b

    iget v3, p1, Lradiant/gestures/queue/QueueRequest;->position:I

    if-gez v3, :adapter_bounds

    goto :invalid

    :adapter_bounds
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lt v3, v4, :adapter_item

    goto :invalid

    :adapter_item
    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    instance-of v4, v2, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    if-eqz v4, :invalid

    check-cast v2, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getMediaItem()Lcom/aspiro/wamp/model/Track;

    move-result-object v4

    invoke-virtual {v2}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getMediaItem()Lcom/aspiro/wamp/model/Track;

    move-result-object v5

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v4

    invoke-virtual {v5}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v6

    if-ne v4, v6, :invalid

    iget v7, p1, Lradiant/gestures/queue/QueueRequest;->id:I

    if-ne v6, v7, :invalid

    invoke-virtual {v2}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getAvailability()Lcom/aspiro/wamp/model/Availability;

    move-result-object v4

    invoke-interface {v4}, Lcom/aspiro/wamp/model/Availability;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    invoke-direct {p0}, Lradiant/gestures/queue/SuggestionsResolver;->availability()Lcom/aspiro/wamp/model/AvailabilityInteractor;

    move-result-object v4

    if-eqz v4, :invalid

    invoke-interface {v4, v5}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getAvailability(Lcom/aspiro/wamp/model/MediaItem;)Lcom/aspiro/wamp/model/Availability$MediaItem;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    invoke-direct {p0}, Lradiant/gestures/queue/SuggestionsResolver;->viewModel()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/l;

    move-result-object v1

    instance-of v4, v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;

    if-eqz v4, :invalid

    check-cast v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;

    iget-object v1, v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;->o:Ljava/lang/Object;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/a1; o

    instance-of v4, v1, Ljava/util/List;

    if-eqz v4, :invalid

    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v4

    if-lt v3, v4, :viewmodel_item

    goto :invalid

    :viewmodel_item
    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    instance-of v3, v1, Lcom/aspiro/wamp/model/Track;

    if-eqz v3, :invalid

    check-cast v1, Lcom/aspiro/wamp/model/Track;

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v1

    if-ne v6, v1, :invalid

    return-object v2

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method private availability()Lcom/aspiro/wamp/model/AvailabilityInteractor;
    .locals 2

    iget-object v0, p0, Lradiant/gestures/queue/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    if-eqz v1, :dialog

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;->d:Lcom/aspiro/wamp/model/AvailabilityInteractor;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/h; d

    return-object v0

    :dialog
    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;->d:Lcom/aspiro/wamp/model/AvailabilityInteractor;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/o0; d

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Landroidx/fragment/app/Fragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/gestures/queue/SuggestionsResolver;

    invoke-direct {v0, p0, p1}, Lradiant/gestures/queue/SuggestionsResolver;-><init>(Landroidx/fragment/app/Fragment;Landroidx/recyclerview/widget/RecyclerView;)V

    invoke-static {p1, v0}, Lradiant/gestures/queue/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/gestures/queue/QueueRowResolver;)V

    :done
    return-void
.end method

.method private viewModel()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/l;
    .locals 2

    iget-object v0, p0, Lradiant/gestures/queue/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    if-eqz v1, :dialog

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;->c:Lcom/aspiro/wamp/nowplaying/view/suggestions/l;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/h; Lcom/aspiro/wamp/nowplaying/view/suggestions/l; c

    return-object v0

    :dialog
    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;->c:Lcom/aspiro/wamp/nowplaying/view/suggestions/l;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/o0; Lcom/aspiro/wamp/nowplaying/view/suggestions/l; c

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method public execute(Lradiant/gestures/queue/QueueRequest;)V
    .locals 7

    invoke-direct {p0, p1}, Lradiant/gestures/queue/SuggestionsResolver;->current(Lradiant/gestures/queue/QueueRequest;)Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    move-result-object v0

    if-eqz v0, :done

    invoke-direct {p0}, Lradiant/gestures/queue/SuggestionsResolver;->viewModel()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/l;

    move-result-object v1

    if-eqz v1, :done

    iget v2, p1, Lradiant/gestures/queue/QueueRequest;->action:I

    const/4 v3, 0x3

    if-eq v2, v3, :track_action

    const/4 v3, 0x1

    if-ne v2, v3, :default_action

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v2

    if-eqz v2, :default_action

    :track_action
    invoke-virtual {v0}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getMediaItem()Lcom/aspiro/wamp/model/Track;

    move-result-object v2

    invoke-virtual {v2}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/aspiro/wamp/model/MediaItemParent;

    invoke-direct {v4, v2}, Lcom/aspiro/wamp/model/MediaItemParent;-><init>(Lcom/aspiro/wamp/model/MediaItem;)V

    invoke-static {v4}, Lkotlin/collections/u;->h(Ljava/lang/Object;)Ljava/util/List;    # MARKER: R8 Lkotlin/collections/u;

    move-result-object v4

    check-cast v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;

    iget-object v5, v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;->j:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/a1; j

    invoke-static {v3, v4, v5}, Lcom/aspiro/wamp/playqueue/source/model/b;->p(Ljava/lang/String;Ljava/util/List;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/source/model/b; p

    move-result-object v6

    new-instance v4, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    const-string v3, "suggestions"

    invoke-direct {v4, v3}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lradiant/gestures/queue/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/fragment/app/Fragment;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v0

    iget p1, p1, Lradiant/gestures/queue/QueueRequest;->action:I

    const/4 v3, 0x3

    if-eq p1, v3, :add_to_playlist

    invoke-static {v0, v2, v4, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :add_to_playlist
    invoke-static {v0, v2, v4, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :default_action
    iget p1, p1, Lradiant/gestures/queue/QueueRequest;->position:I

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v2

    if-eqz v2, :empty_queue

    new-instance v2, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;

    invoke-direct {v2, p1}, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;-><init>(I)V    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;

    goto :emit

    :empty_queue
    new-instance v2, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;

    invoke-direct {v2, p1}, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;-><init>(I)V    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;

    :emit
    invoke-interface {v1, v2}, Lcom/aspiro/wamp/nowplaying/view/suggestions/j;->a(Lcom/aspiro/wamp/nowplaying/view/suggestions/i;)V    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/j; Lcom/aspiro/wamp/nowplaying/view/suggestions/i; a

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/gestures/queue/QueueRequest;
    .locals 5

    iget-object v0, p0, Lradiant/gestures/queue/SuggestionsResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :invalid

    instance-of v0, p2, Lcom/aspiro/wamp/nowplaying/view/suggestions/y$a;    # MARKER: R8 Lcom/aspiro/wamp/nowplaying/view/suggestions/y$a;

    if-eqz v0, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p2

    if-gez p2, :has_position

    goto :invalid

    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object p1

    instance-of v0, p1, La50/b;    # MARKER: R8 La50/b;

    if-eqz v0, :invalid

    check-cast p1, La50/b;    # MARKER: R8 La50/b;

    iget-object p1, p1, La50/b;->b:Ljava/util/ArrayList;    # MARKER: R8 La50/b; b

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p2, v0, :read_item

    goto :invalid

    :read_item
    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    if-eqz v0, :invalid

    check-cast p1, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getMediaItem()Lcom/aspiro/wamp/model/Track;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v1

    new-instance v2, Lradiant/gestures/queue/QueueRequest;

    invoke-direct {v2, p2, p1, v1}, Lradiant/gestures/queue/QueueRequest;-><init>(ILjava/lang/Object;I)V

    invoke-direct {p0, v2}, Lradiant/gestures/queue/SuggestionsResolver;->current(Lradiant/gestures/queue/QueueRequest;)Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    move-result-object v3

    if-eqz v3, :invalid

    return-object v2

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
