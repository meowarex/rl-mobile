.class public final Lradiant/SparkleButton;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public static final a(ILandroidx/compose/runtime/Composer;Landroidx/compose/ui/Modifier;Ltl0/a;)V
    .locals 21
    .annotation build Landroidx/compose/runtime/Composable;
    .end annotation

    .annotation build Landroidx/compose/runtime/ComposableTarget;
        applier = "androidx.compose.ui.UiComposable"
    .end annotation

    move/from16 v0, p0

    move-object/from16 v1, p3

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const v2, 0x5c08c0ab

    move-object/from16 v3, p1

    invoke-interface {v3, v2}, Landroidx/compose/runtime/Composer;->startRestartGroup(I)Landroidx/compose/runtime/Composer;

    move-result-object v11

    and-int/lit8 v3, v0, 0x6

    if-nez v3, :cond_1

    invoke-interface {v11, v1}, Landroidx/compose/runtime/Composer;->changedInstance(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x4

    goto :goto_0

    :cond_0
    const/4 v3, 0x2

    :goto_0
    or-int/2addr v3, v0

    goto :goto_1

    :cond_1
    move v3, v0

    :goto_1
    or-int/lit8 v3, v3, 0x30

    and-int/lit8 v4, v3, 0x13

    const/16 v5, 0x12

    const/4 v6, 0x0

    if-eq v4, v5, :cond_2

    const/4 v4, 0x1

    goto :goto_2

    :cond_2
    move v4, v6

    :goto_2
    and-int/lit8 v5, v3, 0x1

    invoke-interface {v11, v4, v5}, Landroidx/compose/runtime/Composer;->shouldExecute(ZI)Z

    move-result v4

    if-eqz v4, :cond_6

    sget-object v14, Landroidx/compose/ui/Modifier;->Companion:Landroidx/compose/ui/Modifier$Companion;

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->isTraceInProgress()Z

    move-result v4

    if-eqz v4, :cond_3

    const/4 v4, -0x1

    const-string v5, "radiant.SparkleButton"

    invoke-static {v2, v3, v4, v5}, Landroidx/compose/runtime/ComposerKt;->traceEventStart(IIILjava/lang/String;)V

    :cond_3
    sget-object v2, Lcom/squareup/ui/market/core/theme/k;->e:Lcom/squareup/ui/market/core/theme/k$a;

    const/4 v4, 0x6

    invoke-static {v2, v11, v4}, Lcom/squareup/ui/market/core/theme/w;->t(Lcom/squareup/ui/market/core/theme/k$a;Landroidx/compose/runtime/Composer;I)Lcom/squareup/ui/market/core/theme/MarketStylesheet;

    move-result-object v15

    invoke-interface {v11, v15}, Landroidx/compose/runtime/Composer;->changed(Ljava/lang/Object;)Z

    move-result v2

    invoke-interface {v11}, Landroidx/compose/runtime/Composer;->rememberedValue()Ljava/lang/Object;

    move-result-object v4

    if-nez v2, :cond_4

    sget-object v2, Landroidx/compose/runtime/Composer;->Companion:Landroidx/compose/runtime/Composer$Companion;

    invoke-virtual {v2}, Landroidx/compose/runtime/Composer$Companion;->getEmpty()Ljava/lang/Object;

    move-result-object v2

    if-ne v4, v2, :cond_5

    :cond_4
    sget-object v16, Lcom/squareup/ui/market/core/components/properties/IconButton$Size;->MEDIUM:Lcom/squareup/ui/market/core/components/properties/IconButton$Size;

    sget-object v17, Lcom/squareup/ui/market/core/components/properties/IconButton$Rank;->SECONDARY:Lcom/squareup/ui/market/core/components/properties/IconButton$Rank;

    const/16 v19, 0x4

    const/16 v20, 0x0

    const/16 v18, 0x0

    invoke-static/range {v15 .. v20}, Lcom/squareup/ui/market/components/MarketIconButtonKt;->P(Lcom/squareup/ui/market/core/theme/MarketStylesheet;Lcom/squareup/ui/market/core/components/properties/IconButton$Size;Lcom/squareup/ui/market/core/components/properties/IconButton$Rank;Lcom/squareup/ui/market/core/components/properties/IconButton$Variant;ILjava/lang/Object;)Ll20/v1;

    move-result-object v4

    invoke-interface {v11, v4}, Landroidx/compose/runtime/Composer;->updateRememberedValue(Ljava/lang/Object;)V

    :cond_5
    move-object v9, v4

    check-cast v9, Ll20/v1;

    sget v2, Lcom/tidal/android/feature/playerscreen/ui/R$string;->lyrics:I

    invoke-static {v2, v11, v6}, Landroidx/compose/ui/res/StringResources_androidKt;->stringResource(ILandroidx/compose/runtime/Composer;I)Ljava/lang/String;

    move-result-object v2

    move v4, v3

    invoke-static {v14}, Lcom/tidal/android/feature/playerscreen/ui/composables/anim/BouncePressKt;->a(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;

    move-result-object v3

    new-instance v10, Lradiant/SparkleContent;

    invoke-direct {v10}, Ljava/lang/Object;-><init>()V

    and-int/lit8 v12, v4, 0xe

    const/16 v13, 0xf8

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v1 .. v13}, Lcom/squareup/ui/market/components/MarketIconButtonKt;->c(Ltl0/a;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/interaction/MutableInteractionSource;ZLcom/squareup/ui/market/components/n;Ltl0/a;Ljava/lang/String;Ll20/v1;Ltl0/p;Landroidx/compose/runtime/Composer;II)V

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->isTraceInProgress()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->traceEventEnd()V

    goto :goto_3

    :cond_6
    invoke-interface {v11}, Landroidx/compose/runtime/Composer;->skipToGroupEnd()V

    :cond_7
    :goto_3
    invoke-interface {v11}, Landroidx/compose/runtime/Composer;->endRestartGroup()Landroidx/compose/runtime/ScopeUpdateScope;

    move-result-object v2

    goto :cond_8

    :cond_8
    return-void
.end method
