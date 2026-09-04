.class public final Lradiant/MiniSeekerFloating;
.super Ljava/lang/Object;

.implements Lam0/l;    # MARKER: R8 Lam0/l;


# static fields
.field public static final INSTANCE:Lradiant/MiniSeekerFloating;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lradiant/MiniSeekerFloating;    # singleton

    invoke-direct {v0}, Lradiant/MiniSeekerFloating;-><init>()V    # ctor

    sput-object v0, Lradiant/MiniSeekerFloating;->INSTANCE:Lradiant/MiniSeekerFloating;    # publish

    return-void
.end method


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


.method public final invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    check-cast p1, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;    # narrow type

    invoke-interface {p1}, Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;->drawContent()V    # draw pill content

    invoke-static {}, Lradiant/MiniSeekerLine;->start()V    # lazy subscribe

    :try_start
    invoke-static {p1}, Lradiant/MiniSeekerFloating;->drawBorder(Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;)V    # draw progress
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :swallow

    :swallow
    sget-object v0, Lkotlin/u;->a:Lkotlin/u;    # Unit  MARKER: R8 Lkotlin/u;

    return-object v0
.end method


.method private static drawBorder(Landroidx/compose/ui/graphics/drawscope/ContentDrawScope;)V
    .locals 60

    sget-object v0, Lradiant/MiniSeekerLine;->progressState:Landroidx/compose/runtime/MutableFloatState;    # state

    invoke-interface {v0}, Landroidx/compose/runtime/MutableFloatState;->getFloatValue()F    # read tracked

    move-result v0    # raw progress

    const/4 v1, 0x0    # lower bound

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F    # clamp low

    move-result v0    # clamped low

    const/high16 v1, 0x3f800000    # 1.0f upper

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F    # clamp high

    move-result v0    # final progress

    const/4 v1, 0x0    # zero

    cmpg-float v2, v0, v1    # compare to zero

    if-lez v2, :done    # skip if empty

    move/from16 v16, v0    # stash progress

    invoke-interface/range {p0 .. p0}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J    # size long

    move-result-wide v0    # size pair

    invoke-static {v0, v1}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F    # extract width

    move-result v2    # width px

    move/from16 v17, v2    # stash width

    invoke-static {v0, v1}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F    # extract height

    move-result v2    # height px

    move/from16 v18, v2    # stash height

    invoke-interface/range {p0 .. p0}, Landroidx/compose/ui/unit/Density;->getDensity()F    # density

    move-result v2    # px per dp

    move/from16 v19, v2    # stash density

    const/high16 v0, 0x42100000    # 36.0f dp

    move/from16 v1, v19    # density

    mul-float v2, v0, v1    # to px

    move/from16 v20, v2    # stash r

    const/high16 v0, 0x40000000    # 2.0f

    move/from16 v1, v20    # r

    mul-float v2, v1, v0    # 2*r

    move/from16 v21, v2    # stash 2r

    move/from16 v0, v17    # w

    move/from16 v1, v20    # r

    sub-float v2, v0, v1    # w-r

    move/from16 v22, v2    # stash w-r

    move/from16 v0, v18    # h

    move/from16 v1, v20    # r

    sub-float v2, v0, v1    # h-r

    move/from16 v23, v2    # stash h-r

    move/from16 v0, v17    # w

    move/from16 v1, v21    # 2r

    sub-float v2, v0, v1    # w-2r

    move/from16 v24, v2    # stash w-2r

    move/from16 v0, v18    # h

    move/from16 v1, v21    # 2r

    sub-float v2, v0, v1    # h-2r

    move/from16 v25, v2    # stash h-2r

    move/from16 v0, v17    # w

    const/high16 v1, 0x40000000    # 2.0f

    div-float v2, v0, v1    # w/2

    move/from16 v26, v2    # stash top-center x

    const/high16 v0, 0x42b40000    # 90.0f

    move/from16 v27, v0    # stash 90

    const/4 v0, 0x0    # zero

    move/from16 v1, v27    # 90

    sub-float v2, v0, v1    # -90

    move/from16 v28, v2    # stash -90

    const/high16 v0, 0x43340000    # 180.0f

    move/from16 v29, v0    # stash 180

    invoke-static {}, Landroidx/compose/ui/graphics/AndroidPath_androidKt;->Path()Landroidx/compose/ui/graphics/Path;    # new path

    move-result-object v0    # path

    move-object/from16 v30, v0    # stash path

    move-object/from16 v0, v30    # path

    move/from16 v1, v26    # w/2

    const/4 v2, 0x0    # 0

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/graphics/Path;->moveTo(FF)V    # start top-center

    move-object/from16 v0, v30    # path

    move/from16 v1, v22    # w-r

    const/4 v2, 0x0    # 0

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/graphics/Path;->lineTo(FF)V    # top edge right

    new-instance v3, Landroidx/compose/ui/geometry/Rect;    # arc bounds

    move/from16 v4, v24    # w-2r

    const/4 v5, 0x0    # 0

    move/from16 v6, v17    # w

    move/from16 v7, v21    # 2r

    invoke-direct {v3, v4, v5, v6, v7}, Landroidx/compose/ui/geometry/Rect;-><init>(FFFF)V    # TR rect

    move-object/from16 v0, v30    # path

    move/from16 v4, v28    # -90

    move/from16 v5, v27    # 90

    const/4 v6, 0x0    # false

    invoke-interface {v0, v3, v4, v5, v6}, Landroidx/compose/ui/graphics/Path;->arcTo(Landroidx/compose/ui/geometry/Rect;FFZ)V    # TR corner

    move-object/from16 v0, v30    # path

    move/from16 v1, v17    # w

    move/from16 v2, v23    # h-r

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/graphics/Path;->lineTo(FF)V    # right edge

    new-instance v3, Landroidx/compose/ui/geometry/Rect;    # arc bounds

    move/from16 v4, v24    # w-2r

    move/from16 v5, v25    # h-2r

    move/from16 v6, v17    # w

    move/from16 v7, v18    # h

    invoke-direct {v3, v4, v5, v6, v7}, Landroidx/compose/ui/geometry/Rect;-><init>(FFFF)V    # BR rect

    move-object/from16 v0, v30    # path

    const/4 v4, 0x0    # 0 deg

    move/from16 v5, v27    # 90

    const/4 v6, 0x0    # false

    invoke-interface {v0, v3, v4, v5, v6}, Landroidx/compose/ui/graphics/Path;->arcTo(Landroidx/compose/ui/geometry/Rect;FFZ)V    # BR corner

    move-object/from16 v0, v30    # path

    move/from16 v1, v20    # r

    move/from16 v2, v18    # h

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/graphics/Path;->lineTo(FF)V    # bottom edge

    new-instance v3, Landroidx/compose/ui/geometry/Rect;    # arc bounds

    const/4 v4, 0x0    # 0

    move/from16 v5, v25    # h-2r

    move/from16 v6, v21    # 2r

    move/from16 v7, v18    # h

    invoke-direct {v3, v4, v5, v6, v7}, Landroidx/compose/ui/geometry/Rect;-><init>(FFFF)V    # BL rect

    move-object/from16 v0, v30    # path

    move/from16 v4, v27    # 90

    move/from16 v5, v27    # 90

    const/4 v6, 0x0    # false

    invoke-interface {v0, v3, v4, v5, v6}, Landroidx/compose/ui/graphics/Path;->arcTo(Landroidx/compose/ui/geometry/Rect;FFZ)V    # BL corner

    move-object/from16 v0, v30    # path

    const/4 v1, 0x0    # 0

    move/from16 v2, v20    # r

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/graphics/Path;->lineTo(FF)V    # left edge

    new-instance v3, Landroidx/compose/ui/geometry/Rect;    # arc bounds

    const/4 v4, 0x0    # 0

    const/4 v5, 0x0    # 0

    move/from16 v6, v21    # 2r

    move/from16 v7, v21    # 2r

    invoke-direct {v3, v4, v5, v6, v7}, Landroidx/compose/ui/geometry/Rect;-><init>(FFFF)V    # TL rect

    move-object/from16 v0, v30    # path

    move/from16 v4, v29    # 180

    move/from16 v5, v27    # 90

    const/4 v6, 0x0    # false

    invoke-interface {v0, v3, v4, v5, v6}, Landroidx/compose/ui/graphics/Path;->arcTo(Landroidx/compose/ui/geometry/Rect;FFZ)V    # TL corner

    move-object/from16 v0, v30    # path

    move/from16 v1, v26    # w/2

    const/4 v2, 0x0    # 0

    invoke-interface {v0, v1, v2}, Landroidx/compose/ui/graphics/Path;->lineTo(FF)V    # close to start

    const/high16 v0, 0x40000000    # 2.0f

    move/from16 v1, v24    # w-2r

    mul-float v2, v1, v0    # 2*(w-2r)

    move/from16 v1, v25    # h-2r

    mul-float v3, v1, v0    # 2*(h-2r)

    add-float v4, v2, v3    # straight edges

    const v5, 0x40c90fdb    # 2*pi

    move/from16 v6, v20    # r

    mul-float v7, v6, v5    # arc length

    add-float v8, v4, v7    # total perim

    move/from16 v31, v8    # stash perim

    move/from16 v0, v16    # progress

    move/from16 v1, v31    # perim

    mul-float v2, v0, v1    # visible length

    move/from16 v32, v2    # stash visible

    sget-object v0, Landroidx/compose/ui/graphics/PathEffect;->Companion:Landroidx/compose/ui/graphics/PathEffect$Companion;    # companion

    const/4 v1, 0x2    # length 2

    new-array v1, v1, [F    # intervals

    const/4 v2, 0x0    # index 0

    move/from16 v3, v32    # visible

    aput v3, v1, v2    # dash length

    const/4 v2, 0x1    # index 1

    move/from16 v3, v31    # perim

    aput v3, v1, v2    # gap length

    const/4 v2, 0x0    # phase int

    int-to-float v2, v2    # phase float

    invoke-virtual {v0, v1, v2}, Landroidx/compose/ui/graphics/PathEffect$Companion;->dashPathEffect([FF)Landroidx/compose/ui/graphics/PathEffect;    # dash effect

    move-result-object v0    # effect

    move-object/from16 v33, v0    # stash effect

    const/high16 v0, 0x40000000    # 2.0f

    move/from16 v1, v19    # density

    mul-float v2, v0, v1    # stroke px

    move/from16 v34, v2    # stash stroke width

    new-instance v40, Landroidx/compose/ui/graphics/drawscope/Stroke;    # stroke obj

    move/from16 v41, v34    # width

    const/16 v42, 0x0    # miter default

    const/16 v43, 0x0    # cap default

    const/16 v44, 0x0    # join default

    move-object/from16 v45, v33    # effect

    const/16 v46, 0xe    # default mask

    const/16 v47, 0x0    # marker null

    invoke-direct/range {v40 .. v47}, Landroidx/compose/ui/graphics/drawscope/Stroke;-><init>(FFIILandroidx/compose/ui/graphics/PathEffect;ILkotlin/jvm/internal/DefaultConstructorMarker;)V    # stroke ctor

    move-object/from16 v35, v40    # stash stroke

    const v0, -0x1    # white ARGB

    invoke-static {v0}, Landroidx/compose/ui/graphics/ColorKt;->Color(I)J    # pack color

    move-result-wide v0    # color long

    move-wide/from16 v36, v0    # stash color

    move-object/from16 v50, p0    # scope

    move-object/from16 v51, v30    # path

    move-wide/from16 v52, v36    # color

    const/16 v54, 0x0    # alpha default

    move-object/from16 v55, v35    # style

    const/16 v56, 0x0    # filter null

    const/16 v57, 0x0    # blend default

    const/16 v58, 0x34    # default mask

    const/16 v59, 0x0    # marker null

    invoke-static/range {v50 .. v59}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->drawPath-LG529CI$default(Landroidx/compose/ui/graphics/drawscope/DrawScope;Landroidx/compose/ui/graphics/Path;JFLandroidx/compose/ui/graphics/drawscope/DrawStyle;Landroidx/compose/ui/graphics/ColorFilter;IILjava/lang/Object;)V    # draw stroke

    :done
    return-void
.end method
