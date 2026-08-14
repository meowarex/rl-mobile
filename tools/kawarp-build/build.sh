#!/usr/bin/env bash
# Compiles the Java-authored extension classes down to the hand-editable smali that the Manager
# injects. Everything under stubs/ exists only to satisfy javac - those classes are already in the
# TIDAL dex, so they are on the classpath but never compiled into the output.
#
#   ./build.sh          # regenerate ../../patches/extension/radiant/Kawarp*.smali
#
# Override JAVA_HOME / ANDROID_JAR / SMALI_TOOLS if your toolchain lives elsewhere.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo="$(cd "$here/../.." && pwd)"

JAVA_HOME="${JAVA_HOME:-/home/meow/toolchain/jdk-21.0.12+8}"
ANDROID_SDK="${ANDROID_SDK:-/home/meow/toolchain/android-sdk}"
ANDROID_JAR="${ANDROID_JAR:-$ANDROID_SDK/platforms/android-36/android.jar}"
D8="${D8:-$(ls -d "$ANDROID_SDK"/build-tools/*/d8 | sort | tail -1)}"
BAKSMALI="${BAKSMALI:-/home/meow/tools/baksmali.jar}"

export PATH="$JAVA_HOME/bin:$PATH"
javac="$JAVA_HOME/bin/javac"
java="$JAVA_HOME/bin/java"
out="$here/build"

rm -rf "$out"
mkdir -p "$out/stubs" "$out/classes" "$out/dex" "$out/smali"

echo "==> javac stubs"
find "$here/stubs" -name '*.java' > "$out/stubs.list"
"$javac" -nowarn -g:none --release 8 -cp "$ANDROID_JAR" -d "$out/stubs" @"$out/stubs.list" 2>&1 |
    grep -v 'bootstrap class path\|source value 8\|target value 8\|deprecat' || true

# The Kawarp engine lives in the Kawarp-AGSL library repo and is compiled into this bundle.
# Expected checkout location (gitignored): tools/kawarp-agsl — clone it there, or point
# KAWARP_AGSL elsewhere.
KAWARP_AGSL="${KAWARP_AGSL:-$repo/tools/kawarp-agsl}"
ENGINE="$KAWARP_AGSL/kawarp/src/main/java/dev/kawarp/KawarpEngine.java"
[ -f "$ENGINE" ] || { echo "!! Kawarp-AGSL checkout not found at $KAWARP_AGSL" >&2
                      echo "   git clone https://github.com/meowarex/kawarp-agsl tools/kawarp-agsl" >&2
                      exit 1; }

echo "==> javac sources"
{ find "$here/src" -name '*.java'; echo "$ENGINE"; } > "$out/src.list"
"$javac" -nowarn -g:none --release 8 -cp "$ANDROID_JAR:$out/stubs" -d "$out/classes" @"$out/src.list" 2>&1 |
    grep -v 'bootstrap class path\|source value 8\|target value 8\|deprecat' || true

echo "==> d8"
find "$out/classes" -name '*.class' > "$out/class.list"
"$D8" --min-api 24 --no-desugaring --lib "$ANDROID_JAR" --classpath "$out/stubs" \
      --output "$out/dex" @"$out/class.list"

echo "==> baksmali"
"$java" -jar "$BAKSMALI" d "$out/dex/classes.dex" -o "$out/smali"

echo "==> post-process"
# Kotlin mangles value-class accessors with characters that are illegal in Java identifiers, so
# the stubs declare legal names and we restore the real ones here.
# The 0x5241xxxx sentinels are unfoldable stand-ins for the Manager's option placeholders.
find "$out/smali" -name '*.smali' -print0 | xargs -0 sed -i \
    -e 's/getSizeNHjbRc/getSize-NH-jbRc/g' \
    -e 's/getWidthImpl/getWidth-impl/g' \
    -e 's/getHeightImpl/getHeight-impl/g' \
    -e 's/0x52410001/__RL_KW_WARP__/g' \
    -e 's/0x52410002/__RL_KW_SPEED__/g' \
    -e 's/0x52410003/__RL_KW_SCALE__/g' \
    -e 's/0x52410004/__RL_KW_DITHER__/g' \
    -e 's/0x52410005/__RL_KW_DARKEN__/g' \
    -e 's/0x52410006/__RL_KW_REACTIVE__/g' \
    -e 's/0x52410007/__RL_KW_BLUR__/g' \
    -e 's/0x52410008/__RL_KW_CONTRAST__/g' \
    -e 's/0x52410009/__RL_KW_SAT__/g' \
    -e 's/0x5241000a/__RL_KW_BRIGHT__/g'

leftover=$(grep -rl '0x5241000[0-9a-f]' "$out/smali" || true)
if [ -n "$leftover" ]; then
    echo "!! un-tokenised sentinel left in: $leftover" >&2
    exit 1
fi

dest="$repo/patches/extension"
# Clear previous outputs first so a refactor that drops a class can't leave a stale file behind
# (stale extension smali still gets bundled and can break assembly).
rm -f "$dest"/radiant/Kawarp*.smali "$dest"/dev/kawarp/*.smali
mkdir -p "$dest/dev/kawarp"
for f in "$out"/smali/radiant/Kawarp*.smali "$out"/smali/dev/kawarp/*.smali; do
    rel="${f#"$out"/smali/}"
    cp "$f" "$dest/$rel"
    echo "    -> patches/extension/$rel"
done
