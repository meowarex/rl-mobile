.class public final Lradiant/CoverDefaults;
.super Ljava/lang/Object;

# Cover Transitions options, Manager bakes these in <3


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Ripple length for skips, ms
.method static ms()I
    .locals 1

    const v0, __RL_CT_MS__

    return v0
.end method

# Ripple follows TIDAL's crossfade
.method static follow()Z
    .locals 1

    const/4 v0, __RL_CT_FOLLOW__

    return v0
.end method
