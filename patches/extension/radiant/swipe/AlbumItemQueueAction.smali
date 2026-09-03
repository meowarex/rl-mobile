.class public final Lradiant/swipe/AlbumItemQueueAction;
.super Ljava/lang/Object;
.source "AlbumItemQueueAction.smali"

# interfaces
.implements Lradiant/swipe/ComposeSwipeAction;


# instance fields
.field private final callback:Lu5/b$a$a;

.field private context:Landroid/content/Context;

.field private final mediaItemId:I

.field private final moduleId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lu5/b$a;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget-object v0, p1, Lu5/b$a;->a:Lu5/b$a$a;

    iput-object v0, p0, Lradiant/swipe/AlbumItemQueueAction;->callback:Lu5/b$a$a;

    iget-object v0, p1, Lu5/b$a;->c:Lu5/b$a$b;

    iget v1, v0, Lu5/b$a$b;->r:I

    iput v1, p0, Lradiant/swipe/AlbumItemQueueAction;->mediaItemId:I

    iget-object v0, v0, Lu5/b$a$b;->s:Ljava/lang/String;

    iput-object v0, p0, Lradiant/swipe/AlbumItemQueueAction;->moduleId:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public invoke(I)Ljava/lang/Object;
    .locals 10

    iget-object v0, p0, Lradiant/swipe/AlbumItemQueueAction;->callback:Lu5/b$a$a;

    iget v1, p0, Lradiant/swipe/AlbumItemQueueAction;->mediaItemId:I

    iget-object v2, p0, Lradiant/swipe/AlbumItemQueueAction;->moduleId:Ljava/lang/String;

    const/4 v3, 0x3

    if-eq p1, v3, :active_queue

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v3

    if-nez v3, :active_queue

    invoke-interface {v0, v1, v2}, Lu5/b$a$a;->g(ILjava/lang/String;)V

    goto :done

    :active_queue
    iget-object v3, p0, Lradiant/swipe/AlbumItemQueueAction;->context:Landroid/content/Context;

    if-eqz v3, :done

    instance-of v4, v0, Lu5/g;

    if-eqz v4, :done

    check-cast v0, Lu5/g;

    invoke-virtual {v0, v2}, Lk5/f;->l(Ljava/lang/String;)Lcom/aspiro/wamp/dynamicpages/data/model/Module;

    move-result-object v4

    instance-of v5, v4, Lcom/aspiro/wamp/dynamicpages/data/model/collection/AlbumItemCollectionModule;

    if-eqz v5, :done

    check-cast v4, Lcom/aspiro/wamp/dynamicpages/data/model/collection/AlbumItemCollectionModule;

    invoke-virtual {v4}, Lcom/aspiro/wamp/dynamicpages/data/model/collection/AlbumItemCollectionModule;->getMediaItemParents()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :find_item
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :done

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/aspiro/wamp/model/MediaItemParent;

    invoke-virtual {v6}, Lcom/aspiro/wamp/model/MediaItemParent;->getMediaItem()Lcom/aspiro/wamp/model/MediaItem;

    move-result-object v7

    if-eqz v7, :find_item

    invoke-virtual {v7}, Lcom/aspiro/wamp/model/MediaItem;->getId()I

    move-result v8

    if-ne v8, v1, :find_item

    instance-of v8, v7, Lcom/aspiro/wamp/model/Track;

    if-eqz v8, :done

    check-cast v7, Lcom/aspiro/wamp/model/Track;

    iget-object v8, v0, Lu5/g;->h:Lcom/aspiro/wamp/model/AvailabilityInteractor;

    invoke-interface {v8, v7}, Lcom/aspiro/wamp/model/AvailabilityInteractor;->getAvailability(Lcom/aspiro/wamp/model/MediaItem;)Lcom/aspiro/wamp/model/Availability$MediaItem;

    move-result-object v8

    invoke-virtual {v8}, Lcom/aspiro/wamp/model/Availability$MediaItem;->isAvailable()Z

    move-result v8

    if-eqz v8, :done

    new-instance v5, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    invoke-virtual {v4}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getPageId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4}, Lcom/aspiro/wamp/dynamicpages/data/model/Module;->getPosition()I

    move-result v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v5, v6, v8, v9}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v7}, Lcom/aspiro/wamp/model/MediaItem;->getAlbum()Lcom/aspiro/wamp/model/Album;

    move-result-object v6

    if-eqz v6, :done

    iget-object v8, v0, Lu5/g;->j:Lcom/tidal/android/navigation/NavigationInfo;

    invoke-static {v6, v8}, Lcom/aspiro/wamp/playqueue/source/model/b;->c(Lcom/aspiro/wamp/model/Album;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/AlbumSource;

    move-result-object v6

    invoke-virtual {v6, v7}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    const/4 v8, 0x1

    if-ne p1, v8, :check_add_to_playlist

    invoke-static {v3, v7, v5, v6}, Lradiant/swipe/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :check_add_to_playlist
    const/4 v8, 0x3

    if-ne p1, v8, :append_track

    invoke-static {v3, v7, v5, v6}, Lradiant/swipe/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :append_track
    invoke-static {v3, v7, v5, v6}, Lradiant/swipe/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public invoke()Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lradiant/swipe/AlbumItemQueueAction;->invoke(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lradiant/swipe/AlbumItemQueueAction;->context:Landroid/content/Context;

    return-void
.end method
