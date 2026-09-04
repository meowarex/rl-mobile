.class public final Lradiant/gestures/queue/ComposeSearchQueueEvent;
.super Ljava/lang/Object;
.source "ComposeSearchQueueEvent.smali"

# interfaces
.implements Lcom/tidal/android/feature/search/ui/b;    # MARKER: R8 Lcom/tidal/android/feature/search/ui/b;


# static fields
.field public static final TYPE_ALBUM:I = 0x2

.field public static final TYPE_MIX:I = 0x4

.field public static final TYPE_PLAYLIST:I = 0x3

.field public static final TYPE_TRACK:I = 0x1


# instance fields
.field public final action:I

.field public final context:Landroid/content/Context;

.field public final id:Ljava/lang/String;

.field public final type:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/ComposeSearchQueueEvent;->context:Landroid/content/Context;

    iput-object p2, p0, Lradiant/gestures/queue/ComposeSearchQueueEvent;->id:Ljava/lang/String;

    iput p3, p0, Lradiant/gestures/queue/ComposeSearchQueueEvent;->type:I

    iput p4, p0, Lradiant/gestures/queue/ComposeSearchQueueEvent;->action:I

    return-void
.end method
