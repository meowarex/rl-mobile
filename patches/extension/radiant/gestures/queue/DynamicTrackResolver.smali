.class public final Lradiant/gestures/queue/DynamicTrackResolver;
.super Ljava/lang/Object;
.source "DynamicTrackResolver.smali"

# interfaces
.implements Lradiant/gestures/queue/QueueRowResolver;


# instance fields
.field private final recycler:Ljava/lang/ref/WeakReference;


# direct methods
.method private currentAlbumRow(Lradiant/gestures/queue/QueueRequest;)Lu5/b$a;    # MARKER: R8 Lu5/b$a;
    .locals 9

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/gestures/queue/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    if-eqz v1, :invalid

    check-cast v0, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    iget-object v1, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v1, :invalid

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v2

    instance-of v1, v2, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    if-eqz v1, :invalid

    check-cast v2, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    invoke-virtual {v2}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object v2

    iget v3, p1, Lradiant/gestures/queue/QueueRequest;->position:I

    if-gez v3, :check_size

    goto :invalid

    :check_size
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-lt v3, v4, :read_row

    goto :invalid

    :read_row
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    if-eqz v3, :invalid

    check-cast v2, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    iget-object v3, v0, Lu5/b$a;->a:Lu5/b$a$a;    # MARKER: R8 Lu5/b$a; Lu5/b$a$a; a

    iget-object v4, v2, Lu5/b$a;->a:Lu5/b$a$a;    # MARKER: R8 Lu5/b$a; Lu5/b$a$a; a

    if-ne v3, v4, :invalid

    iget-wide v3, v0, Lu5/b$a;->b:J    # MARKER: R8 Lu5/b$a; b

    iget-wide v5, v2, Lu5/b$a;->b:J    # MARKER: R8 Lu5/b$a; b

    cmp-long v7, v3, v5

    if-nez v7, :invalid

    iget-object v3, v0, Lu5/b$a;->c:Lu5/b$a$b;    # MARKER: R8 Lu5/b$a; Lu5/b$a$b; c

    iget-object v4, v2, Lu5/b$a;->c:Lu5/b$a$b;    # MARKER: R8 Lu5/b$a; Lu5/b$a$b; c

    if-eqz v3, :invalid

    if-eqz v4, :invalid

    iget v5, v3, Lu5/b$a$b;->r:I    # MARKER: R8 Lu5/b$a$b; r

    iget v6, v4, Lu5/b$a$b;->r:I    # MARKER: R8 Lu5/b$a$b; r

    iget v7, p1, Lradiant/gestures/queue/QueueRequest;->id:I

    if-ne v5, v7, :invalid

    if-ne v6, v7, :invalid

    iget-object v5, v3, Lu5/b$a$b;->s:Ljava/lang/String;    # MARKER: R8 Lu5/b$a$b; s

    iget-object v6, v4, Lu5/b$a$b;->s:Ljava/lang/String;    # MARKER: R8 Lu5/b$a$b; s

    if-eq v5, v6, :module_valid

    if-eqz v5, :invalid

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :invalid

    :module_valid
    iget-object v5, v4, Lu5/b$a$b;->g:Lcom/aspiro/wamp/model/Availability;    # MARKER: R8 Lu5/b$a$b; g

    invoke-interface {v5}, Lcom/aspiro/wamp/model/Availability;->isAvailable()Z

    move-result v5

    if-eqz v5, :invalid

    iget-boolean v5, v4, Lu5/b$a$b;->p:Z    # MARKER: R8 Lu5/b$a$b; p

    if-nez v5, :invalid

    return-object v2

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method private constructor <init>(Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private currentRow(Lradiant/gestures/queue/QueueRequest;)Lo6/b;    # MARKER: R8 Lo6/b;
    .locals 8

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/gestures/queue/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lo6/b;    # MARKER: R8 Lo6/b;

    if-eqz v1, :invalid

    check-cast v0, Lo6/b;    # MARKER: R8 Lo6/b;

    iget-object v1, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v1, :invalid

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v2

    instance-of v1, v2, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    if-eqz v1, :invalid

    check-cast v2, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    invoke-virtual {v2}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object v2

    iget v3, p1, Lradiant/gestures/queue/QueueRequest;->position:I

    if-gez v3, :check_size

    goto :invalid

    :check_size
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-lt v3, v4, :read_row

    goto :invalid

    :read_row
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Lo6/b;    # MARKER: R8 Lo6/b;

    if-eqz v3, :invalid

    check-cast v2, Lo6/b;    # MARKER: R8 Lo6/b;

    iget-object v3, v0, Lo6/b;->a:Lo6/i;    # MARKER: R8 Lo6/b; Lo6/i; a

    iget-object v4, v2, Lo6/b;->a:Lo6/i;    # MARKER: R8 Lo6/b; Lo6/i; a

    if-ne v3, v4, :invalid

    iget-wide v3, v0, Lo6/b;->b:J    # MARKER: R8 Lo6/b; b

    iget-wide v5, v2, Lo6/b;->b:J    # MARKER: R8 Lo6/b; b

    cmp-long v7, v3, v5

    if-nez v7, :invalid

    iget-object v3, v0, Lo6/b;->c:Lo6/b$a;    # MARKER: R8 Lo6/b; Lo6/b$a; c

    iget-object v4, v2, Lo6/b;->c:Lo6/b$a;    # MARKER: R8 Lo6/b; Lo6/b$a; c

    if-eqz v3, :invalid

    if-eqz v4, :invalid

    iget v5, v3, Lo6/b$a;->d:I    # MARKER: R8 Lo6/b$a; d

    iget v6, v4, Lo6/b$a;->d:I    # MARKER: R8 Lo6/b$a; d

    iget v7, p1, Lradiant/gestures/queue/QueueRequest;->id:I

    if-ne v5, v7, :invalid

    if-ne v6, v7, :invalid

    iget v5, v3, Lo6/b$a;->o:I    # MARKER: R8 Lo6/b$a; o

    iget v6, v4, Lo6/b$a;->o:I    # MARKER: R8 Lo6/b$a; o

    if-ne v5, v6, :invalid

    iget-object v5, v3, Lo6/b$a;->q:Ljava/lang/String;    # MARKER: R8 Lo6/b$a; q

    iget-object v6, v4, Lo6/b$a;->q:Ljava/lang/String;    # MARKER: R8 Lo6/b$a; q

    if-eq v5, v6, :valid

    if-eqz v5, :invalid

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :invalid

    :valid
    return-object v2

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method private currentTrack(Lradiant/gestures/queue/QueueRequest;)Lcom/aspiro/wamp/model/Track;
    .locals 7

    invoke-direct {p0, p1}, Lradiant/gestures/queue/DynamicTrackResolver;->currentRow(Lradiant/gestures/queue/QueueRequest;)Lo6/b;    # MARKER: R8 Lo6/b;

    move-result-object v0

    if-eqz v0, :invalid

    iget-object v1, v0, Lo6/b;->a:Lo6/i;    # MARKER: R8 Lo6/b; Lo6/i; a

    iget-object v2, v0, Lo6/b;->c:Lo6/b$a;    # MARKER: R8 Lo6/b; Lo6/b$a; c

    iget-object v3, v1, Lo6/i;->p:Ljava/util/LinkedHashMap;    # MARKER: R8 Lo6/i; p

    iget-object v4, v2, Lo6/b$a;->q:Ljava/lang/String;    # MARKER: R8 Lo6/b$a; q

    invoke-virtual {v3, v4}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    instance-of v4, v3, Lcom/aspiro/wamp/dynamicpages/data/model/collection/TrackCollectionModule;

    if-eqz v4, :invalid

    check-cast v3, Lcom/aspiro/wamp/dynamicpages/data/model/collection/TrackCollectionModule;

    invoke-virtual {v3}, Lcom/aspiro/wamp/dynamicpages/data/model/collection/MediaItemCollectionModule;->getFilteredPagedListItems()Ljava/util/List;

    move-result-object v3

    iget v4, v2, Lo6/b$a;->o:I    # MARKER: R8 Lo6/b$a; o

    if-gez v4, :check_size

    goto :invalid

    :check_size
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v5

    if-lt v4, v5, :read_track

    goto :invalid

    :read_track
    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    instance-of v4, v3, Lcom/aspiro/wamp/model/Track;

    if-eqz v4, :invalid

    check-cast v3, Lcom/aspiro/wamp/model/Track;

    invoke-virtual {v3}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v4

    iget v5, p1, Lradiant/gestures/queue/QueueRequest;->id:I

    if-ne v4, v5, :invalid

    iget-object v1, v1, Lo6/i;->g:Lcom/aspiro/wamp/model/AvailabilityInteractor;    # MARKER: R8 Lo6/i; g

    invoke-interface {v1, v3}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getAvailability(Lcom/aspiro/wamp/model/MediaItem;)Lcom/aspiro/wamp/model/Availability$MediaItem;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z

    move-result v1

    if-eqz v1, :invalid

    return-object v3

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method private resolveAlbum(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/gestures/queue/QueueRequest;
    .locals 5

    iget-object v0, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p2

    const/4 v0, -0x1

    if-ne p2, v0, :has_position

    goto :invalid

    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object p1

    instance-of v0, p1, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    if-eqz v0, :invalid

    check-cast p1, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object p1

    if-gez p2, :check_size

    goto :invalid

    :check_size
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :read_row

    goto :invalid

    :read_row
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    if-eqz v0, :invalid

    check-cast p1, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    iget-object v0, p1, Lu5/b$a;->c:Lu5/b$a$b;    # MARKER: R8 Lu5/b$a; Lu5/b$a$b; c

    if-eqz v0, :invalid

    iget-object v1, v0, Lu5/b$a$b;->g:Lcom/aspiro/wamp/model/Availability;    # MARKER: R8 Lu5/b$a$b; g

    invoke-interface {v1}, Lcom/aspiro/wamp/model/Availability;->isAvailable()Z

    move-result v1

    if-eqz v1, :invalid

    iget-boolean v1, v0, Lu5/b$a$b;->p:Z    # MARKER: R8 Lu5/b$a$b; p

    if-nez v1, :invalid

    iget v0, v0, Lu5/b$a$b;->r:I    # MARKER: R8 Lu5/b$a$b; r

    new-instance v1, Lradiant/gestures/queue/QueueRequest;

    invoke-direct {v1, p2, p1, v0}, Lradiant/gestures/queue/QueueRequest;-><init>(ILjava/lang/Object;I)V

    return-object v1

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method

.method public static install(Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    new-instance v0, Lradiant/gestures/queue/DynamicTrackResolver;

    invoke-direct {v0, p0}, Lradiant/gestures/queue/DynamicTrackResolver;-><init>(Landroidx/recyclerview/widget/RecyclerView;)V

    invoke-static {p0, v0}, Lradiant/gestures/queue/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/gestures/queue/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/gestures/queue/QueueRequest;)V
    .locals 9

    iget v8, p1, Lradiant/gestures/queue/QueueRequest;->action:I

    iget-object v0, p1, Lradiant/gestures/queue/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    if-eqz v1, :dynamic_track

    invoke-direct {p0, p1}, Lradiant/gestures/queue/DynamicTrackResolver;->currentAlbumRow(Lradiant/gestures/queue/QueueRequest;)Lu5/b$a;    # MARKER: R8 Lu5/b$a;

    move-result-object v0

    if-eqz v0, :done

    new-instance v1, Lradiant/gestures/queue/AlbumItemQueueAction;

    invoke-direct {v1, v0}, Lradiant/gestures/queue/AlbumItemQueueAction;-><init>(Lu5/b$a;)V    # MARKER: R8 Lu5/b$a;

    iget-object v2, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v2, :done

    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v1, v2}, Lradiant/gestures/queue/AlbumItemQueueAction;->setContext(Landroid/content/Context;)V

    invoke-virtual {v1, v8}, Lradiant/gestures/queue/AlbumItemQueueAction;->invoke(I)Ljava/lang/Object;

    return-void

    :dynamic_track
    invoke-direct {p0, p1}, Lradiant/gestures/queue/DynamicTrackResolver;->currentRow(Lradiant/gestures/queue/QueueRequest;)Lo6/b;    # MARKER: R8 Lo6/b;

    move-result-object v0

    invoke-direct {p0, p1}, Lradiant/gestures/queue/DynamicTrackResolver;->currentTrack(Lradiant/gestures/queue/QueueRequest;)Lcom/aspiro/wamp/model/Track;

    move-result-object v1

    if-eqz v0, :done

    if-eqz v1, :done

    const/4 v2, 0x3

    if-eq v8, v2, :append

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v2

    if-nez v2, :append

    iget-object v2, v0, Lo6/b;->a:Lo6/i;    # MARKER: R8 Lo6/b; Lo6/i; a

    iget-object v3, v0, Lo6/b;->c:Lo6/b$a;    # MARKER: R8 Lo6/b; Lo6/b$a; c

    iget v4, v3, Lo6/b$a;->o:I    # MARKER: R8 Lo6/b$a; o

    iget-object v5, v3, Lo6/b$a;->q:Ljava/lang/String;    # MARKER: R8 Lo6/b$a; q

    invoke-virtual {v2, v4, v5}, Lo6/i;->e(ILjava/lang/String;)V    # MARKER: R8 Lo6/i; e

    goto :done

    :append
    iget-object v0, v0, Lo6/b;->a:Lo6/i;    # MARKER: R8 Lo6/b; Lo6/i; a

    iget-object v2, v0, Lo6/i;->p:Ljava/util/LinkedHashMap;    # MARKER: R8 Lo6/i; p

    iget-object v3, p1, Lradiant/gestures/queue/QueueRequest;->media:Ljava/lang/Object;

    check-cast v3, Lo6/b;    # MARKER: R8 Lo6/b;

    iget-object v3, v3, Lo6/b;->c:Lo6/b$a;    # MARKER: R8 Lo6/b; Lo6/b$a; c

    iget-object v3, v3, Lo6/b$a;->q:Ljava/lang/String;    # MARKER: R8 Lo6/b$a; q

    invoke-virtual {v2, v3}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aspiro/wamp/dynamicpages/data/model/collection/TrackCollectionModule;

    new-instance v3, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    invoke-virtual {v2}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getPageId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getId()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getPosition()I

    move-result v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v4, v5, v6}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getTitle()Ljava/lang/String;

    move-result-object v5

    iget-object v6, v0, Lo6/i;->m:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lo6/i; m

    invoke-virtual {v2}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getSelfLink()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$a;->a(Ljava/lang/String;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;    # MARKER: R8 a

    move-result-object v7

    invoke-static {v4, v5, v6, v7}, Lcom/aspiro/wamp/playqueue/source/model/b;->j(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/source/model/b; j

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    iget-object v5, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v5}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v5, :done

    invoke-virtual {v5}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v5

    const/4 v0, 0x1

    if-ne v8, v0, :check_add_to_playlist

    invoke-static {v5, v1, v3, v4}, Lradiant/gestures/queue/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :check_add_to_playlist
    const/4 v0, 0x3

    if-ne v8, v0, :append_track

    invoke-static {v5, v1, v3, v4}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :append_track
    invoke-static {v5, v1, v3, v4}, Lradiant/gestures/queue/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/gestures/queue/QueueRequest;
    .locals 5

    instance-of v0, p2, Lv6/e$a;    # MARKER: R8 Lv6/e$a;

    if-eqz v0, :dynamic_holder

    invoke-direct {p0, p1, p2}, Lradiant/gestures/queue/DynamicTrackResolver;->resolveAlbum(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/gestures/queue/QueueRequest;

    move-result-object p1

    return-object p1

    :dynamic_holder
    instance-of v0, p2, Lp7/a$a;    # MARKER: R8 Lp7/a$a;

    if-eqz v0, :invalid

    iget-object v0, p0, Lradiant/gestures/queue/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p2

    const/4 v0, -0x1

    if-ne p2, v0, :has_position

    goto :invalid

    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object p1

    instance-of v0, p1, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    if-eqz v0, :invalid

    check-cast p1, Lcom/tidal/android/core/adapterdelegate/c;    # MARKER: R8 Lcom/tidal/android/core/adapterdelegate/c;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object p1

    if-gez p2, :check_size

    goto :invalid

    :check_size
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :read_row

    goto :invalid

    :read_row
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lo6/b;    # MARKER: R8 Lo6/b;

    if-eqz v0, :invalid

    check-cast p1, Lo6/b;    # MARKER: R8 Lo6/b;

    iget-object v0, p1, Lo6/b;->c:Lo6/b$a;    # MARKER: R8 Lo6/b; Lo6/b$a; c

    if-eqz v0, :invalid

    iget v0, v0, Lo6/b$a;->d:I    # MARKER: R8 Lo6/b$a; d

    new-instance v1, Lradiant/gestures/queue/QueueRequest;

    invoke-direct {v1, p2, p1, v0}, Lradiant/gestures/queue/QueueRequest;-><init>(ILjava/lang/Object;I)V

    invoke-direct {p0, v1}, Lradiant/gestures/queue/DynamicTrackResolver;->currentTrack(Lradiant/gestures/queue/QueueRequest;)Lcom/aspiro/wamp/model/Track;

    move-result-object p1

    if-eqz p1, :invalid

    return-object v1

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
