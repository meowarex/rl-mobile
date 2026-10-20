.class public final Lradiant/RLMenu;
.super Ljava/lang/Object;

# interfaces
.implements Lyl0/a;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# static fields
.field private static final BACK:I = 0xe

.field private static final FLUSH:I = 0x11

.field private static final INSETS:Lradiant/RLMenu;

.field private static final LANGUAGES:I = 0xc

.field private static final NOOP:I = 0x1

.field private static final NOOP_FN:Lradiant/RLMenu;

.field private static final OPEN:I = 0x0

.field private static final OPEN_FN:Lradiant/RLMenu;

.field private static final PICK_LANGUAGE:I = 0xd

.field private static final RADIANT_AI:I = 0xf

.field private static final RAINBOW:[I

.field private static final ROMANIZE:I = 0xa

.field private static final SYNC:I = 0x10

.field private static final TAG:Ljava/lang/String; = "RLMenu"

.field private static final TRANSLATE:I = 0xb

.field private static dialog:Lcom/google/android/material/bottomsheet/BottomSheetDialog;

.field private static hostView:Landroid/view/View;

.field private static languagePage:Z

.field private static lastOpenMs:J

.field private static list:Landroid/widget/LinearLayout;


# instance fields
.field private final action:I

.field private final arg:I


# direct methods
.method static constructor <clinit>()V
    .registers 4

    new-instance v0, Lradiant/RLMenu;

    const/4 v1, 0x0

    invoke-direct {v0, v1, v1}, Lradiant/RLMenu;-><init>(II)V

    sput-object v0, Lradiant/RLMenu;->OPEN_FN:Lradiant/RLMenu;

    new-instance v0, Lradiant/RLMenu;

    const/4 v2, 0x1

    invoke-direct {v0, v2, v1}, Lradiant/RLMenu;-><init>(II)V

    sput-object v0, Lradiant/RLMenu;->NOOP_FN:Lradiant/RLMenu;

    new-instance v0, Lradiant/RLMenu;

    invoke-direct {v0, v2, v1}, Lradiant/RLMenu;-><init>(II)V

    sput-object v0, Lradiant/RLMenu;->INSETS:Lradiant/RLMenu;

    const v0, -0xa11801

    const v1, -0x587406

    const v2, -0x9463

    const/16 v3, -0x2e9a

    filled-new-array {v2, v3, v0, v1}, [I

    move-result-object v0

    sput-object v0, Lradiant/RLMenu;->RAINBOW:[I

    return-void
.end method

.method private constructor <init>(II)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lradiant/RLMenu;->action:I

    iput p2, p0, Lradiant/RLMenu;->arg:I

    return-void
.end method

.method private static activity(Landroid/view/View;)Landroid/app/Activity;
    .registers 3

    const/4 v0, 0x0

    if-nez p0, :cond_5

    move-object p0, v0

    goto :goto_9

    :cond_5
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p0

    :goto_9
    instance-of v1, p0, Landroid/content/ContextWrapper;

    if-eqz v1, :cond_1b

    instance-of v1, p0, Landroid/app/Activity;

    if-eqz v1, :cond_14

    check-cast p0, Landroid/app/Activity;

    return-object p0

    :cond_14
    check-cast p0, Landroid/content/ContextWrapper;

    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object p0

    goto :goto_9

    :cond_1b
    return-object v0
.end method

.method private static color(Landroid/content/Context;Z)I
    .registers 5

    if-eqz p1, :cond_5

    const-string v0, "white"

    goto :goto_7

    :cond_5
    const-string v0, "glass_darken_20"

    :goto_7
    const-string v1, "color"

    invoke-static {p0, v0, v1}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    const v2, 0x33ffffff

    if-nez v0, :cond_18

    if-eqz p1, :cond_16

    goto :goto_1c

    :cond_16
    move v1, v2

    goto :goto_1c

    :cond_18
    :try_start_18
    invoke-virtual {p0, v0}, Landroid/content/Context;->getColor(I)I

    move-result v1
    :try_end_1c
    .catchall {:try_start_18 .. :try_end_1c} :catchall_1d

    :goto_1c
    return v1

    :catchall_1d
    move-exception p0

    if-eqz p1, :cond_21

    goto :goto_22

    :cond_21
    move v1, v2

    :goto_22
    return v1
.end method

.method private static dismiss()V
    .registers 2

    sget-object v0, Lradiant/RLMenu;->dialog:Lcom/google/android/material/bottomsheet/BottomSheetDialog;

    const/4 v1, 0x0

    sput-object v1, Lradiant/RLMenu;->dialog:Lcom/google/android/material/bottomsheet/BottomSheetDialog;

    sput-object v1, Lradiant/RLMenu;->list:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_12

    invoke-virtual {v0}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-virtual {v0}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->dismiss()V

    :cond_12
    return-void
.end method

.method private static dp(Landroid/content/Context;I)I
    .registers 2

    int-to-float p1, p1

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method private static drawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .registers 3

    const-string v0, "drawable"

    invoke-static {p0, p1, v0}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    if-nez p1, :cond_e

    const-string p1, "ic_sparkle"

    invoke-static {p0, p1, v0}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    :cond_e
    const/4 v0, 0x0

    if-nez p1, :cond_12

    goto :goto_16

    :cond_12
    :try_start_12
    invoke-virtual {p0, p1}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0
    :try_end_16
    .catchall {:try_start_12 .. :try_end_16} :catchall_17

    :goto_16
    return-object v0

    :catchall_17
    move-exception p0

    return-object v0
.end method

.method private static icon(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/ImageView;
    .registers 4

    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    invoke-static {p0, p1}, Lradiant/RLMenu;->drawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_19

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-static {p0, p2}, Lradiant/RLMenu;->color(Landroid/content/Context;Z)I

    move-result p0

    invoke-virtual {p1, p0}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_19
    return-object v0
.end method

.method private static item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;
    .registers 10

    invoke-virtual {p0}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const-string v2, "context_menu_item"

    const-string v3, "layout"

    invoke-static {v0, v2, v3}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, p0, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    const-string v1, "icon"

    const-string v2, "id"

    invoke-static {v0, v1, v2}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    const-string v3, "title"

    invoke-static {v0, v3, v2}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    invoke-static {v0, p3}, Lradiant/RLMenu;->color(Landroid/content/Context;Z)I

    move-result v3

    if-eqz v1, :cond_58

    invoke-static {v0, p1}, Lradiant/RLMenu;->drawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_58

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {p1, v3}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    invoke-virtual {v1, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    const/16 p1, 0x18

    invoke-static {v0, p1}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result p1

    invoke-virtual {v1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    if-eqz v0, :cond_58

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_58
    if-eqz v2, :cond_60

    invoke-virtual {v2, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_60
    invoke-virtual {p0, p3}, Landroid/view/View;->setEnabled(Z)V

    if-eqz p3, :cond_6b

    new-instance p1, Lradiant/RLMenu;

    invoke-direct {p1, p4, p5}, Lradiant/RLMenu;-><init>(II)V

    goto :goto_6c

    :cond_6b
    const/4 p1, 0x0

    :goto_6c
    invoke-virtual {p0, p1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object p0
.end method

.method public static longClick(Landroidx/compose/runtime/Composer;)Lyl0/a;
    .registers 3

    sget-boolean v0, Lradiant/RLSettings;->rlActive:Z

    if-eqz v0, :cond_27

    invoke-static {}, Lradiant/RLSettings;->quickMenu()Z

    move-result v0

    if-nez v0, :cond_b

    goto :goto_27

    :cond_b
    :try_start_b
    invoke-static {}, Landroidx/compose/ui/platform/AndroidCompositionLocals_androidKt;->getLocalView()Landroidx/compose/runtime/ProvidableCompositionLocal;

    move-result-object v0

    invoke-interface {p0, v0}, Landroidx/compose/runtime/Composer;->consume(Landroidx/compose/runtime/CompositionLocal;)Ljava/lang/Object;

    move-result-object p0

    instance-of v0, p0, Landroid/view/View;

    if-eqz v0, :cond_24

    check-cast p0, Landroid/view/View;

    sput-object p0, Lradiant/RLMenu;->hostView:Landroid/view/View;
    :try_end_1b
    .catchall {:try_start_b .. :try_end_1b} :catchall_1c

    goto :goto_24

    :catchall_1c
    move-exception p0

    const-string v0, "RLMenu"

    const-string v1, "no LocalView"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_24
    :goto_24
    sget-object p0, Lradiant/RLMenu;->OPEN_FN:Lradiant/RLMenu;

    return-object p0

    :cond_27
    :goto_27
    const/4 p0, 0x0

    return-object p0
.end method

.method private static open()V
    .registers 6

    sget-boolean v0, Lradiant/RLSettings;->rlActive:Z

    if-eqz v0, :cond_44

    invoke-static {}, Lradiant/RLSettings;->quickMenu()Z

    move-result v0

    if-nez v0, :cond_b

    goto :goto_44

    :cond_b
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sget-wide v2, Lradiant/RLMenu;->lastOpenMs:J

    sub-long v2, v0, v2

    const-wide/16 v4, 0x258

    cmp-long v2, v2, v4

    if-gez v2, :cond_1a

    return-void

    :cond_1a
    sput-wide v0, Lradiant/RLMenu;->lastOpenMs:J

    sget-object v0, Lradiant/RLMenu;->dialog:Lcom/google/android/material/bottomsheet/BottomSheetDialog;

    if-eqz v0, :cond_29

    sget-object v0, Lradiant/RLMenu;->dialog:Lcom/google/android/material/bottomsheet/BottomSheetDialog;

    invoke-virtual {v0}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_29

    return-void

    :cond_29
    sget-object v0, Lradiant/RLMenu;->hostView:Landroid/view/View;

    invoke-static {v0}, Lradiant/RLMenu;->activity(Landroid/view/View;)Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_44

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-eqz v1, :cond_38

    goto :goto_44

    :cond_38
    :try_start_38
    invoke-static {v0}, Lradiant/RLMenu;->show(Landroid/app/Activity;)V
    :try_end_3b
    .catchall {:try_start_38 .. :try_end_3b} :catchall_3c

    goto :goto_44

    :catchall_3c
    move-exception v0

    const-string v1, "RLMenu"

    const-string v2, "menu failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_44
    :goto_44
    return-void
.end method

.method static openFromButton()V
    .registers 2

    sget-object v0, Lradiant/RLMenu;->hostView:Landroid/view/View;

    if-eqz v0, :cond_8

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->performHapticFeedback(I)Z

    :cond_8
    invoke-static {}, Lradiant/RLMenu;->open()V

    return-void
.end method

.method private static rainbow(Landroid/view/View;)V
    .registers 11

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "title"

    const-string v2, "id"

    invoke-static {v0, v1, v2}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p0

    check-cast p0, Landroid/widget/TextView;

    if-nez p0, :cond_15

    return-void

    :cond_15
    invoke-virtual {p0}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v0

    invoke-virtual {p0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/text/TextPaint;->measureText(Ljava/lang/String;)F

    move-result v0

    invoke-virtual {p0}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v1

    new-instance v2, Landroid/graphics/LinearGradient;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3, v0}, Ljava/lang/Math;->max(FF)F

    move-result v5

    sget-object v7, Lradiant/RLMenu;->RAINBOW:[I

    const/4 v8, 0x0

    sget-object v9, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x0

    invoke-direct/range {v2 .. v9}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v1, v2}, Landroid/text/TextPaint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setTextColor(I)V

    return-void
.end method

.method private static refresh()V
    .registers 10

    sget-object v0, Lradiant/RLMenu;->list:Landroid/widget/LinearLayout;

    if-nez v0, :cond_5

    return-void

    :cond_5
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getContext()Landroid/content/Context;

    move-result-object v6

    sget-boolean v1, Lradiant/RLMenu;->languagePage:Z

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-eqz v1, :cond_4b

    const/16 v4, 0xe

    const/4 v5, 0x0

    const-string v1, "ic_arrows_left_medium"

    const-string v2, "Translation Language"

    const/4 v3, 0x1

    invoke-static/range {v0 .. v5}, Lradiant/RLMenu;->item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-static {}, Lradiant/RLSettings;->languageIndex()I

    move-result v9

    move v5, v7

    :goto_26
    sget-object v1, Lradiant/RLSettings;->LANG_LABELS:[Ljava/lang/String;

    array-length v1, v1

    if-ge v5, v1, :cond_4a

    sget-object v1, Lradiant/RLSettings;->LANG_LABELS:[Ljava/lang/String;

    aget-object v2, v1, v5

    const/4 v3, 0x1

    const/16 v4, 0xd

    const-string v1, "ic_social_globe_large"

    invoke-static/range {v0 .. v5}, Lradiant/RLMenu;->item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;

    move-result-object v1

    if-ne v5, v9, :cond_44

    const-string v2, "ic_arrows_checkmark_large"

    invoke-static {v6, v2, v8}, Lradiant/RLMenu;->icon(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/ImageView;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lradiant/RLMenu;->withEnd(Landroid/view/ViewGroup;Landroid/view/View;Landroid/view/View;)Landroid/view/View;

    move-result-object v1

    :cond_44
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_26

    :cond_4a
    return-void

    :cond_4b
    invoke-static {v0}, Lradiant/RLMenu;->syncRow(Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-static {}, Lradiant/RLSettings;->romanize()Z

    move-result v1

    const/16 v2, 0xa

    const-string v3, "ic_text_formatting_alphabetical_large"

    const-string v4, "Romanization"

    invoke-static {v0, v3, v4, v1, v2}, Lradiant/RLMenu;->toggle(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/String;ZI)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v1

    const/16 v2, 0xb

    const-string v3, "ic_social_globe_large"

    const-string v4, "Translation"

    invoke-static {v0, v3, v4, v1, v2}, Lradiant/RLMenu;->toggle(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/String;ZI)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result v1

    if-eqz v1, :cond_bb

    const/16 v4, 0xc

    const/4 v5, 0x0

    const-string v1, "ic_text_formatting_list_large"

    const-string v2, "Translation Language"

    const/4 v3, 0x1

    invoke-static/range {v0 .. v5}, Lradiant/RLMenu;->item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;

    move-result-object v1

    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v6}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lradiant/RLSettings;->LANG_LABELS:[Ljava/lang/String;

    invoke-static {}, Lradiant/RLSettings;->languageIndex()I

    move-result v5

    aget-object v4, v4, v5

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "  \u203a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const v3, -0x66000001

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v3, 0x41600000    # 14.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-static {v0, v1, v2}, Lradiant/RLMenu;->withEnd(Landroid/view/ViewGroup;Landroid/view/View;Landroid/view/View;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_bb
    invoke-static {}, Lradiant/RLSettings;->allowAI()Z

    move-result v1

    if-eqz v1, :cond_d2

    invoke-static {}, Lradiant/RLSettings;->radiantAI()Z

    move-result v2

    const/16 v3, 0xf

    const-string v4, "ic_sparkle"

    const-string v5, "Radiant AI"

    invoke-static {v0, v4, v5, v2, v3}, Lradiant/RLMenu;->toggle(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/String;ZI)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_d2
    sget-boolean v6, Lradiant/RLLyrics;->busy:Z

    sget-object v2, Lradiant/RLLyrics;->trackKey:Ljava/lang/String;

    if-eqz v1, :cond_e3

    if-eqz v2, :cond_e3

    sget-object v1, Lradiant/RLLyrics;->retimeTrack:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_e3

    move v7, v8

    :cond_e3
    xor-int/lit8 v3, v6, 0x1

    const/16 v4, 0x11

    const/4 v5, 0x0

    if-eqz v7, :cond_ef

    const-string v1, "ic_sparkle"

    const-string v2, "Retime Lyrics using Sylla!"

    goto :goto_f3

    :cond_ef
    const-string v1, "ic_media_lyric_sync_medium"

    const-string v2, "Flush Lyrics"

    :goto_f3
    invoke-static/range {v0 .. v5}, Lradiant/RLMenu;->item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;

    move-result-object v1

    if-eqz v7, :cond_fe

    if-nez v6, :cond_fe

    invoke-static {v1}, Lradiant/RLMenu;->rainbow(Landroid/view/View;)V

    :cond_fe
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void
.end method

.method private static res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .registers 5

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    :try_start_4
    sget v1, Lcom/aspiro/wamp/R$drawable;->ic_music_note:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getResourcePackageName(I)Ljava/lang/String;

    move-result-object p0
    :try_end_a
    .catchall {:try_start_4 .. :try_end_a} :catchall_b

    goto :goto_10

    :catchall_b
    move-exception v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    :goto_10
    invoke-virtual {v0, p1, p2, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private static show(Landroid/app/Activity;)V
    .registers 12

    new-instance v0, Lcom/google/android/material/bottomsheet/BottomSheetDialog;

    const-string v1, "BottomSheetDialogTheme"

    const-string v2, "style"

    invoke-static {p0, v1, v2}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-direct {v0, p0, v1}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v0}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->getContext()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const-string v2, "bottom_sheet_context_menu_dialog"

    const-string v3, "layout"

    invoke-static {p0, v2, v3}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    const-string v2, "headerContainer"

    const-string v4, "id"

    invoke-static {p0, v2, v4}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/FrameLayout;

    const-string v6, "recyclerView"

    invoke-static {p0, v6, v4}, Lradiant/RLMenu;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v1, v4}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v4

    sget-object v6, Lradiant/RLLyrics;->track:Lcom/aspiro/wamp/model/Track;

    const-string v7, "RLMenu"

    if-eqz v6, :cond_53

    if-eqz v5, :cond_53

    :try_start_44
    new-instance v8, Lcom/aspiro/wamp/contextmenu/presentation/header/track/BottomSheetTrackHeader;

    invoke-direct {v8, p0, v6}, Lcom/aspiro/wamp/contextmenu/presentation/header/track/BottomSheetTrackHeader;-><init>(Landroid/content/Context;Lcom/aspiro/wamp/model/Track;)V

    invoke-virtual {v5, v8}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V
    :try_end_4c
    .catchall {:try_start_44 .. :try_end_4c} :catchall_4d

    goto :goto_53

    :catchall_4d
    move-exception v5

    const-string v6, "no track header"

    invoke-static {v7, v6, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_53
    :goto_53
    new-instance v5, Landroid/widget/ScrollView;

    invoke-direct {v5, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Landroid/widget/ScrollView;->setNestedScrollingEnabled(Z)V

    const/4 v8, 0x0

    invoke-virtual {v5, v8}, Landroid/widget/ScrollView;->setClipToPadding(Z)V

    if-nez v4, :cond_63

    goto :goto_67

    :cond_63
    invoke-virtual {v4}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    :goto_67
    if-eqz v3, :cond_7a

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v9

    if-eqz v9, :cond_7a

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v5, v3}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    :cond_7a
    if-eqz v4, :cond_81

    const/16 v3, 0x8

    invoke-virtual {v4, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_81
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v9, -0x1

    const/4 v10, -0x2

    invoke-direct {v4, v9, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v3, v4}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v4, v9, v10}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    const/4 v9, 0x3

    invoke-virtual {v4, v9, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    invoke-virtual {v1, v5, v4}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    sget-object v2, Lradiant/RLMenu;->INSETS:Lradiant/RLMenu;

    invoke-virtual {v5, v2}, Landroid/widget/ScrollView;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    invoke-virtual {v0, v1}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->setContentView(Landroid/view/View;)V

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    instance-of v2, v2, Landroid/view/View;

    if-eqz v2, :cond_bf

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    const v2, 0x106000d

    invoke-virtual {p0, v2}, Landroid/content/Context;->getColor(I)I

    move-result p0

    invoke-virtual {v1, p0}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_bf
    :try_start_bf
    invoke-virtual {v0}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->getBehavior()Lcom/google/android/material/bottomsheet/BottomSheetBehavior;

    move-result-object p0

    invoke-virtual {p0, v6}, Lcom/google/android/material/bottomsheet/BottomSheetBehavior;->setSkipCollapsed(Z)V

    invoke-virtual {p0, v9}, Lcom/google/android/material/bottomsheet/BottomSheetBehavior;->setState(I)V
    :try_end_c9
    .catchall {:try_start_bf .. :try_end_c9} :catchall_ca

    goto :goto_d0

    :catchall_ca
    move-exception p0

    const-string v1, "behavior"

    invoke-static {v7, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_d0
    sput-object v0, Lradiant/RLMenu;->dialog:Lcom/google/android/material/bottomsheet/BottomSheetDialog;

    sput-object v3, Lradiant/RLMenu;->list:Landroid/widget/LinearLayout;

    sput-boolean v8, Lradiant/RLMenu;->languagePage:Z

    invoke-static {}, Lradiant/RLMenu;->refresh()V

    invoke-virtual {v0}, Lcom/google/android/material/bottomsheet/BottomSheetDialog;->show()V

    invoke-virtual {v5}, Landroid/widget/ScrollView;->requestApplyInsets()V

    return-void
.end method

.method private static syncRow(Landroid/view/ViewGroup;)Landroid/view/View;
    .registers 12

    invoke-virtual {p0}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    const/4 v5, 0x1

    const/4 v6, 0x0

    const-string v2, "ic_media_lyrics_large"

    const-string v3, ""

    const/4 v4, 0x1

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lradiant/RLMenu;->item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;

    move-result-object p0

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/view/View;->setClickable(Z)V

    new-instance v2, Landroid/widget/FrameLayout;

    invoke-direct {v2, v0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    if-eqz v3, :cond_2a

    iget v4, v3, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-lez v4, :cond_2a

    iget v3, v3, Landroid/view/ViewGroup$LayoutParams;->height:I

    goto :goto_30

    :cond_2a
    const/16 v3, 0x38

    invoke-static {v0, v3}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v3

    :goto_30
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v4, v5, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, p0, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance p0, Landroid/widget/LinearLayout;

    invoke-direct {p0, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v4, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v4}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/16 v6, 0xa

    invoke-static {v0, v6}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v6

    int-to-float v6, v6

    invoke-virtual {v4, v6}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const v6, 0x1fffffff

    invoke-virtual {v4, v6}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {p0, v4}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/4 v4, 0x3

    invoke-static {v0, v4}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v4

    invoke-virtual {p0, v4, v4, v4, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    invoke-static {}, Lradiant/RLSettings;->sync()I

    move-result v4

    move v6, v1

    :goto_66
    sget-object v7, Lradiant/RLSettings;->SYNC_LABELS:[Ljava/lang/String;

    array-length v7, v7

    const/16 v8, 0x10

    if-ge v6, v7, :cond_bd

    new-instance v7, Landroid/widget/TextView;

    invoke-direct {v7, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    sget-object v9, Lradiant/RLSettings;->SYNC_LABELS:[Ljava/lang/String;

    aget-object v9, v9, v6

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/16 v9, 0x11

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setGravity(I)V

    const/high16 v9, 0x41500000    # 13.0f

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setTextSize(F)V

    sget-object v9, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    if-ne v6, v4, :cond_a2

    new-instance v9, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v9}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/16 v10, 0x8

    invoke-static {v0, v10}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v10

    int-to-float v10, v10

    invoke-virtual {v9, v10}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v9, v5}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/high16 v9, -0x1000000

    goto :goto_a5

    :cond_a2
    const v9, -0x4c000001

    :goto_a5
    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setTextColor(I)V

    new-instance v9, Lradiant/RLMenu;

    invoke-direct {v9, v8, v6}, Lradiant/RLMenu;-><init>(II)V

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-direct {v8, v1, v5, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {p0, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_66

    :cond_bd
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v4, 0x24

    invoke-static {v0, v4}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v4

    invoke-direct {v1, v5, v4, v8}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    const/16 v4, 0x48

    invoke-static {v0, v4}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v4

    invoke-virtual {v1, v4}, Landroid/widget/FrameLayout$LayoutParams;->setMarginStart(I)V

    invoke-static {v0, v8}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout$LayoutParams;->setMarginEnd(I)V

    invoke-virtual {v2, p0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance p0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v5, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, p0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-object v2
.end method

.method private static toggle(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/String;ZI)Landroid/view/View;
    .registers 11

    const/4 v3, 0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v4, p4

    invoke-static/range {v0 .. v5}, Lradiant/RLMenu;->item(Landroid/view/ViewGroup;Ljava/lang/String;Ljava/lang/CharSequence;ZII)Landroid/view/View;

    move-result-object p0

    new-instance p1, Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    new-instance p2, Lradiant/RLSwitch;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p4

    invoke-virtual {p4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p4

    invoke-virtual {p4}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p4

    iget p4, p4, Landroid/util/DisplayMetrics;->density:F

    const/4 v1, 0x1

    invoke-direct {p2, p3, v1, p4}, Lradiant/RLSwitch;-><init>(ZZF)V

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-static {v0, p0, p1}, Lradiant/RLMenu;->withEnd(Landroid/view/ViewGroup;Landroid/view/View;Landroid/view/View;)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method private static withEnd(Landroid/view/ViewGroup;Landroid/view/View;Landroid/view/View;)Landroid/view/View;
    .registers 8

    invoke-virtual {p0}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p0

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    if-eqz v1, :cond_16

    iget v2, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-lez v2, :cond_16

    iget v1, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    goto :goto_1c

    :cond_16
    const/16 v1, 0x38

    invoke-static {p0, v1}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result v1

    :goto_1c
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v2, v3, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance p1, Landroid/widget/FrameLayout$LayoutParams;

    const v2, 0x800015

    const/4 v4, -0x2

    invoke-direct {p1, v4, v4, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    const/16 v2, 0x10

    invoke-static {p0, v2}, Lradiant/RLMenu;->dp(Landroid/content/Context;I)I

    move-result p0

    invoke-virtual {p1, p0}, Landroid/widget/FrameLayout$LayoutParams;->setMarginEnd(I)V

    const/4 p0, 0x0

    invoke-virtual {p2, p0}, Landroid/view/View;->setClickable(Z)V

    const/4 p0, 0x2

    invoke-virtual {p2, p0}, Landroid/view/View;->setImportantForAccessibility(I)V

    invoke-virtual {v0, p2, p1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance p0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v3, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method public static wrap(Landroidx/compose/ui/Modifier;Z)Landroidx/compose/ui/Modifier;
    .registers 13

    if-nez p1, :cond_1f

    sget-boolean p1, Lradiant/RLSettings;->rlActive:Z

    if-eqz p1, :cond_1f

    invoke-static {}, Lradiant/RLSettings;->quickMenu()Z

    move-result p1

    if-nez p1, :cond_d

    goto :goto_1f

    :cond_d
    sget-object v7, Lradiant/RLMenu;->OPEN_FN:Lradiant/RLMenu;

    const/4 v9, 0x1

    sget-object v10, Lradiant/RLMenu;->NOOP_FN:Lradiant/RLMenu;

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v10}, Landroidx/compose/foundation/ClickableKt;->combinedClickable-auXiCPI(Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/interaction/MutableInteractionSource;Landroidx/compose/foundation/Indication;ZLjava/lang/String;Landroidx/compose/ui/semantics/Role;Ljava/lang/String;Lyl0/a;Lyl0/a;ZLyl0/a;)Landroidx/compose/ui/Modifier;

    move-result-object p0

    return-object p0

    :cond_1f
    :goto_1f
    move-object v0, p0

    return-object v0
.end method


# virtual methods
.method public invoke()Ljava/lang/Object;
    .registers 2

    iget v0, p0, Lradiant/RLMenu;->action:I

    if-nez v0, :cond_7

    invoke-static {}, Lradiant/RLMenu;->open()V

    :cond_7
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;

    return-object v0
.end method

.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 7

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_11

    invoke-static {}, Landroid/view/WindowInsets$Type;->navigationBars()I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v0

    iget v0, v0, Landroid/graphics/Insets;->bottom:I

    goto :goto_15

    :cond_11
    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetBottom()I

    move-result v0

    :goto_15
    invoke-virtual {p1}, Landroid/view/View;->getPaddingLeft()I

    move-result v1

    invoke-virtual {p1}, Landroid/view/View;->getPaddingTop()I

    move-result v2

    invoke-virtual {p1}, Landroid/view/View;->getPaddingRight()I

    move-result v3

    invoke-virtual {p1, v1, v2, v3, v0}, Landroid/view/View;->setPadding(IIII)V

    return-object p2
.end method

.method public onClick(Landroid/view/View;)V
    .registers 4

    :try_start_0
    iget p1, p0, Lradiant/RLMenu;->action:I

    const/4 v0, 0x1

    const/4 v1, 0x0

    packed-switch p1, :pswitch_data_74

    return-void

    :pswitch_8
    invoke-static {}, Lradiant/RLMenu;->dismiss()V

    invoke-static {}, Lradiant/RLLyrics;->flush()V

    return-void

    :pswitch_f
    iget p1, p0, Lradiant/RLMenu;->arg:I

    invoke-static {}, Lradiant/RLSettings;->sync()I

    move-result v0

    if-eq p1, v0, :cond_4d

    iget p1, p0, Lradiant/RLMenu;->arg:I

    invoke-static {p1}, Lradiant/RLSettings;->setSync(I)V

    goto :goto_4d

    :pswitch_1d
    invoke-static {}, Lradiant/RLSettings;->radiantAI()Z

    move-result p1

    xor-int/2addr p1, v0

    invoke-static {p1}, Lradiant/RLSettings;->setRadiantAI(Z)V

    goto :goto_4d

    :pswitch_26
    sput-boolean v1, Lradiant/RLMenu;->languagePage:Z

    goto :goto_4d

    :pswitch_29
    sput-boolean v1, Lradiant/RLMenu;->languagePage:Z

    iget p1, p0, Lradiant/RLMenu;->arg:I

    invoke-static {}, Lradiant/RLSettings;->languageIndex()I

    move-result v0

    if-eq p1, v0, :cond_4d

    iget p1, p0, Lradiant/RLMenu;->arg:I

    invoke-static {p1}, Lradiant/RLSettings;->setLanguage(I)V

    goto :goto_4d

    :pswitch_39
    sput-boolean v0, Lradiant/RLMenu;->languagePage:Z

    goto :goto_4d

    :pswitch_3c
    invoke-static {}, Lradiant/RLSettings;->translate()Z

    move-result p1

    xor-int/2addr p1, v0

    invoke-static {p1}, Lradiant/RLSettings;->setTranslate(Z)V

    goto :goto_4d

    :pswitch_45
    invoke-static {}, Lradiant/RLSettings;->romanize()Z

    move-result p1

    xor-int/2addr p1, v0

    invoke-static {p1}, Lradiant/RLSettings;->setRomanize(Z)V

    :cond_4d
    :goto_4d
    invoke-static {}, Lradiant/RLMenu;->refresh()V
    :try_end_50
    .catchall {:try_start_0 .. :try_end_50} :catchall_51

    goto :goto_72

    :catchall_51
    move-exception p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "action "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lradiant/RLMenu;->action:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " failed"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "RLMenu"

    invoke-static {v1, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_72
    return-void

    nop

    :pswitch_data_74
    .packed-switch 0xa
        :pswitch_45
        :pswitch_3c
        :pswitch_39
        :pswitch_29
        :pswitch_26
        :pswitch_1d
        :pswitch_f
        :pswitch_8
    .end packed-switch
.end method
