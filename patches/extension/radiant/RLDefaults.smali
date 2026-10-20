.class public final Lradiant/RLDefaults;
.super Ljava/lang/Object;

# Manager defaults, the sparkle menu can change them
# Sync style is set by the variant patches


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static romanize()I
    .locals 1

    const v0, __RL_ROMANIZE__

    return v0
.end method

.method static translate()I
    .locals 1

    const v0, __RL_TRANSLATE__

    return v0
.end method

# Index into RLSettings.LANG_VALUES
.method static language()I
    .locals 1

    const v0, __RL_TRANSLATE_LANG__

    return v0
.end method

# Off only with the Disable AI Features patch
.method static allowAI()I
    .locals 1

    const/4 v0, 0x1    # AI features allowed

    return v0
.end method

.method static radiantAI()I
    .locals 1

    const v0, __RL_RADIANT_AI__

    return v0
.end method

# Long press the Sparkle for quick options
.method static quickMenu()I
    .locals 1

    const v0, __RL_QUICK_MENU__

    return v0
.end method

# 0 Line, 1 Word, 2 Syllable
.method static sync()I
    .locals 1

    const/4 v0, 0x0    # default sync style

    return v0
.end method
