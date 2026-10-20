.class public final Lradiant/ArtDefaults;
.super Ljava/lang/Object;

# Animated cover options, baked in by the Manager


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Frame rate, 25 is native, lower plays slower
.method static fps()I
    .locals 1

    const/16 v0, __RL_ART_FPS__

    return v0
.end method
