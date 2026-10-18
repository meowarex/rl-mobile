.class public final Lradiant/QualitySeek;
.super Ljava/lang/Object;


# static fields
.field private static final HI_RES:I = -0x21976

.field private static final LOSSLESS:I = -0x5a0c04

.field private static final LOW_HIGH:I = -0x1d1710

.field private static volatile queue:Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static argb()I
    .registers 3

    sget-object v0, Lradiant/QualitySeek;->queue:Ljava/lang/Object;

    instance-of v1, v0, Lzh/e;

    const/4 v2, -0x1

    if-nez v1, :cond_8

    return v2

    :cond_8
    :try_start_8
    check-cast v0, Lzh/e;

    invoke-interface {v0}, Lzh/e;->isCurrentStreamHiResLosslessQuality()Z

    move-result v1

    if-eqz v1, :cond_14

    const v0, -0x21976

    return v0

    :cond_14
    invoke-interface {v0}, Lzh/e;->isCurrentStreamLossless()Z

    move-result v0
    :try_end_18
    .catchall {:try_start_8 .. :try_end_18} :catchall_22

    if-eqz v0, :cond_1e

    const v0, -0x5a0c04

    return v0

    :cond_1e
    const v0, -0x1d1710

    return v0

    :catchall_22
    move-exception v0

    return v2
.end method

.method public static setQueue(Ljava/lang/Object;)V
    .registers 1

    sput-object p0, Lradiant/QualitySeek;->queue:Ljava/lang/Object;

    return-void
.end method
