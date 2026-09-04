.class public final Lradiant/gestures/queue/ArtistTrackCreditsQueueEvent;
.super Ljava/lang/Object;
.source "ArtistTrackCreditsQueueEvent.smali"

# interfaces
.implements Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b;    # MARKER: R8 Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b;


# instance fields
.field public final action:I

.field public final context:Landroid/content/Context;

.field public final moduleUuid:Ljava/lang/String;

.field public final pageId:Ljava/lang/String;

.field public final trackId:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;JI)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lradiant/gestures/queue/ArtistTrackCreditsQueueEvent;->context:Landroid/content/Context;

    iput-object p2, p0, Lradiant/gestures/queue/ArtistTrackCreditsQueueEvent;->pageId:Ljava/lang/String;

    iput-object p3, p0, Lradiant/gestures/queue/ArtistTrackCreditsQueueEvent;->moduleUuid:Ljava/lang/String;

    iput-wide p4, p0, Lradiant/gestures/queue/ArtistTrackCreditsQueueEvent;->trackId:J

    iput p6, p0, Lradiant/gestures/queue/ArtistTrackCreditsQueueEvent;->action:I

    return-void
.end method
