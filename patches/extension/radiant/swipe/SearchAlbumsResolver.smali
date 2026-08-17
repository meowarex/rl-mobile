.class public final Lradiant/swipe/SearchAlbumsResolver;
.super Ljava/lang/Object;
.source "SearchAlbumsResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/SearchAlbumsResolver;->fragment:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/swipe/QueueRequest;)Lzc/a;
    .locals 5

    if-eqz p1, :invalid

    iget-object v0, p0, Lradiant/swipe/SearchAlbumsResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;

    if-eqz v0, :invalid

    iget-object v1, v0, Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;->f:Lid/e;

    if-eqz v1, :invalid

    invoke-virtual {v0}, Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;->N()La50/d;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object v0

    iget v1, p1, Lradiant/swipe/QueueRequest;->position:I

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

    instance-of v1, v0, Lzc/a;

    if-eqz v1, :invalid

    check-cast v0, Lzc/a;

    iget-boolean v1, v0, Lzc/a;->k:Z

    if-eqz v1, :invalid

    iget-object v1, v0, Lzc/a;->b:Lcom/aspiro/wamp/model/Album;

    invoke-virtual {v1}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v1

    iget v2, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v1, v2, :invalid

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/swipe/SearchAlbumsResolver;

    invoke-direct {v0, p0}, Lradiant/swipe/SearchAlbumsResolver;-><init>(Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;)V

    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 7

    invoke-direct {p0, p1}, Lradiant/swipe/SearchAlbumsResolver;->current(Lradiant/swipe/QueueRequest;)Lzc/a;

    move-result-object p1

    if-eqz p1, :done

    iget-object v0, p0, Lradiant/swipe/SearchAlbumsResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;

    if-eqz v0, :done

    iget-object v1, v0, Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;->c:Lld/c;

    if-eqz v1, :done

    iget-object v2, v1, Lld/c;->a:Lx40/a;

    instance-of v3, v2, Lh4/a;

    if-eqz v3, :done

    check-cast v2, Lh4/a;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v3

    iget-object v4, p1, Lzc/a;->b:Lcom/aspiro/wamp/model/Album;

    iget-object v5, v1, Lld/c;->d:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    iget-object v6, v1, Lld/c;->c:Lcom/tidal/android/navigation/NavigationInfo;

    invoke-static {v3, v4, v5, v6, v2}, Lradiant/swipe/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;

    move-result-object p1

    if-eqz p1, :done

    iget-object v0, v0, Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;->g:Lio/reactivex/disposables/CompositeDisposable;

    invoke-virtual {v0, p1}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    instance-of v0, p2, Ljd/d$a;

    if-eqz v0, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p2

    const/4 v0, -0x1

    if-ne p2, v0, :has_position

    goto :invalid

    :has_position
    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object p1

    instance-of v0, p1, La50/d;

    if-eqz v0, :invalid

    check-cast p1, La50/d;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/ListAdapter;->getCurrentList()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :read_item

    goto :invalid

    :read_item
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lzc/a;

    if-eqz v0, :invalid

    check-cast p1, Lzc/a;

    iget-boolean v0, p1, Lzc/a;->k:Z

    if-eqz v0, :invalid

    iget-object v0, p1, Lzc/a;->b:Lcom/aspiro/wamp/model/Album;

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result v1

    new-instance v2, Lradiant/swipe/QueueRequest;

    invoke-direct {v2, p2, v0, v1}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    return-object v2

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
