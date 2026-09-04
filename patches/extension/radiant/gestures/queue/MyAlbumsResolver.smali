.class public final Lradiant/gestures/queue/MyAlbumsResolver;
.super Ljava/lang/Object;
.source "MyAlbumsResolver.smali"

# interfaces
.implements Lradiant/gestures/queue/QueueRowResolver;


# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/gestures/queue/MyAlbumsResolver;->fragment:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/gestures/queue/QueueRequest;)Lzc/a;    # MARKER: R8 Lzc/a;
    .locals 7

    if-eqz p1, :invalid

    iget-object v0, p0, Lradiant/gestures/queue/MyAlbumsResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;

    if-eqz v0, :invalid

    iget-object v1, v0, Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;->h:Lad/f;    # MARKER: R8 Lad/f; h

    if-eqz v1, :invalid

    invoke-virtual {v0}, Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;->N()La50/d;    # MARKER: R8 La50/d; N

    move-result-object v0

    invoke-virtual {v0}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object v0

    iget v1, p1, Lradiant/gestures/queue/QueueRequest;->position:I

    if-gez v1, :check_size

    goto :invalid

    :check_size
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lt v1, v2, :read_item

    goto :invalid

    :read_item
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Lzc/a;    # MARKER: R8 Lzc/a;

    if-eqz v1, :invalid

    check-cast v0, Lzc/a;    # MARKER: R8 Lzc/a;

    iget-boolean v1, v0, Lzc/a;->k:Z    # MARKER: R8 Lzc/a; k

    if-eqz v1, :invalid

    iget-object v1, v0, Lzc/a;->b:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lzc/a; b

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v1

    iget v2, p1, Lradiant/gestures/queue/QueueRequest;->id:I

    if-ne v1, v2, :invalid

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/gestures/queue/MyAlbumsResolver;

    invoke-direct {v0, p0}, Lradiant/gestures/queue/MyAlbumsResolver;-><init>(Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;)V

    invoke-static {p1, v0}, Lradiant/gestures/queue/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/gestures/queue/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/gestures/queue/QueueRequest;)V
    .locals 7

    iget v6, p1, Lradiant/gestures/queue/QueueRequest;->action:I

    invoke-direct {p0, p1}, Lradiant/gestures/queue/MyAlbumsResolver;->current(Lradiant/gestures/queue/QueueRequest;)Lzc/a;    # MARKER: R8 Lzc/a;

    move-result-object p1

    if-eqz p1, :done

    iget-object v0, p0, Lradiant/gestures/queue/MyAlbumsResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;

    if-eqz v0, :done

    iget-object v1, v0, Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;->c:Lfd/c;    # MARKER: R8 Lfd/c; c

    if-eqz v1, :done

    iget-object v2, v1, Lfd/c;->a:Lx40/a;    # MARKER: R8 Lfd/c; Lx40/a; a

    instance-of v3, v2, Lh4/a;    # MARKER: R8 Lh4/a;

    if-eqz v3, :done

    check-cast v2, Lh4/a;    # MARKER: R8 Lh4/a;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v3

    iget-object v4, p1, Lzc/a;->b:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lzc/a; b

    iget-object v5, v1, Lfd/c;->d:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;    # MARKER: R8 Lfd/c; d

    iget-object p0, v1, Lfd/c;->c:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lfd/c; c

    const/4 v1, 0x3

    if-eq v6, v1, :add_to_playlist

    const/4 v1, 0x1

    if-ne v6, v1, :append

    invoke-static {v3, v4, v5, p0, v2}, Lradiant/gestures/queue/QueueExecutor;->playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    move-result-object p1

    goto :retain

    :append
    invoke-static {v3, v4, v5, p0, v2}, Lradiant/gestures/queue/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    move-result-object p1

    goto :retain

    :add_to_playlist
    invoke-static {v3, v4, v5, p0, v2}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :retain
    if-eqz p1, :done

    iget-object v0, v0, Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;->j:Lio/reactivex/disposables/CompositeDisposable;    # MARKER: R8 j

    invoke-virtual {v0, p1}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/gestures/queue/QueueRequest;
    .locals 6

    instance-of v0, p2, Lbd/d$a;    # MARKER: R8 Lbd/d$a;

    if-eqz v0, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p2

    const/4 v0, -0x1

    if-ne p2, v0, :has_position

    goto :invalid

    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object p1

    instance-of v0, p1, La50/d;    # MARKER: R8 La50/d;

    if-eqz v0, :invalid

    check-cast p1, La50/d;    # MARKER: R8 La50/d;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :read_item

    goto :invalid

    :read_item
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lzc/a;    # MARKER: R8 Lzc/a;

    if-eqz v0, :invalid

    check-cast p1, Lzc/a;    # MARKER: R8 Lzc/a;

    iget-boolean v0, p1, Lzc/a;->k:Z    # MARKER: R8 Lzc/a; k

    if-eqz v0, :invalid

    iget-object v0, p1, Lzc/a;->b:Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lzc/a; b

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v1

    new-instance v2, Lradiant/gestures/queue/QueueRequest;

    invoke-direct {v2, p2, v0, v1}, Lradiant/gestures/queue/QueueRequest;-><init>(ILjava/lang/Object;I)V

    return-object v2

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
