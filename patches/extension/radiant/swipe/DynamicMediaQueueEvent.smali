.class public final Lradiant/swipe/DynamicMediaQueueEvent;
.super Ljava/lang/Object;
.source "DynamicMediaQueueEvent.smali"

# interfaces
.implements Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b;
.implements Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/b;


# instance fields
.field public final context:Landroid/content/Context;

.field public final itemId:Ljava/lang/String;

.field public final mediaType:I

.field public final moduleUuid:Ljava/lang/String;

.field public final pageId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/DynamicMediaQueueEvent;->context:Landroid/content/Context;

    iput-object p2, p0, Lradiant/swipe/DynamicMediaQueueEvent;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/swipe/DynamicMediaQueueEvent;->moduleUuid:Ljava/lang/String;

    iput-object p4, p0, Lradiant/swipe/DynamicMediaQueueEvent;->itemId:Ljava/lang/String;

    iput p5, p0, Lradiant/swipe/DynamicMediaQueueEvent;->mediaType:I

    return-void
.end method
