.class public final Lradiant/swipe/ViewAllTrackQueue;
.super Ljava/lang/Object;
.source "ViewAllTrackQueue.smali"


# static fields
.field private static context:Ljava/lang/ref/WeakReference;


# direct methods
.method public static handle(Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;Landroid/content/Context;JI)V
    .locals 10

    if-eqz p0, :done

    if-eqz p1, :done

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-lez v2, :done

    iget-object v0, p0, Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;->n:Lcom/tidal/android/feature/viewall/ui/c;

    iget-object v0, v0, Lcom/tidal/android/feature/viewall/ui/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :find_track
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :done

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Lpd0/a;

    if-eqz v2, :find_track

    check-cast v1, Lpd0/a;

    iget-object v1, v1, Lpd0/a;->a:Lh40/n;

    instance-of v2, v1, Lh40/p;

    if-eqz v2, :find_track

    check-cast v1, Lh40/p;

    iget-wide v3, v1, Lh40/p;->a:J

    cmp-long v2, v3, p2

    if-nez v2, :find_track

    iget-object v0, p0, Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;->f:Lcom/tidal/android/feature/viewall/ui/u;

    instance-of v2, v0, Lra/d;

    if-eqz v2, :done

    check-cast v0, Lra/d;

    iget-object v2, v0, Lra/d;->b:Lcom/tidal/android/navigation/NavigationInfo;

    invoke-static {v1}, Lie0/i;->a(Lh40/p;)Lcom/aspiro/wamp/model/Track;

    move-result-object v3

    if-eqz v3, :done

    const-string v5, "null"

    new-instance v4, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    invoke-direct {v4, v5, v5}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v6, 0x0

    if-eqz v2, :navigation_ready

    invoke-static {v2}, Lcom/tidal/android/navigation/a;->b(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;

    move-result-object v6

    :navigation_ready
    sget-object v7, Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$None;->INSTANCE:Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$None;

    const/4 v8, 0x0

    invoke-static {v5, v8, v6, v7}, Lcom/aspiro/wamp/playqueue/source/model/b;->j(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;

    move-result-object v9

    invoke-virtual {v9, v3}, Lcom/aspiro/wamp/playqueue/source/model/Source;->addSourceItem(Lcom/aspiro/wamp/model/MediaItem;)V

    const/4 v0, 0x1

    if-ne p4, v0, :append

    invoke-static {p1, v3, v4, v9}, Lradiant/swipe/QueueExecutor;->playNextTrack(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    goto :done

    :append
    invoke-static {p1, v3, v4, v9}, Lradiant/swipe/QueueExecutor;->track(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z

    :done
    return-void
.end method

.method public static handleEvent(Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;Lcom/tidal/android/feature/viewall/ui/e;)Z
    .locals 6

    instance-of v0, p1, Lcom/tidal/android/feature/viewall/ui/e$c;

    if-eqz v0, :not_handled

    check-cast p1, Lcom/tidal/android/feature/viewall/ui/e$c;

    iget-object v0, p1, Lcom/tidal/android/feature/viewall/ui/e$c;->a:Ljava/lang/Object;

    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :not_handled

    check-cast v0, Ljava/lang/String;

    const-string v1, "rl-swipe:"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :not_handled

    const/16 v1, 0x9

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-lez v1, :not_handled

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    sget-object v3, Lradiant/swipe/ViewAllTrackQueue;->context:Ljava/lang/ref/WeakReference;

    const/4 v5, 0x0

    sput-object v5, Lradiant/swipe/ViewAllTrackQueue;->context:Ljava/lang/ref/WeakReference;

    if-eqz v3, :handled

    invoke-virtual {v3}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/Context;

    invoke-static {p0, v3, v1, v2, v4}, Lradiant/swipe/ViewAllTrackQueue;->handle(Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;Landroid/content/Context;JI)V

    :handled
    const/4 v0, 0x1

    return v0

    :not_handled
    const/4 v0, 0x0

    return v0
.end method

.method public static marker(JI)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "rl-swipe:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static setContext(Landroid/content/Context;)V
    .locals 1

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lradiant/swipe/ViewAllTrackQueue;->context:Ljava/lang/ref/WeakReference;

    return-void
.end method
