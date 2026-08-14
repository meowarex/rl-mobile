.class public final Lradiant/swipe/FavoriteTracksResolver;
.super Ljava/lang/Object;
.source "FavoriteTracksResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/FavoriteTracksResolver;->fragment:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method public static install(Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/swipe/FavoriteTracksResolver;

    invoke-direct {v0, p0}, Lradiant/swipe/FavoriteTracksResolver;-><init>(Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;)V

    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 3

    iget-object v0, p0, Lradiant/swipe/FavoriteTracksResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;

    if-eqz v0, :done

    iget v1, p1, Lradiant/swipe/QueueRequest;->position:I

    iget-object v2, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    check-cast v2, Lcom/aspiro/wamp/model/FavoriteTrack;

    invoke-virtual {v0, v1, v2}, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;->Z(ILcom/aspiro/wamp/model/FavoriteTrack;)V

    :done
    return-void
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    instance-of p1, p2, Ln8/d;

    if-eqz p1, :invalid

    invoke-virtual {p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->getBindingAdapterPosition()I

    move-result p1

    const/4 v0, -0x1

    if-ne p1, v0, :has_position

    goto :invalid

    :has_position
    check-cast p2, Ln8/d;

    iget-object p2, p2, Ln8/d;->f:Lcom/aspiro/wamp/model/MediaItem;

    instance-of v0, p2, Lcom/aspiro/wamp/model/FavoriteTrack;

    if-eqz v0, :invalid

    check-cast p2, Lcom/aspiro/wamp/model/FavoriteTrack;

    iget-object v0, p0, Lradiant/swipe/FavoriteTracksResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;

    if-eqz v0, :invalid

    invoke-virtual {v0, p1, p2}, Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;->Y(ILcom/aspiro/wamp/model/FavoriteTrack;)Z

    move-result v0

    if-eqz v0, :invalid

    invoke-virtual {p2}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v0

    new-instance v1, Lradiant/swipe/QueueRequest;

    invoke-direct {v1, p1, p2, v0}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    return-object v1

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
