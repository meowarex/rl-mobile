.class public final Lradiant/gestures/queue/DynamicMediaQueueEvent;
.super Ljava/lang/Object;
.source "DynamicMediaQueueEvent.smali"

# interfaces
.implements Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b;
.implements Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/b;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/b;


# instance fields
.field public final action:I

.field public final context:Landroid/content/Context;

.field public final itemId:Ljava/lang/String;

.field public final mediaType:I

.field public final moduleUuid:Ljava/lang/String;

.field public final pageId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/DynamicMediaQueueEvent;->context:Landroid/content/Context;

    iput-object p2, p0, Lradiant/gestures/queue/DynamicMediaQueueEvent;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/gestures/queue/DynamicMediaQueueEvent;->moduleUuid:Ljava/lang/String;

    iput-object p4, p0, Lradiant/gestures/queue/DynamicMediaQueueEvent;->itemId:Ljava/lang/String;

    iput p5, p0, Lradiant/gestures/queue/DynamicMediaQueueEvent;->mediaType:I

    iput p6, p0, Lradiant/gestures/queue/DynamicMediaQueueEvent;->action:I

    return-void
.end method
