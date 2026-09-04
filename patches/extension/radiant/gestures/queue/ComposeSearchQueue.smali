.class public final Lradiant/gestures/queue/ComposeSearchQueue;
.super Ljava/lang/Object;
.source "ComposeSearchQueue.smali"


# direct methods
.method public static handle(Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;Lradiant/gestures/queue/ComposeSearchQueueEvent;)V
    .locals 10

    if-eqz p0, :done

    if-eqz p1, :done

    iget v0, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    const/4 v1, 0x1

    if-lt v0, v1, :done

    const/4 v1, 0x3

    if-gt v0, v1, :done

    iget-object v8, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->context:Landroid/content/Context;

    if-eqz v8, :done

    iget-object v2, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->id:Ljava/lang/String;

    if-eqz v2, :done

    iget v4, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->type:I

    const/4 v0, 0x1

    if-lt v4, v0, :done

    const/4 v0, 0x4

    if-gt v4, v0, :done

    iget-object v0, p0, Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;->n:Ljava/util/List;    # MARKER: R8 n

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :find_row
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :done

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lmb0/e;    # MARKER: R8 Lmb0/e;

    invoke-static {v1}, Lmb0/f;->a(Lmb0/e;)Ljava/lang/String;    # MARKER: R8 Lmb0/f; Lmb0/e; a

    move-result-object v9

    invoke-virtual {v2, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :find_row

    instance-of v9, v1, Lmb0/a;    # MARKER: R8 Lmb0/a;

    if-eqz v9, :find_row

    check-cast v1, Lmb0/a;    # MARKER: R8 Lmb0/a;

    iget-object v3, v1, Lmb0/a;->a:Lh40/n;    # MARKER: R8 Lmb0/a; Lh40/n; a

    const/4 v9, 0x1

    if-ne v4, v9, :check_album

    instance-of v9, v3, Lh40/p;    # MARKER: R8 Lh40/p;

    if-eqz v9, :find_row

    goto :recover_dependencies

    :check_album
    const/4 v9, 0x2

    if-ne v4, v9, :check_playlist

    instance-of v9, v3, Lh40/a;    # MARKER: R8 Lh40/a;

    if-eqz v9, :find_row

    goto :recover_dependencies

    :check_playlist
    const/4 v9, 0x3

    if-ne v4, v9, :check_mix

    instance-of v9, v3, Lh40/j;    # MARKER: R8 Lh40/j;

    if-eqz v9, :find_row

    goto :recover_dependencies

    :check_mix
    instance-of v9, v3, Lh40/i;    # MARKER: R8 Lh40/i;

    if-eqz v9, :find_row

    :recover_dependencies
    iget-object v9, p0, Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;->d:Lcom/tidal/android/feature/search/ui/e;    # MARKER: R8 Lcom/tidal/android/feature/search/ui/e; d

    instance-of v0, v9, Lv9/e;    # MARKER: R8 Lv9/e;

    if-eqz v0, :done

    check-cast v9, Lv9/e;    # MARKER: R8 Lv9/e;

    iget-object v5, v9, Lv9/e;->b:Lcom/tidal/android/navigation/NavigationInfo;    # MARKER: R8 Lv9/e; b

    iget-object v9, v9, Lv9/e;->a:Lcom/aspiro/wamp/core/k;    # MARKER: R8 Lv9/e; Lcom/aspiro/wamp/core/k; a

    const/4 v6, 0x0

    const/4 v0, 0x2

    if-eq v4, v0, :recover_menu

    const/4 v0, 0x4

    if-ne v4, v0, :dependencies_ready

    :recover_menu

    instance-of v0, v9, Lh9/p1;    # MARKER: R8 Lh9/p1;

    if-eqz v0, :done

    check-cast v9, Lh9/p1;    # MARKER: R8 Lh9/p1;

    iget-object v9, v9, Lh9/p1;->b:Lx40/a;    # MARKER: R8 Lh9/p1; Lx40/a; b

    instance-of v0, v9, Lh4/a;    # MARKER: R8 Lh4/a;

    if-eqz v0, :done

    move-object v6, v9

    check-cast v6, Lh4/a;    # MARKER: R8 Lh4/a;

    :dependencies_ready

    new-instance v7, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    const-string v0, "search"

    invoke-direct {v7, v0, v2}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    if-ne v4, v0, :album

    check-cast v3, Lh40/p;    # MARKER: R8 Lh40/p;

    iget v0, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    const/4 v1, 0x3

    if-eq v0, v1, :queue_track

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v0

    if-eqz v0, :play_track

    :queue_track
    invoke-static {v3}, Lie0/i;->a(Lh40/p;)Lcom/aspiro/wamp/model/Track;    # MARKER: R8 Lie0/i; Lh40/p; a

    move-result-object v9

    iget-object v4, p0, Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;->m:Lkotlinx/coroutines/flow/MutableStateFlow;    # MARKER: R8 m

    invoke-interface {v4}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/tidal/android/feature/search/ui/SearchQuery;

    iget-object v4, v4, Lcom/tidal/android/feature/search/ui/SearchQuery;->a:Ljava/lang/String;    # MARKER: R8 a

    if-nez v4, :track_query_ready

    const-string v4, ""

    :track_query_ready
    const/4 v1, 0x0

    if-eqz v5, :track_navigation_ready

    invoke-static {v5}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;    # MARKER: R8 Lcom/tidal/android/navigation/a; b

    move-result-object v1

    :track_navigation_ready
    invoke-static {v2, v4, v1}, Lcom/aspiro/wamp/playqueue/source/model/b;->o(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/source/model/b; o

    move-result-object v4

    invoke-virtual {v4, v9}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    iget v0, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_track_to_playlist

    invoke-static {v8, v9, v7, v4}, Lradiant/gestures/queue/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :check_add_track_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_track

    invoke-static {v8, v9, v7, v4}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V

    goto :done

    :append_track
    invoke-static {v8, v9, v7, v4}, Lradiant/gestures/queue/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :play_track
    iget-object v5, p0, Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;->m:Lkotlinx/coroutines/flow/MutableStateFlow;    # MARKER: R8 m

    invoke-interface {v5}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/tidal/android/feature/search/ui/SearchQuery;

    iget-object v5, v5, Lcom/tidal/android/feature/search/ui/SearchQuery;->a:Ljava/lang/String;    # MARKER: R8 a

    if-nez v5, :play_query_ready

    const-string v5, ""

    :play_query_ready
    iget-object v9, p0, Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;->f:Lcom/tidal/android/feature/search/ui/f;    # MARKER: R8 Lcom/tidal/android/feature/search/ui/f; f

    iget-wide v0, v3, Lh40/p;->a:J    # MARKER: R8 Lh40/p; a

    invoke-interface {v9, v0, v1, v3, v5}, Lcom/tidal/android/feature/search/ui/f;->a(JLh40/p;Ljava/lang/String;)V    # MARKER: R8 Lcom/tidal/android/feature/search/ui/f; Lh40/p; a

    goto :done

    :album
    const/4 v0, 0x2

    if-ne v4, v0, :playlist

    check-cast v3, Lh40/a;    # MARKER: R8 Lh40/a;

    invoke-static {v3}, Lie0/a;->a(Lh40/a;)Lcom/aspiro/wamp/model/Album;    # MARKER: R8 Lie0/a; Lh40/a; a

    move-result-object v9

    iget v0, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_album_to_playlist

    invoke-static {v8, v9, v7, v5, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :check_add_album_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_album

    invoke-static {v8, v9, v7, v5, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :append_album
    invoke-static {v8, v9, v7, v5, v6}, Lradiant/gestures/queue/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :playlist
    const/4 v0, 0x3

    if-ne v4, v0, :mix

    check-cast v3, Lh40/j;    # MARKER: R8 Lh40/j;

    invoke-static {v3}, Lie0/h;->a(Lh40/j;)Lcom/aspiro/wamp/model/Playlist;    # MARKER: R8 Lie0/h; Lh40/j; a

    move-result-object v9

    iget v0, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_playlist_to_playlist

    invoke-static {v8, v9, v7, v5}, Lradiant/gestures/queue/QueueExecutor;->playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :check_add_playlist_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_playlist

    invoke-static {v8, v9, v7, v5}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :append_playlist
    invoke-static {v8, v9, v7, v5}, Lradiant/gestures/queue/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    goto :done

    :mix
    check-cast v3, Lh40/i;    # MARKER: R8 Lh40/i;

    invoke-static {v3}, Lie0/g;->b(Lh40/i;)Lcom/aspiro/wamp/mix/model/Mix;    # MARKER: R8 Lie0/g; Lh40/i; b

    move-result-object v9

    iget v0, p1, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    const/4 v1, 0x1

    if-ne v0, v1, :check_add_mix_to_playlist

    invoke-static {v8, v9, v7, v5, v6}, Lradiant/gestures/queue/QueueExecutor;->playNextMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    goto :done

    :check_add_mix_to_playlist
    const/4 v1, 0x3

    if-ne v0, v1, :append_mix

    invoke-static {v8, v9, v7, v5, v6}, Lradiant/gestures/queue/QueueExecutor;->addToPlaylistMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;

    goto :done

    :append_mix
    invoke-static {v8, v9, v7, v5, v6}, Lradiant/gestures/queue/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    :done
    return-void
.end method
