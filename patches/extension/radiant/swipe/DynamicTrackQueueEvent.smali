.class public final Lradiant/swipe/DynamicTrackQueueEvent;
.super Ljava/lang/Object;
.source "DynamicTrackQueueEvent.smali"

# interfaces
.implements Lcom/tidal/android/dynamicpages/ui/modules/tracklist/b;


# instance fields
.field public final context:Landroid/content/Context;

.field public final moduleUuid:Ljava/lang/String;

.field public final pageId:Ljava/lang/String;

.field public final trackId:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/swipe/DynamicTrackQueueEvent;->context:Landroid/content/Context;

    iput-object p2, p0, Lradiant/swipe/DynamicTrackQueueEvent;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/swipe/DynamicTrackQueueEvent;->moduleUuid:Ljava/lang/String;

    iput-wide p4, p0, Lradiant/swipe/DynamicTrackQueueEvent;->trackId:J

    return-void
.end method
