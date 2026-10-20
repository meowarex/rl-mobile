# R8 Symbol Map - TIDAL 2.213.0-10017

Maintained by hand. Snapshot of the tree as of TIDAL 2.213.0-10017 (re-derived from the 2.200.0-10004 map by the 2.213 rename sweep) - counts and line
numbers in section 4 drift as patches are edited, so treat them as a starting point
rather than gospel, and re-check with `grep -rn 'MARKER: R8'`.

Every identifier below is **renamed by R8 on each TIDAL build** and has to be re-derived
when bumping the target APK. This file is the checklist for that sweep.

In `extension/**/*.smali` and `tools/kawarp-build/**/*.java` each occurrence also carries
an inline `MARKER: R8 <symbol>` comment, so `grep -rn 'MARKER: R8'` finds them in place.
Smali comments are stripped by the assembler - verified by round-tripping the whole tree
through `smali a` + `baksmali d`, which reproduced the unannotated bytecode exactly.

**`.patch` files are deliberately NOT annotated inline.** A comment on a context or
removed line changes the text `applyPatchFuzzy` matches against and makes the hunk
unlocatable (`Fuzzy match failed: could not locate context for hunk near line N`).
Comments on added `+` lines are unsafe too, because several patches stack on the same
target class (8 hook `PlayerScreenKt.smali` alone), so one patch's output is another's
context. Section 4 lists those occurrences by line number instead.

## Re-deriving after a TIDAL bump

1. baksmali the new APK.
2. For **members** (section 2) the owner class name is usually stable - open the new owner
   and match on the descriptor, which R8 does not change. That pins the new member name.
3. For **classes** (section 1) match on shape: superclass, interfaces, method descriptors.
4. Apply each rename everywhere, re-run the patch set, and check for failed hunks.
5. Update the `TIDAL <version>` in the heading above once the sweep is done.

## Gotcha: extension classes that are themselves patch targets

`player-backdrop-kawarp.patch` has `--- a/radiant/HomeBackdrop.smali` - it patches one of our
own extension classes, not a TIDAL class. For those files the extension smali IS the patch's
match target, so a marker comment on a context or removed line breaks the hunk exactly like it
would in a `.patch` file (`Fuzzy match failed: could not locate context for hunk near line N`).

`extension/radiant/HomeBackdrop.smali` is therefore deliberately left unmarked. Before marking
any extension file, check it is not a patch target:

    grep -rn '^--- a/radiant/\|^--- a/dev/' --include=*.patch patches/

## Gotcha: `tools/kawarp-build/build.sh` drops markers

That script regenerates `extension/radiant/Kawarp.smali` and
`extension/dev/kawarp/KawarpEngine.smali` from the Java sources on every run, so any
`MARKER: R8` comments in those two files are lost. After running it, re-mark them
(`Kawarp.smali` had 39 marked lines) or the Kawarp half of this map goes stale silently.
The Java side under `tools/kawarp-build/{src,stubs}` is not regenerated and keeps its
markers.

## Gotcha: Pebble integration hooks

`extension/radiant/PebbleBridge*.smali` is built by `tools/pebble-bridge-build/build.sh`.

- `integration-pebble-playback.patch` hooks `bk0/e`, TIDAL's 200 ms position poller.
  It holds `Lyj0/d;`, `ExoPlayer` and `Handler` and reposts with `0xc8`.
- `integration-pebble-lyrics.patch` hooks our `RLAPILyricsWorker`, so no markers there.

## 1. Rolled class references (270)

