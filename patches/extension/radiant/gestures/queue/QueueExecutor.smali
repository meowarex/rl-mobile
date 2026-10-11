.class public final Lradiant/gestures/queue/QueueExecutor;
.super Ljava/lang/Object;
.source "QueueExecutor.smali"


# direct methods
.method private static activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;
    .locals 1

    :unwrap
    instance-of v0, p0, Landroidx/fragment/app/FragmentActivity;

    if-nez v0, :ready

    instance-of v0, p0, Landroid/content/ContextWrapper;

    if-eqz v0, :invalid

    check-cast p0, Landroid/content/ContextWrapper;

    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    if-eq v0, p0, :invalid

    move-object p0, v0

    goto :unwrap

    :ready
    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    return-object p0

    :invalid
    const/4 p0, 0x0

    return-object p0
.end method

.method public static addToPlaylistAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;
    .locals 2

    if-eqz p1, :done

    if-eqz p2, :done

    if-eqz p4, :done

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    iget-object v0, p4, Lh4/a;->b:Lo3/a$a;    # MARKER: R8 Lh4/a; Lo3/a$a; b

    if-eqz v0, :done

    invoke-interface {v0, p1, p2, p3}, Lo3/a$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lo3/a;    # MARKER: R8 Lo3/a$a; Lo3/a; a

    move-result-object v0

    if-eqz v0, :done

    iget-object v0, v0, Lo3/a;->m:Lcom/aspiro/wamp/module/album/AlbumProvider;    # MARKER: R8 Lo3/a; l

    if-eqz v0, :done

    new-instance v1, Ld3/f;    # MARKER: R8 Ld3/f;

    invoke-direct {v1, p1, v0, p2, p3}, Ld3/f;-><init>(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/module/album/AlbumProvider;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V    # MARKER: R8 Ld3/f;

    invoke-virtual {v1, p0}, Ld3/f;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Ld3/f; b

    :done
    return-void
.end method

.method public static addToPlaylistMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)V    # MARKER: R8 Lh4/a;
    .locals 1

    if-eqz p1, :done

    if-eqz p2, :done

    if-eqz p4, :done

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    iget-object v0, p4, Lh4/a;->h:Lu3/a$a;    # MARKER: R8 Lh4/a; Lu3/a$a; h

    if-eqz v0, :done

    invoke-interface {v0, p1, p2, p3}, Lu3/a$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lu3/a;    # MARKER: R8 Lu3/a$a; Lu3/a; a

    move-result-object v0

    if-eqz v0, :done

    iget-object v0, v0, Lu3/a;->j:Lk3/m$a;    # MARKER: R8 Lu3/a; Lk3/m$a; j

    if-eqz v0, :done

    invoke-interface {v0, p1, p2, p3}, Lk3/m$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lk3/m;    # MARKER: R8 Lk3/m$a; Lk3/m; a

    move-result-object v0

    if-eqz v0, :done

    invoke-virtual {v0, p0}, Lk3/m;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lk3/m; b

    :done
    return-void
.end method

