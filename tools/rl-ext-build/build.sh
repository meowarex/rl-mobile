#!/usr/bin/env bash
# Builds the RL extension classes into smali
#
#   ./build.sh          # rebuild extension smali
#
# Java 8, no lambdas, no nested classes
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
    grep -v 'bootstrap class path\|source value 8\|target value 8\|deprecat\|^[0-9] warning' || true

echo "==> javac sources"
find "$here/src" -name '*.java' > "$out/src.list"
"$javac" -nowarn -g:none --release 8 -cp "$ANDROID_JAR:$out/stubs" -d "$out/classes" @"$out/src.list" 2>&1 |
    grep -v 'bootstrap class path\|source value 8\|target value 8\|deprecat\|^[0-9] warning' || true

echo "==> d8"
find "$out/classes" -name '*.class' > "$out/class.list"
"$D8" --min-api 24 --no-desugaring --lib "$ANDROID_JAR" --classpath "$out/stubs" \
      --output "$out/dex" @"$out/class.list"

echo "==> baksmali"
"$java" -jar "$BAKSMALI" d "$out/dex/classes.dex" -o "$out/smali"

echo "==> post-process"
find "$out/smali" -name '*.smali' -print0 | xargs -0 sed -i \
    -e 's/getSizeNHjbRc/getSize-NH-jbRc/g' \
    -e 's/getIntrinsicSizeNHjbRc/getIntrinsicSize-NH-jbRc/g' \
    -e 's/drawxKDEd0/draw-x_KDEd0/g' \
    -e 's/getWidthImpl/getWidth-impl/g' \
    -e 's/getHeightImpl/getHeight-impl/g'

if grep -rl 'invoke-custom\|access\$' "$out/smali" >/dev/null; then
    echo "!! invoke-custom / access\$ bridge in output - keep it to one class, no lambdas" >&2
    exit 1
fi

dest="$repo/patches/extension/radiant"
for c in AiSparkle AnimatedCovers AnimatedCoverView RoundOutline SparkleIcons; do
    rm -f "$dest/$c".smali
    cp "$out"/smali/radiant/"$c".smali "$dest/"
    echo "    -> patches/extension/radiant/$c.smali"
done
