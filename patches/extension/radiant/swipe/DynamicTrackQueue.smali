.class public final Lradiant/swipe/DynamicTrackQueue;
.super Ljava/lang/Object;
.source "DynamicTrackQueue.smali"


# direct methods
.method public static handle(Lcom/tidal/android/dynamicpages/ui/modules/tracklist/TrackListModuleManager;Lradiant/swipe/DynamicTrackQueueEvent;)V
    .locals 11

    if-eqz p0, :done

    if-eqz p1, :done

    iget-object v0, p1, Lradiant/swipe/DynamicTrackQueueEvent;->pageId:Ljava/lang/String;

    if-eqz v0, :done

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :done

    iget-object v1, p1, Lradiant/swipe/DynamicTrackQueueEvent;->moduleUuid:Ljava/lang/String;

    if-eqz v1, :done

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :done

    iget-wide v2, p1, Lradiant/swipe/DynamicTrackQueueEvent;->trackId:J

    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-lez v4, :done

    invoke-virtual {p0, v1}, Li60/c;->c(Ljava/lang/String;)Lc60/h;

    move-result-object v4

    instance-of v5, v4, Lc60/b0;

    if-eqz v5, :done

    check-cast v4, Lc60/b0;

    iget-object v5, v4, Lc60/b0;->b:Ljava/lang/String;

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :done

    iget-object v1, v4, Lc60/b0;->f:Ljava/util/ArrayList;

    if-eqz v1, :done

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :find_track
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :done

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    instance-of v6, v5, Lc60/r$b;

    if-eqz v6, :find_track

    check-cast v5, Lc60/r$b;

    iget-object v5, v5, Lc60/r$b;->a:Lh40/n;

    instance-of v6, v5, Lh40/p;

    if-eqz v6, :find_track

    check-cast v5, Lh40/p;

    iget-wide v6, v5, Lh40/p;->a:J

    cmp-long v6, v6, v2

    if-nez v6, :find_track

    iget-object v1, p0, Lcom/tidal/android/dynamicpages/ui/modules/tracklist/TrackListModuleManager;->b:Lcom/tidal/android/dynamicpages/ui/b;

    instance-of v2, v1, Lcom/tidal/android/dynamicpages/ui/c;

    if-eqz v2, :done

    check-cast v1, Lcom/tidal/android/dynamicpages/ui/c;

    iget-object v6, v1, Lcom/tidal/android/dynamicpages/ui/c;->b:Lcom/tidal/android/navigation/NavigationInfo;

    if-eqz v6, :done

    iget-object v1, p1, Lradiant/swipe/DynamicTrackQueueEvent;->context:Landroid/content/Context;

    if-eqz v1, :done

    invoke-static {v5}, Lie0/i;->a(Lh40/p;)Lcom/aspiro/wamp/model/Track;

    move-result-object v7

    if-eqz v7, :done

    iget-object v2, v4, Lc60/b0;->a:Ljava/lang/String;

    if-eqz v2, :done

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :done

    new-instance v8, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    iget v3, v4, Lc60/b0;->e:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v8, v0, v2, v3}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-wide v2, p1, Lradiant/swipe/DynamicTrackQueueEvent;->trackId:J

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    iget-object v3, v4, Lc60/b0;->c:Ljava/lang/String;

    if-eqz v3, :done

    iget-object v10, v4, Lc60/b0;->g:Ljava/lang/String;

    invoke-static {v10}, Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$a;->a(Ljava/lang/String;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;

    move-result-object v4

    invoke-static {v2, v3, v6, v4}, Lcom/aspiro/wamp/playqueue/source/model/b;->j(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;

    move-result-object v9

    if-eqz v9, :done

    invoke-virtual {v9, v7}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    iget v0, p1, Lradiant/swipe/DynamicTrackQueueEvent;->action:I

    const/4 v2, 0x1

    if-ne v0, v2, :check_add_to_playlist

    invoke-static {v1, v7, v8, v9}, Lradiant/swipe/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :check_add_to_playlist
    const/4 v2, 0x3

    if-ne v0, v2, :append

    invoke-static {v1, v7, v8, v9}, Lradiant/swipe/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :append
    invoke-static {v1, v7, v8, v9}, Lradiant/swipe/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    return-void
.end method
