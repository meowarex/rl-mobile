.class public final Lcom/tidal/android/feature/appscaffold/ui/r$c;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r$c;
.super Lcom/tidal/android/feature/appscaffold/ui/r;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r;
.source "SourceFile"

# Synthetic mini-player event used by right swipe (previous/rewind).

# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/tidal/android/feature/appscaffold/ui/r;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "c"
.end annotation


# static fields
.field public static final a:Lcom/tidal/android/feature/appscaffold/ui/r$c;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r$c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/tidal/android/feature/appscaffold/ui/r$c;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r$c;

    invoke-direct {v0}, Lcom/tidal/android/feature/appscaffold/ui/r;-><init>()V    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r;

    sput-object v0, Lcom/tidal/android/feature/appscaffold/ui/r$c;->a:Lcom/tidal/android/feature/appscaffold/ui/r$c;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r$c; a

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 1

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of p1, p1, Lcom/tidal/android/feature/appscaffold/ui/r$c;    # MARKER: R8 Lcom/tidal/android/feature/appscaffold/ui/r$c;

    if-nez p1, :cond_1

    const/4 p1, 0x0

    return p1

    :cond_1
    return v0
.end method

.method public final hashCode()I
    .locals 1

    const v0, -0x5d6a0f8

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    const-string v0, "PreviousButtonClicked"

    return-object v0
.end method