| symbol | uses | referenced from |
|---|---:|---|
| `Lyl0/l;` | 246 | `extension/radiant/Kawarp.smali`, `extension/radiant/MiniPlayerBackground.smali`, `extension/radiant/MiniSeekerFloating.smali` +31 more |
| `Lh4/a;` | 152 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/FeedResolver.smali` +6 more |
| `Lkotlin/u;` | 109 | `extension/radiant/Kawarp.smali`, `extension/radiant/MiniSeekerFloating.smali`, `extension/radiant/NoOp.smali` +22 more |
| `Lcom/google/android/gms/internal/play_billing/f5;` | 74 | `extension/radiant/HomeBackdrop.smali`, `extension/radiant/Kawarp.smali`, `extension/radiant/NoOp.smali` +10 more |
| `Laf/b;` | 60 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali`, `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Ls30/e$e;` | 49 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueueAction.smali`, `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackQueueAction.smali` +3 more |
| `Ln30/p;` | 46 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` +2 more |
| `Lm6/b;` | 46 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lxc/a;` | 44 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali`, `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lm30/b;` | 42 | `extension/radiant/gestures/queue/FeedResolver.smali`, `extension/radiant/gestures/queue/PlaylistItemsResolver.smali`, `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/tidal/android/dynamicpages/ui/c;` | 42 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a;` | 40 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lg40/d;` | 38 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali`, `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali`, `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` +3 more |
| `Le5/d0$t2;` | 36 | `extension/radiant/MiniSeekerLine.smali`, `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Ln6/b$a;` | 36 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Ls30/e$d;` | 32 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/PublicPlaylistQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` +1 more |
| `Li50/u$b;` | 30 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$b;` | 30 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lbm/k;` | 28 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcoil/request/b;` | 28 | `extension/radiant/Kawarp.smali` |
| `Lbm/a;` | 26 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Ls30/e$a;` | 26 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` |
| `Ls30/e$c;` | 26 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` |
| `Lre/a;` | 26 | `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali` |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | 25 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali` +8 more |
| `Lbm/f;` | 24 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lbm/g;` | 24 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Ln30/k;` | 24 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lm70/a;` | 22 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lm70/c;` | 20 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Ln6/g;` | 20 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lr00/a;` | 19 | `extension/radiant/QualityBadge.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/mini-player/mini-player-up-gesture.patch` |
| `Lm70/d;` | 18 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Li50/u;` | 18 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Ln30/a;` | 18 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Ln30/j;` | 18 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Ls30/e;` | 18 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lj30/a;` | 17 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/FeedResolver.smali` +5 more |
| `Li50/e0;` | 16 | `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lo40/e;` | 16 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali` |
| `Lcom/tidal/android/core/adapterdelegate/c;` | 16 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/r$c;` | 16 | `extension/com/tidal/android/feature/appscaffold/ui/r$c.smali`, `extension/radiant/gestures/miniplayer/MiniPlayerTrackGestures$Gesture.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Le5/c;` | 16 | `extension/radiant/MiniSeekerLine.smali`, `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Leh/j;` | 16 | `extension/radiant/MiniSeekerLine.smali` |
| `Li50/f0;` | 14 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lo40/g;` | 14 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lcoil/e;` | 14 | `extension/radiant/Kawarp.smali` |
| `Ln30/o;` | 14 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` +2 more |
| `Lua0/b;` | 14 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$a;` | 14 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Landroidx/compose/foundation/text/input/internal/selection/b;` | 13 | `extension/radiant/gestures/queue/SuggestionsResolver.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Li50/y;` | 12 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/j;` | 12 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/search/v2/d;` | 12 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcom/tidal/android/navigation/a;` | 12 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` +2 more |
| `Lg9/u1;` | 12 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lae0/i;` | 12 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` +2 more |
| `Lo3/a$a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lo3/a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lu3/a$a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lu3/a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/n;` | 11 | `extension/radiant/gestures/queue/SuggestionsResolver.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lw10/c2;` | 11 | `extension/radiant/QualityBadge.smali`, `player-move-playing-from.patch`, `player-quality-badge-colors.patch` |
| `Lml0/a;` | 11 | `extension/radiant/MiniSeekerLine.smali`, `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lo40/j;` | 10 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lcoil/request/h$a;` | 10 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/e1;` | 10 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/player/b;` | 10 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | 10 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Landroidx/compose/foundation/text/selection/g0;` | 10 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/dynamicpages/ui/b;` | 10 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/f;` | 10 | `extension/radiant/RLAPILyricsWorker.smali`, `lyrics-rl-api-syllable.patch`, `lyrics-rl-api-word.patch` |
| `Lq50/c;` | 10 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Ltl/l;` | 10 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcoil/request/h;` | 9 | `extension/radiant/Kawarp.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | 9 | `lyrics-disable-cover.patch`, `lyrics-replace-lyrics-button.patch`, `lyrics-replace-share-button.patch` +3 more |
| `Lhb0/b$a;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lhb0/b$e;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lhb0/b$f;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lhb0/b$i;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Ll70/c;` | 8 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/b$b;` | 8 | `extension/radiant/gestures/miniplayer/MiniPlayerGestures$Gesture.smali`, `extension/radiant/gestures/miniplayer/MiniPlayerGestures.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a;` | 8 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b;` | 8 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/i$a;` | 8 | `player-quality-badge-colors.patch` |
| `Ldagger/internal/f;` | 8 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Ldd/c;` | 8 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali` |
| `Lo30/c$b;` | 8 | `extension/radiant/gestures/queue/ViewAllTrackQueueAction.smali` |
| `Lae0/h;` | 8 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Ljd/b;` | 8 | `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lle/e;` | 8 | `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali` |
| `Ltl/r;` | 8 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lu5/g;` | 8 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali` |
| `Lv9/e;` | 8 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lzh/e;` | 7 | `extension/radiant/RLAPILyricsWorker.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/e3;` | 7 | `extension/radiant/HomeBackdrop.smali`, `extension/radiant/Kawarp.smali`, `player-backdrop-kawarp.patch` +1 more |
| `Lm3/f;` | 7 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lyl0/p;` | 6 | `extension/radiant/SparkleButton.smali`, `extension/radiant/SparkleContent.smali`, `mini-player-black.patch` +1 more |
| `Ld3/f;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Li50/v;` | 6 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lud0/b$a;` | 6 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/f;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | 6 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` | 6 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/b$a;` | 6 | `extension/radiant/gestures/miniplayer/MiniPlayerGestures.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/r;` | 6 | `extension/com/tidal/android/feature/appscaffold/ui/r$c.smali` |
| `Lcom/tidal/android/feature/feed/ui/c;` | 6 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/l1;` | 6 | `lyrics-rl-api-syllable.patch`, `lyrics-rl-api-word.patch` |
| `Lcom/tidal/android/feature/viewall/ui/e$e;` | 6 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Ll10/d;` | 6 | `extension/radiant/QualityBadge.smali` |
| `Leh/b;` | 6 | `extension/radiant/SeekerConsumer.smali` |
| `Ldf/c;` | 6 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` |
| `Lsd0/a;` | 6 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lae0/g;` | 6 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lm3/d;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lm3/f$a;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Leb0/a;` | 6 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lm8/d;` | 6 | `extension/radiant/gestures/queue/FavoriteTracksResolver.smali` |
| `Lhd0/a;` | 6 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lw10/u1;` | 6 | `extension/radiant/SparkleButton.smali` |
| `Lra/d;` | 6 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lpd0/g;` | 6 | `extension/radiant/Kawarp.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/g$c;` | 5 | `extension/radiant/RLAPILyricsWorker.smali`, `lyrics-rl-api-observer.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/p;` | 5 | `lyrics-replace-lyrics-button.patch`, `lyrics-sparkle-conditional-visibility.patch`, `player-hide-playing-from.patch` +1 more |
| `Lc0/c;` | 4 | `extension/radiant/Kawarp.smali` |
| `Lbm/h;` | 4 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Ld3/g$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Ld3/g;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Ld3/j$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Le3/k;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lud0/b;` | 4 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/z$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/e0;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/core/l;` | 4 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m;` | 4 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/j$a;` | 4 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/j$e;` | 4 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/playback/e0;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/playback/d;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/playback/k0;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/playqueue/r0;` | 4 | `extension/radiant/MiniSeekerLine.smali` |
| `Lcom/aspiro/wamp/playqueue/m0;` | 4 | `extension/radiant/RLAPILyricsWorker.smali` |
| `Lcom/aspiro/wamp/search/v2/a$g;` | 4 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcom/squareup/ui/market/core/theme/k$a;` | 4 | `extension/radiant/SparkleButton.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b$a;` | 4 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueueAction.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/tracklist/b$a;` | 4 | `extension/radiant/gestures/queue/DynamicTrackQueueAction.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b$a;` | 4 | `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/q;` | 4 | `cover-capture.patch`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/search/ui/f;` | 4 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lcom/tidal/android/feature/viewall/ui/c;` | 4 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lcom/tidal/android/image/core/b$a;` | 4 | `extension/radiant/Kawarp.smali` |
| `Le0/c$a;` | 4 | `extension/radiant/Kawarp.smali` |
| `Lk3/m$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lk3/m;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Le3/j$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lk3/p;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Le3/b$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lk3/s;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lm3/i$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lm3/i;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Leb0/e;` | 4 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Ltn0/b;` | 4 | `extension/radiant/RLAPILyricsWorker.smali` |
| `Lk70/a;` | 4 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lxf/c;` | 4 | `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Lx/f0;` | 3 | `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Landroidx/window/embedding/c2;` | 3 | `lyrics-replace-lyrics-button.patch`, `lyrics-sparkle-conditional-visibility.patch` |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | 3 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/r$a;` | 3 | `extension/radiant/gestures/miniplayer/MiniPlayerTrackGestures$Gesture.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | 3 | `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/mini-player/mini-player-up-gesture.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/b;` | 3 | `lyrics-replace-share-button.patch` |
| `Lcom/tidal/android/feature/viewall/ui/e;` | 3 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/image/core/b$h$a;` | 3 | `extension/radiant/Kawarp.smali` |
| `Ldagger/internal/j;` | 3 | `extension/radiant/MiniSeekerLine.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lkotlin/jvm/internal/n;` | 3 | `integration-waze-playback.patch` |
| `Lg20/a;` | 2 | `player-favorite-heart.patch` |
| `Lyc/f;` | 2 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali` |
| `Lyl0/q;` | 2 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Landroidx/window/embedding/d2;` | 2 | `lyrics-replace-share-button.patch` |
| `Lbd/d$a;` | 2 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali` |
| `Lbm/i;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcoil/request/d;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lz3/b;` | 2 | `gestures/queue/swipe-to-queue.patch` |
| `Lz3/c;` | 2 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/h;` | 2 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/k;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/l;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/z$a;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/search/v2/a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcom/aspiro/wamp/util/a0;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lcom/squareup/ui/market/components/n;` | 2 | `extension/radiant/SparkleButton.smali` |
| `Lcom/squareup/ui/market/core/theme/k;` | 2 | `extension/radiant/SparkleButton.smali` |
| `Lcom/squareup/ui/market/core/theme/h0;` | 2 | `extension/radiant/SparkleButton.smali` |
| `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d;` | 2 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b;` | 2 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueueEvent.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/b;` | 2 | `extension/radiant/gestures/queue/DynamicMediaQueueEvent.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/tracklist/b;` | 2 | `extension/radiant/gestures/queue/DynamicTrackQueueEvent.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b;` | 2 | `extension/radiant/gestures/queue/DynamicMediaQueueEvent.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/a;` | 2 | `mini-player-black.patch`, `mini-player-dynamic-bg.patch` |
| `Lbd0/a;` | 2 | `lyrics-replace-lyrics-button.patch`, `lyrics-sparkle-conditional-visibility.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/d;` | 2 | `lyrics-disable-cover.patch`, `player-move-playing-from.patch` |
| `Lcom/tidal/android/feature/profile/ui/sociallinks/y;` | 2 | `lyrics-replace-share-button.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/g;` | 2 | `lyrics-disable-cover.patch`, `lyrics-progress-pill.patch` |
| `Lcom/tidal/android/feature/search/ui/b;` | 2 | `extension/radiant/gestures/queue/ComposeSearchQueueEvent.smali` |
| `Lcom/tidal/android/feature/search/ui/e;` | 2 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lcom/tidal/android/feature/viewall/ui/u;` | 2 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lcom/tidal/android/image/coil/c;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lcom/tidal/android/image/core/b;` | 2 | `extension/radiant/Kawarp.smali` |
| `Ldf/d$a;` | 2 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` |
| `Lhu/akarnokd/rxjava/interop/f;` | 2 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lgd/e;` | 2 | `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lgj/b0$a;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lgj/l0$a;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lgj/r$a;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Ljd/d$a;` | 2 | `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lk5/f;` | 2 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali` |
| `Lkotlin/collections/u;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lkotlin/coroutines/e;` | 2 | `extension/radiant/gestures/lyrics/LyricsDrag$Guard.smali` |
| `Landroidx/compose/ui/text/p;` | 2 | `extension/radiant/MiniPlayerBackground.smali` |
| `Lkotlin/i;` | 2 | `mini-player-dynamic-bg.patch` |
| `Lmb0/f;` | 2 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lo4/g;` | 2 | `gestures/queue/swipe-to-queue.patch` |
| `La40/a;` | 2 | `debug-menu-unlock.patch` |
| `Lo7/a$a;` | 2 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lw10/r4;` | 2 | `extension/radiant/QualityBadge.smali` |
| `Lw10/s4;` | 2 | `extension/radiant/QualityBadge.smali` |
| `Lqe/c$a;` | 2 | `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali` |
| `Ltl/j;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/a0$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/d$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/n0$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/w$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lu6/e$a;` | 2 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lr60/a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lrn0/a;` | 2 | `extension/radiant/RLAPILyricsWorker.smali` |
| `Lw70/c$a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lw70/h$a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lw70/k$a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Luf/d;` | 2 | `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Lhd0/h;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lhd0/j;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lxf/d$a;` | 2 | `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Lg20/b;` | 1 | `player-favorite-heart.patch` |
| `Landroidx/compose/foundation/text/input/a;` | 1 | `player-backdrop-playback.patch` |
| `Lyj0/d;` | 1 | `integration-pebble-playback.patch` |
| `Lyj0/e;` | 1 | `integration-pebble-playback.patch` |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/n;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/p;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/a;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/squareup/ui/market/layout/e;` | 1 | `player-backdrop-playback.patch` |
| `Lcom/squareup/ui/market/text/a;` | 1 | `player-move-playing-from.patch` |
| `Lcom/tidal/android/dynamicpages/ui/composables/verticallistcard/m;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/g;` | 1 | `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/i0;` | 1 | `lyrics-disable-cover.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/c4;` | 1 | `lyrics-replace-share-button.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/v0;` | 1 | `lyrics-replace-lyrics-button.patch` |
| `Lcom/squareup/ui/market/modal/a0;` | 1 | `lyrics-fade-region.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/u3;` | 1 | `player-quality-badge-colors.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/g$a;` | 1 | `lyrics-disable-cover.patch` |
| `Lcom/tidal/android/feature/viewall/ui/e$a;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/viewall/ui/w;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/featureflags/l;` | 1 | `debug-menu-unlock.patch` |
| `Lcom/tidal/android/tidalapi/domain/model/q;` | 1 | `lyrics-rl-api-isrc.patch` |
| `Lvd0/c;` | 1 | `player-backdrop-playback.patch` |
| `Lkb/f;` | 1 | `integration-waze-playback.patch` |
| `Lm8/b;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lo4/g$e;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lgb0/x;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lgb0/d0;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |

