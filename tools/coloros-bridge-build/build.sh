#!/usr/bin/env bash
# Builds OplusBridge.smali for the patches <3
# Stubs are just for javac
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo="$(cd "$here/../.." && pwd)"

ANDROID_SDK="${ANDROID_SDK:-${ANDROID_HOME:-$HOME/Android/Sdk}}"
ANDROID_JAR="${ANDROID_JAR:-$(ls -d "$ANDROID_SDK"/platforms/android-3*/android.jar | sort -V | tail -1)}"
D8="${D8:-$(ls -d "$ANDROID_SDK"/build-tools/*/d8 | sort -V | tail -1)}"
BAKSMALI="${BAKSMALI:-/home/meow/tools/baksmali.jar}"

javac="${JAVA_HOME:+$JAVA_HOME/bin/}javac"
java="${JAVA_HOME:+$JAVA_HOME/bin/}java"
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
bash "$D8" --min-api 24 --no-desugaring --lib "$ANDROID_JAR" --classpath "$out/stubs" \
      --output "$out/dex" @"$out/class.list"

echo "==> baksmali"
"$java" -jar "$BAKSMALI" d "$out/dex/classes.dex" -o "$out/smali"

echo "==> tokens"
bridge="$out/smali/radiant/OplusBridge.smali"
for pair in 0xc010001:RL_OPLUS_LYRICS 0xc010002:RL_OPLUS_HEART; do
    grep -q "const v0, ${pair%%:*}$" "$bridge" || { echo "missing ${pair#*:} sentinel" >&2; exit 1; }
    sed -i "s/const v0, ${pair%%:*}$/const v0, __${pair#*:}__/" "$bridge"
done

echo "==> copy"
dest="$repo/patches/extension/radiant"
rm -f "$dest"/OplusBridge*.smali
cp "$out"/smali/radiant/OplusBridge*.smali "$dest/"
echo "==> wrote $dest"
