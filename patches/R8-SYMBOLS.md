# R8 Symbol Map - TIDAL 2.200.0-10004

Maintained by hand. Snapshot of the tree as of TIDAL 2.200.0-10004 - counts and line
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

## 1. Rolled class references (268)

| symbol | uses | referenced from |
|---|---:|---|
| `Lam0/l;` | 246 | `extension/radiant/Kawarp.smali`, `extension/radiant/MiniPlayerBackground.smali`, `extension/radiant/MiniSeekerFloating.smali` +31 more |
| `Lh4/a;` | 152 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/FeedResolver.smali` +6 more |
| `Lkotlin/u;` | 109 | `extension/radiant/Kawarp.smali`, `extension/radiant/MiniSeekerFloating.smali`, `extension/radiant/NoOp.smali` +22 more |
| `Lam0/a;` | 74 | `extension/radiant/HomeBackdrop.smali`, `extension/radiant/Kawarp.smali`, `extension/radiant/NoOp.smali` +10 more |
| `Lcf/b;` | 60 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali`, `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Lm40/e$e;` | 49 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueueAction.smali`, `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackQueueAction.smali` +3 more |
| `Lh40/p;` | 46 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` +2 more |
| `Lo6/b;` | 46 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lzc/a;` | 44 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali`, `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `La50/b;` | 42 | `extension/radiant/gestures/queue/FeedResolver.smali`, `extension/radiant/gestures/queue/PlaylistItemsResolver.smali`, `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/tidal/android/dynamicpages/ui/c;` | 42 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lu5/b$a;` | 40 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `La50/d;` | 38 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali`, `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali`, `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` +3 more |
| `Le5/z$n2;` | 36 | `extension/radiant/MiniSeekerLine.smali`, `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lo6/b$a;` | 36 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lm40/e$d;` | 32 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/PublicPlaylistQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` +1 more |
| `Lc60/r$b;` | 30 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lu5/b$a$b;` | 30 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lbm/k;` | 28 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcoil/request/b;` | 28 | `extension/radiant/Kawarp.smali` |
| `Lbm/a;` | 26 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lm40/e$a;` | 26 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` |
| `Lm40/e$c;` | 26 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` |
| `Lve/a;` | 26 | `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali` |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | 25 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali` +8 more |
| `Lbm/f;` | 24 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lbm/g;` | 24 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lh40/j;` | 24 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lb80/a;` | 22 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lb80/c;` | 20 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lo6/i;` | 20 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lf20/a;` | 19 | `extension/radiant/QualityBadge.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/mini-player/mini-player-up-gesture.patch` |
| `Lb80/d;` | 18 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lc60/r;` | 18 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lh40/a;` | 18 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lh40/i;` | 18 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lm40/e;` | 18 | `extension/radiant/gestures/queue/CompactGridMediaQueueAction.smali`, `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lx40/a;` | 17 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/FeedResolver.smali` +5 more |
| `Lc60/b0;` | 16 | `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lc60/d;` | 16 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali` |
| `Lcom/tidal/android/core/adapterdelegate/c;` | 16 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/r$c;` | 16 | `extension/com/tidal/android/feature/appscaffold/ui/r$c.smali`, `extension/radiant/gestures/miniplayer/MiniPlayerTrackGestures$Gesture.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Le5/c;` | 16 | `extension/radiant/MiniSeekerLine.smali`, `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lgh/j;` | 16 | `extension/radiant/MiniSeekerLine.smali` |
| `Lc60/c0;` | 14 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lc60/f;` | 14 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lcoil/f;` | 14 | `extension/radiant/Kawarp.smali` |
| `Lh40/n;` | 14 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` +2 more |
| `Lpb0/b;` | 14 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lu5/b$a$a;` | 14 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali`, `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;` | 13 | `extension/radiant/gestures/queue/SuggestionsResolver.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lc60/v;` | 12 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/h;` | 12 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/search/v2/d;` | 12 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcom/tidal/android/navigation/a;` | 12 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` +2 more |
| `Lh9/p1;` | 12 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lie0/i;` | 12 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` +2 more |
| `Lo3/a$a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lo3/a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lu3/a$a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lu3/a;` | 12 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/l;` | 11 | `extension/radiant/gestures/queue/SuggestionsResolver.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lq20/c2;` | 11 | `extension/radiant/QualityBadge.smali`, `player-move-playing-from.patch`, `player-quality-badge-colors.patch` |
| `Lql0/a;` | 11 | `extension/radiant/MiniSeekerLine.smali`, `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lc60/h;` | 10 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lcoil/request/h$a;` | 10 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;` | 10 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/player/d;` | 10 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | 10 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lcom/aspiro/wamp/playqueue/g1;` | 10 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/dynamicpages/ui/b;` | 10 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/f;` | 10 | `extension/radiant/RLAPILyricsWorker.smali`, `lyrics-rl-api-syllable.patch`, `lyrics-rl-api-word.patch` |
| `Li60/c;` | 10 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `extension/radiant/gestures/queue/DynamicTrackQueue.smali` |
| `Ltl/h;` | 10 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcoil/request/h;` | 9 | `extension/radiant/Kawarp.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | 9 | `lyrics-disable-cover.patch`, `lyrics-replace-lyrics-button.patch`, `lyrics-replace-share-button.patch` +3 more |
| `Lpb0/b$a;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lpb0/b$e;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lpb0/b$f;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lpb0/b$i;` | 9 | `extension/radiant/gestures/queue/ComposeSearchQueueAction.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `La80/c;` | 8 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/b$b;` | 8 | `extension/radiant/gestures/miniplayer/MiniPlayerGestures$Gesture.smali`, `extension/radiant/gestures/miniplayer/MiniPlayerGestures.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a;` | 8 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b;` | 8 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/i$a;` | 8 | `player-quality-badge-colors.patch` |
| `Ldagger/internal/f;` | 8 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lfd/c;` | 8 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali` |
| `Li40/c$b;` | 8 | `extension/radiant/gestures/queue/ViewAllTrackQueueAction.smali` |
| `Lie0/h;` | 8 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lld/c;` | 8 | `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lpe/f;` | 8 | `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali` |
| `Ltl/q;` | 8 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lu5/g;` | 8 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali` |
| `Lv9/e;` | 8 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lbi/e;` | 7 | `extension/radiant/RLAPILyricsWorker.smali`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/p3;` | 7 | `extension/radiant/HomeBackdrop.smali`, `extension/radiant/Kawarp.smali`, `player-backdrop-kawarp.patch` +1 more |
| `Lm3/f;` | 7 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lam0/p;` | 6 | `extension/radiant/SparkleButton.smali`, `extension/radiant/SparkleContent.smali`, `mini-player-black.patch` +1 more |
| `Lc3/h;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lc60/s;` | 6 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lce0/b$a;` | 6 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/f;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | 6 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` | 6 | `extension/radiant/gestures/queue/DynamicMediaQueue.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/b$a;` | 6 | `extension/radiant/gestures/miniplayer/MiniPlayerGestures.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/r;` | 6 | `extension/com/tidal/android/feature/appscaffold/ui/r$c.smali` |
| `Lcom/tidal/android/feature/feed/ui/c;` | 6 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/f2;` | 6 | `lyrics-rl-api-syllable.patch`, `lyrics-rl-api-word.patch` |
| `Lcom/tidal/android/feature/viewall/ui/e$c;` | 6 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lf20/d;` | 6 | `extension/radiant/QualityBadge.smali` |
| `Lgh/b;` | 6 | `extension/radiant/SeekerConsumer.smali` |
| `Lhf/c;` | 6 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` |
| `Lie0/a;` | 6 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lie0/g;` | 6 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lm3/d;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lm3/f$a;` | 6 | `extension/radiant/gestures/queue/QueueExecutor.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lmb0/a;` | 6 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Ln8/d;` | 6 | `extension/radiant/gestures/queue/FavoriteTracksResolver.smali` |
| `Lpd0/a;` | 6 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lq20/u1;` | 6 | `extension/radiant/SparkleButton.smali` |
| `Lra/d;` | 6 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lxd0/g;` | 6 | `extension/radiant/Kawarp.smali` |
| `Lcom/tidal/android/feature/playerscreen/ui/g$c;` | 5 | `extension/radiant/RLAPILyricsWorker.smali`, `lyrics-rl-api-observer.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/p;` | 5 | `lyrics-replace-lyrics-button.patch`, `lyrics-sparkle-conditional-visibility.patch`, `player-hide-playing-from.patch` +1 more |
| `Lb0/c;` | 4 | `extension/radiant/Kawarp.smali` |
| `Lbm/h;` | 4 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lc3/i$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lc3/i;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lc3/l$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lc3/l;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lce0/b;` | 4 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/u$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/u;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/core/k;` | 4 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali`, `extension/radiant/gestures/queue/DynamicMediaQueue.smali` |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m;` | 4 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/i$a;` | 4 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/i$e;` | 4 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/playback/e0;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/playback/f;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/playback/k0;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lcom/aspiro/wamp/playqueue/d1;` | 4 | `extension/radiant/MiniSeekerLine.smali` |
| `Lcom/aspiro/wamp/playqueue/u0;` | 4 | `extension/radiant/RLAPILyricsWorker.smali` |
| `Lcom/aspiro/wamp/search/v2/a$g;` | 4 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcom/squareup/ui/market/core/theme/k$a;` | 4 | `extension/radiant/SparkleButton.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b$a;` | 4 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueueAction.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/tracklist/b$a;` | 4 | `extension/radiant/gestures/queue/DynamicTrackQueueAction.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b$a;` | 4 | `extension/radiant/gestures/queue/VerticalMediaQueueAction.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/q;` | 4 | `cover-capture.patch`, `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/search/ui/f;` | 4 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lcom/tidal/android/feature/viewall/ui/c;` | 4 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lcom/tidal/android/image/core/b$a;` | 4 | `extension/radiant/Kawarp.smali` |
| `Ld0/c$a;` | 4 | `extension/radiant/Kawarp.smali` |
| `Lj3/k$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lj3/k;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lj3/n$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lj3/n;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lj3/q$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lj3/q;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lm3/i$a;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lm3/i;` | 4 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lmb0/e;` | 4 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lvn0/b;` | 4 | `extension/radiant/RLAPILyricsWorker.smali` |
| `Lz70/a;` | 4 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lzf/c;` | 4 | `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Landroidx/navigation/f0;` | 3 | `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Landroidx/window/embedding/a2;` | 3 | `lyrics-replace-lyrics-button.patch`, `lyrics-sparkle-conditional-visibility.patch` |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | 3 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/r$a;` | 3 | `extension/radiant/gestures/miniplayer/MiniPlayerTrackGestures$Gesture.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | 3 | `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/mini-player/mini-player-up-gesture.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/b;` | 3 | `lyrics-replace-share-button.patch` |
| `Lcom/tidal/android/feature/viewall/ui/e;` | 3 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali`, `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/image/core/b$h$a;` | 3 | `extension/radiant/Kawarp.smali` |
| `Ldagger/internal/j;` | 3 | `extension/radiant/MiniSeekerLine.smali`, `gestures/queue/swipe-to-queue.patch` |
| `Lkotlin/jvm/internal/n;` | 3 | `integration-waze-playback.patch` |
| `La30/a;` | 2 | `player-favorite-heart.patch` |
| `Lad/f;` | 2 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali` |
| `Lam0/q;` | 2 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Landroidx/window/embedding/b2;` | 2 | `lyrics-replace-share-button.patch` |
| `Lbd/d$a;` | 2 | `extension/radiant/gestures/queue/MyAlbumsResolver.smali` |
| `Lbm/i;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcoil/request/d;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lcom/aspiro/wamp/contextmenu/menu/track/c;` | 2 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/contextmenu/menu/track/d;` | 2 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/h;` | 2 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/i;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/j;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/y$a;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lcom/aspiro/wamp/search/v2/a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lcom/aspiro/wamp/util/h0;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lcom/squareup/ui/market/components/n;` | 2 | `extension/radiant/SparkleButton.smali` |
| `Lcom/squareup/ui/market/core/theme/k;` | 2 | `extension/radiant/SparkleButton.smali` |
| `Lcom/squareup/ui/market/core/theme/z;` | 2 | `extension/radiant/SparkleButton.smali` |
| `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d;` | 2 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/b;` | 2 | `extension/radiant/gestures/queue/ArtistTrackCreditsQueueEvent.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/b;` | 2 | `extension/radiant/gestures/queue/DynamicMediaQueueEvent.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/tracklist/b;` | 2 | `extension/radiant/gestures/queue/DynamicTrackQueueEvent.smali` |
| `Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/b;` | 2 | `extension/radiant/gestures/queue/DynamicMediaQueueEvent.smali` |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/a;` | 2 | `mini-player-black.patch`, `mini-player-dynamic-bg.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/s3;` | 2 | `lyrics-replace-lyrics-button.patch`, `lyrics-sparkle-conditional-visibility.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/d;` | 2 | `lyrics-disable-cover.patch`, `player-move-playing-from.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/e0;` | 2 | `lyrics-replace-share-button.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/g;` | 2 | `lyrics-disable-cover.patch`, `lyrics-progress-pill.patch` |
| `Lcom/tidal/android/feature/search/ui/b;` | 2 | `extension/radiant/gestures/queue/ComposeSearchQueueEvent.smali` |
| `Lcom/tidal/android/feature/search/ui/e;` | 2 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lcom/tidal/android/feature/viewall/ui/u;` | 2 | `extension/radiant/gestures/queue/ViewAllTrackQueue.smali` |
| `Lcom/tidal/android/image/coil/c;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lcom/tidal/android/image/core/b;` | 2 | `extension/radiant/Kawarp.smali` |
| `Ldf/d$a;` | 2 | `extension/radiant/gestures/queue/MyPlaylistsResolver.smali` |
| `Lhu/akarnokd/rxjava/interop/f;` | 2 | `extension/radiant/gestures/queue/QueueExecutor.smali` |
| `Lid/e;` | 2 | `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lij/a0$a;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lij/j0$a;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Lij/q$a;` | 2 | `extension/radiant/gestures/queue/PlaylistItemsResolver.smali` |
| `Ljd/d$a;` | 2 | `extension/radiant/gestures/queue/SearchAlbumsResolver.smali` |
| `Lk5/f;` | 2 | `extension/radiant/gestures/queue/AlbumItemQueueAction.smali` |
| `Lkotlin/collections/u;` | 2 | `extension/radiant/gestures/queue/SuggestionsResolver.smali` |
| `Lkotlin/coroutines/e;` | 2 | `extension/radiant/gestures/lyrics/LyricsDrag$Guard.smali` |
| `Lkotlin/coroutines/h;` | 2 | `extension/radiant/MiniPlayerBackground.smali` |
| `Lkotlin/i;` | 2 | `mini-player-dynamic-bg.patch` |
| `Lmb0/f;` | 2 | `extension/radiant/gestures/queue/ComposeSearchQueue.smali` |
| `Lo4/g;` | 2 | `gestures/queue/swipe-to-queue.patch` |
| `Lo50/a;` | 2 | `debug-menu-unlock.patch` |
| `Lp7/a$a;` | 2 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lq20/r4;` | 2 | `extension/radiant/QualityBadge.smali` |
| `Lq20/s4;` | 2 | `extension/radiant/QualityBadge.smali` |
| `Lqe/c$a;` | 2 | `extension/radiant/gestures/queue/MyMixesAndRadioResolver.smali` |
| `Ltl/f;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/a0$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/d$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/n0$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lul/w$a;` | 2 | `extension/radiant/gestures/queue/UnifiedSearchResolver.smali` |
| `Lv6/e$a;` | 2 | `extension/radiant/gestures/queue/DynamicTrackResolver.smali` |
| `Lv70/b;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lvn0/a;` | 2 | `extension/radiant/RLAPILyricsWorker.smali` |
| `Lw70/c$a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lw70/h$a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lw70/k$a;` | 2 | `extension/radiant/gestures/queue/FeedResolver.smali` |
| `Lwf/d;` | 2 | `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `Lxd0/e;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lxd0/f;` | 2 | `extension/radiant/Kawarp.smali` |
| `Lxf/d$a;` | 2 | `extension/radiant/gestures/queue/SearchPlaylistsResolver.smali` |
| `La30/b;` | 1 | `player-favorite-heart.patch` |
| `Landroidx/compose/foundation/text/input/a;` | 1 | `player-backdrop-playback.patch` |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/n;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/l;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/a;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lcom/squareup/ui/market/layout/e;` | 1 | `player-backdrop-playback.patch` |
| `Lcom/squareup/ui/market/text/a;` | 1 | `player-move-playing-from.patch` |
| `Lcom/tidal/android/dynamicpages/ui/composables/verticallistcard/m;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/g;` | 1 | `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/b0;` | 1 | `lyrics-disable-cover.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/e5;` | 1 | `lyrics-replace-share-button.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/k1;` | 1 | `lyrics-replace-lyrics-button.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/o1;` | 1 | `lyrics-fade-region.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/t4;` | 1 | `player-quality-badge-colors.patch` |
| `Lcom/tidal/android/feature/playerscreen/ui/g$a;` | 1 | `lyrics-disable-cover.patch` |
| `Lcom/tidal/android/feature/viewall/ui/e$a;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/feature/viewall/ui/n;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lcom/tidal/android/featureflags/n;` | 1 | `debug-menu-unlock.patch` |
| `Lcom/tidal/android/tidalapi/domain/model/o;` | 1 | `lyrics-rl-api-isrc.patch` |
| `Lde0/c;` | 1 | `player-backdrop-playback.patch` |
| `Lmb/f;` | 1 | `integration-waze-playback.patch` |
| `Ln8/b;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lo4/g$e;` | 1 | `gestures/queue/swipe-to-queue.patch` |
| `Lob0/q;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |
| `Lob0/w;` | 1 | `gestures/queue/swipe-to-queue-compose.patch` |

