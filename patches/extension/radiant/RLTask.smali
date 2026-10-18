.class public final Lradiant/RLTask;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field static final AUTO_SYLLA:I = 0x0

.field static final BUMP:I = 0x4

.field static final FLUSH:I = 0x1

.field static final REFETCH:I = 0x5

.field static final TOAST:I = 0x3


# instance fields
.field private final a:Ljava/lang/Object;

.field private final b:Ljava/lang/Object;

.field private final c:Ljava/lang/Object;

.field private final n:I

.field private final op:I


# direct methods
.method constructor <init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V
    .registers 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/RLTask;->op:I

    iput-object p2, p0, Lradiant/RLTask;->a:Ljava/lang/Object;

    iput-object p3, p0, Lradiant/RLTask;->b:Ljava/lang/Object;

    iput-object p4, p0, Lradiant/RLTask;->c:Ljava/lang/Object;

    iput p5, p0, Lradiant/RLTask;->n:I

    return-void
.end method


# virtual methods
.method public run()V
    .registers 5

    :try_start_0
    iget v0, p0, Lradiant/RLTask;->op:I

    packed-switch v0, :pswitch_data_5c

    :pswitch_5
    goto :goto_5a

    :pswitch_6
    iget-object v0, p0, Lradiant/RLTask;->a:Ljava/lang/Object;

    check-cast v0, Lradiant/RLAPILyricsWorker;

    invoke-static {v0}, Lradiant/RLLyrics;->runRefetch(Lradiant/RLAPILyricsWorker;)V

    goto :goto_5a

    :pswitch_e
    invoke-static {}, Lradiant/RLLyrics;->bumpNow()V

    goto :goto_5a

    :pswitch_12
    iget-object v0, p0, Lradiant/RLTask;->a:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget v1, p0, Lradiant/RLTask;->n:I

    if-eqz v1, :cond_1c

    const/4 v1, 0x1

    goto :goto_1d

    :cond_1c
    const/4 v1, 0x0

    :goto_1d
    invoke-static {v0, v1}, Lradiant/RLLyrics;->showToast(Ljava/lang/String;Z)V

    goto :goto_5a

    :pswitch_21
    invoke-static {}, Lradiant/RLLyrics;->runFlush()V

    goto :goto_5a

    :pswitch_25
    iget-object v0, p0, Lradiant/RLTask;->a:Ljava/lang/Object;

    check-cast v0, Lradiant/RLAPILyricsWorker;

    iget-object v1, p0, Lradiant/RLTask;->b:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lradiant/RLTask;->c:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    iget v3, p0, Lradiant/RLTask;->n:I

    invoke-static {v0, v1, v2, v3}, Lradiant/RLLyrics;->runAutoSylla(Lradiant/RLAPILyricsWorker;Ljava/lang/String;Ljava/lang/String;I)V
    :try_end_36
    .catchall {:try_start_0 .. :try_end_36} :catchall_37

    goto :goto_5a

    :catchall_37
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RLTask "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lradiant/RLTask;->op:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    :goto_5a
    return-void

    nop

    :pswitch_data_5c
    .packed-switch 0x0
        :pswitch_25
        :pswitch_21
        :pswitch_5
        :pswitch_12
        :pswitch_e
        :pswitch_6
    .end packed-switch
.end method
