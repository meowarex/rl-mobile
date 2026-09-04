.class public final Lradiant/gestures/queue/DynamicMediaQueue;
.super Ljava/lang/Object;
.source "DynamicMediaQueue.smali"


# direct methods
.method public static handleCompact(Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;Lradiant/gestures/queue/DynamicMediaQueueEvent;)V    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;
    .locals 13

    if-eqz p0, :done

    if-eqz p1, :done

    iget v4, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v5, 0x1

    if-lt v4, v5, :done

    const/4 v5, 0x3

    if-gt v4, v5, :done

    iget-object v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->pageId:Ljava/lang/String;

    iget-object v1, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->moduleUuid:Ljava/lang/String;

    iget-object v2, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->itemId:Ljava/lang/String;

    iget v3, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->mediaType:I

    if-eqz v0, :done

    if-eqz v1, :done

    if-eqz v2, :done

    const/4 v4, 0x1

    if-lt v3, v4, :done

    const/4 v4, 0x4

    if-gt v3, v4, :done

    invoke-virtual {p0, v1}, Li60/c;->c(Ljava/lang/String;)Lc60/h;    # MARKER: R8 Li60/c; Lc60/h; c

    move-result-object v4

    instance-of v5, v4, Lc60/f;    # MARKER: R8 Lc60/f;

    if-eqz v5, :done

    check-cast v4, Lc60/f;    # MARKER: R8 Lc60/f;

    iget-object v5, v4, Lc60/f;->b:Ljava/lang/String;    # MARKER: R8 Lc60/f; b

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :done

    iget-object v1, v4, Lc60/f;->g:Ljava/util/ArrayList;    # MARKER: R8 Lc60/f; g

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :find_media
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :done

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    instance-of v5, v6, Lc60/r;    # MARKER: R8 Lc60/r;

    if-eqz v5, :find_media

    check-cast v6, Lc60/r;    # MARKER: R8 Lc60/r;

    invoke-static {v6}, Lc60/s;->a(Lc60/r;)Ljava/lang/String;    # MARKER: R8 Lc60/s; Lc60/r; a

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :find_media

    instance-of v5, v6, Lc60/r$b;    # MARKER: R8 Lc60/r$b;

    if-eqz v5, :done

    check-cast v6, Lc60/r$b;    # MARKER: R8 Lc60/r$b;

    iget-object v7, v6, Lc60/r$b;->a:Lh40/n;    # MARKER: R8 Lc60/r$b; Lh40/n; a

    const/4 v5, 0x1

    if-ne v3, v5, :check_mix

    instance-of v5, v7, Lh40/a;    # MARKER: R8 Lh40/a;

    if-eqz v5, :done

    goto :dependencies

    :check_mix
    const/4 v5, 0x2

    if-ne v3, v5, :check_playlist

    instance-of v5, v7, Lh40/i;    # MARKER: R8 Lh40/i;

    if-eqz v5, :done

    goto :dependencies

    :check_playlist
    const/4 v5, 0x3

    if-ne v3, v5, :check_track

    instance-of v5, v7, Lh40/j;    # MARKER: R8 Lh40/j;

    if-eqz v5, :done

    goto :dependencies

    :check_track
    instance-of v5, v7, Lh40/p;    # MARKER: R8 Lh40/p;

    if-eqz v5, :done

    :dependencies
    iget-object v8, p0, Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;->b:Lcom/tidal/android/dynamicpages/ui/b;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a; Lcom/tidal/android/dynamicpages/ui/b; b

    instance-of v5, v8, Lcom/tidal/android/dynamicpages/ui/c;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c;

    if-eqz v5, :done

    check-cast v8, Lcom/tidal/android/dynamicpages/ui/c;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c;

    iget-object v5, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->context:Landroid/content/Context;

    if-eqz v5, :done

    iget-object v9, v8, Lcom/tidal/android/dynamicpages/ui/c;->b:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; b

    new-instance v10, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    iget-object v11, v4, Lc60/f;->a:Ljava/lang/String;    # MARKER: R8 Lc60/f; a

    iget v12, v4, Lc60/f;->d:I    # MARKER: R8 Lc60/f; d

    invoke-static {v12}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v12

    invoke-direct {v10, v0, v11, v12}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    if-ne v3, v0, :mix

    check-cast v7, Lh40/a;    # MARKER: R8 Lh40/a;

    invoke-static {v7}, Lie0/a;->a(Lh40/a;)Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lie0/a; Lh40/a; a

    move-result-object v12

    invoke-static {v8}, Lradiant/gestures/queue/DynamicMediaQueue;->menu(Lcom/tidal/android/dynamicpages/ui/c;)Lh4/a;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; Lh4/a;

    move-result-object v6

    if-eqz v6, :done

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_album_to_playlist

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :check_add_album_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_album

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :append_album
    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :mix
    const/4 v0, 0x2

    if-ne v3, v0, :playlist

    check-cast v7, Lh40/i;    # MARKER: R8 Lh40/i;

    invoke-static {v7}, Lie0/g;->b(Lh40/i;)Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lie0/g; Lh40/i; b

    move-result-object v12

    invoke-static {v8}, Lradiant/gestures/queue/DynamicMediaQueue;->menu(Lcom/tidal/android/dynamicpages/ui/c;)Lh4/a;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; Lh4/a;

    move-result-object v6

    if-eqz v6, :done

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_mix_to_playlist

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :check_add_mix_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_mix

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :append_mix
    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :playlist
    const/4 v0, 0x3

    if-ne v3, v0, :track

    check-cast v7, Lh40/j;    # MARKER: R8 Lh40/j;

    invoke-static {v7}, Lie0/h;->a(Lh40/j;)Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lie0/h; Lh40/j; a

    move-result-object v12

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_playlist_to_playlist

    invoke-static {v5, v12, v10, v9}, Lradiant/gestures/queue/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :check_add_playlist_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_playlist

    invoke-static {v5, v12, v10, v9}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append_playlist
    invoke-static {v5, v12, v10, v9}, Lradiant/gestures/queue/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :track
    check-cast v7, Lh40/p;    # MARKER: R8 Lh40/p;

    invoke-static {v7}, Lie0/i;->a(Lh40/p;)Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lie0/i; Lh40/p; a

    move-result-object v12

    const/4 v6, 0x0

    if-eqz v9, :navigation_ready

    invoke-static {v9}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;    # MARKER: R8 Lcom/tidal/android/navigation/a; b

    move-result-object v6

    :navigation_ready
    iget-object v0, v4, Lc60/f;->e:Ljava/lang/String;    # MARKER: R8 Lc60/f; e

    invoke-static {v2, v0, v6}, Lcom/aspiro/wamp/playqueue/source/model/b;->o(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/source/model/b; o

    move-result-object v11

    invoke-virtual {v11, v12}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_track_to_playlist

    invoke-static {v5, v12, v10, v11}, Lradiant/gestures/queue/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :check_add_track_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_track

    invoke-static {v5, v12, v10, v11}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :append_track
    invoke-static {v5, v12, v10, v11}, Lradiant/gestures/queue/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    return-void
.end method

.method public static handlePublicPlaylist(Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/PublicPlaylistListModuleManager;Lradiant/gestures/queue/DynamicMediaQueueEvent;)V
    .locals 11

    if-eqz p0, :done

    if-eqz p1, :done

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-lt v0, v1, :done

    const/4 v1, 0x3

    if-gt v0, v1, :done

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->mediaType:I

    const/4 v1, 0x3

    if-ne v0, v1, :done

    iget-object v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->pageId:Ljava/lang/String;

    iget-object v1, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->moduleUuid:Ljava/lang/String;

    iget-object v2, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->itemId:Ljava/lang/String;

    if-eqz v0, :done

    if-eqz v1, :done

    if-eqz v2, :done

    invoke-virtual {p0, v1}, Li60/c;->c(Ljava/lang/String;)Lc60/h;    # MARKER: R8 Li60/c; Lc60/h; c

    move-result-object v3

    instance-of v4, v3, Lc60/v;    # MARKER: R8 Lc60/v;

    if-eqz v4, :done

    check-cast v3, Lc60/v;    # MARKER: R8 Lc60/v;

    iget-object v4, v3, Lc60/v;->b:Ljava/lang/String;    # MARKER: R8 Lc60/v; b

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :done

    iget-object v1, v3, Lc60/v;->f:Ljava/util/ArrayList;    # MARKER: R8 Lc60/v; f

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :find_playlist
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :done

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    instance-of v5, v4, Lc60/r;    # MARKER: R8 Lc60/r;

    if-eqz v5, :find_playlist

    check-cast v4, Lc60/r;    # MARKER: R8 Lc60/r;

    invoke-static {v4}, Lc60/s;->a(Lc60/r;)Ljava/lang/String;    # MARKER: R8 Lc60/s; Lc60/r; a

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :find_playlist

    instance-of v5, v4, Lc60/r$b;    # MARKER: R8 Lc60/r$b;

    if-eqz v5, :done

    check-cast v4, Lc60/r$b;    # MARKER: R8 Lc60/r$b;

    iget-object v4, v4, Lc60/r$b;->a:Lh40/n;    # MARKER: R8 Lc60/r$b; Lh40/n; a

    instance-of v5, v4, Lh40/j;    # MARKER: R8 Lh40/j;

    if-eqz v5, :done

    check-cast v4, Lh40/j;    # MARKER: R8 Lh40/j;

    iget-object v5, p0, Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/PublicPlaylistListModuleManager;->f:Lcom/tidal/android/dynamicpages/ui/b;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/b; f

    instance-of v6, v5, Lcom/tidal/android/dynamicpages/ui/c;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c;

    if-eqz v6, :done

    check-cast v5, Lcom/tidal/android/dynamicpages/ui/c;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c;

    iget-object v6, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->context:Landroid/content/Context;

    if-eqz v6, :done

    iget-object v7, v5, Lcom/tidal/android/dynamicpages/ui/c;->b:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; b

    new-instance v8, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    iget-object v9, v3, Lc60/v;->a:Ljava/lang/String;    # MARKER: R8 Lc60/v; a

    iget v10, v3, Lc60/v;->e:I    # MARKER: R8 Lc60/v; e

    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    invoke-direct {v8, v0, v9, v10}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v4}, Lie0/h;->a(Lh40/j;)Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lie0/h; Lh40/j; a

    move-result-object v4

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_playlist_to_playlist

    invoke-static {v6, v4, v8, v7}, Lradiant/gestures/queue/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :check_add_playlist_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_playlist

    invoke-static {v6, v4, v8, v7}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append_playlist
    invoke-static {v6, v4, v8, v7}, Lradiant/gestures/queue/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    :done
    return-void
