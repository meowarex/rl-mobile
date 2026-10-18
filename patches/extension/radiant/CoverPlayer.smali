.class public final Lradiant/CoverPlayer;
.super Landroid/media/MediaPlayer;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static volatile nextH:I

.field private static volatile nextW:I


# instance fields
.field private art:Lradiant/ArtPlayer;

.field private final onFirstFrame:Lyl0/a;


# direct methods
.method private constructor <init>(Lyl0/a;)V
    .registers 2

    invoke-direct {p0}, Landroid/media/MediaPlayer;-><init>()V

    iput-object p1, p0, Lradiant/CoverPlayer;->onFirstFrame:Lyl0/a;

    return-void
.end method

.method public static create(Ljava/lang/String;Landroid/view/Surface;Lyl0/a;)Landroid/media/MediaPlayer;
    .registers 11

    invoke-static {p0}, Lradiant/ArtPlayer;->isStream(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_8

    return-object v1

    :cond_8
    invoke-static {}, Lradiant/RLSettings;->app()Landroid/content/Context;

    move-result-object v2

    if-nez v2, :cond_f

    return-object v1

    :cond_f
    new-instance v7, Lradiant/CoverPlayer;

    invoke-direct {v7, p2}, Lradiant/CoverPlayer;-><init>(Lyl0/a;)V

    sget v5, Lradiant/CoverPlayer;->nextW:I

    sget v6, Lradiant/CoverPlayer;->nextH:I

    move-object v3, p0

    move-object v4, p1

    invoke-static/range {v2 .. v7}, Lradiant/ArtPlayer;->start(Landroid/content/Context;Ljava/lang/String;Landroid/view/Surface;IILjava/lang/Runnable;)Lradiant/ArtPlayer;

    move-result-object p0

    iput-object p0, v7, Lradiant/CoverPlayer;->art:Lradiant/ArtPlayer;

    return-object v7
.end method

.method public static nextSize(II)V
    .registers 2

    sput p0, Lradiant/CoverPlayer;->nextW:I

    sput p1, Lradiant/CoverPlayer;->nextH:I

    return-void
.end method


# virtual methods
.method public release()V
    .registers 3

    iget-object v0, p0, Lradiant/CoverPlayer;->art:Lradiant/ArtPlayer;

    const/4 v1, 0x0

    iput-object v1, p0, Lradiant/CoverPlayer;->art:Lradiant/ArtPlayer;

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Lradiant/ArtPlayer;->release()V

    :cond_a
    invoke-super {p0}, Landroid/media/MediaPlayer;->release()V

    return-void
.end method

.method public run()V
    .registers 2

    iget-object v0, p0, Lradiant/CoverPlayer;->onFirstFrame:Lyl0/a;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lradiant/CoverPlayer;->onFirstFrame:Lyl0/a;

    invoke-interface {v0}, Lyl0/a;->invoke()Ljava/lang/Object;

    :cond_9
    return-void
.end method