.method public static addToPlaylistPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    .locals 1

    if-eqz p1, :done

    if-eqz p2, :done

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    new-instance v0, Lcom/aspiro/wamp/contextmenu/item/playlist/f;    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/f;

    invoke-direct {v0, p1, p2, p3}, Lcom/aspiro/wamp/contextmenu/item/playlist/f;-><init>(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/f;

    invoke-virtual {v0, p0}, Lcom/aspiro/wamp/contextmenu/item/playlist/f;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/f; b

    :done
    return-void
.end method

.method public static addToPlaylistTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V
    .locals 1

    if-eqz p1, :done

    if-eqz p2, :done

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    new-instance v0, Lm3/d;    # MARKER: R8 Lm3/d;

    invoke-direct {v0, p1, p2, p3}, Lm3/d;-><init>(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)V    # MARKER: R8 Lm3/d;

    invoke-virtual {v0, p0}, Lm3/d;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lm3/d; b

    :done
    return-void
.end method

.method public static album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;
    .locals 8

    const/4 v0, 0x0

    if-eqz p1, :done

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object v1

    check-cast v1, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    invoke-virtual {v1}, Le5/d0$t2;->A2()Lcom/aspiro/wamp/playqueue/x0;    # MARKER: R8 Le5/d0$t2; Lcom/aspiro/wamp/playqueue/x0; r2

    move-result-object v2

    invoke-virtual {v2}, Lcom/aspiro/wamp/playqueue/x0;->a()Lcom/aspiro/wamp/player/c;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/x0; Lcom/aspiro/wamp/player/c; a

    move-result-object v2

    invoke-virtual {v2}, Lcom/aspiro/wamp/player/c;->b()Lcom/aspiro/wamp/model/MediaItemParent;    # MARKER: R8 Lcom/aspiro/wamp/player/c; b

    move-result-object v2

    if-eqz v2, :play

    if-eqz p4, :done

    :unwrap_context
    instance-of v2, p0, Landroidx/fragment/app/FragmentActivity;

    if-nez v2, :has_activity

    instance-of v2, p0, Landroid/content/ContextWrapper;

    if-eqz v2, :done

    move-object v2, p0

    check-cast v2, Landroid/content/ContextWrapper;

    invoke-virtual {v2}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v2

    if-eq v2, p0, :done

    move-object p0, v2

    goto :unwrap_context

    :has_activity

    iget-object v2, p4, Lh4/a;->b:Lo3/a$a;    # MARKER: R8 Lh4/a; Lo3/a$a; b

    invoke-interface {v2, p1, p2, p3}, Lo3/a$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lo3/a;    # MARKER: R8 Lo3/a$a; Lo3/a; a

    move-result-object v2

    iget-object v2, v2, Lo3/a;->f:Ld3/g$a;    # MARKER: R8 Lo3/a; Ld3/g$a; e

    invoke-interface {v2, p1, p2, p3}, Ld3/g$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Ld3/g;    # MARKER: R8 Ld3/g$a; Ld3/g; a

    move-result-object p1

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p1, p0}, Ld3/g;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Ld3/g; b

    goto :done

    :play
    invoke-virtual {v1}, Le5/d0$t2;->F3()Lcom/aspiro/wamp/playback/e;    # MARKER: R8 Le5/d0$t2; Lcom/aspiro/wamp/playback/e; u3

    move-result-object p0

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result p1

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p3, p2, v0}, Lcom/aspiro/wamp/playback/e;->a(ILcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lhu/akarnokd/rxjava/interop/f;    # MARKER: R8 Lcom/aspiro/wamp/playback/e; Lhu/akarnokd/rxjava/interop/f; a

    move-result-object v0

    :done
    return-object v0
.end method

.method public static hasActiveQueue()Z
    .locals 2

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object v0

    check-cast v0, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    invoke-virtual {v0}, Le5/d0$t2;->A2()Lcom/aspiro/wamp/playqueue/x0;    # MARKER: R8 Le5/d0$t2; Lcom/aspiro/wamp/playqueue/x0; r2

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/playqueue/x0;->a()Lcom/aspiro/wamp/player/c;    # MARKER: R8 Lcom/aspiro/wamp/playqueue/x0; Lcom/aspiro/wamp/player/c; a

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/player/c;->b()Lcom/aspiro/wamp/model/MediaItemParent;    # MARKER: R8 Lcom/aspiro/wamp/player/c; b

    move-result-object v0

    if-eqz v0, :empty

    const/4 v0, 0x1

    return v0

    :empty
    const/4 v0, 0x0

    return v0
.end method

.method public static mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;
    .locals 4

    const/4 v0, 0x0

    if-eqz p1, :done

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    if-eqz p4, :done

    :unwrap_context
    instance-of v1, p0, Landroidx/fragment/app/FragmentActivity;

    if-nez v1, :has_activity

    instance-of v1, p0, Landroid/content/ContextWrapper;

    if-eqz v1, :done

    move-object v1, p0

    check-cast v1, Landroid/content/ContextWrapper;

    invoke-virtual {v1}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v1

    if-eq v1, p0, :done

    move-object p0, v1

    goto :unwrap_context

    :has_activity

    iget-object v1, p4, Lh4/a;->h:Lu3/a$a;    # MARKER: R8 Lh4/a; Lu3/a$a; h

    invoke-interface {v1, p1, p2, p3}, Lu3/a$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lu3/a;    # MARKER: R8 Lu3/a$a; Lu3/a; a

    move-result-object v1

    iget-object v1, v1, Lu3/a;->e:Lk3/p$a;    # MARKER: R8 Lu3/a; Lk3/p$a; e

    invoke-interface {v1, p1, p2, p3}, Lk3/p$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lk3/p;    # MARKER: R8 Lk3/p$a; Lk3/p; a

    move-result-object p1

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p1, p0}, Lk3/p;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lk3/p; b

    goto :done

    :play
    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object p0

    invoke-virtual {p0}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object p0

    check-cast p0, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    invoke-virtual {p0}, Le5/d0$t2;->I3()Lcom/aspiro/wamp/playback/e0;    # MARKER: R8 Le5/d0$t2; Lcom/aspiro/wamp/playback/e0; x3

    move-result-object p0

    invoke-virtual {p1}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p3, p2, v0}, Lcom/aspiro/wamp/playback/e0;->a(Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lcom/aspiro/wamp/playback/e0; a

    move-result-object v0

    :done
    return-object v0
.end method

.method public static playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    .locals 4

    if-eqz p1, :done

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I

    move-result v0

    if-lez v0, :done

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object v0

    check-cast v0, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    :unwrap_context
    instance-of v1, p0, Landroidx/fragment/app/FragmentActivity;

    if-nez v1, :has_activity

    instance-of v1, p0, Landroid/content/ContextWrapper;

    if-eqz v1, :done

    move-object v1, p0

    check-cast v1, Landroid/content/ContextWrapper;

    invoke-virtual {v1}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v1

    if-eq v1, p0, :done

    move-object p0, v1

    goto :unwrap_context

    :has_activity

    iget-object v1, v0, Le5/d0$t2;->e9:Ldagger/internal/f;    # MARKER: R8 Le5/d0$t2; Ldagger/internal/f; w8

    invoke-interface {v1}, Lol0/a;->get()Ljava/lang/Object;    # MARKER: R8 Lol0/a;

    move-result-object v1

    check-cast v1, Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;

    invoke-interface {v1, p1, p2, p3}, Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;->a(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/h;    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/h$a; Lcom/aspiro/wamp/contextmenu/item/playlist/h; a

    move-result-object p2

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p2, p0}, Lcom/aspiro/wamp/contextmenu/item/playlist/h;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/h; b

    goto :done

    :play
    invoke-virtual {v0}, Le5/d0$t2;->J3()Lcom/aspiro/wamp/playback/k0;    # MARKER: R8 Le5/d0$t2; Lcom/aspiro/wamp/playback/k0; y3

    move-result-object p0

    invoke-virtual {p0, p1, p3}, Lcom/aspiro/wamp/playback/k0;->c(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)V    # MARKER: R8 Lcom/aspiro/wamp/playback/k0; c

    :done
    return-void
.end method

.method public static playNextAlbum(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :done

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    if-eqz p4, :done

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    iget-object v1, p4, Lh4/a;->b:Lo3/a$a;    # MARKER: R8 Lh4/a; Lo3/a$a; b

    invoke-interface {v1, p1, p2, p3}, Lo3/a$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lo3/a;    # MARKER: R8 Lo3/a$a; Lo3/a; a

    move-result-object v1

    iget-object v1, v1, Lo3/a;->e:Ld3/j$a;    # MARKER: R8 Lo3/a; Ld3/j$a; d

    invoke-interface {v1, p1, p2, p3}, Ld3/j$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Ld3/j;    # MARKER: R8 Ld3/j$a; Ld3/j; a

    move-result-object p1

    invoke-virtual {p1, p0}, Ld3/j;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Ld3/j; b

    goto :done

    :play
    invoke-static {p0, p1, p2, p3, p4}, Lradiant/gestures/queue/QueueExecutor;->album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    move-result-object v0

    :done
    return-object v0
.end method

.method public static playNextMix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :done

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    if-eqz p4, :done

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    iget-object v1, p4, Lh4/a;->h:Lu3/a$a;    # MARKER: R8 Lh4/a; Lu3/a$a; h

    invoke-interface {v1, p1, p2, p3}, Lu3/a$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lu3/a;    # MARKER: R8 Lu3/a$a; Lu3/a; a

    move-result-object v1

    iget-object v1, v1, Lu3/a;->d:Lk3/s$a;    # MARKER: R8 Lu3/a; Lk3/s$a; d

    invoke-interface {v1, p1, p2, p3}, Lk3/s$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lk3/s;    # MARKER: R8 Lk3/s$a; Lk3/s; a

    move-result-object p1

    invoke-virtual {p1, p0}, Lk3/s;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lk3/s; b

    goto :done

    :play
    invoke-static {p0, p1, p2, p3, p4}, Lradiant/gestures/queue/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;    # MARKER: R8 Lh4/a;

    move-result-object v0

    :done
    return-object v0
.end method

.method public static playNextPlaylist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    .locals 2

    if-eqz p1, :done

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I

    move-result v0

    if-lez v0, :done

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v0

    if-eqz v0, :play

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object v0

    check-cast v0, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    iget-object v0, v0, Le5/d0$t2;->d9:Ldagger/internal/f;    # MARKER: R8 Le5/d0$t2; Ldagger/internal/f; v8

    invoke-interface {v0}, Lol0/a;->get()Ljava/lang/Object;    # MARKER: R8 Lol0/a;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/contextmenu/item/playlist/z$a;    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/z$a;

    invoke-interface {v0, p1, p2, p3}, Lcom/aspiro/wamp/contextmenu/item/playlist/z$a;->a(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/z;    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/z$a; Lcom/aspiro/wamp/contextmenu/item/playlist/z; a

    move-result-object p1

    invoke-virtual {p1, p0}, Lcom/aspiro/wamp/contextmenu/item/playlist/z;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lcom/aspiro/wamp/contextmenu/item/playlist/z; b

    goto :done

    :play
    invoke-static {p0, p1, p2, p3}, Lradiant/gestures/queue/QueueExecutor;->playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V

    :done
    return-void
.end method

.method public static playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :done

    invoke-static {}, Lradiant/gestures/queue/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    invoke-static {p0}, Lradiant/gestures/queue/QueueExecutor;->activity(Landroid/content/Context;)Landroidx/fragment/app/FragmentActivity;

    move-result-object p0

    if-eqz p0, :done

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object v1

    check-cast v1, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    iget-object v1, v1, Le5/d0$t2;->ga:Ldagger/internal/f;    # MARKER: R8 Le5/d0$t2; Ldagger/internal/f; K9

    invoke-interface {v1}, Lol0/a;->get()Ljava/lang/Object;    # MARKER: R8 Lol0/a;

    move-result-object v1

    check-cast v1, Lm3/i$a;    # MARKER: R8 Lm3/i$a;

    invoke-interface {v1, p1, p2, p3}, Lm3/i$a;->a(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/i;    # MARKER: R8 Lm3/i$a; Lm3/i; a

    move-result-object p1

    invoke-virtual {p1, p0}, Lm3/i;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lm3/i; b

    const/4 v0, 0x1

    goto :done

    :play
    invoke-static {p0, p1, p2, p3}, Lradiant/gestures/queue/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    move-result v0

    :done
    return v0
.end method

.method public static track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z
    .locals 2

    const/4 v0, 0x0

    :unwrap_context
    instance-of v1, p0, Landroidx/fragment/app/FragmentActivity;

    if-nez v1, :has_activity

    instance-of v1, p0, Landroid/content/ContextWrapper;

    if-eqz v1, :done

    move-object v1, p0

    check-cast v1, Landroid/content/ContextWrapper;

    invoke-virtual {v1}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v1

    if-eq v1, p0, :done

    move-object p0, v1

    goto :unwrap_context

    :has_activity

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;    # MARKER: R8 a

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/App;->e()Le5/c;    # MARKER: R8 Le5/c; e

    move-result-object v1

    check-cast v1, Le5/d0$t2;    # MARKER: R8 Le5/d0$t2;

    iget-object v1, v1, Le5/d0$t2;->Z9:Ldagger/internal/f;    # MARKER: R8 Le5/d0$t2; Ldagger/internal/f; k9

    invoke-interface {v1}, Lol0/a;->get()Ljava/lang/Object;    # MARKER: R8 Lol0/a;

    move-result-object v1

    check-cast v1, Lm3/f$a;    # MARKER: R8 Lm3/f$a;

    invoke-interface {v1, p1, p2, p3}, Lm3/f$a;->a(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/f;    # MARKER: R8 Lm3/f$a; Lm3/f; a

    move-result-object p1

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p1, p0}, Lm3/f;->b(Landroidx/fragment/app/FragmentActivity;)V    # MARKER: R8 Lm3/f; b

    const/4 v0, 0x1

    :done
    return v0
.end method
