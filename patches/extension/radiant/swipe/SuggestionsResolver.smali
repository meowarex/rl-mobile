.class public final Lradiant/swipe/SuggestionsResolver;
.super Ljava/lang/Object;
.source "SuggestionsResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final host:Ljava/lang/ref/WeakReference;

.field private final recycler:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Landroidx/fragment/app/Fragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/SuggestionsResolver;->recycler:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;
    .locals 8

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    iget-object v1, p0, Lradiant/swipe/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Landroidx/fragment/app/Fragment;

    if-eqz v2, :invalid

    check-cast v1, Landroidx/fragment/app/Fragment;

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :invalid

    iget-object v2, p0, Lradiant/swipe/SuggestionsResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v2, :invalid

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v2

    instance-of v3, v2, La50/b;

    if-eqz v3, :invalid

    check-cast v2, La50/b;

    iget-object v2, v2, La50/b;->b:Ljava/util/ArrayList;

    iget v3, p1, Lradiant/swipe/QueueRequest;->position:I

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

    iget v7, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v6, v7, :invalid

    invoke-virtual {v2}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getAvailability()Lcom/aspiro/wamp/model/Availability;

    move-result-object v4

    invoke-interface {v4}, Lcom/aspiro/wamp/model/Availability;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    invoke-direct {p0}, Lradiant/swipe/SuggestionsResolver;->availability()Lcom/aspiro/wamp/model/AvailabilityInteractor;

    move-result-object v4

    if-eqz v4, :invalid

    invoke-interface {v4, v5}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getAvailability(Lcom/aspiro/wamp/model/MediaItem;)Lcom/aspiro/wamp/model/Availability$MediaItem;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z

    move-result v4

    if-eqz v4, :invalid

    invoke-direct {p0}, Lradiant/swipe/SuggestionsResolver;->viewModel()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;

    move-result-object v1

    instance-of v4, v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;

    if-eqz v4, :invalid

    check-cast v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;

    iget-object v1, v1, Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;->o:Ljava/lang/Object;

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

    iget-object v0, p0, Lradiant/swipe/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    if-eqz v1, :dialog

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;->d:Lcom/aspiro/wamp/model/AvailabilityInteractor;

    return-object v0

    :dialog
    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;->d:Lcom/aspiro/wamp/model/AvailabilityInteractor;

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Landroidx/fragment/app/Fragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/swipe/SuggestionsResolver;

    invoke-direct {v0, p0, p1}, Lradiant/swipe/SuggestionsResolver;-><init>(Landroidx/fragment/app/Fragment;Landroidx/recyclerview/widget/RecyclerView;)V

    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method

.method private viewModel()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;
    .locals 2

    iget-object v0, p0, Lradiant/swipe/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    if-eqz v1, :dialog

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/h;->c:Lcom/aspiro/wamp/nowplaying/view/suggestions/l;

    return-object v0

    :dialog
    instance-of v1, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;

    iget-object v0, v0, Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;->c:Lcom/aspiro/wamp/nowplaying/view/suggestions/l;

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 4

    invoke-direct {p0, p1}, Lradiant/swipe/SuggestionsResolver;->current(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    move-result-object v0

    if-eqz v0, :done

    iget-object v0, p0, Lradiant/swipe/SuggestionsResolver;->host:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    invoke-direct {p0}, Lradiant/swipe/SuggestionsResolver;->viewModel()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;

    move-result-object v1

    if-eqz v1, :done

    iget p1, p1, Lradiant/swipe/QueueRequest;->position:I

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v2

    if-eqz v2, :empty_queue

    new-instance v2, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;

    invoke-direct {v2, p1}, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;-><init>(I)V

    goto :emit

    :empty_queue
    new-instance v2, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;

    invoke-direct {v2, p1}, Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;-><init>(I)V

    :emit
    invoke-interface {v1, v2}, Lcom/aspiro/wamp/nowplaying/view/suggestions/j;->a(Lcom/aspiro/wamp/nowplaying/view/suggestions/i;)V

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    iget-object v0, p0, Lradiant/swipe/SuggestionsResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :invalid

    instance-of v0, p2, Lcom/aspiro/wamp/nowplaying/view/suggestions/y$a;

    if-eqz v0, :invalid

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

    instance-of v0, p1, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    if-eqz v0, :invalid

    check-cast p1, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;->getMediaItem()Lcom/aspiro/wamp/model/Track;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v1

    new-instance v2, Lradiant/swipe/QueueRequest;

    invoke-direct {v2, p2, p1, v1}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    invoke-direct {p0, v2}, Lradiant/swipe/SuggestionsResolver;->current(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/SuggestedMediaItem$SuggestedTrack;

    move-result-object v3

    if-eqz v3, :invalid

    return-object v2

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