## 2. Rolled members on otherwise-stable classes (347)

The owner name survives R8; only the member name rolls. Match on the descriptor.

| owner | member | descriptor | uses |
|---|---|---|---:|
| `Lcom/aspiro/wamp/App$a;` | `a` | `()Lcom/aspiro/wamp/App;` | 8 |
| `Lcom/aspiro/wamp/App;` | `e` | `()Le5/c;` | 8 |
| `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b;` | `a` | `(Landroidx/lifecycle/LifecycleOwner;Landroidx/recyclerview/widget/RecyclerView;)Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a;` | 8 |
| `Ls30/e$e;` | `a` | `:J` | 8 |
| `Lg40/b;` | `b` | `:Ljava/util/ArrayList;` | 7 |
| `Laf/b;` | `a` | `:Lcom/aspiro/wamp/model/Playlist;` | 6 |
| `Lcom/tidal/android/navigation/a;` | `b` | `(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;` | 6 |
| `Lae0/i;` | `c` | `(Ln30/p;)Lcom/aspiro/wamp/model/Track;` | 6 |
| `Ln6/b;` | `c` | `:Ln6/b$a;` | 6 |
| `Lxc/a;` | `b` | `:Lcom/aspiro/wamp/model/Album;` | 6 |
| `Li50/u$b;` | `a` | `:Ln30/o;` | 5 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `j` | `(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;` | 5 |
| `Lcom/tidal/android/dynamicpages/ui/c;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 5 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `S` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 5 |
| `Lq50/c;` | `c` | `(Ljava/lang/String;)Li50/j;` | 5 |
| `Ls30/e$e;` | `j` | `:Z` | 5 |
| `Ln6/b$a;` | `q` | `:Ljava/lang/String;` | 5 |
| `Ln6/b;` | `a` | `:Ln6/g;` | 5 |
| `Lbm/a;` | `a` | `:Lcom/aspiro/wamp/model/Album;` | 4 |
| `Lbm/f;` | `a` | `:Lcom/aspiro/wamp/mix/model/Mix;` | 4 |
| `Lbm/g;` | `a` | `:Lcom/aspiro/wamp/model/Playlist;` | 4 |
| `Lbm/k;` | `a` | `:Lcom/aspiro/wamp/model/Track;` | 4 |
| `Laf/b;` | `h` | `:Z` | 4 |
| `Laf/b;` | `f` | `:Z` | 4 |
| `Laf/b;` | `g` | `:Ljava/lang/String;` | 4 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `o` | `(Lcom/tidal/android/navigation/NavigationInfo;Ljava/lang/String;Ljava/lang/String;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;` | 4 |
| `Lcom/aspiro/wamp/search/v2/UnifiedSearchView;` | `N` | `()Ltl/j;` | 4 |
| `Lcom/tidal/android/feature/playerscreen/ui/f;` | `a` | `:Ljava/lang/String;` | 4 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `m` | `:Lcom/tidal/android/feature/playerscreen/ui/p;` | 4 |
| `Ln30/p;` | `a` | `:J` | 4 |
| `Lae0/h;` | `a` | `(Ln30/k;)Lcom/aspiro/wamp/model/Playlist;` | 4 |
| `Ln6/b$a;` | `o` | `:I` | 4 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$b;` | `s` | `:I` | 4 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a;` | `c` | `:Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$b;` | 4 |
| `Lxc/a;` | `k` | `:Z` | 4 |
| `Lm70/a;` | `a` | `:Lcom/aspiro/wamp/model/Album;` | 3 |
| `Lm70/c;` | `a` | `:Lcom/aspiro/wamp/mix/model/Mix;` | 3 |
| `Lm70/d;` | `a` | `:Lcom/aspiro/wamp/model/Playlist;` | 3 |
| `Li50/v;` | `a` | `(Li50/u;)Ljava/lang/String;` | 3 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `i` | `:Z` | 3 |
| `Lcom/aspiro/wamp/player/c;` | `b` | `()Lcom/aspiro/wamp/model/MediaItemParent;` | 3 |
| `Lcom/aspiro/wamp/playqueue/x0;` | `a` | `()Lcom/aspiro/wamp/player/c;` | 3 |
| `Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$a;` | `a` | `(Ljava/lang/String;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;` | 3 |
| `Lcom/tidal/android/feature/appscaffold/ui/b$b;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/b$b;` | 3 |
| `Lcom/tidal/android/feature/appscaffold/ui/r$c;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/r$c;` | 3 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/e3;` | `a` | `(ILjava/lang/String;ZZLyl0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V` | 3 |
| `Lh4/a;` | `b` | `:Lo3/a$a;` | 3 |
| `Lh4/a;` | `h` | `:Lu3/a$a;` | 3 |
| `Lae0/a;` | `b` | `(Ln30/a;)Lcom/aspiro/wamp/model/Album;` | 3 |
| `Lae0/g;` | `b` | `(Ln30/j;)Lcom/aspiro/wamp/mix/model/Mix;` | 3 |
| `Ls30/e$d;` | `a` | `:Ljava/lang/String;` | 3 |
| `Ls30/e$d;` | `g` | `:Z` | 3 |
| `Lo3/a$a;` | `a` | `(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lo3/a;` | 3 |
| `Ln6/b$a;` | `d` | `:I` | 3 |
| `Lu3/a$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lu3/a;` | 3 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$b;` | `t` | `:Ljava/lang/String;` | 3 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a;` | `a` | `:Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$a;` | 3 |
| `Lte/a;` | `c` | `:Lcom/aspiro/wamp/mix/model/Mix;` | 3 |
| `Lcoil/request/h$a;` | `b` | `:Lcoil/request/b;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `Y` | `(ILcom/aspiro/wamp/model/FavoriteTrack;)Z` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `d` | `:Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `l` | `:Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | `b` | `(I)Lcom/aspiro/wamp/model/FavoriteTrack;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m;` | `f` | `:Landroidx/recyclerview/widget/RecyclerView;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;` | `c` | `:Lne/f;` | 2 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `h` | `:Landroid/graphics/drawable/Drawable;` | 2 |
| `Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;` | `h` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 2 |
| `Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;` | `c` | `:Lcom/aspiro/wamp/playlist/ui/items/a;` | 2 |
| `Lcom/aspiro/wamp/search/v2/UnifiedSearchView;` | `g` | `:Lio/reactivex/disposables/CompositeDisposable;` | 2 |
| `Lcom/aspiro/wamp/search/v2/d;` | `e` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 2 |
| `Lcom/squareup/ui/market/core/theme/MarketStylesheet$c;` | `p0` | `()Ll10/a;` | 2 |
| `Lcom/tidal/android/feature/appscaffold/ui/b$a;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/b$a;` | 2 |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/a;` | `c` | `:Landroidx/compose/foundation/shape/RoundedCornerShape;` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/BroadcastButtonKt;` | `b` | `(Lcom/tidal/android/feature/playerscreen/ui/b;Lyl0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/u1;` | `b` | `:I` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/u1;` | `d` | `:J` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/u1;` | `e` | `:J` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/e3;` | `b` | `(Lcom/tidal/android/feature/playerscreen/ui/model/PlayerBackgroundStyle;JILjava/lang/String;ZZLyl0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/h3;` | `a` | `(ILyl0/a;Landroidx/compose/runtime/Composer;Landroidx/compose/ui/Modifier;)V` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/i$a;` | `b` | `:I` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/i$a;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lcom/tidal/android/feature/search/ui/SearchQuery;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `m` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 2 |
| `Le5/d0$t2;` | `A2` | `()Lcom/aspiro/wamp/playqueue/x0;` | 2 |
| `Lg9/u1;` | `b` | `:Ld40/a;` | 2 |
| `Lm3/f$a;` | `a` | `(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/f;` | 2 |
| `Lm3/f;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 2 |
| `Ls30/e$a;` | `a` | `:J` | 2 |
| `Ls30/e$a;` | `e` | `:Z` | 2 |
| `Ls30/e$c;` | `a` | `:Ljava/lang/String;` | 2 |
| `Ls30/e$c;` | `h` | `:Z` | 2 |
| `Lu40/a;` | `a` | `:Ljava/lang/String;` | 2 |
| `Ln6/b;` | `b` | `:J` | 2 |
| `Ln6/g;` | `p` | `:Ljava/util/LinkedHashMap;` | 2 |
| `Ltl/r;` | `a` | `:Ld40/a;` | 2 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$b;` | `g` | `:Lcom/aspiro/wamp/model/Availability;` | 2 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$b;` | `p` | `:Z` | 2 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a;` | `b` | `:J` | 2 |
| `Lte/a;` | `f` | `:Z` | 2 |
| `Lte/a;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lg20/a;` | `a` | `:I` | 1 |
| `Lg20/b;` | `O` | `:Lg20/a;` | 1 |
| `Ll70/c;` | `a` | `:Ljava/lang/String;` | 1 |
| `Ll70/c;` | `e` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Ll70/c;` | `b` | `:Ld40/a;` | 1 |
| `Lm70/a;` | `c` | `:Z` | 1 |
| `Lm70/a;` | `g` | `:I` | 1 |
| `Lm70/c;` | `c` | `:I` | 1 |
| `Lm70/d;` | `c` | `:I` | 1 |
| `Lzh/e;` | `i` | `()Z` | 1 |
| `Lzh/e;` | `h` | `(Z)V` | 1 |
| `Lbm/a;` | `c` | `:Lcom/aspiro/wamp/model/Availability$Album;` | 1 |
| `Lbm/i;` | `a` | `(Lbm/h;)Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lbm/k;` | `e` | `:Lcom/aspiro/wamp/model/Availability$MediaItem;` | 1 |
| `Lbm/k;` | `n` | `:Lcom/aspiro/wamp/search/SearchDataSource;` | 1 |
| `Ld3/f;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Ld3/g$a;` | `a` | `(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Ld3/g;` | 1 |
| `Ld3/g;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Ld3/j$a;` | `a` | `(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Ld3/j;` | 1 |
| `Ld3/j;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Li50/e0;` | `b` | `:Ljava/lang/String;` | 1 |
| `Li50/e0;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Li50/e0;` | `a` | `:Ljava/lang/String;` | 1 |
| `Li50/e0;` | `e` | `:I` | 1 |
| `Li50/e0;` | `c` | `:Ljava/lang/String;` | 1 |
| `Li50/e0;` | `g` | `:Ljava/lang/String;` | 1 |
| `Li50/f0;` | `b` | `:Ljava/lang/String;` | 1 |
| `Li50/f0;` | `g` | `:Ljava/util/ArrayList;` | 1 |
| `Li50/f0;` | `a` | `:Ljava/lang/String;` | 1 |
| `Li50/f0;` | `f` | `:I` | 1 |
| `Li50/f0;` | `c` | `:Ljava/lang/String;` | 1 |
| `Li50/d;` | `b` | `:Ljava/lang/String;` | 1 |
| `Li50/d;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Li50/d;` | `a` | `:Ljava/lang/String;` | 1 |
| `Li50/d;` | `e` | `:I` | 1 |
| `Li50/d;` | `c` | `:Ljava/lang/String;` | 1 |
| `Li50/d;` | `g` | `:Ljava/lang/String;` | 1 |
| `Li50/f;` | `b` | `:Ljava/lang/String;` | 1 |
| `Li50/f;` | `g` | `:Ljava/util/ArrayList;` | 1 |
| `Li50/f;` | `a` | `:Ljava/lang/String;` | 1 |
| `Li50/f;` | `d` | `:I` | 1 |
| `Li50/f;` | `e` | `:Ljava/lang/String;` | 1 |
| `Li50/y;` | `b` | `:Ljava/lang/String;` | 1 |
| `Li50/y;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Li50/y;` | `a` | `:Ljava/lang/String;` | 1 |
| `Li50/y;` | `e` | `:I` | 1 |
| `Lud0/b$a;` | `a` | `()Lud0/b;` | 1 |
| `Lud0/b;` | `a` | `()Lpd0/e;` | 1 |
| `Lcoil/e;` | `b` | `(Lcoil/request/h;)Lcoil/request/d;` | 1 |
| `Lcoil/request/b;` | `a` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `b` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `c` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `d` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `e` | `:Le0/c$a;` | 1 |
| `Lcoil/request/b;` | `f` | `:Lcoil/size/Precision;` | 1 |
| `Lcoil/request/b;` | `g` | `:Landroid/graphics/Bitmap$Config;` | 1 |
| `Lcoil/request/b;` | `h` | `:Z` | 1 |
| `Lcoil/request/b;` | `i` | `:Lcoil/request/CachePolicy;` | 1 |
| `Lcoil/request/b;` | `j` | `:Lcoil/request/CachePolicy;` | 1 |
| `Lcoil/request/h$a;` | `d` | `:Lc0/c;` | 1 |
| `Lcoil/request/h$a;` | `a` | `()Lcoil/request/h;` | 1 |
| `Lcoil/request/h;` | `a` | `(Lcoil/request/h;)Lcoil/request/h$a;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/f;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;` | `a` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/h;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/z$a;` | `a` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/z;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/z;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lz3/b;` | `b` | `:Ldagger/internal/j;` | 1 |
| `Lz3/c;` | `a` | `:Lz3/b;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `h` | `:Lyc/f;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `N` | `()Lg40/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `c` | `:Ldd/c;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `j` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `f` | `:Lgd/e;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `N` | `()Lg40/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `c` | `:Ljd/b;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `g` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `Z` | `(ILcom/aspiro/wamp/model/FavoriteTrack;I)V` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `f` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `b` | `:Ld40/a;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `x` | `(Landroidx/recyclerview/widget/RecyclerView;ILandroid/view/View;)V` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `N` | `()Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/n;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | `m` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | `k` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;` | `N` | `()Lg40/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;` | `h` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;` | `j` | `:Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/h;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;` | `N` | `()Lg40/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;` | `d` | `:Lff/c;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView;` | `g` | `:Luf/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView;` | `N` | `()Lg40/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView;` | `c` | `:Lxf/c;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `c` | `:Landroid/graphics/drawable/ColorDrawable;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `d` | `:Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl$ActionType;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/e1;` | `o` | `:Ljava/lang/Object;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/e1;` | `j` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/i;` | `d` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/i;` | `c` | `:Lcom/aspiro/wamp/nowplaying/view/suggestions/m;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/k;` | `a` | `(Lcom/aspiro/wamp/nowplaying/view/suggestions/j;)V` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/q0;` | `d` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/q0;` | `c` | `:Lcom/aspiro/wamp/nowplaying/view/suggestions/m;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/q0;` | `M` | `()Lcom/aspiro/wamp/nowplaying/view/suggestions/m;` | 1 |
| `Lcom/aspiro/wamp/playback/e0;` | `a` | `(Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lio/reactivex/disposables/Disposable;` | 1 |
| `Lcom/aspiro/wamp/playback/e;` | `a` | `(ILcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lhu/akarnokd/rxjava/interop/f;` | 1 |
| `Lcom/aspiro/wamp/playback/k0;` | `c` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)V` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;` | `d` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | `l` | `()Lcom/aspiro/wamp/playlist/viewmodel/PlaylistCollectionViewModel;` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | `c` | `(Lcom/aspiro/wamp/model/Track;)V` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | `j` | `(I)V` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `c` | `(Lcom/aspiro/wamp/model/Album;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/AlbumSource;` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `f` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/PlaylistSource;` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `p` | `(Ljava/lang/String;Ljava/util/List;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `m` | `(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/MyItemsSource;` | 1 |
| `Lcom/aspiro/wamp/search/v2/UnifiedSearchView;` | `c` | `:Ltl/r;` | 1 |
| `Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lcom/aspiro/wamp/util/a0;` | `c` | `(I)Ljava/lang/String;` | 1 |
| `Lcom/squareup/ui/market/components/MarketIconButtonKt;` | `P` | `(Lcom/squareup/ui/market/core/theme/MarketStylesheet;Lcom/squareup/ui/market/core/components/properties/IconButton$Size;Lcom/squareup/ui/market/core/components/properties/IconButton$Rank;Lcom/squareup/ui/market/core/components/properties/IconButton$Variant;ILjava/lang/Object;)Lw10/u1;` | 1 |
| `Lcom/squareup/ui/market/components/MarketIconButtonKt;` | `c` | `(Lyl0/a;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/interaction/MutableInteractionSource;ZLcom/squareup/ui/market/components/n;Lyl0/a;Ljava/lang/String;Lw10/u1;Lyl0/p;Landroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/squareup/ui/market/components/MarketLabelKt;` | `e` | `(Ljava/lang/String;Landroidx/compose/ui/Modifier;IILcom/squareup/ui/market/text/a;Landroidx/compose/foundation/interaction/MutableInteractionSource;Lyl0/l;Lw10/c2;Landroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/squareup/ui/market/core/theme/k;` | `e` | `:Lcom/squareup/ui/market/core/theme/k$a;` | 1 |
| `Lcom/squareup/ui/market/core/theme/d0;` | `t` | `(Lcom/squareup/ui/market/core/theme/k$a;Landroidx/compose/runtime/Composer;I)Lcom/squareup/ui/market/core/theme/MarketStylesheet;` | 1 |
| `Lrx/functions/u;` | `b` | `(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;` | 1 |
| `Lcom/tidal/android/core/debug/DebugFeatureInteractorDefault;` | `a` | `:Lcom/tidal/android/featureflags/m;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/c;` | `a` | `:Lcom/aspiro/wamp/core/l;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d;` | `c` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/ArtistTrackCreditsModuleManager;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | `f` | `:Lyl0/q;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/PublicPlaylistListModuleManager;` | `f` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/tracklist/TrackListModuleManager;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/VerticalListCardModuleManager;` | `e` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/g;` | `a` | `:Lyl0/l;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/q;` | `d` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/q;` | `e` | `:Z` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/r$a;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/r$a;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | `b` | `:Lcom/tidal/android/feature/appscaffold/ui/q;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | `c` | `:Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$PlayState;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$ItemType;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/FeedView;` | `d` | `:Lg70/b;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/FeedView;` | `c` | `:Ll70/c;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/FeedView;` | `f` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/c;` | `c` | `:Lk70/a;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/viewstates/UpdatedIntervals$a;` | `a` | `(I)Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel$observeLyricsProgress$1$a;` | `a` | `:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `W` | `:Lkotlinx/coroutines/flow/StateFlow;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `T` | `:Lkotlin/i;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `a` | `:Lzh/e;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `R` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `N` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/i0;` | `b` | `:Lcom/tidal/android/feature/playerscreen/ui/s$a;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/CoverPagerKt;` | `c` | `(Lcom/tidal/android/feature/playerscreen/ui/d;Lyl0/l;FLandroidx/compose/ui/Modifier;ZLandroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/LyricsKt;` | `a` | `(Lcom/tidal/android/feature/playerscreen/ui/g;Lyl0/l;Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/layout/PaddingValues;Lyl0/l;Landroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/anim/BouncePressKt;` | `a` | `(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/o4;` | `a` | `(ILyl0/a;Landroidx/compose/runtime/Composer;Landroidx/compose/ui/Modifier;)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/c1;` | `a` | `(Landroidx/compose/ui/Modifier;Lyl0/a;ZLandroidx/compose/runtime/Composer;I)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/f1;` | `a` | `:F` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/g4;` | `g` | `:F` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/g$c;` | `c` | `:I` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/p;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `j` | `:Lcom/tidal/android/feature/playerscreen/ui/g;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `d` | `:Lcom/tidal/android/feature/playerscreen/ui/b;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `i` | `:Z` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `c` | `:Lcom/tidal/android/feature/playerscreen/ui/d;` | 1 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `n` | `:Ljava/util/List;` | 1 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `d` | `:Lcom/tidal/android/feature/search/ui/e;` | 1 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `f` | `:Lcom/tidal/android/feature/search/ui/f;` | 1 |
| `Lcom/tidal/android/feature/search/ui/f;` | `a` | `(JLn30/p;Ljava/lang/String;)V` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;` | `n` | `:Lcom/tidal/android/feature/viewall/ui/c;` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;` | `f` | `:Lcom/tidal/android/feature/viewall/ui/u;` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/c;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/e$d;` | `a` | `:Ljava/lang/Object;` | 1 |
| `Lcom/tidal/android/image/coil/base/CoilImageLoader;` | `a` | `:Lcoil/e;` | 1 |
| `Lcom/tidal/android/image/coil/c;` | `a` | `(Lpd0/g;Landroidx/compose/ui/layout/ContentScale;)Lcoil/request/h;` | 1 |
| `Lvd0/c;` | `a` | `:Ljava/lang/String;` | 1 |
| `Le5/d0$t2;` | `e1` | `:Ldagger/internal/j;` | 1 |
| `Le5/d0$t2;` | `F3` | `()Lcom/aspiro/wamp/playback/e;` | 1 |
| `Le5/d0$t2;` | `I3` | `()Lcom/aspiro/wamp/playback/e0;` | 1 |
| `Le5/d0$t2;` | `w8` | `:Ldagger/internal/f;` | 1 |
| `Le5/d0$t2;` | `J3` | `()Lcom/aspiro/wamp/playback/k0;` | 1 |
| `Le5/d0$t2;` | `v8` | `:Ldagger/internal/f;` | 1 |
| `Le5/d0$t2;` | `K9` | `:Ldagger/internal/f;` | 1 |
| `Le5/d0$t2;` | `k9` | `:Ldagger/internal/f;` | 1 |
| `Ldd/c;` | `a` | `:Ld40/a;` | 1 |
| `Ldd/c;` | `d` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Ldd/c;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Leh/b;` | `b` | `:F` | 1 |
| `Leh/j;` | `a` | `()V` | 1 |
| `Leh/j;` | `d` | `:Lio/reactivex/subjects/BehaviorSubject;` | 1 |
| `Lh4/a;` | `q` | `(Landroidx/fragment/app/FragmentActivity;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z` | 1 |
| `Lh4/a;` | `m` | `:Lz3/a$a;` | 1 |
| `Lff/c;` | `e` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lff/c;` | `d` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lk3/m$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lk3/m;` | 1 |
| `Lk3/m;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/k$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lk3/p;` | 1 |
| `Lk3/p;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/AddToFavorites$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lk3/s;` | 1 |
| `Lk3/s;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lk5/f;` | `l` | `(Ljava/lang/String;)Lcom/aspiro/wamp/dynamicpages/data/model/Module;` | 1 |
| `Ljd/b;` | `a` | `:Ld40/a;` | 1 |
| `Ljd/b;` | `d` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Ljd/b;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lm3/d;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lm3/f;` | `j` | `:Lcom/aspiro/wamp/playqueue/x0;` | 1 |
| `Lm3/i$a;` | `a` | `(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/i;` | 1 |
| `Lm3/i;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lkb/f;` | `c` | `:Ljava/util/Map;` | 1 |
| `Leb0/a;` | `a` | `:Ln30/o;` | 1 |
| `Lcom/squareup/experiments/x;` | `c` | `(Leb0/e;)Ljava/lang/String;` | 1 |
| `Lm8/d;` | `f` | `:Lcom/aspiro/wamp/model/MediaItem;` | 1 |
| `Lo3/a;` | `m` | `:Lcom/aspiro/wamp/module/album/AlbumProvider;` | 1 |
| `Lo3/a;` | `f` | `:Ld3/g$a;` | 1 |
| `Lo3/a;` | `e` | `:Ld3/j$a;` | 1 |
| `Lo4/g;` | `e` | `:Lo4/g$e;` | 1 |
| `Lo4/g;` | `b` | `:I` | 1 |
| `Ln6/g;` | `g` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Ln6/g;` | `e` | `(ILjava/lang/String;)V` | 1 |
| `Ln6/g;` | `m` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lgb0/x;` | `a` | `(Lhb0/b$e;Lyl0/a;Landroidx/compose/ui/Modifier;Lyl0/a;Landroidx/compose/runtime/Composer;I)V` | 1 |
| `Lgb0/d0;` | `a` | `(Lhb0/b$f;Lyl0/a;Landroidx/compose/ui/Modifier;Lyl0/a;Landroidx/compose/runtime/Composer;I)V` | 1 |
| `Lhb0/b$a;` | `a` | `:J` | 1 |
| `Lhb0/b$a;` | `f` | `:Z` | 1 |
| `Lhb0/b$e;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lhb0/b$f;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lhb0/b$i;` | `a` | `:J` | 1 |
| `Lhb0/b$i;` | `i` | `:Z` | 1 |
| `Lhd0/a;` | `a` | `:Ln30/o;` | 1 |
| `Lne/f;` | `a` | `:Ld40/a;` | 1 |
| `Lne/f;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lw10/c2;` | `g` | `(Lw10/c2;Lw10/s4;Ll10/d;Lcom/squareup/ui/market/core/text/MarketTextAlignment;Lcom/squareup/ui/market/core/text/MarketTextTransform;Lw10/r4;ILjava/lang/Object;)Lw10/c2;` | 1 |
| `Lra/d;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Ltl/h;` | `e` | `(Lcom/aspiro/wamp/search/v2/a;)V` | 1 |
| `Ltl/j;` | `c` | `()Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;` | 1 |
| `Ltl/r;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lu3/a;` | `j` | `:Lk3/m$a;` | 1 |
| `Lu3/a;` | `e` | `:Lcom/aspiro/wamp/contextmenu/item/playlist/k$a;` | 1 |
| `Lu3/a;` | `d` | `:Lcom/aspiro/wamp/contextmenu/item/playlist/AddToFavorites$a;` | 1 |
| `Lcom/aspiro/wamp/dynamicpages/modules/albumitemcollection/b$a$a;` | `g` | `(ILjava/lang/String;)V` | 1 |
| `Lu5/g;` | `h` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lu5/g;` | `j` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lv9/e;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lv9/e;` | `a` | `:Lcom/aspiro/wamp/core/l;` | 1 |
| `Ltn0/a;` | `c` | `(Ljava/lang/Iterable;)Ltn0/b;` | 1 |
| `Lk70/a;` | `c` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lxf/c;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |

## 3. Rolled patch target classes (65)

`--- a/` headers naming an obfuscated class. If these move the hunk cannot even be located.

| target | hooked by |
|---|---|
| `yj0/e.smali` | `integration-pebble-playback.patch` |
| `vf0/h.smali` | `lyrics-rl-api-isrc.patch` |
| `com/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/playqueue/n.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/suggestions/i.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/suggestions/q0.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/playlist/ui/fragment/PlaylistFragment.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/search/v2/UnifiedSearchView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/tidal/android/core/debug/DebugFeatureInteractorDefault.smali` | `debug-menu-unlock.patch` |
| `com/tidal/android/core/ui/composable/c0.smali` | `player-backdrop-kawarp.patch`, `player-backdrop-playback.patch` |
| `com/tidal/android/dynamicpages/ui/composables/artisttrackcredits/h.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/compactgridcard/CompactGridCardModuleRowKt.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/compactgridcard/d.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/publicplaylistlist/j.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/verticallistcard/VerticalListCardKt.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/verticaltracklist/i.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/artisttrackcredits/ArtistTrackCreditsModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/compactgridcard/CompactGridCardModuleManager$createModuleViewState$2$2.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/publicplaylistlist/PublicPlaylistListModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/tracklist/TrackListModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/verticallistcard/VerticalListCardModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/appscaffold/ui/MiniPlayerViewModel.smali` | `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/MiniPlayerKt.smali` | `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/mini-player/mini-player-up-gesture.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/a.smali` | `mini-player-black.patch`, `mini-player-grey.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/g.smali` | `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/k.smali` | `gestures/mini-player/mini-player-up-gesture.patch`, `mini-player-black.patch`, `mini-player-dynamic-bg.patch`, `mini-player-floating-border.patch`, `mini-player-grey.patch` |
| `com/tidal/android/feature/appscaffold/ui/q.smali` | `cover-capture.patch` |
| `com/tidal/android/feature/appscaffold/ui/t.smali` | `cover-capture.patch` |
| `com/tidal/android/feature/feed/ui/FeedView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/tidal/android/feature/home/ui/composables/f.smali` | `home-backdrop.patch` |
| `com/tidal/android/feature/home/ui/j.smali` | `home-backdrop.patch` |
| `com/tidal/android/feature/home/ui/m.smali` | `home-backdrop.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerScreenKt$PlayerScreenPortrait$2$1.smali` | `lyrics-keep-controls-visible.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerScreenKt.smali` | `lyrics-replace-lyrics-button.patch`, `lyrics-replace-share-button.patch`, `lyrics-sparkle-conditional-visibility.patch`, `player-backdrop-kawarp.patch`, `player-backdrop-playback.patch`, `player-hide-playing-from.patch`, `player-move-playing-from.patch`, `player-one-handed.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerViewModel$observeLyricsProgress$1$a.smali` | `lyrics-rl-api-observer.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerViewModel$special$$inlined$mapNotNull$1$2.smali` | `lyrics-rl-api.patch`, `player-quality-badge-colors.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerViewModel.smali` | `lyrics-keep-controls-visible.patch`, `lyrics-rl-api.patch`, `mini-player-dynamic-bg.patch` |
| `com/tidal/android/feature/playerscreen/ui/i0.smali` | `lyrics-disable-cover.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/LyricsKt.smali` | `gestures/lyrics/lyrics-gesture-scroll-guard.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/SeekbarAndTimeKt.smali` | `player-quality-badge-colors.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/v0.smali` | `player-favorite-heart.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/u1.smali` | `lyrics-rl-api-syllable.patch`, `lyrics-rl-api-word.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/c2.smali` | `player-move-playing-from.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/f1.smali` | `lyrics-fade-region.patch` |
| `com/tidal/android/feature/playerscreen/ui/i$a.smali` | `player-quality-badge-colors.patch` |
| `com/tidal/android/feature/playerscreen/ui/z0.smali` | `lyrics-progress-pill.patch` |
| `com/tidal/android/feature/search/ui/SearchScreenViewModel.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/search/ui/composables/s0.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/viewall/ui/ViewAllScreenViewModel.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/viewall/ui/s.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/wave2/foundation/WaveScaffoldKt.smali` | `collection-backdrop.patch` |
| `vd0/c.smali` | `player-backdrop-playback.patch` |
| `h4/a.smali` | `gestures/queue/swipe-to-queue.patch` |
| `p30/h4.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `p30/t2.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `kb/f.smali` | `integration-waze-playback.patch` |
| `o7/a.smali` | `gestures/queue/swipe-to-queue.patch` |
| `u6/e.smali` | `gestures/queue/swipe-to-queue.patch` |

## 4. Occurrences inside .patch files - not marked inline (221)

| file | line | kind | symbols |
|---|---:|---|---|
| `cover-capture.patch` | 5 | context | `Lcom/tidal/android/feature/appscaffold/ui/q; d` |
| `cover-capture.patch` | 11 | context | `Lcom/tidal/android/feature/appscaffold/ui/q; e` |
| `cover-capture.patch` | 15 | context | `Lcom/tidal/android/feature/appscaffold/ui/q;` |
| `debug-menu-unlock.patch` | 11 | context | `Lcom/tidal/android/featureflags/m; a` |
| `debug-menu-unlock.patch` | 26 | context | `Lu40/a; a` |
| `debug-menu-unlock.patch` | 36 | context | `Lu40/a; a` |
| `gestures/lyrics/lyrics-gesture-scroll-guard.patch` | 12 | context | `Lyl0/l;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 7 | added | `Lyl0/l;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 16 | context | `Lcom/tidal/android/feature/appscaffold/ui/t; Lcom/tidal/android/feature/appscaffold/ui/q; b` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 32 | context | `Ll10/a; p0` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 63 | context | `Lzh/e; i` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 73 | added | `Lcom/tidal/android/feature/appscaffold/ui/r$c; a` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 81 | added | `Lzh/e;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 89 | added | `Lzh/e; h` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 95 | context | `Lx/f0;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 116 | added | `Lkotlin/u;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 122 | context | `Lcom/tidal/android/feature/appscaffold/ui/composable/g; Lyl0/l; a` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 126 | context | `Lcom/tidal/android/feature/appscaffold/ui/b$b; a` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 14 | added | `Lyl0/l;` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 23 | context | `Lcom/tidal/android/feature/appscaffold/ui/t; c` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 25 | added | `Lcom/tidal/android/feature/appscaffold/ui/t; a` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 64 | context | `Ll10/a; p0` |
| `gestures/player/player-swipe-gesture.patch` | 35 | added | `Lyl0/l;` |
| `gestures/player/player-swipe-gesture.patch` | 37 | added | `Lyl0/l;` |
| `gestures/player/player-swipe-gesture.patch` | 41 | context | `Lyl0/l;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 5 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 7 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 18 | added | `Ls30/e$e; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 26 | added | `Lyl0/l; Ls30/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 28 | added | `Ls30/e$e; j` |
| `gestures/queue/swipe-to-queue-compose.patch` | 54 | context | `Lx/f0;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 60 | added | `Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 72 | added | `Lyl0/l; Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 93 | added | `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d; Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c; b` |
| `gestures/queue/swipe-to-queue-compose.patch` | 95 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c; Lyl0/q; f` |
| `gestures/queue/swipe-to-queue-compose.patch` | 97 | added | `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d; c` |
| `gestures/queue/swipe-to-queue-compose.patch` | 99 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 103 | added | `Lyl0/q;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 105 | added | `Lkotlin/u;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 123 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 127 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 129 | added | `Lkotlin/u;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 159 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 161 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 167 | added | `Lyl0/l; Lhb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 173 | added | `Lhb0/b$a; f` |
| `gestures/queue/swipe-to-queue-compose.patch` | 187 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 193 | added | `Lyl0/l; Lhb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 208 | context | `Lgb0/d0; Lhb0/b$f; Lyl0/a; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 211 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 213 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 219 | added | `Lyl0/l; Lhb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 225 | added | `Lhb0/b$i; i` |
| `gestures/queue/swipe-to-queue-compose.patch` | 239 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 245 | added | `Lyl0/l; Lhb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 260 | context | `Lgb0/x; Lhb0/b$e; Lyl0/a; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 265 | context | `Lyl0/l;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 267 | added | `Ls30/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 273 | added | `Ls30/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 275 | added | `Ls30/e$e; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 283 | added | `Lyl0/l; Ls30/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 285 | added | `Ls30/e$e; j` |
| `gestures/queue/swipe-to-queue-compose.patch` | 300 | added | `Lcom/tidal/android/feature/viewall/ui/w;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 304 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 318 | added | `Lcom/tidal/android/feature/viewall/ui/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 324 | added | `Lkotlin/u;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 330 | context | `Lcom/tidal/android/feature/viewall/ui/e$a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 334 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 335 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 341 | added | `Ls30/e$e; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 349 | added | `Lyl0/l; Ls30/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 351 | added | `Ls30/e$e; j` |
| `gestures/queue/swipe-to-queue-compose.patch` | 376 | added | `Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 384 | added | `Lyl0/l; Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 390 | added | `Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 402 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 403 | added | `Lcom/tidal/android/dynamicpages/ui/composables/verticallistcard/m;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 407 | added | `Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 413 | added | `Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 415 | added | `Ls30/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 421 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 429 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 430 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 438 | added | `Lyl0/l; Ls30/e$d;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 444 | added | `Ls30/e$d; g` |
| `gestures/queue/swipe-to-queue-compose.patch` | 480 | context | `Lx/f0;` |
| `gestures/queue/swipe-to-queue.patch` | 13 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; d` |
| `gestures/queue/swipe-to-queue.patch` | 17 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; b` |
| `gestures/queue/swipe-to-queue.patch` | 33 | added | `f` |
| `gestures/queue/swipe-to-queue.patch` | 62 | added | `Y` |
| `gestures/queue/swipe-to-queue.patch` | 69 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; d` |
| `gestures/queue/swipe-to-queue.patch` | 73 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; b` |
| `gestures/queue/swipe-to-queue.patch` | 79 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; m` |
| `gestures/queue/swipe-to-queue.patch` | 81 | added | `Lcom/aspiro/wamp/playqueue/source/model/b; m` |
| `gestures/queue/swipe-to-queue.patch` | 87 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; k` |
| `gestures/queue/swipe-to-queue.patch` | 89 | added | `Ld40/a; b` |
| `gestures/queue/swipe-to-queue.patch` | 91 | added | `Lh4/a;` |
| `gestures/queue/swipe-to-queue.patch` | 95 | added | `Lh4/a;` |
| `gestures/queue/swipe-to-queue.patch` | 126 | added | `Lh4/a; q` |
| `gestures/queue/swipe-to-queue.patch` | 142 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; l` |
| `gestures/queue/swipe-to-queue.patch` | 146 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; f` |
| `gestures/queue/swipe-to-queue.patch` | 148 | added | `w` |
| `gestures/queue/swipe-to-queue.patch` | 156 | context | `Lm8/b;` |
| `gestures/queue/swipe-to-queue.patch` | 159 | context | `Lo4/g; Lo4/g$e; e` |
| `gestures/queue/swipe-to-queue.patch` | 163 | context | `Lo4/g; b` |
| `gestures/queue/swipe-to-queue.patch` | 164 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; l` |
| `gestures/queue/swipe-to-queue.patch` | 168 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; f` |
| `gestures/queue/swipe-to-queue.patch` | 174 | context | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/n; N` |
| `gestures/queue/swipe-to-queue.patch` | 207 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 218 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 230 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 270 | added | `Lh4/a; n` |
| `gestures/queue/swipe-to-queue.patch` | 272 | added | `Lz3/c;` |
| `gestures/queue/swipe-to-queue.patch` | 274 | added | `Lz3/c; Lz3/b; a` |
| `gestures/queue/swipe-to-queue.patch` | 276 | added | `Lz3/b; Ldagger/internal/j; b` |
| `gestures/queue/swipe-to-queue.patch` | 278 | added | `Lml0/a;` |
| `gestures/queue/swipe-to-queue.patch` | 282 | added | `Lm3/f$a;` |
| `gestures/queue/swipe-to-queue.patch` | 284 | added | `Lm3/f$a; Lm3/f; a` |
| `gestures/queue/swipe-to-queue.patch` | 288 | added | `Lm3/f; Lcom/aspiro/wamp/playqueue/x0; j` |
| `gestures/queue/swipe-to-queue.patch` | 290 | added | `Lcom/aspiro/wamp/playqueue/x0; Lcom/aspiro/wamp/player/c; a` |
| `gestures/queue/swipe-to-queue.patch` | 294 | added | `Lcom/aspiro/wamp/player/c; b` |
| `gestures/queue/swipe-to-queue.patch` | 300 | added | `Lm3/f; b` |
| `gestures/queue/swipe-to-queue.patch` | 323 | context | `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/a; Lcom/aspiro/wamp/nowplaying/view/playqueue/n;` |
| `gestures/queue/swipe-to-queue.patch` | 346 | added | `h` |
| `gestures/queue/swipe-to-queue.patch` | 357 | added | `i` |
| `gestures/queue/swipe-to-queue.patch` | 359 | context | `d` |
| `gestures/queue/swipe-to-queue.patch` | 430 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 443 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 456 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 469 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 482 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 500 | context | `Lcom/aspiro/wamp/nowplaying/view/suggestions/q0; Lcom/aspiro/wamp/nowplaying/view/suggestions/m; M` |
| `integration-pebble-playback.patch` | 30 | context | `Lyj0/d; Lyj0/e;` |
| `integration-waze-playback.patch` | 9 | added | `Lkotlin/jvm/internal/n;` |
| `integration-waze-playback.patch` | 17 | added | `Lkotlin/jvm/internal/n;` |
| `integration-waze-playback.patch` | 35 | added | `Lkotlin/jvm/internal/n;` |
| `integration-waze-playback.patch` | 55 | context | `Lkb/f; c` |
| `lyrics-disable-cover.patch` | 11 | added | `Lcom/tidal/android/feature/playerscreen/ui/i0; Lcom/tidal/android/feature/playerscreen/ui/s$a; b` |
| `lyrics-disable-cover.patch` | 13 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/g; j` |
| `lyrics-disable-cover.patch` | 15 | added | `Lcom/tidal/android/feature/playerscreen/ui/g$a;` |
| `lyrics-disable-cover.patch` | 19 | context | `Lcom/tidal/android/feature/playerscreen/ui/d; Lyl0/l; c` |
| `lyrics-fade-region.patch` | 7 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/f1; a` |
| `lyrics-keep-controls-visible.patch` | 28 | added | `Lkotlin/u;` |
| `lyrics-progress-pill.patch` | 14 | context | `Lcom/tidal/android/feature/playerscreen/ui/g; Lyl0/l; a` |
| `lyrics-progress-pill.patch` | 60 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `lyrics-progress-pill.patch` | 72 | added | `Lyl0/l;` |
| `lyrics-replace-lyrics-button.patch` | 8 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/c1; Lyl0/a; a` |
| `lyrics-replace-lyrics-button.patch` | 19 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/h3; Lyl0/a; a` |
| `lyrics-replace-lyrics-button.patch` | 21 | added | `Landroidx/window/embedding/c2;` |
| `lyrics-replace-lyrics-button.patch` | 27 | added | `Landroidx/window/embedding/c2;` |
| `lyrics-replace-lyrics-button.patch` | 35 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `lyrics-replace-lyrics-button.patch` | 38 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `lyrics-replace-share-button.patch` | 7 | removed | `Lcom/tidal/android/feature/playerscreen/ui/b; Lyl0/a; b` |
| `lyrics-replace-share-button.patch` | 20 | removed | `Lcom/tidal/android/feature/profile/ui/sociallinks/y;` |
| `lyrics-replace-share-button.patch` | 21 | added | `Landroidx/window/embedding/d2;` |
| `lyrics-replace-share-button.patch` | 26 | removed | `Lcom/tidal/android/feature/profile/ui/sociallinks/y;` |
| `lyrics-replace-share-button.patch` | 27 | added | `Landroidx/window/embedding/d2;` |
| `lyrics-replace-share-button.patch` | 33 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `lyrics-replace-share-button.patch` | 36 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/b; d` |
| `lyrics-replace-share-button.patch` | 42 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/o4; Lyl0/a; a` |
| `lyrics-replace-share-button.patch` | 43 | added | `Lcom/tidal/android/feature/playerscreen/ui/b; Lyl0/a; b` |
| `lyrics-rl-api-isrc.patch` | 4 | context | `Lcom/tidal/android/tidalapi/domain/model/q;` |
| `lyrics-rl-api-observer.patch` | 10 | context | `a` |
| `lyrics-rl-api-observer.patch` | 34 | context | `Lcom/tidal/android/feature/playerscreen/ui/g$c; c` |
| `lyrics-rl-api-syllable.patch` | 14 | context | `Lcom/tidal/android/feature/playerscreen/ui/f;` |
| `lyrics-rl-api-syllable.patch` | 23 | context | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-syllable.patch` | 25 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/u1; b` |
| `lyrics-rl-api-syllable.patch` | 29 | added | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-syllable.patch` | 33 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/u1; d` |
| `lyrics-rl-api-syllable.patch` | 37 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/u1; e` |
| `lyrics-rl-api-syllable.patch` | 64 | added | `Lyl0/l;` |
| `lyrics-rl-api-syllable.patch` | 76 | removed | `Lyl0/l;` |
| `lyrics-rl-api-syllable.patch` | 77 | added | `Lyl0/l;` |
| `lyrics-rl-api-word.patch` | 14 | context | `Lcom/tidal/android/feature/playerscreen/ui/f;` |
| `lyrics-rl-api-word.patch` | 23 | context | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-word.patch` | 25 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/u1; b` |
| `lyrics-rl-api-word.patch` | 29 | added | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-word.patch` | 33 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/u1; d` |
| `lyrics-rl-api-word.patch` | 37 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/u1; e` |
| `lyrics-rl-api-word.patch` | 52 | removed | `Lyl0/l;` |
| `lyrics-rl-api-word.patch` | 53 | added | `Lyl0/l;` |
| `lyrics-rl-api.patch` | 77 | context | `P` |
| `lyrics-sparkle-conditional-visibility.patch` | 5 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/h3; Lyl0/a; a` |
| `lyrics-sparkle-conditional-visibility.patch` | 7 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; i` |
| `lyrics-sparkle-conditional-visibility.patch` | 15 | context | `Landroidx/window/embedding/c2;` |
| `lyrics-sparkle-conditional-visibility.patch` | 20 | context | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `lyrics-sparkle-conditional-visibility.patch` | 36 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `mini-player-black.patch` | 56 | context | `Lcom/tidal/android/feature/appscaffold/ui/composable/a; c` |
| `mini-player-black.patch` | 71 | context | `Lyl0/p;` |
| `mini-player-dynamic-bg.patch` | 14 | context | `Lcom/tidal/android/feature/appscaffold/ui/composable/a; c` |
| `mini-player-dynamic-bg.patch` | 20 | context | `W` |
| `mini-player-dynamic-bg.patch` | 22 | added | `Lkotlin/i; Q` |
| `mini-player-dynamic-bg.patch` | 24 | added | `Lkotlin/i;` |
| `mini-player-floating-border.patch` | 9 | added | `Lyl0/l;` |
| `mini-player-floating-border.patch` | 14 | context | `Lkotlin/u;` |
| `mini-player-grey.patch` | 58 | context | `Lyl0/p;` |
| `player-backdrop-kawarp.patch` | 8 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/e3; Lyl0/a; b` |
| `player-backdrop-kawarp.patch` | 9 | added | `Lcom/google/android/gms/internal/play_billing/f5;` |
| `player-backdrop-kawarp.patch` | 36 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/e3; Lyl0/a; a` |
| `player-backdrop-playback.patch` | 10 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/e3; Lyl0/a; b` |
| `player-backdrop-playback.patch` | 46 | removed | `Landroidx/compose/foundation/text/input/a;` |
| `player-backdrop-playback.patch` | 73 | context | `Lvd0/c; a` |
| `player-backdrop-playback.patch` | 95 | context | `Lcom/squareup/ui/market/layout/e; c` |
| `player-favorite-heart.patch` | 16 | removed | `Lg20/b; Lg20/a; O` |
| `player-favorite-heart.patch` | 20 | removed | `Lg20/a; a` |
| `player-hide-playing-from.patch` | 5 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `player-move-playing-from.patch` | 8 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `player-move-playing-from.patch` | 12 | added | `Lcom/tidal/android/feature/playerscreen/ui/p; a` |
| `player-move-playing-from.patch` | 22 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/d; c` |
| `player-move-playing-from.patch` | 29 | context | `Lw10/c2;` |
| `player-move-playing-from.patch` | 61 | added | `Lcom/squareup/ui/market/text/a; Lyl0/l; Lw10/c2; e` |
| `player-quality-badge-colors.patch` | 5 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/g4; g` |
| `player-quality-badge-colors.patch` | 16 | context | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
| `player-quality-badge-colors.patch` | 18 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a; b` |
| `player-quality-badge-colors.patch` | 22 | context | `Lcom/tidal/android/feature/playerscreen/ui/i$a; a` |
| `player-quality-badge-colors.patch` | 33 | added | `Lw10/c2;` |
| `player-quality-badge-colors.patch` | 55 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
| `player-quality-badge-colors.patch` | 66 | context | `Lcom/tidal/android/feature/playerscreen/ui/i$a; a` |
| `player-quality-badge-colors.patch` | 68 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a; b` |
| `player-quality-badge-colors.patch` | 111 | removed | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
| `player-quality-badge-colors.patch` | 114 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
