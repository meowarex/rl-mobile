.class public final Lradiant/swipe/MyPlaylistsResolver;
.super Ljava/lang/Object;
.source "MyPlaylistsResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/MyPlaylistsResolver;->fragment:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/swipe/QueueRequest;)Lcf/b;
    .locals 6

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lcom/aspiro/wamp/model/Playlist;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/model/Playlist;

    iget-object v1, p0, Lradiant/swipe/MyPlaylistsResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;

    if-eqz v1, :invalid

    iget-object v2, v1, Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;->j:Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/h;

    if-eqz v2, :invalid

    invoke-virtual {v1}, Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;->N()La50/d;

    move-result-object v1

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

    instance-of v2, v1, Lcf/b;

    if-eqz v2, :invalid

    check-cast v1, Lcf/b;

    iget-boolean v2, v1, Lcf/b;->h:Z

    if-eqz v2, :invalid

    iget-boolean v2, v1, Lcf/b;->f:Z

    if-eqz v2, :check_playlist

    const-string v2, "NOT_READY"

    iget-object v3, v1, Lcf/b;->g:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :invalid

    :check_playlist
    iget-object v2, v1, Lcf/b;->a:Lcom/aspiro/wamp/model/Playlist;

    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I

    move-result v3

    if-lez v3, :invalid

    invoke-virtual {v2}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :invalid

    return-object v1

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/swipe/MyPlaylistsResolver;

    invoke-direct {v0, p0}, Lradiant/swipe/MyPlaylistsResolver;-><init>(Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;)V

    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 6

    iget v5, p1, Lradiant/swipe/QueueRequest;->action:I

    invoke-direct {p0, p1}, Lradiant/swipe/MyPlaylistsResolver;->current(Lradiant/swipe/QueueRequest;)Lcf/b;

    move-result-object p1

    if-eqz p1, :done

    iget-object v0, p0, Lradiant/swipe/MyPlaylistsResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;

    if-eqz v0, :done

    iget-object v1, v0, Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;->d:Lhf/c;

    if-eqz v1, :done

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p1, Lcf/b;->a:Lcom/aspiro/wamp/model/Playlist;

    iget-object v4, v1, Lhf/c;->e:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    iget-object p0, v1, Lhf/c;->d:Lcom/tidal/android/navigation/NavigationInfo;

    const/4 v0, 0x1

    if-ne v5, v0, :append

    invoke-static {v2, v3, v4, p0}, Lradiant/swipe/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append
    invoke-static {v2, v3, v4, p0}, Lradiant/swipe/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    instance-of v0, p2, Ldf/d$a;

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

    instance-of v0, p1, Lcf/b;

    if-eqz v0, :invalid

    check-cast p1, Lcf/b;

    iget-boolean v0, p1, Lcf/b;->h:Z

    if-eqz v0, :invalid

    iget-boolean v0, p1, Lcf/b;->f:Z

    if-eqz v0, :check_playlist

    const-string v0, "NOT_READY"

    iget-object v1, p1, Lcf/b;->g:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :invalid

    :check_playlist
    iget-object v0, p1, Lcf/b;->a:Lcom/aspiro/wamp/model/Playlist;

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I

    move-result v1

    if-lez v1, :invalid

    invoke-virtual {v0}, Lcom/aspiro/wamp/model/Playlist;->getUuid()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    new-instance v3, Lradiant/swipe/QueueRequest;

    invoke-direct {v3, p2, v0, v2}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    return-object v3

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
