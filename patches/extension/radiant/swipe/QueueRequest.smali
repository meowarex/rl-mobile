.class public final Lradiant/swipe/QueueRequest;
.super Ljava/lang/Object;
.source "QueueRequest.smali"

# static fields
.field public static final ACTION_NONE:I = 0x0

.field public static final ACTION_PLAY_NEXT:I = 0x1

.field public static final ACTION_ADD_TO_QUEUE:I = 0x2


# instance fields
.field public action:I

.field public final id:I

.field public final media:Ljava/lang/Object;

.field public final position:I


# direct methods
.method public constructor <init>(ILjava/lang/Object;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/swipe/QueueRequest;->position:I

    iput-object p2, p0, Lradiant/swipe/QueueRequest;->media:Ljava/lang/Object;

    iput p3, p0, Lradiant/swipe/QueueRequest;->id:I

    return-void
.end method
