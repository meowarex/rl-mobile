.class public final Lradiant/RLSettings;
.super Ljava/lang/Object;


# static fields
.field static final LANG_LABELS:[Ljava/lang/String;

.field static final LANG_VALUES:[Ljava/lang/String;

.field private static final PREFS:Ljava/lang/String; = "radiant_lyrics"

.field static final SYNC_LABELS:[Ljava/lang/String;

.field static final SYNC_LINE:I = 0x0

.field static final SYNC_SYLLABLE:I = 0x2

.field static final SYNC_WORD:I = 0x1

.field private static volatile allowAI:Z

.field private static volatile language:I

.field private static volatile loaded:Z

.field private static volatile quickMenu:Z

.field private static volatile radiantAI:Z

.field public static volatile rlActive:Z

.field private static volatile romanize:Z

.field private static volatile sync:I

.field private static volatile translate:Z


# direct methods
.method static constructor <clinit>()V
    .registers 11

    const-string v8, "korean"

    const-string v9, "chinese"

    const-string v0, "english"

    const-string v1, "spanish"

    const-string v2, "french"

    const-string v3, "german"

    const-string v4, "portuguese"

    const-string v5, "italian"

    const-string v6, "russian"

    const-string v7, "japanese"

    filled-new-array/range {v0 .. v9}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lradiant/RLSettings;->LANG_VALUES:[Ljava/lang/String;

    const-string v9, "Korean"

    const-string v10, "Chinese"

    const-string v1, "English"

    const-string v2, "Spanish"

    const-string v3, "French"

    const-string v4, "German"

    const-string v5, "Portuguese"

    const-string v6, "Italian"

    const-string v7, "Russian"

    const-string v8, "Japanese"

    filled-new-array/range {v1 .. v10}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lradiant/RLSettings;->LANG_LABELS:[Ljava/lang/String;

    const-string v0, "Word"

    const-string v1, "Syllable"

    const-string v2, "Line"

    filled-new-array {v2, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lradiant/RLSettings;->SYNC_LABELS:[Ljava/lang/String;

    const/4 v0, 0x1

    sput-boolean v0, Lradiant/RLSettings;->allowAI:Z

    sput-boolean v0, Lradiant/RLSettings;->quickMenu:Z

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static allowAI()Z
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget-boolean v0, Lradiant/RLSettings;->allowAI:Z

    return v0
.end method

.method static app()Landroid/content/Context;
    .registers 5

    const/4 v0, 0x0

    :try_start_1
    const-string v1, "android.app.ActivityThread"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "currentApplication"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/Context;
    :try_end_18
    .catchall {:try_start_1 .. :try_end_18} :catchall_19

    return-object v1

    :catchall_19
    move-exception v1

    return-object v0
.end method

.method private static clampLang(I)I
    .registers 2

    if-ltz p0, :cond_7

    sget-object v0, Lradiant/RLSettings;->LANG_VALUES:[Ljava/lang/String;

    array-length v0, v0

    if-lt p0, v0, :cond_8

    :cond_7
    const/4 p0, 0x0

    :cond_8
    return p0
.end method

.method private static clampSync(I)I
    .registers 2

    if-ltz p0, :cond_5

    const/4 v0, 0x2

    if-le p0, v0, :cond_6

    :cond_5
    const/4 p0, 0x0

    :cond_6
    return p0
.end method

.method public static language()Ljava/lang/String;
    .registers 2

    sget-object v0, Lradiant/RLSettings;->LANG_VALUES:[Ljava/lang/String;

    invoke-static {}, Lradiant/RLSettings;->languageIndex()I

    move-result v1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public static languageIndex()I
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget v0, Lradiant/RLSettings;->language:I

    return v0
.end method

.method static load()V
    .registers 1

    sget-boolean v0, Lradiant/RLSettings;->loaded:Z

    if-nez v0, :cond_7

    invoke-static {}, Lradiant/RLSettings;->loadNow()V

    :cond_7
    return-void
.end method

.method private static declared-synchronized loadNow()V
    .registers 12

    const-class v0, Lradiant/RLSettings;

    monitor-enter v0

    :try_start_3
    sget-boolean v1, Lradiant/RLSettings;->loaded:Z
    :try_end_5
    .catchall {:try_start_3 .. :try_end_5} :catchall_102

    if-eqz v1, :cond_9

    monitor-exit v0

    return-void

    :cond_9
    :try_start_9
    invoke-static {}, Lradiant/RLDefaults;->romanize()I

    move-result v1

    invoke-static {}, Lradiant/RLDefaults;->translate()I

    move-result v2

    invoke-static {}, Lradiant/RLDefaults;->language()I

    move-result v3

    invoke-static {}, Lradiant/RLDefaults;->radiantAI()I

    move-result v4

    invoke-static {}, Lradiant/RLDefaults;->sync()I

    move-result v5

    invoke-static {}, Lradiant/RLDefaults;->allowAI()I

    move-result v6

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-eqz v6, :cond_27

    move v6, v8

    goto :goto_28

    :cond_27
    move v6, v7

    :goto_28
    sput-boolean v6, Lradiant/RLSettings;->allowAI:Z

    invoke-static {}, Lradiant/RLDefaults;->quickMenu()I

    move-result v6

    if-eqz v6, :cond_32

    move v6, v8

    goto :goto_33

    :cond_32
    move v6, v7

    :goto_33
    sput-boolean v6, Lradiant/RLSettings;->quickMenu:Z

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, ","

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, ","

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, ","

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, ","

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, ","

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-boolean v9, Lradiant/RLSettings;->quickMenu:Z

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    sget-boolean v9, Lradiant/RLSettings;->quickMenu:Z

    const/4 v10, 0x0

    if-eqz v9, :cond_80

    invoke-static {}, Lradiant/RLSettings;->prefs()Landroid/content/SharedPreferences;

    move-result-object v9

    goto :goto_81

    :cond_80
    move-object v9, v10

    :goto_81
    if-eqz v9, :cond_cd

    const-string v11, "baked"

    invoke-interface {v9, v11, v10}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v6, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_cd

    const-string v6, "romanize"

    if-eqz v1, :cond_95

    move v1, v8

    goto :goto_96

    :cond_95
    move v1, v7

    :goto_96
    invoke-interface {v9, v6, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    sput-boolean v1, Lradiant/RLSettings;->romanize:Z

    const-string v1, "translate"

    if-eqz v2, :cond_a2

    move v2, v8

    goto :goto_a3

    :cond_a2
    move v2, v7

    :goto_a3
    invoke-interface {v9, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    sput-boolean v1, Lradiant/RLSettings;->translate:Z

    const-string v1, "language"

    invoke-interface {v9, v1, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v1}, Lradiant/RLSettings;->clampLang(I)I

    move-result v1

    sput v1, Lradiant/RLSettings;->language:I

    const-string v1, "radiantAI"

    if-eqz v4, :cond_ba

    move v7, v8

    :cond_ba
    invoke-interface {v9, v1, v7}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    sput-boolean v1, Lradiant/RLSettings;->radiantAI:Z

    const-string v1, "sync"

    invoke-interface {v9, v1, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v1}, Lradiant/RLSettings;->clampSync(I)I

    move-result v1

    sput v1, Lradiant/RLSettings;->sync:I

    goto :goto_fe

    :cond_cd
    if-eqz v1, :cond_d1

    move v1, v8

    goto :goto_d2

    :cond_d1
    move v1, v7

    :goto_d2
    sput-boolean v1, Lradiant/RLSettings;->romanize:Z

    if-eqz v2, :cond_d8

    move v1, v8

    goto :goto_d9

    :cond_d8
    move v1, v7

    :goto_d9
    sput-boolean v1, Lradiant/RLSettings;->translate:Z

    invoke-static {v3}, Lradiant/RLSettings;->clampLang(I)I

    move-result v1

    sput v1, Lradiant/RLSettings;->language:I

    if-eqz v4, :cond_e4

    move v7, v8

    :cond_e4
    sput-boolean v7, Lradiant/RLSettings;->radiantAI:Z

    invoke-static {v5}, Lradiant/RLSettings;->clampSync(I)I

    move-result v1

    sput v1, Lradiant/RLSettings;->sync:I

    if-eqz v9, :cond_fe

    invoke-interface {v9}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "baked"

    invoke-interface {v1, v2, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {}, Lradiant/RLSettings;->save()V

    :cond_fe
    :goto_fe
    sput-boolean v8, Lradiant/RLSettings;->loaded:Z
    :try_end_100
    .catchall {:try_start_9 .. :try_end_100} :catchall_102

    monitor-exit v0

    return-void

    :catchall_102
    move-exception v1

    :try_start_103
    monitor-exit v0
    :try_end_104
    .catchall {:try_start_103 .. :try_end_104} :catchall_102

    throw v1
.end method

.method private static prefs()Landroid/content/SharedPreferences;
    .registers 3

    invoke-static {}, Lradiant/RLSettings;->app()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_8

    const/4 v0, 0x0

    goto :goto_f

    :cond_8
    const-string v1, "radiant_lyrics"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    :goto_f
    return-object v0
.end method

.method public static quickMenu()Z
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget-boolean v0, Lradiant/RLSettings;->quickMenu:Z

    return v0
.end method

.method public static radiantAI()Z
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget-boolean v0, Lradiant/RLSettings;->allowAI:Z

    if-eqz v0, :cond_d

    sget-boolean v0, Lradiant/RLSettings;->radiantAI:Z

    if-eqz v0, :cond_d

    const/4 v0, 0x1

    goto :goto_e

    :cond_d
    const/4 v0, 0x0

    :goto_e
    return v0
.end method

.method public static romanize()Z
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget-boolean v0, Lradiant/RLSettings;->romanize:Z

    return v0
.end method

.method private static save()V
    .registers 3

    invoke-static {}, Lradiant/RLSettings;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "romanize"

    sget-boolean v2, Lradiant/RLSettings;->romanize:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "translate"

    sget-boolean v2, Lradiant/RLSettings;->translate:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "language"

    sget v2, Lradiant/RLSettings;->language:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "radiantAI"

    sget-boolean v2, Lradiant/RLSettings;->radiantAI:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "sync"

    sget v2, Lradiant/RLSettings;->sync:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method static setLanguage(I)V
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    invoke-static {p0}, Lradiant/RLSettings;->clampLang(I)I

    move-result p0

    sput p0, Lradiant/RLSettings;->language:I

    invoke-static {}, Lradiant/RLSettings;->save()V

    invoke-static {}, Lradiant/RLLyrics;->onTextModeChanged()V

    return-void
.end method

.method static setRadiantAI(Z)V
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sput-boolean p0, Lradiant/RLSettings;->radiantAI:Z

    invoke-static {}, Lradiant/RLSettings;->save()V

    invoke-static {}, Lradiant/RLLyrics;->onRadiantAIChanged()V

    return-void
.end method

.method static setRomanize(Z)V
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sput-boolean p0, Lradiant/RLSettings;->romanize:Z

    invoke-static {}, Lradiant/RLSettings;->save()V

    invoke-static {}, Lradiant/RLLyrics;->onTextModeChanged()V

    return-void
.end method

.method static setSync(I)V
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    invoke-static {p0}, Lradiant/RLSettings;->clampSync(I)I

    move-result p0

    sput p0, Lradiant/RLSettings;->sync:I

    invoke-static {}, Lradiant/RLSettings;->save()V

    invoke-static {}, Lradiant/RLLyrics;->onSyncChanged()V

    return-void
.end method

.method static setTranslate(Z)V
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sput-boolean p0, Lradiant/RLSettings;->translate:Z

    invoke-static {}, Lradiant/RLSettings;->save()V

    invoke-static {}, Lradiant/RLLyrics;->onTextModeChanged()V

    return-void
.end method

.method public static sync()I
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget v0, Lradiant/RLSettings;->sync:I

    return v0
.end method

.method public static translate()Z
    .registers 1

    invoke-static {}, Lradiant/RLSettings;->load()V

    sget-boolean v0, Lradiant/RLSettings;->translate:Z

    return v0
.end method
