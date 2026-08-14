.class public final Lradiant/swipe/DynamicTrackResolver;
.super Ljava/lang/Object;
.source "DynamicTrackResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final recycler:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private currentRow(Lradiant/swipe/QueueRequest;)Lo6/b;
    .locals 8

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lo6/b;

    if-eqz v1, :invalid

    check-cast v0, Lo6/b;

    iget-object v1, p0, Lradiant/swipe/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v1, :invalid

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v2

    instance-of v1, v2, Lcom/tidal/android/core/adapterdelegate/c;

    if-eqz v1, :invalid

    check-cast v2, Lcom/tidal/android/core/adapterdelegate/c;

    invoke-virtual {v2}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object v2

    iget v3, p1, Lradiant/swipe/QueueRequest;->position:I

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

    instance-of v3, v2, Lo6/b;

    if-eqz v3, :invalid

    check-cast v2, Lo6/b;

    iget-object v3, v0, Lo6/b;->a:Lo6/i;

    iget-object v4, v2, Lo6/b;->a:Lo6/i;

    if-ne v3, v4, :invalid

    iget-wide v3, v0, Lo6/b;->b:J

    iget-wide v5, v2, Lo6/b;->b:J

    cmp-long v7, v3, v5

    if-nez v7, :invalid

    iget-object v3, v0, Lo6/b;->c:Lo6/b$a;

    iget-object v4, v2, Lo6/b;->c:Lo6/b$a;

    if-eqz v3, :invalid

    if-eqz v4, :invalid

    iget v5, v3, Lo6/b$a;->d:I

    iget v6, v4, Lo6/b$a;->d:I

    iget v7, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v5, v7, :invalid

    if-ne v6, v7, :invalid

    iget v5, v3, Lo6/b$a;->o:I

    iget v6, v4, Lo6/b$a;->o:I

    if-ne v5, v6, :invalid

    iget-object v5, v3, Lo6/b$a;->q:Ljava/lang/String;

    iget-object v6, v4, Lo6/b$a;->q:Ljava/lang/String;

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

.method private currentTrack(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/Track;
    .locals 7

    invoke-direct {p0, p1}, Lradiant/swipe/DynamicTrackResolver;->currentRow(Lradiant/swipe/QueueRequest;)Lo6/b;

    move-result-object v0

    if-eqz v0, :invalid

    iget-object v1, v0, Lo6/b;->a:Lo6/i;

    iget-object v2, v0, Lo6/b;->c:Lo6/b$a;

    iget-object v3, v1, Lo6/i;->p:Ljava/util/LinkedHashMap;

    iget-object v4, v2, Lo6/b$a;->q:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    instance-of v4, v3, Lcom/aspiro/wamp/dynamicpages/data/model/collection/TrackCollectionModule;

    if-eqz v4, :invalid

    check-cast v3, Lcom/aspiro/wamp/dynamicpages/data/model/collection/TrackCollectionModule;

    invoke-virtual {v3}, Lcom/aspiro/wamp/dynamicpages/data/model/collection/MediaItemCollectionModule;->getFilteredPagedListItems()Ljava/util/List;

    move-result-object v3

    iget v4, v2, Lo6/b$a;->o:I

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

    iget v5, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v4, v5, :invalid

    iget-object v1, v1, Lo6/i;->g:Lcom/aspiro/wamp/model/AvailabilityInteractor;

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

.method public static install(Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    new-instance v0, Lradiant/swipe/DynamicTrackResolver;

    invoke-direct {v0, p0}, Lradiant/swipe/DynamicTrackResolver;-><init>(Landroidx/recyclerview/widget/RecyclerView;)V

    invoke-static {p0, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 8

    invoke-direct {p0, p1}, Lradiant/swipe/DynamicTrackResolver;->currentRow(Lradiant/swipe/QueueRequest;)Lo6/b;

    move-result-object v0

    invoke-direct {p0, p1}, Lradiant/swipe/DynamicTrackResolver;->currentTrack(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/Track;

    move-result-object v1

    if-eqz v0, :done

    if-eqz v1, :done

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v2

    if-nez v2, :append

    iget-object v2, v0, Lo6/b;->a:Lo6/i;

    iget-object v3, v0, Lo6/b;->c:Lo6/b$a;

    iget v4, v3, Lo6/b$a;->o:I

    iget-object v5, v3, Lo6/b$a;->q:Ljava/lang/String;

    invoke-virtual {v2, v4, v5}, Lo6/i;->e(ILjava/lang/String;)V

    goto :done

    :append
    iget-object v0, v0, Lo6/b;->a:Lo6/i;

    iget-object v2, v0, Lo6/i;->p:Ljava/util/LinkedHashMap;

    iget-object v3, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    check-cast v3, Lo6/b;

    iget-object v3, v3, Lo6/b;->c:Lo6/b$a;

    iget-object v3, v3, Lo6/b$a;->q:Ljava/lang/String;

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

    iget-object v6, v0, Lo6/i;->m:Lcom/tidal/android/navigation/NavigationInfo;

    invoke-virtual {v2}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getSelfLink()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$a;->a(Ljava/lang/String;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;

    move-result-object v7

    invoke-static {v4, v5, v6, v7}, Lcom/aspiro/wamp/playqueue/source/model/b;->j(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    iget-object v5, p0, Lradiant/swipe/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

    invoke-virtual {v5}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v5, :done

    invoke-virtual {v5}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v1, v3, v4}, Lradiant/swipe/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    return-void
.end method

.method public isValid(Lradiant/swipe/QueueRequest;)Z
    .locals 1

    invoke-direct {p0, p1}, Lradiant/swipe/DynamicTrackResolver;->currentTrack(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/Track;

    move-result-object p1

    if-eqz p1, :invalid

    const/4 p1, 0x1

    return p1

    :invalid
    const/4 p1, 0x0

    return p1
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    instance-of v0, p2, Lp7/a$a;

    if-eqz v0, :invalid

    iget-object v0, p0, Lradiant/swipe/DynamicTrackResolver;->recycler:Ljava/lang/ref/WeakReference;

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

    instance-of v0, p1, Lcom/tidal/android/core/adapterdelegate/c;

    if-eqz v0, :invalid

    check-cast p1, Lcom/tidal/android/core/adapterdelegate/c;

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

    instance-of v0, p1, Lo6/b;

    if-eqz v0, :invalid

    check-cast p1, Lo6/b;

    iget-object v0, p1, Lo6/b;->c:Lo6/b$a;

    iget v0, v0, Lo6/b$a;->d:I

    new-instance v1, Lradiant/swipe/QueueRequest;

    invoke-direct {v1, p2, p1, v0}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    invoke-direct {p0, v1}, Lradiant/swipe/DynamicTrackResolver;->currentTrack(Lradiant/swipe/QueueRequest;)Lcom/aspiro/wamp/model/Track;

    move-result-object p1

    if-eqz p1, :invalid

    return-object v1

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
