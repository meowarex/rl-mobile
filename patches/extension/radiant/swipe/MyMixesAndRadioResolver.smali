.class public final Lradiant/swipe/MyMixesAndRadioResolver;
.super Ljava/lang/Object;
.source "MyMixesAndRadioResolver.smali"

# interfaces
.implements Lradiant/swipe/QueueRowResolver;


# instance fields
.field private final fragment:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lradiant/swipe/MyMixesAndRadioResolver;->fragment:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private current(Lradiant/swipe/QueueRequest;)Lve/a;
    .locals 6

    if-eqz p1, :invalid

    iget-object v0, p1, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    instance-of v1, v0, Lcom/aspiro/wamp/mix/model/Mix;

    if-eqz v1, :invalid

    check-cast v0, Lcom/aspiro/wamp/mix/model/Mix;

    iget-object v1, p0, Lradiant/swipe/MyMixesAndRadioResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;

    if-eqz v1, :invalid

    iget-object v2, v1, Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;->c:Lpe/f;

    if-eqz v2, :invalid

    invoke-virtual {v1}, Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;->N()La50/d;

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

    instance-of v2, v1, Lve/a;

    if-eqz v2, :invalid

    check-cast v1, Lve/a;

    iget-boolean v2, v1, Lve/a;->f:Z

    if-eqz v2, :invalid

    iget-object v2, v1, Lve/a;->c:Lcom/aspiro/wamp/mix/model/Mix;

    if-eqz v2, :invalid

    invoke-virtual {v0}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object v0

    iget-object v3, v1, Lve/a;->a:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :invalid

    invoke-virtual {v2}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :invalid

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v2

    iget v3, p1, Lradiant/swipe/QueueRequest;->id:I

    if-ne v2, v3, :invalid

    return-object v1

    :invalid
    const/4 v0, 0x0

    return-object v0
.end method

.method public static install(Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 1

    if-eqz p0, :done

    if-eqz p1, :done

    new-instance v0, Lradiant/swipe/MyMixesAndRadioResolver;

    invoke-direct {v0, p0}, Lradiant/swipe/MyMixesAndRadioResolver;-><init>(Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;)V

    invoke-static {p1, v0}, Lradiant/SwipeToQueue;->install(Landroidx/recyclerview/widget/RecyclerView;Lradiant/swipe/QueueRowResolver;)V

    :done
    return-void
.end method


# virtual methods
.method public execute(Lradiant/swipe/QueueRequest;)V
    .locals 7

    invoke-direct {p0, p1}, Lradiant/swipe/MyMixesAndRadioResolver;->current(Lradiant/swipe/QueueRequest;)Lve/a;

    move-result-object p1

    if-eqz p1, :done

    iget-object v0, p0, Lradiant/swipe/MyMixesAndRadioResolver;->fragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;

    if-eqz v0, :done

    iget-object v1, v0, Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;->c:Lpe/f;

    if-eqz v1, :done

    iget-object v2, v1, Lpe/f;->a:Lx40/a;

    instance-of v3, v2, Lh4/a;

    if-eqz v3, :done

    check-cast v2, Lh4/a;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v3

    iget-object v4, p1, Lve/a;->c:Lcom/aspiro/wamp/mix/model/Mix;

    new-instance v5, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;

    const-string v6, "mycollection_mixes_and_radio"

    invoke-direct {v5, v6}, Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;-><init>(Ljava/lang/String;)V

    iget-object v6, v1, Lpe/f;->b:Lcom/tidal/android/navigation/NavigationInfo;

    invoke-static {v3, v4, v5, v6, v2}, Lradiant/swipe/QueueExecutor;->mix(Landroid/content/Context;Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;Lh4/a;)Lio/reactivex/disposables/Disposable;

    move-result-object p1

    if-eqz p1, :done

    iget-object v0, v0, Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;->h:Lio/reactivex/disposables/CompositeDisposable;

    invoke-virtual {v0, p1}, Lio/reactivex/disposables/CompositeDisposable;->add(Lio/reactivex/disposables/Disposable;)Z

    :done
    return-void
.end method

.method public isValid(Lradiant/swipe/QueueRequest;)Z
    .locals 1

    invoke-direct {p0, p1}, Lradiant/swipe/MyMixesAndRadioResolver;->current(Lradiant/swipe/QueueRequest;)Lve/a;

    move-result-object p1

    if-eqz p1, :invalid

    const/4 p1, 0x1

    return p1

    :invalid
    const/4 p1, 0x0

    return p1
.end method

.method public resolve(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$ViewHolder;)Lradiant/swipe/QueueRequest;
    .locals 5

    instance-of v0, p2, Lqe/c$a;

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

    if-gez p2, :check_size

    goto :invalid

    :check_size
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :read_item

    goto :invalid

    :read_item
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lve/a;

    if-eqz v0, :invalid

    check-cast p1, Lve/a;

    iget-boolean v0, p1, Lve/a;->f:Z

    if-eqz v0, :invalid

    iget-object v0, p1, Lve/a;->c:Lcom/aspiro/wamp/mix/model/Mix;

    if-eqz v0, :invalid

    iget-object v1, p1, Lve/a;->a:Ljava/lang/String;

    invoke-virtual {v0}, Lcom/aspiro/wamp/mix/model/Mix;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :invalid

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    new-instance v3, Lradiant/swipe/QueueRequest;

    invoke-direct {v3, p2, v0, v2}, Lradiant/swipe/QueueRequest;-><init>(ILjava/lang/Object;I)V

    return-object v3

    :invalid
    const/4 p1, 0x0

    return-object p1
.end method
