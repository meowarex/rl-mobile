.class public final Lradiant/swipe/QueueExecutor;
.super Ljava/lang/Object;
.source "QueueExecutor.smali"


# direct methods
.method public static album(Landroid/content/Context;Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;
    .locals 8

    const/4 v0, 0x0

    if-eqz p0, :done

    if-eqz p1, :done

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/App;->e()Le5/c;

    move-result-object v1

    check-cast v1, Le5/z$n2;

    invoke-virtual {v1}, Le5/z$n2;->r2()Lcom/aspiro/wamp/playqueue/g1;

    move-result-object v2

    invoke-virtual {v2}, Lcom/aspiro/wamp/playqueue/g1;->a()Lcom/aspiro/wamp/player/d;

    move-result-object v2

    invoke-virtual {v2}, Lcom/aspiro/wamp/player/d;->b()Lcom/aspiro/wamp/model/MediaItemParent;

    move-result-object v2

    if-eqz v2, :play

    if-eqz p4, :done

    iget-object v2, p4, Lh4/a;->b:Lo3/a$a;

    invoke-interface {v2, p1, p2, p3}, Lo3/a$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lo3/a;

    move-result-object v2

    iget-object v2, v2, Lo3/a;->e:Lc3/i$a;

    invoke-interface {v2, p1, p2, p3}, Lc3/i$a;->a(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lc3/i;

    move-result-object p1

    instance-of p2, p0, Landroidx/fragment/app/FragmentActivity;

    if-eqz p2, :done

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p1, p0}, Lc3/i;->b(Landroidx/fragment/app/FragmentActivity;)V

    goto :done

    :play
    invoke-virtual {v1}, Le5/z$n2;->u3()Lcom/aspiro/wamp/playback/f;

    move-result-object p0

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/Album;->getId()I

    move-result p1

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p3, p2, v0}, Lcom/aspiro/wamp/playback/f;->a(ILcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lhu/akarnokd/rxjava/interop/f;

    move-result-object v0

    :done
    return-object v0
.end method

.method public static hasActiveQueue()Z
    .locals 2

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/App;->e()Le5/c;

    move-result-object v0

    check-cast v0, Le5/z$n2;

    invoke-virtual {v0}, Le5/z$n2;->r2()Lcom/aspiro/wamp/playqueue/g1;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/playqueue/g1;->a()Lcom/aspiro/wamp/player/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/player/d;->b()Lcom/aspiro/wamp/model/MediaItemParent;

    move-result-object v0

    if-eqz v0, :empty

    const/4 v0, 0x1

    return v0

    :empty
    const/4 v0, 0x0

    return v0
.end method

.method public static mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;
    .locals 4

    const/4 v0, 0x0

    if-eqz p0, :done

    if-eqz p1, :done

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
    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    if-eqz p4, :done

    iget-object v1, p4, Lh4/a;->h:Lu3/a$a;

    invoke-interface {v1, p1, p2, p3}, Lu3/a$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lu3/a;

    move-result-object v1

    iget-object v1, v1, Lu3/a;->e:Lj3/n$a;

    invoke-interface {v1, p1, p2, p3}, Lj3/n$a;->a(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lj3/n;

    move-result-object p1

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p1, p0}, Lj3/n;->b(Landroidx/fragment/app/FragmentActivity;)V

    goto :done

    :play
    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aspiro/wamp/App;->e()Le5/c;

    move-result-object p0

    check-cast p0, Le5/z$n2;

    invoke-virtual {p0}, Le5/z$n2;->x3()Lcom/aspiro/wamp/playback/e0;

    move-result-object p0

    invoke-virtual {p1}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p3, p2, v0}, Lcom/aspiro/wamp/playback/e0;->a(Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lio/reactivex/disposables/Disposable;

    move-result-object v0

    :done
    return-object v0
.end method

.method public static playlist(Landroid/content/Context;Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)V
    .locals 4

    if-eqz p0, :done

    if-eqz p1, :done

    invoke-virtual {p1}, Lcom/aspiro/wamp/model/Playlist;->getNumberOfItems()I

    move-result v0

    if-lez v0, :done

    :unwrap_context
    instance-of v0, p0, Landroidx/fragment/app/FragmentActivity;

    if-nez v0, :has_activity

    instance-of v0, p0, Landroid/content/ContextWrapper;

    if-eqz v0, :done

    move-object v0, p0

    check-cast v0, Landroid/content/ContextWrapper;

    invoke-virtual {v0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    if-eq v0, p0, :done

    move-object p0, v0

    goto :unwrap_context

    :has_activity
    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aspiro/wamp/App;->e()Le5/c;

    move-result-object v0

    check-cast v0, Le5/z$n2;

    invoke-static {}, Lradiant/swipe/QueueExecutor;->hasActiveQueue()Z

    move-result v1

    if-eqz v1, :play

    iget-object v1, v0, Le5/z$n2;->w8:Ldagger/internal/f;

    invoke-interface {v1}, Lql0/a;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;

    invoke-interface {v1, p1, p2, p3}, Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;->a(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/h;

    move-result-object p2

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p2, p0}, Lcom/aspiro/wamp/contextmenu/item/playlist/h;->b(Landroidx/fragment/app/FragmentActivity;)V

    goto :done

    :play
    invoke-virtual {v0}, Le5/z$n2;->y3()Lcom/aspiro/wamp/playback/k0;

    move-result-object p0

    invoke-virtual {p0, p1, p3}, Lcom/aspiro/wamp/playback/k0;->c(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)V

    :done
    return-void
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

    invoke-static {}, Lcom/aspiro/wamp/App$a;->a()Lcom/aspiro/wamp/App;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aspiro/wamp/App;->e()Le5/c;

    move-result-object v1

    check-cast v1, Le5/z$n2;

    iget-object v1, v1, Le5/z$n2;->k9:Ldagger/internal/f;

    invoke-interface {v1}, Lql0/a;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lm3/f$a;

    invoke-interface {v1, p1, p2, p3}, Lm3/f$a;->a(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/f;

    move-result-object p1

    check-cast p0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p1, p0}, Lm3/f;->b(Landroidx/fragment/app/FragmentActivity;)V

    const/4 v0, 0x1

    :done
    return v0
.end method