## 2. Rolled members on otherwise-stable classes (347)

The owner name survives R8; only the member name rolls. Match on the descriptor.

| owner | member | descriptor | uses |
|---|---|---|---:|
| `Lcom/aspiro/wamp/App$a;` | `a` | `()Lcom/aspiro/wamp/App;` | 8 |
| `Lcom/aspiro/wamp/App;` | `e` | `()Le5/c;` | 8 |
| `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b;` | `a` | `(Landroidx/lifecycle/LifecycleOwner;Landroidx/recyclerview/widget/RecyclerView;)Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a;` | 8 |
| `Lm40/e$e;` | `a` | `:J` | 8 |
| `La50/b;` | `b` | `:Ljava/util/ArrayList;` | 7 |
| `Lcf/b;` | `a` | `:Lcom/aspiro/wamp/model/Playlist;` | 6 |
| `Lcom/tidal/android/navigation/a;` | `b` | `(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/tidal/android/navigation/NavigationInfo$Node;` | 6 |
| `Lie0/i;` | `a` | `(Lh40/p;)Lcom/aspiro/wamp/model/Track;` | 6 |
| `Lo6/b;` | `c` | `:Lo6/b$a;` | 6 |
| `Lzc/a;` | `b` | `:Lcom/aspiro/wamp/model/Album;` | 6 |
| `Lc60/r$b;` | `a` | `:Lh40/n;` | 5 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `j` | `(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;` | 5 |
| `Lcom/tidal/android/dynamicpages/ui/c;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 5 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `P` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 5 |
| `Li60/c;` | `c` | `(Ljava/lang/String;)Lc60/h;` | 5 |
| `Lm40/e$e;` | `j` | `:Z` | 5 |
| `Lo6/b$a;` | `q` | `:Ljava/lang/String;` | 5 |
| `Lo6/b;` | `a` | `:Lo6/i;` | 5 |
| `Lbm/a;` | `a` | `:Lcom/aspiro/wamp/model/Album;` | 4 |
| `Lbm/f;` | `a` | `:Lcom/aspiro/wamp/mix/model/Mix;` | 4 |
| `Lbm/g;` | `a` | `:Lcom/aspiro/wamp/model/Playlist;` | 4 |
| `Lbm/k;` | `a` | `:Lcom/aspiro/wamp/model/Track;` | 4 |
| `Lcf/b;` | `h` | `:Z` | 4 |
| `Lcf/b;` | `f` | `:Z` | 4 |
| `Lcf/b;` | `g` | `:Ljava/lang/String;` | 4 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `o` | `(Ljava/lang/String;Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;` | 4 |
| `Lcom/aspiro/wamp/search/v2/UnifiedSearchView;` | `N` | `()Ltl/h;` | 4 |
| `Lcom/tidal/android/feature/playerscreen/ui/f;` | `a` | `:Ljava/lang/String;` | 4 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `m` | `:Lcom/tidal/android/feature/playerscreen/ui/p;` | 4 |
| `Lh40/p;` | `a` | `:J` | 4 |
| `Lie0/h;` | `a` | `(Lh40/j;)Lcom/aspiro/wamp/model/Playlist;` | 4 |
| `Lo6/b$a;` | `o` | `:I` | 4 |
| `Lu5/b$a$b;` | `r` | `:I` | 4 |
| `Lu5/b$a;` | `c` | `:Lu5/b$a$b;` | 4 |
| `Lzc/a;` | `k` | `:Z` | 4 |
| `Lb80/a;` | `a` | `:Lcom/aspiro/wamp/model/Album;` | 3 |
| `Lb80/c;` | `a` | `:Lcom/aspiro/wamp/mix/model/Mix;` | 3 |
| `Lb80/d;` | `a` | `:Lcom/aspiro/wamp/model/Playlist;` | 3 |
| `Lc60/s;` | `a` | `(Lc60/r;)Ljava/lang/String;` | 3 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `i` | `:Z` | 3 |
| `Lcom/aspiro/wamp/player/d;` | `b` | `()Lcom/aspiro/wamp/model/MediaItemParent;` | 3 |
| `Lcom/aspiro/wamp/playqueue/g1;` | `a` | `()Lcom/aspiro/wamp/player/d;` | 3 |
| `Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType$a;` | `a` | `(Ljava/lang/String;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource$NavigationType;` | 3 |
| `Lcom/tidal/android/feature/appscaffold/ui/b$b;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/b$b;` | 3 |
| `Lcom/tidal/android/feature/appscaffold/ui/r$c;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/r$c;` | 3 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/p3;` | `a` | `(ILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V` | 3 |
| `Lh4/a;` | `b` | `:Lo3/a$a;` | 3 |
| `Lh4/a;` | `h` | `:Lu3/a$a;` | 3 |
| `Lie0/a;` | `a` | `(Lh40/a;)Lcom/aspiro/wamp/model/Album;` | 3 |
| `Lie0/g;` | `b` | `(Lh40/i;)Lcom/aspiro/wamp/mix/model/Mix;` | 3 |
| `Lm40/e$d;` | `a` | `:Ljava/lang/String;` | 3 |
| `Lm40/e$d;` | `g` | `:Z` | 3 |
| `Lo3/a$a;` | `a` | `(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lo3/a;` | 3 |
| `Lo6/b$a;` | `d` | `:I` | 3 |
| `Lu3/a$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lu3/a;` | 3 |
| `Lu5/b$a$b;` | `s` | `:Ljava/lang/String;` | 3 |
| `Lu5/b$a;` | `a` | `:Lu5/b$a$a;` | 3 |
| `Lve/a;` | `c` | `:Lcom/aspiro/wamp/mix/model/Mix;` | 3 |
| `Lcoil/request/h$a;` | `b` | `:Lcoil/request/b;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `Y` | `(ILcom/aspiro/wamp/model/FavoriteTrack;)Z` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `d` | `:Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `l` | `:Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | `b` | `(I)Lcom/aspiro/wamp/model/FavoriteTrack;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m;` | `f` | `:Landroidx/recyclerview/widget/RecyclerView;` | 2 |
| `Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;` | `c` | `:Lpe/f;` | 2 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `h` | `:Landroid/graphics/drawable/Drawable;` | 2 |
| `Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;` | `h` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 2 |
| `Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;` | `c` | `:Lcom/aspiro/wamp/playlist/ui/items/a;` | 2 |
| `Lcom/aspiro/wamp/search/v2/UnifiedSearchView;` | `g` | `:Lio/reactivex/disposables/CompositeDisposable;` | 2 |
| `Lcom/aspiro/wamp/search/v2/d;` | `e` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 2 |
| `Lcom/squareup/ui/market/core/theme/MarketStylesheet$c;` | `p0` | `()Lf20/a;` | 2 |
| `Lcom/tidal/android/feature/appscaffold/ui/b$a;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/b$a;` | 2 |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/a;` | `c` | `:Landroidx/compose/foundation/shape/RoundedCornerShape;` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/BroadcastButtonKt;` | `b` | `(Lcom/tidal/android/feature/playerscreen/ui/b;Lam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/f2;` | `b` | `:I` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/f2;` | `d` | `:J` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/f2;` | `e` | `:J` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/p3;` | `b` | `(Lcom/tidal/android/feature/playerscreen/ui/model/PlayerBackgroundStyle;JILjava/lang/String;ZZLam0/a;Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/s3;` | `a` | `(ILam0/a;Landroidx/compose/runtime/Composer;Landroidx/compose/ui/Modifier;)V` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/i$a;` | `b` | `:I` | 2 |
| `Lcom/tidal/android/feature/playerscreen/ui/i$a;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lcom/tidal/android/feature/search/ui/SearchQuery;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `m` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 2 |
| `Le5/z$n2;` | `r2` | `()Lcom/aspiro/wamp/playqueue/g1;` | 2 |
| `Lh9/p1;` | `b` | `:Lx40/a;` | 2 |
| `Lm3/f$a;` | `a` | `(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/f;` | 2 |
| `Lm3/f;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 2 |
| `Lm40/e$a;` | `a` | `:J` | 2 |
| `Lm40/e$a;` | `e` | `:Z` | 2 |
| `Lm40/e$c;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lm40/e$c;` | `h` | `:Z` | 2 |
| `Lo50/a;` | `a` | `:Ljava/lang/String;` | 2 |
| `Lo6/b;` | `b` | `:J` | 2 |
| `Lo6/i;` | `p` | `:Ljava/util/LinkedHashMap;` | 2 |
| `Ltl/q;` | `a` | `:Lx40/a;` | 2 |
| `Lu5/b$a$b;` | `g` | `:Lcom/aspiro/wamp/model/Availability;` | 2 |
| `Lu5/b$a$b;` | `p` | `:Z` | 2 |
| `Lu5/b$a;` | `b` | `:J` | 2 |
| `Lve/a;` | `f` | `:Z` | 2 |
| `Lve/a;` | `a` | `:Ljava/lang/String;` | 2 |
| `La30/a;` | `a` | `:I` | 1 |
| `La30/b;` | `O` | `:La30/a;` | 1 |
| `La80/c;` | `a` | `:Ljava/lang/String;` | 1 |
| `La80/c;` | `e` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `La80/c;` | `b` | `:Lx40/a;` | 1 |
| `Lb80/a;` | `c` | `:Z` | 1 |
| `Lb80/a;` | `g` | `:I` | 1 |
| `Lb80/c;` | `c` | `:I` | 1 |
| `Lb80/d;` | `c` | `:I` | 1 |
| `Lbi/e;` | `i` | `()Z` | 1 |
| `Lbi/e;` | `h` | `(Z)V` | 1 |
| `Lbm/a;` | `c` | `:Lcom/aspiro/wamp/model/Availability$Album;` | 1 |
| `Lbm/i;` | `a` | `(Lbm/h;)Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lbm/k;` | `e` | `:Lcom/aspiro/wamp/model/Availability$MediaItem;` | 1 |
| `Lbm/k;` | `n` | `:Lcom/aspiro/wamp/search/SearchDataSource;` | 1 |
| `Lc3/h;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lc3/i$a;` | `a` | `(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lc3/i;` | 1 |
| `Lc3/i;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lc3/l$a;` | `a` | `(Lcom/aspiro/wamp/model/Album;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lc3/l;` | 1 |
| `Lc3/l;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lc60/b0;` | `b` | `:Ljava/lang/String;` | 1 |
| `Lc60/b0;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Lc60/b0;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lc60/b0;` | `e` | `:I` | 1 |
| `Lc60/b0;` | `c` | `:Ljava/lang/String;` | 1 |
| `Lc60/b0;` | `g` | `:Ljava/lang/String;` | 1 |
| `Lc60/c0;` | `b` | `:Ljava/lang/String;` | 1 |
| `Lc60/c0;` | `g` | `:Ljava/util/ArrayList;` | 1 |
| `Lc60/c0;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lc60/c0;` | `f` | `:I` | 1 |
| `Lc60/c0;` | `c` | `:Ljava/lang/String;` | 1 |
| `Lc60/d;` | `b` | `:Ljava/lang/String;` | 1 |
| `Lc60/d;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Lc60/d;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lc60/d;` | `e` | `:I` | 1 |
| `Lc60/d;` | `c` | `:Ljava/lang/String;` | 1 |
| `Lc60/d;` | `g` | `:Ljava/lang/String;` | 1 |
| `Lc60/f;` | `b` | `:Ljava/lang/String;` | 1 |
| `Lc60/f;` | `g` | `:Ljava/util/ArrayList;` | 1 |
| `Lc60/f;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lc60/f;` | `d` | `:I` | 1 |
| `Lc60/f;` | `e` | `:Ljava/lang/String;` | 1 |
| `Lc60/v;` | `b` | `:Ljava/lang/String;` | 1 |
| `Lc60/v;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Lc60/v;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lc60/v;` | `e` | `:I` | 1 |
| `Lce0/b$a;` | `a` | `()Lce0/b;` | 1 |
| `Lce0/b;` | `a` | `()Lxd0/e;` | 1 |
| `Lcoil/f;` | `b` | `(Lcoil/request/h;)Lcoil/request/d;` | 1 |
| `Lcoil/request/b;` | `a` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `b` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `c` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `d` | `:Lkotlinx/coroutines/CoroutineDispatcher;` | 1 |
| `Lcoil/request/b;` | `e` | `:Ld0/c$a;` | 1 |
| `Lcoil/request/b;` | `f` | `:Lcoil/size/Precision;` | 1 |
| `Lcoil/request/b;` | `g` | `:Landroid/graphics/Bitmap$Config;` | 1 |
| `Lcoil/request/b;` | `h` | `:Z` | 1 |
| `Lcoil/request/b;` | `i` | `:Lcoil/request/CachePolicy;` | 1 |
| `Lcoil/request/b;` | `j` | `:Lcoil/request/CachePolicy;` | 1 |
| `Lcoil/request/h$a;` | `d` | `:Lb0/c;` | 1 |
| `Lcoil/request/h$a;` | `a` | `()Lcoil/request/h;` | 1 |
| `Lcoil/request/h;` | `a` | `(Lcoil/request/h;)Lcoil/request/h$a;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/f;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h$a;` | `a` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/h;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/h;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/u$a;` | `a` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/contextmenu/item/playlist/u;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/item/playlist/u;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lcom/aspiro/wamp/contextmenu/menu/track/c;` | `b` | `:Ldagger/internal/j;` | 1 |
| `Lcom/aspiro/wamp/contextmenu/menu/track/d;` | `a` | `:Lcom/aspiro/wamp/contextmenu/menu/track/c;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `h` | `:Lad/f;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `N` | `()La50/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `c` | `:Lfd/c;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView;` | `j` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `f` | `:Lid/e;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `N` | `()La50/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `c` | `:Lld/c;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView;` | `g` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `Z` | `(ILcom/aspiro/wamp/model/FavoriteTrack;I)V` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `f` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `b` | `:Lx40/a;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `w` | `(Landroidx/recyclerview/widget/RecyclerView;ILandroid/view/View;)V` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment;` | `N` | `()Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/n;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | `m` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0;` | `k` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;` | `N` | `()La50/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView;` | `h` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;` | `j` | `:Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/h;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;` | `N` | `()La50/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView;` | `d` | `:Lhf/c;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView;` | `g` | `:Lwf/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView;` | `N` | `()La50/d;` | 1 |
| `Lcom/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView;` | `c` | `:Lzf/c;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `c` | `:Landroid/graphics/drawable/ColorDrawable;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl;` | `d` | `:Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl$ActionType;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;` | `o` | `:Ljava/lang/Object;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/a1;` | `j` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/h;` | `d` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/h;` | `c` | `:Lcom/aspiro/wamp/nowplaying/view/suggestions/l;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/j;` | `a` | `(Lcom/aspiro/wamp/nowplaying/view/suggestions/i;)V` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;` | `d` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;` | `c` | `:Lcom/aspiro/wamp/nowplaying/view/suggestions/l;` | 1 |
| `Lcom/aspiro/wamp/nowplaying/view/suggestions/o0;` | `M` | `()Lcom/aspiro/wamp/nowplaying/view/suggestions/l;` | 1 |
| `Lcom/aspiro/wamp/playback/e0;` | `a` | `(Ljava/lang/String;Lcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lio/reactivex/disposables/Disposable;` | 1 |
| `Lcom/aspiro/wamp/playback/f;` | `a` | `(ILcom/tidal/android/navigation/NavigationInfo;ZLjava/lang/String;)Lhu/akarnokd/rxjava/interop/f;` | 1 |
| `Lcom/aspiro/wamp/playback/k0;` | `c` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)V` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/PlaylistItemCollectionView;` | `d` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | `k` | `()Lcom/aspiro/wamp/playlist/viewmodel/PlaylistCollectionViewModel;` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | `c` | `(Lcom/aspiro/wamp/model/Track;)V` | 1 |
| `Lcom/aspiro/wamp/playlist/ui/items/a;` | `i` | `(I)V` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `c` | `(Lcom/aspiro/wamp/model/Album;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/AlbumSource;` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `f` | `(Lcom/aspiro/wamp/model/Playlist;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/PlaylistSource;` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `p` | `(Ljava/lang/String;Ljava/util/List;Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/ItemSource;` | 1 |
| `Lcom/aspiro/wamp/playqueue/source/model/b;` | `m` | `(Lcom/tidal/android/navigation/NavigationInfo;)Lcom/aspiro/wamp/playqueue/source/model/MyItemsSource;` | 1 |
| `Lcom/aspiro/wamp/search/v2/UnifiedSearchView;` | `c` | `:Ltl/q;` | 1 |
| `Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lcom/aspiro/wamp/util/h0;` | `c` | `(I)Ljava/lang/String;` | 1 |
| `Lcom/squareup/ui/market/components/MarketIconButtonKt;` | `P` | `(Lcom/squareup/ui/market/core/theme/MarketStylesheet;Lcom/squareup/ui/market/core/components/properties/IconButton$Size;Lcom/squareup/ui/market/core/components/properties/IconButton$Rank;Lcom/squareup/ui/market/core/components/properties/IconButton$Variant;ILjava/lang/Object;)Lq20/u1;` | 1 |
| `Lcom/squareup/ui/market/components/MarketIconButtonKt;` | `b` | `(Lam0/a;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/interaction/MutableInteractionSource;ZLcom/squareup/ui/market/components/n;Lam0/a;Ljava/lang/String;Lq20/u1;Lam0/p;Landroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/squareup/ui/market/components/MarketLabelKt;` | `e` | `(Ljava/lang/String;Landroidx/compose/ui/Modifier;IILcom/squareup/ui/market/text/a;Landroidx/compose/foundation/interaction/MutableInteractionSource;Lam0/l;Lq20/c2;Landroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/squareup/ui/market/core/theme/k;` | `e` | `:Lcom/squareup/ui/market/core/theme/k$a;` | 1 |
| `Lcom/squareup/ui/market/core/theme/z;` | `t` | `(Lcom/squareup/ui/market/core/theme/k$a;Landroidx/compose/runtime/Composer;I)Lcom/squareup/ui/market/core/theme/MarketStylesheet;` | 1 |
| `Lcom/squareup/ui/market/layout/e;` | `c` | `(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;` | 1 |
| `Lcom/tidal/android/core/debug/DebugFeatureInteractorDefault;` | `a` | `:Lcom/tidal/android/featureflags/n;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/c;` | `a` | `:Lcom/aspiro/wamp/core/k;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d;` | `c` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/artisttrackcredits/ArtistTrackCreditsModuleManager;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | `f` | `:Lam0/q;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/publicplaylistlist/PublicPlaylistListModuleManager;` | `f` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/tracklist/TrackListModuleManager;` | `b` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/dynamicpages/ui/modules/verticallistcard/VerticalListCardModuleManager;` | `e` | `:Lcom/tidal/android/dynamicpages/ui/b;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/composable/g;` | `a` | `:Lam0/l;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/q;` | `d` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/q;` | `e` | `:Z` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/r$a;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/r$a;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | `b` | `:Lcom/tidal/android/feature/appscaffold/ui/q;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | `c` | `:Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$PlayState;` | 1 |
| `Lcom/tidal/android/feature/appscaffold/ui/t;` | `a` | `:Lcom/tidal/android/feature/appscaffold/ui/MiniPlayerContract$ItemType;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/FeedView;` | `d` | `:Lv70/b;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/FeedView;` | `c` | `:La80/c;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/FeedView;` | `f` | `:Lio/reactivex/disposables/CompositeDisposable;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/c;` | `c` | `:Lz70/a;` | 1 |
| `Lcom/tidal/android/feature/feed/ui/viewstates/UpdatedIntervals$a;` | `a` | `(I)Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel$observeLyricsProgress$1$a;` | `a` | `:Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `W` | `:Lkotlinx/coroutines/flow/StateFlow;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `Q` | `:Lkotlin/i;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `a` | `:Lbi/e;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `O` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/PlayerViewModel;` | `K` | `:Lkotlinx/coroutines/flow/MutableStateFlow;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/b0;` | `b` | `:Lcom/tidal/android/feature/playerscreen/ui/s$a;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/CoverPagerKt;` | `c` | `(Lcom/tidal/android/feature/playerscreen/ui/d;Lam0/l;FLandroidx/compose/ui/Modifier;ZLandroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/LyricsKt;` | `a` | `(Lcom/tidal/android/feature/playerscreen/ui/g;Lam0/l;Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/layout/PaddingValues;Lam0/l;Landroidx/compose/runtime/Composer;II)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/anim/BouncePressKt;` | `a` | `(Landroidx/compose/ui/Modifier;)Landroidx/compose/ui/Modifier;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/e5;` | `a` | `(ILam0/a;Landroidx/compose/runtime/Composer;Landroidx/compose/ui/Modifier;)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/k1;` | `a` | `(Landroidx/compose/ui/Modifier;Lam0/a;ZLandroidx/compose/runtime/Composer;I)V` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/o1;` | `a` | `:F` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/composables/t4;` | `g` | `:F` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/g$c;` | `c` | `:I` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/p;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `j` | `:Lcom/tidal/android/feature/playerscreen/ui/g;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `d` | `:Lcom/tidal/android/feature/playerscreen/ui/b;` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `i` | `:Z` | 1 |
| `Lcom/tidal/android/feature/playerscreen/ui/s$a;` | `c` | `:Lcom/tidal/android/feature/playerscreen/ui/d;` | 1 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `n` | `:Ljava/util/List;` | 1 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `d` | `:Lcom/tidal/android/feature/search/ui/e;` | 1 |
| `Lcom/tidal/android/feature/search/ui/SearchScreenViewModel;` | `f` | `:Lcom/tidal/android/feature/search/ui/f;` | 1 |
| `Lcom/tidal/android/feature/search/ui/f;` | `a` | `(JLh40/p;Ljava/lang/String;)V` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;` | `n` | `:Lcom/tidal/android/feature/viewall/ui/c;` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/ViewAllScreenViewModel;` | `f` | `:Lcom/tidal/android/feature/viewall/ui/u;` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/c;` | `f` | `:Ljava/util/ArrayList;` | 1 |
| `Lcom/tidal/android/feature/viewall/ui/e$c;` | `a` | `:Ljava/lang/Object;` | 1 |
| `Lcom/tidal/android/image/coil/base/CoilImageLoader;` | `a` | `:Lcoil/f;` | 1 |
| `Lcom/tidal/android/image/coil/c;` | `a` | `(Lxd0/g;Landroidx/compose/ui/layout/ContentScale;)Lcoil/request/h;` | 1 |
| `Lde0/c;` | `a` | `:Ljava/lang/String;` | 1 |
| `Le5/z$n2;` | `z0` | `:Ldagger/internal/j;` | 1 |
| `Le5/z$n2;` | `u3` | `()Lcom/aspiro/wamp/playback/f;` | 1 |
| `Le5/z$n2;` | `x3` | `()Lcom/aspiro/wamp/playback/e0;` | 1 |
| `Le5/z$n2;` | `w8` | `:Ldagger/internal/f;` | 1 |
| `Le5/z$n2;` | `y3` | `()Lcom/aspiro/wamp/playback/k0;` | 1 |
| `Le5/z$n2;` | `v8` | `:Ldagger/internal/f;` | 1 |
| `Le5/z$n2;` | `K9` | `:Ldagger/internal/f;` | 1 |
| `Le5/z$n2;` | `k9` | `:Ldagger/internal/f;` | 1 |
| `Lfd/c;` | `a` | `:Lx40/a;` | 1 |
| `Lfd/c;` | `d` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lfd/c;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lgh/b;` | `b` | `:F` | 1 |
| `Lgh/j;` | `a` | `()V` | 1 |
| `Lgh/j;` | `d` | `:Lio/reactivex/subjects/BehaviorSubject;` | 1 |
| `Lh4/a;` | `q` | `(Landroidx/fragment/app/FragmentActivity;Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Z` | 1 |
| `Lh4/a;` | `n` | `:Lcom/aspiro/wamp/contextmenu/menu/track/TrackContextMenu$a;` | 1 |
| `Lhf/c;` | `e` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lhf/c;` | `d` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lj3/k$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lj3/k;` | 1 |
| `Lj3/k;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lj3/n$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lj3/n;` | 1 |
| `Lj3/n;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lj3/q$a;` | `a` | `(Lcom/aspiro/wamp/mix/model/Mix;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/tidal/android/navigation/NavigationInfo;)Lj3/q;` | 1 |
| `Lj3/q;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lk5/f;` | `l` | `(Ljava/lang/String;)Lcom/aspiro/wamp/dynamicpages/data/model/Module;` | 1 |
| `Lld/c;` | `a` | `:Lx40/a;` | 1 |
| `Lld/c;` | `d` | `:Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;` | 1 |
| `Lld/c;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lm3/d;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lm3/f;` | `j` | `:Lcom/aspiro/wamp/playqueue/g1;` | 1 |
| `Lm3/i$a;` | `a` | `(Lcom/aspiro/wamp/model/Track;Lcom/aspiro/wamp/eventtracking/model/ContextualMetadata;Lcom/aspiro/wamp/playqueue/source/model/Source;)Lm3/i;` | 1 |
| `Lm3/i;` | `b` | `(Landroidx/fragment/app/FragmentActivity;)V` | 1 |
| `Lmb/f;` | `c` | `:Ljava/util/Map;` | 1 |
| `Lmb0/a;` | `a` | `:Lh40/n;` | 1 |
| `Lmb0/f;` | `a` | `(Lmb0/e;)Ljava/lang/String;` | 1 |
| `Ln8/d;` | `f` | `:Lcom/aspiro/wamp/model/MediaItem;` | 1 |
| `Lo3/a;` | `l` | `:Lcom/aspiro/wamp/module/album/AlbumProvider;` | 1 |
| `Lo3/a;` | `e` | `:Lc3/i$a;` | 1 |
| `Lo3/a;` | `d` | `:Lc3/l$a;` | 1 |
| `Lo4/g;` | `e` | `:Lo4/g$e;` | 1 |
| `Lo4/g;` | `b` | `:I` | 1 |
| `Lo6/i;` | `g` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lo6/i;` | `e` | `(ILjava/lang/String;)V` | 1 |
| `Lo6/i;` | `m` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lob0/q;` | `a` | `(Lpb0/b$e;Lam0/a;Landroidx/compose/ui/Modifier;Lam0/a;Landroidx/compose/runtime/Composer;I)V` | 1 |
| `Lob0/w;` | `a` | `(Lpb0/b$f;Lam0/a;Landroidx/compose/ui/Modifier;Lam0/a;Landroidx/compose/runtime/Composer;I)V` | 1 |
| `Lpb0/b$a;` | `a` | `:J` | 1 |
| `Lpb0/b$a;` | `f` | `:Z` | 1 |
| `Lpb0/b$e;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lpb0/b$f;` | `a` | `:Ljava/lang/String;` | 1 |
| `Lpb0/b$i;` | `a` | `:J` | 1 |
| `Lpb0/b$i;` | `i` | `:Z` | 1 |
| `Lpd0/a;` | `a` | `:Lh40/n;` | 1 |
| `Lpe/f;` | `a` | `:Lx40/a;` | 1 |
| `Lpe/f;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lq20/c2;` | `g` | `(Lq20/c2;Lq20/s4;Lf20/d;Lcom/squareup/ui/market/core/text/MarketTextAlignment;Lcom/squareup/ui/market/core/text/MarketTextTransform;Lq20/r4;ILjava/lang/Object;)Lq20/c2;` | 1 |
| `Lra/d;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Ltl/f;` | `e` | `(Lcom/aspiro/wamp/search/v2/a;)V` | 1 |
| `Ltl/h;` | `c` | `()Lcom/aspiro/wamp/search/v2/model/UnifiedSearchQuery;` | 1 |
| `Ltl/q;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lu3/a;` | `j` | `:Lj3/k$a;` | 1 |
| `Lu3/a;` | `e` | `:Lj3/n$a;` | 1 |
| `Lu3/a;` | `d` | `:Lj3/q$a;` | 1 |
| `Lu5/b$a$a;` | `g` | `(ILjava/lang/String;)V` | 1 |
| `Lu5/g;` | `h` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lu5/g;` | `j` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lv9/e;` | `b` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |
| `Lv9/e;` | `a` | `:Lcom/aspiro/wamp/core/k;` | 1 |
| `Lvn0/a;` | `c` | `(Ljava/lang/Iterable;)Lvn0/b;` | 1 |
| `Lz70/a;` | `c` | `:Lcom/aspiro/wamp/model/AvailabilityInteractor;` | 1 |
| `Lzf/c;` | `c` | `:Lcom/tidal/android/navigation/NavigationInfo;` | 1 |

## 3. Rolled patch target classes (64)

`--- a/` headers naming an obfuscated class. If these move the hunk cannot even be located.

| target | hooked by |
|---|---|
| `cg0/h.smali` | `lyrics-rl-api-isrc.patch` |
| `com/aspiro/wamp/mycollection/subpages/albums/myalbums/MyAlbumsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/albums/search/SearchAlbumsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/favoritetracks/FavoriteTracksFragment.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/mixesandradios/MyMixesAndRadioView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/playlists/myplaylists/MyPlaylistsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/mycollection/subpages/playlists/searchplaylists/SearchPlaylistsView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/playqueue/l.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/ItemTouchHelperCallbackImpl.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/suggestions/h.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/nowplaying/view/suggestions/o0.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/playlist/ui/fragment/PlaylistFragment.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/aspiro/wamp/search/v2/UnifiedSearchView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/tidal/android/core/debug/DebugFeatureInteractorDefault.smali` | `debug-menu-unlock.patch` |
| `com/tidal/android/core/ui/composable/c0.smali` | `player-backdrop-kawarp.patch`, `player-backdrop-playback.patch` |
| `com/tidal/android/dynamicpages/ui/composables/artisttrackcredits/h.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/compactgridcard/CompactGridCardModuleRowKt.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/compactgridcard/d.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/publicplaylistlist/i.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/verticallistcard/VerticalListCardKt.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/composables/verticaltracklist/j.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/artisttrackcredits/ArtistTrackCreditsModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/compactgridcard/CompactGridCardModuleManager$createModuleViewState$2$2.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/publicplaylistlist/PublicPlaylistListModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/tracklist/TrackListModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/dynamicpages/ui/modules/verticallistcard/VerticalListCardModuleManager$createModuleViewState$3.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/appscaffold/ui/MiniPlayerViewModel.smali` | `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/MiniPlayerKt.smali` | `gestures/mini-player/mini-player-left-right-gesture.patch`, `gestures/mini-player/mini-player-up-gesture.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/a.smali` | `mini-player-black.patch`, `mini-player-grey.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/g.smali` | `gestures/mini-player/mini-player-left-right-gesture.patch` |
| `com/tidal/android/feature/appscaffold/ui/composable/i.smali` | `gestures/mini-player/mini-player-up-gesture.patch`, `mini-player-black.patch`, `mini-player-dynamic-bg.patch`, `mini-player-floating-border.patch`, `mini-player-grey.patch` |
| `com/tidal/android/feature/appscaffold/ui/q.smali` | `cover-capture.patch` |
| `com/tidal/android/feature/appscaffold/ui/t.smali` | `cover-capture.patch` |
| `com/tidal/android/feature/feed/ui/FeedView.smali` | `gestures/queue/swipe-to-queue.patch` |
| `com/tidal/android/feature/home/ui/composables/g.smali` | `home-backdrop.patch` |
| `com/tidal/android/feature/home/ui/k.smali` | `home-backdrop.patch` |
| `com/tidal/android/feature/home/ui/o.smali` | `home-backdrop.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerScreenKt$PlayerScreenPortrait$2$1.smali` | `lyrics-keep-controls-visible.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerScreenKt.smali` | `lyrics-replace-lyrics-button.patch`, `lyrics-replace-share-button.patch`, `lyrics-sparkle-conditional-visibility.patch`, `player-backdrop-kawarp.patch`, `player-backdrop-playback.patch`, `player-hide-playing-from.patch`, `player-move-playing-from.patch`, `player-one-handed.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerViewModel$observeLyricsProgress$1$a.smali` | `lyrics-rl-api-observer.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerViewModel$special$$inlined$mapNotNull$1$2.smali` | `lyrics-rl-api.patch`, `player-quality-badge-colors.patch` |
| `com/tidal/android/feature/playerscreen/ui/PlayerViewModel.smali` | `lyrics-keep-controls-visible.patch`, `lyrics-rl-api.patch`, `mini-player-dynamic-bg.patch` |
| `com/tidal/android/feature/playerscreen/ui/b0.smali` | `lyrics-disable-cover.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/LyricsKt.smali` | `gestures/lyrics/lyrics-gesture-scroll-guard.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/SeekbarAndTimeKt.smali` | `player-quality-badge-colors.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/c1.smali` | `player-favorite-heart.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/f2.smali` | `lyrics-rl-api-syllable.patch`, `lyrics-rl-api-word.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/n2.smali` | `player-move-playing-from.patch` |
| `com/tidal/android/feature/playerscreen/ui/composables/o1.smali` | `lyrics-fade-region.patch` |
| `com/tidal/android/feature/playerscreen/ui/i$a.smali` | `player-quality-badge-colors.patch` |
| `com/tidal/android/feature/playerscreen/ui/m0.smali` | `lyrics-progress-pill.patch` |
| `com/tidal/android/feature/search/ui/SearchScreenViewModel.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/search/ui/composables/u0.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/viewall/ui/ViewAllScreenViewModel.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/android/feature/viewall/ui/l.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `com/tidal/wave2/foundation/WaveScaffoldKt.smali` | `collection-backdrop.patch` |
| `de0/c.smali` | `player-backdrop-playback.patch` |
| `h4/a.smali` | `gestures/queue/swipe-to-queue.patch` |
| `hg/d.smali` | `enable-legacy-ui.patch` |
| `j40/e4.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `j40/p2.smali` | `gestures/queue/swipe-to-queue-compose.patch` |
| `mb/f.smali` | `integration-waze-playback.patch` |
| `p7/a.smali` | `gestures/queue/swipe-to-queue.patch` |
| `v6/e.smali` | `gestures/queue/swipe-to-queue.patch` |

## 4. Occurrences inside .patch files - not marked inline (220)

| file | line | kind | symbols |
|---|---:|---|---|
| `cover-capture.patch` | 5 | context | `Lcom/tidal/android/feature/appscaffold/ui/q; d` |
| `cover-capture.patch` | 11 | context | `Lcom/tidal/android/feature/appscaffold/ui/q; e` |
| `cover-capture.patch` | 15 | context | `Lcom/tidal/android/feature/appscaffold/ui/q;` |
| `debug-menu-unlock.patch` | 11 | context | `Lcom/tidal/android/featureflags/n; a` |
| `debug-menu-unlock.patch` | 26 | context | `Lo50/a; a` |
| `debug-menu-unlock.patch` | 36 | context | `Lo50/a; a` |
| `gestures/lyrics/lyrics-gesture-scroll-guard.patch` | 12 | context | `Lam0/l;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 7 | added | `Lam0/l;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 16 | context | `Lcom/tidal/android/feature/appscaffold/ui/t; Lcom/tidal/android/feature/appscaffold/ui/q; b` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 32 | context | `Lf20/a; p0` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 63 | context | `Lbi/e; i` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 73 | added | `Lcom/tidal/android/feature/appscaffold/ui/r$c; a` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 81 | added | `Lbi/e;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 89 | added | `Lbi/e; h` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 95 | context | `Landroidx/navigation/f0;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 116 | added | `Lkotlin/u;` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 122 | context | `Lcom/tidal/android/feature/appscaffold/ui/composable/g; Lam0/l; a` |
| `gestures/mini-player/mini-player-left-right-gesture.patch` | 126 | context | `Lcom/tidal/android/feature/appscaffold/ui/b$b; a` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 14 | added | `Lam0/l;` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 23 | context | `Lcom/tidal/android/feature/appscaffold/ui/t; c` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 25 | added | `Lcom/tidal/android/feature/appscaffold/ui/t; a` |
| `gestures/mini-player/mini-player-up-gesture.patch` | 64 | context | `Lf20/a; p0` |
| `gestures/player/player-swipe-gesture.patch` | 35 | added | `Lam0/l;` |
| `gestures/player/player-swipe-gesture.patch` | 37 | added | `Lam0/l;` |
| `gestures/player/player-swipe-gesture.patch` | 41 | context | `Lam0/l;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 5 | context | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 7 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 18 | added | `Lm40/e$e; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 26 | added | `Lam0/l; Lm40/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 28 | added | `Lm40/e$e; j` |
| `gestures/queue/swipe-to-queue-compose.patch` | 54 | context | `Landroidx/navigation/f0;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 60 | added | `Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 72 | added | `Lam0/l; Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 93 | added | `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d; Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c; b` |
| `gestures/queue/swipe-to-queue-compose.patch` | 95 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c; Lam0/q; f` |
| `gestures/queue/swipe-to-queue-compose.patch` | 97 | added | `Lcom/tidal/android/dynamicpages/ui/composables/compactgridcard/d; c` |
| `gestures/queue/swipe-to-queue-compose.patch` | 99 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/c; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 103 | added | `Lam0/q;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 105 | added | `Lkotlin/u;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 123 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 127 | added | `Lcom/tidal/android/dynamicpages/ui/modules/compactgridcard/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 129 | added | `Lkotlin/u;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 159 | context | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 161 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 167 | added | `Lam0/l; Lpb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 173 | added | `Lpb0/b$a; f` |
| `gestures/queue/swipe-to-queue-compose.patch` | 187 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 193 | added | `Lam0/l; Lpb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 208 | context | `Lob0/w; Lpb0/b$f; Lam0/a; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 211 | context | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 213 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 219 | added | `Lam0/l; Lpb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 225 | added | `Lpb0/b$i; i` |
| `gestures/queue/swipe-to-queue-compose.patch` | 239 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 245 | added | `Lam0/l; Lpb0/b;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 260 | context | `Lob0/q; Lpb0/b$e; Lam0/a; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 265 | context | `Lam0/l;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 267 | added | `Lm40/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 273 | added | `Lm40/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 275 | added | `Lm40/e$e; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 283 | added | `Lam0/l; Lm40/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 285 | added | `Lm40/e$e; j` |
| `gestures/queue/swipe-to-queue-compose.patch` | 300 | added | `Lcom/tidal/android/feature/viewall/ui/n;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 304 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 318 | added | `Lcom/tidal/android/feature/viewall/ui/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 324 | added | `Lkotlin/u;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 330 | context | `Lcom/tidal/android/feature/viewall/ui/e$a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 334 | context | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 335 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 341 | added | `Lm40/e$e; a` |
| `gestures/queue/swipe-to-queue-compose.patch` | 349 | added | `Lam0/l; Lm40/e$e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 351 | added | `Lm40/e$e; j` |
| `gestures/queue/swipe-to-queue-compose.patch` | 376 | added | `Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 384 | added | `Lam0/l; Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 390 | added | `Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 402 | context | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 403 | added | `Lcom/tidal/android/dynamicpages/ui/composables/verticallistcard/m;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 407 | added | `Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 413 | added | `Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 415 | added | `Lm40/e;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 421 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 429 | context | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 430 | added | `Lam0/a;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 438 | added | `Lam0/l; Lm40/e$d;` |
| `gestures/queue/swipe-to-queue-compose.patch` | 444 | added | `Lm40/e$d; g` |
| `gestures/queue/swipe-to-queue-compose.patch` | 480 | context | `Landroidx/navigation/f0;` |
| `gestures/queue/swipe-to-queue.patch` | 13 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; d` |
| `gestures/queue/swipe-to-queue.patch` | 17 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; b` |
| `gestures/queue/swipe-to-queue.patch` | 33 | added | `f` |
| `gestures/queue/swipe-to-queue.patch` | 62 | added | `Y` |
| `gestures/queue/swipe-to-queue.patch` | 69 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; d` |
| `gestures/queue/swipe-to-queue.patch` | 73 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; b` |
| `gestures/queue/swipe-to-queue.patch` | 79 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; m` |
| `gestures/queue/swipe-to-queue.patch` | 81 | added | `Lcom/aspiro/wamp/playqueue/source/model/b; m` |
| `gestures/queue/swipe-to-queue.patch` | 87 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/g0; k` |
| `gestures/queue/swipe-to-queue.patch` | 89 | added | `Lx40/a; b` |
| `gestures/queue/swipe-to-queue.patch` | 91 | added | `Lh4/a;` |
| `gestures/queue/swipe-to-queue.patch` | 95 | added | `Lh4/a;` |
| `gestures/queue/swipe-to-queue.patch` | 126 | added | `Lh4/a; q` |
| `gestures/queue/swipe-to-queue.patch` | 142 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; l` |
| `gestures/queue/swipe-to-queue.patch` | 146 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; f` |
| `gestures/queue/swipe-to-queue.patch` | 148 | added | `w` |
| `gestures/queue/swipe-to-queue.patch` | 156 | context | `Ln8/b;` |
| `gestures/queue/swipe-to-queue.patch` | 159 | context | `Lo4/g; Lo4/g$e; e` |
| `gestures/queue/swipe-to-queue.patch` | 163 | context | `Lo4/g; b` |
| `gestures/queue/swipe-to-queue.patch` | 164 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; l` |
| `gestures/queue/swipe-to-queue.patch` | 168 | added | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/m; f` |
| `gestures/queue/swipe-to-queue.patch` | 174 | context | `Lcom/aspiro/wamp/mycollection/subpages/favoritetracks/n; N` |
| `gestures/queue/swipe-to-queue.patch` | 207 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 218 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 230 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 270 | added | `Lh4/a; n` |
| `gestures/queue/swipe-to-queue.patch` | 272 | added | `Lcom/aspiro/wamp/contextmenu/menu/track/d;` |
| `gestures/queue/swipe-to-queue.patch` | 274 | added | `Lcom/aspiro/wamp/contextmenu/menu/track/d; Lcom/aspiro/wamp/contextmenu/menu/track/c; a` |
| `gestures/queue/swipe-to-queue.patch` | 276 | added | `Lcom/aspiro/wamp/contextmenu/menu/track/c; Ldagger/internal/j; b` |
| `gestures/queue/swipe-to-queue.patch` | 278 | added | `Lql0/a;` |
| `gestures/queue/swipe-to-queue.patch` | 282 | added | `Lm3/f$a;` |
| `gestures/queue/swipe-to-queue.patch` | 284 | added | `Lm3/f$a; Lm3/f; a` |
| `gestures/queue/swipe-to-queue.patch` | 288 | added | `Lm3/f; Lcom/aspiro/wamp/playqueue/g1; j` |
| `gestures/queue/swipe-to-queue.patch` | 290 | added | `Lcom/aspiro/wamp/playqueue/g1; Lcom/aspiro/wamp/player/d; a` |
| `gestures/queue/swipe-to-queue.patch` | 294 | added | `Lcom/aspiro/wamp/player/d; b` |
| `gestures/queue/swipe-to-queue.patch` | 300 | added | `Lm3/f; b` |
| `gestures/queue/swipe-to-queue.patch` | 323 | context | `Lcom/aspiro/wamp/nowplaying/view/playqueue/touchmanagement/a; Lcom/aspiro/wamp/nowplaying/view/playqueue/l;` |
| `gestures/queue/swipe-to-queue.patch` | 346 | added | `h` |
| `gestures/queue/swipe-to-queue.patch` | 357 | added | `i` |
| `gestures/queue/swipe-to-queue.patch` | 359 | context | `d` |
| `gestures/queue/swipe-to-queue.patch` | 430 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 443 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 456 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 469 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 482 | context | `Lcom/tidal/android/feature/appscaffold/ui/recyclerview/b; Lcom/tidal/android/feature/appscaffold/ui/recyclerview/a; a` |
| `gestures/queue/swipe-to-queue.patch` | 500 | context | `Lcom/aspiro/wamp/nowplaying/view/suggestions/o0; Lcom/aspiro/wamp/nowplaying/view/suggestions/l; M` |
| `integration-waze-playback.patch` | 9 | added | `Lkotlin/jvm/internal/n;` |
| `integration-waze-playback.patch` | 17 | added | `Lkotlin/jvm/internal/n;` |
| `integration-waze-playback.patch` | 35 | added | `Lkotlin/jvm/internal/n;` |
| `integration-waze-playback.patch` | 55 | context | `Lmb/f; c` |
| `lyrics-disable-cover.patch` | 11 | added | `Lcom/tidal/android/feature/playerscreen/ui/b0; Lcom/tidal/android/feature/playerscreen/ui/s$a; b` |
| `lyrics-disable-cover.patch` | 13 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/g; j` |
| `lyrics-disable-cover.patch` | 15 | added | `Lcom/tidal/android/feature/playerscreen/ui/g$a;` |
| `lyrics-disable-cover.patch` | 19 | context | `Lcom/tidal/android/feature/playerscreen/ui/d; Lam0/l; c` |
| `lyrics-fade-region.patch` | 7 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/o1; a` |
| `lyrics-keep-controls-visible.patch` | 28 | added | `Lkotlin/u;` |
| `lyrics-progress-pill.patch` | 14 | context | `Lcom/tidal/android/feature/playerscreen/ui/g; Lam0/l; a` |
| `lyrics-progress-pill.patch` | 60 | added | `Lam0/a;` |
| `lyrics-progress-pill.patch` | 72 | added | `Lam0/l;` |
| `lyrics-replace-lyrics-button.patch` | 8 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/k1; Lam0/a; a` |
| `lyrics-replace-lyrics-button.patch` | 19 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/s3; Lam0/a; a` |
| `lyrics-replace-lyrics-button.patch` | 21 | added | `Landroidx/window/embedding/a2;` |
| `lyrics-replace-lyrics-button.patch` | 27 | added | `Landroidx/window/embedding/a2;` |
| `lyrics-replace-lyrics-button.patch` | 35 | added | `Lam0/a;` |
| `lyrics-replace-lyrics-button.patch` | 38 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `lyrics-replace-share-button.patch` | 7 | removed | `Lcom/tidal/android/feature/playerscreen/ui/b; Lam0/a; b` |
| `lyrics-replace-share-button.patch` | 20 | removed | `Lcom/tidal/android/feature/playerscreen/ui/e0;` |
| `lyrics-replace-share-button.patch` | 21 | added | `Landroidx/window/embedding/b2;` |
| `lyrics-replace-share-button.patch` | 26 | removed | `Lcom/tidal/android/feature/playerscreen/ui/e0;` |
| `lyrics-replace-share-button.patch` | 27 | added | `Landroidx/window/embedding/b2;` |
| `lyrics-replace-share-button.patch` | 33 | context | `Lam0/a;` |
| `lyrics-replace-share-button.patch` | 36 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/b; d` |
| `lyrics-replace-share-button.patch` | 42 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/e5; Lam0/a; a` |
| `lyrics-replace-share-button.patch` | 43 | added | `Lcom/tidal/android/feature/playerscreen/ui/b; Lam0/a; b` |
| `lyrics-rl-api-isrc.patch` | 4 | context | `Lcom/tidal/android/tidalapi/domain/model/o;` |
| `lyrics-rl-api-observer.patch` | 10 | context | `a` |
| `lyrics-rl-api-observer.patch` | 34 | context | `Lcom/tidal/android/feature/playerscreen/ui/g$c; c` |
| `lyrics-rl-api-syllable.patch` | 14 | context | `Lcom/tidal/android/feature/playerscreen/ui/f;` |
| `lyrics-rl-api-syllable.patch` | 23 | context | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-syllable.patch` | 25 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/f2; b` |
| `lyrics-rl-api-syllable.patch` | 29 | added | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-syllable.patch` | 33 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/f2; d` |
| `lyrics-rl-api-syllable.patch` | 37 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/f2; e` |
| `lyrics-rl-api-syllable.patch` | 64 | added | `Lam0/l;` |
| `lyrics-rl-api-syllable.patch` | 76 | removed | `Lam0/l;` |
| `lyrics-rl-api-syllable.patch` | 77 | added | `Lam0/l;` |
| `lyrics-rl-api-word.patch` | 14 | context | `Lcom/tidal/android/feature/playerscreen/ui/f;` |
| `lyrics-rl-api-word.patch` | 23 | context | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-word.patch` | 25 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/f2; b` |
| `lyrics-rl-api-word.patch` | 29 | added | `Lcom/tidal/android/feature/playerscreen/ui/f; a` |
| `lyrics-rl-api-word.patch` | 33 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/f2; d` |
| `lyrics-rl-api-word.patch` | 37 | added | `Lcom/tidal/android/feature/playerscreen/ui/composables/f2; e` |
| `lyrics-rl-api-word.patch` | 52 | removed | `Lam0/l;` |
| `lyrics-rl-api-word.patch` | 53 | added | `Lam0/l;` |
| `lyrics-rl-api.patch` | 77 | context | `P` |
| `lyrics-sparkle-conditional-visibility.patch` | 5 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/s3; Lam0/a; a` |
| `lyrics-sparkle-conditional-visibility.patch` | 7 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; i` |
| `lyrics-sparkle-conditional-visibility.patch` | 15 | context | `Landroidx/window/embedding/a2;` |
| `lyrics-sparkle-conditional-visibility.patch` | 20 | context | `Lam0/a;` |
| `lyrics-sparkle-conditional-visibility.patch` | 36 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `mini-player-black.patch` | 56 | context | `Lcom/tidal/android/feature/appscaffold/ui/composable/a; c` |
| `mini-player-black.patch` | 71 | context | `Lam0/p;` |
| `mini-player-dynamic-bg.patch` | 14 | context | `Lcom/tidal/android/feature/appscaffold/ui/composable/a; c` |
| `mini-player-dynamic-bg.patch` | 20 | context | `W` |
| `mini-player-dynamic-bg.patch` | 22 | added | `Lkotlin/i; Q` |
| `mini-player-dynamic-bg.patch` | 24 | added | `Lkotlin/i;` |
| `mini-player-floating-border.patch` | 9 | added | `Lam0/l;` |
| `mini-player-floating-border.patch` | 14 | context | `Lkotlin/u;` |
| `mini-player-grey.patch` | 58 | context | `Lam0/p;` |
| `player-backdrop-kawarp.patch` | 8 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/p3; Lam0/a; b` |
| `player-backdrop-kawarp.patch` | 9 | added | `Lam0/a;` |
| `player-backdrop-kawarp.patch` | 36 | removed | `Lcom/tidal/android/feature/playerscreen/ui/composables/p3; Lam0/a; a` |
| `player-backdrop-playback.patch` | 10 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/p3; Lam0/a; b` |
| `player-backdrop-playback.patch` | 46 | removed | `Landroidx/compose/foundation/text/input/a;` |
| `player-backdrop-playback.patch` | 73 | context | `Lde0/c; a` |
| `player-backdrop-playback.patch` | 95 | context | `Lcom/squareup/ui/market/layout/e; c` |
| `player-favorite-heart.patch` | 16 | removed | `La30/b; La30/a; O` |
| `player-favorite-heart.patch` | 20 | removed | `La30/a; a` |
| `player-hide-playing-from.patch` | 5 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `player-move-playing-from.patch` | 8 | added | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/p; m` |
| `player-move-playing-from.patch` | 12 | added | `Lcom/tidal/android/feature/playerscreen/ui/p; a` |
| `player-move-playing-from.patch` | 22 | context | `Lcom/tidal/android/feature/playerscreen/ui/s$a; Lcom/tidal/android/feature/playerscreen/ui/d; c` |
| `player-move-playing-from.patch` | 29 | context | `Lq20/c2;` |
| `player-move-playing-from.patch` | 61 | added | `Lcom/squareup/ui/market/text/a; Lam0/l; Lq20/c2; e` |
| `player-quality-badge-colors.patch` | 5 | context | `Lcom/tidal/android/feature/playerscreen/ui/composables/t4; g` |
| `player-quality-badge-colors.patch` | 16 | context | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
| `player-quality-badge-colors.patch` | 18 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a; b` |
| `player-quality-badge-colors.patch` | 22 | context | `Lcom/tidal/android/feature/playerscreen/ui/i$a; a` |
| `player-quality-badge-colors.patch` | 33 | added | `Lq20/c2;` |
| `player-quality-badge-colors.patch` | 55 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
| `player-quality-badge-colors.patch` | 66 | context | `Lcom/tidal/android/feature/playerscreen/ui/i$a; a` |
| `player-quality-badge-colors.patch` | 68 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a; b` |
| `player-quality-badge-colors.patch` | 111 | removed | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
| `player-quality-badge-colors.patch` | 114 | added | `Lcom/tidal/android/feature/playerscreen/ui/i$a;` |