.end method

.method public static handleVertical(Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/VerticalListCardModuleManager;Lradiant/gestures/queue/DynamicMediaQueueEvent;)V
    .locals 13

    if-eqz p0, :done

    if-eqz p1, :done

    iget v4, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v5, 0x1

    if-lt v4, v5, :done

    const/4 v5, 0x3

    if-gt v4, v5, :done

    iget-object v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->pageId:Ljava/lang/String;

    iget-object v1, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->moduleUuid:Ljava/lang/String;

    iget-object v2, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->itemId:Ljava/lang/String;

    iget v3, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->mediaType:I

    if-eqz v0, :done

    if-eqz v1, :done

    if-eqz v2, :done

    const/4 v4, 0x1

    if-lt v3, v4, :done

    const/4 v4, 0x4

    if-gt v3, v4, :done

    invoke-virtual {p0, v1}, Li60/c;->c(Ljava/lang/String;)Lc60/h;    # MARKER: R8 Li60/c; Lc60/h; c

    move-result-object v4

    instance-of v5, v4, Lc60/c0;    # MARKER: R8 Lc60/c0;

    if-eqz v5, :done

    check-cast v4, Lc60/c0;    # MARKER: R8 Lc60/c0;

    iget-object v5, v4, Lc60/c0;->b:Ljava/lang/String;    # MARKER: R8 Lc60/c0; b

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :done

    iget-object v1, v4, Lc60/c0;->g:Ljava/util/ArrayList;    # MARKER: R8 Lc60/c0; g

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :find_media
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :done

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    instance-of v5, v6, Lc60/r;    # MARKER: R8 Lc60/r;

    if-eqz v5, :find_media

    check-cast v6, Lc60/r;    # MARKER: R8 Lc60/r;

    invoke-static {v6}, Lc60/s;->a(Lc60/r;)Ljava/lang/String;    # MARKER: R8 Lc60/s; Lc60/r; a

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :find_media

    instance-of v5, v6, Lc60/r$b;    # MARKER: R8 Lc60/r$b;

    if-eqz v5, :done

    check-cast v6, Lc60/r$b;    # MARKER: R8 Lc60/r$b;

    iget-object v7, v6, Lc60/r$b;->a:Lh40/n;    # MARKER: R8 Lc60/r$b; Lh40/n; a

    const/4 v5, 0x1

    if-ne v3, v5, :check_mix

    instance-of v5, v7, Lh40/a;    # MARKER: R8 Lh40/a;

    if-eqz v5, :done

    goto :dependencies

    :check_mix
    const/4 v5, 0x2

    if-ne v3, v5, :check_playlist

    instance-of v5, v7, Lh40/i;    # MARKER: R8 Lh40/i;

    if-eqz v5, :done

    goto :dependencies

    :check_playlist
    const/4 v5, 0x3

    if-ne v3, v5, :check_track

    instance-of v5, v7, Lh40/j;    # MARKER: R8 Lh40/j;

    if-eqz v5, :done

    goto :dependencies

    :check_track
    instance-of v5, v7, Lh40/p;    # MARKER: R8 Lh40/p;

    if-eqz v5, :done

    :dependencies
    iget-object v8, p0, Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/VerticalListCardModuleManager;->e:Lcom/tidal/android/dynamicpages/ui/b;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/b; e

    instance-of v5, v8, Lcom/tidal/android/dynamicpages/ui/c;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c;

    if-eqz v5, :done

    check-cast v8, Lcom/tidal/android/dynamicpages/ui/c;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c;

    iget-object v5, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->context:Landroid/content/Context;

    if-eqz v5, :done

    iget-object v9, v8, Lcom/tidal/android/dynamicpages/ui/c;->b:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; b

    new-instance v10, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    iget-object v11, v4, Lc60/c0;->a:Ljava/lang/String;    # MARKER: R8 Lc60/c0; a

    iget v12, v4, Lc60/c0;->f:I    # MARKER: R8 Lc60/c0; f

    invoke-static {v12}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v12

    invoke-direct {v10, v0, v11, v12}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    if-ne v3, v0, :mix

    check-cast v7, Lh40/a;    # MARKER: R8 Lh40/a;

    invoke-static {v7}, Lie0/a;->a(Lh40/a;)Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lie0/a; Lh40/a; a

    move-result-object v12

    invoke-static {v8}, Lradiant/gestures/queue/DynamicMediaQueue;->menu(Lcom/tidal/android/dynamicpages/ui/c;)Lh4/a;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; Lh4/a;

    move-result-object v6

    if-eqz v6, :done

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_album_to_playlist

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :check_add_album_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_album

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :append_album
    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :mix
    const/4 v0, 0x2

    if-ne v3, v0, :playlist

    check-cast v7, Lh40/i;    # MARKER: R8 Lh40/i;

    invoke-static {v7}, Lie0/g;->b(Lh40/i;)Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lie0/g; Lh40/i; b

    move-result-object v12

    invoke-static {v8}, Lradiant/gestures/queue/DynamicMediaQueue;->menu(Lcom/tidal/android/dynamicpages/ui/c;)Lh4/a;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; Lh4/a;

    move-result-object v6

    if-eqz v6, :done

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_mix_to_playlist

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :check_add_mix_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_mix

    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :append_mix
    invoke-static {v5, v12, v10, v9, v6}, Lradiant/gestures/queue/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :playlist
    const/4 v0, 0x3

    if-ne v3, v0, :track

    check-cast v7, Lh40/j;    # MARKER: R8 Lh40/j;

    invoke-static {v7}, Lie0/h;->a(Lh40/j;)Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lie0/h; Lh40/j; a

    move-result-object v12

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_playlist_to_playlist

    invoke-static {v5, v12, v10, v9}, Lradiant/gestures/queue/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :check_add_playlist_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_playlist

    invoke-static {v5, v12, v10, v9}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append_playlist
    invoke-static {v5, v12, v10, v9}, Lradiant/gestures/queue/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :track
    check-cast v7, Lh40/p;    # MARKER: R8 Lh40/p;

    invoke-static {v7}, Lie0/i;->a(Lh40/p;)Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lie0/i; Lh40/p; a

    move-result-object v12

    const/4 v6, 0x0

    if-eqz v9, :navigation_ready

    invoke-static {v9}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;    # MARKER: R8 Lcom/tidal/android/navigation/a; b

    move-result-object v6

    :navigation_ready
    iget-object v0, v4, Lc60/c0;->c:Ljava/lang/String;    # MARKER: R8 Lc60/c0; c

    invoke-static {v2, v0, v6}, Lcom/aspiro/wamp/playqueue/source/model/b;->o(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/source/model/b; o

    move-result-object v11

    invoke-virtual {v11, v12}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    iget v0, p1, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_track_to_playlist

    invoke-static {v5, v12, v10, v11}, Lradiant/gestures/queue/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :check_add_track_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_track

    invoke-static {v5, v12, v10, v11}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :append_track
    invoke-static {v5, v12, v10, v11}, Lradiant/gestures/queue/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    return-void
.end method

.method private static menu(Lcom/tidal/android/dynamicpages/ui/c;)Lh4/a;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; Lh4/a;
    .locals 2

    iget-object v0, p0, Lcom/tidal/android/dynamicpages/ui/c;->a:Lcom/aspiro/wamp/core/k;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/c; Lcom/aspiro/wamp/core/k; a

    instance-of v1, v0, Lh9/p1;    # MARKER: R8 Lh9/p1;

    if-eqz v1, :invalid

    check-cast v0, Lh9/p1;    # MARKER: R8 Lh9/p1;

    iget-object v0, v0, Lh9/p1;->b:Lx40/a;    # MARKER: R8 Lh9/p1; Lx40/a; b

    instance-of v1, v0, Lh4/a;    # MARKER: R8 Lh4/a;

    if-eqz v1, :invalid

    check-cast v0, Lh4/a;    # MARKER: R8 Lh4/a;

    return-object v0

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method
