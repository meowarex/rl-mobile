#!/usr/bin/env bash
# Builds PebbleBridge*.smali into patches/extension/radiant
# Stubs only satisfy javac
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo="$(cd "$here/../.." && pwd)"

ANDROID_SDK="${ANDROID_SDK:-${ANDROID_HOME:-$HOME/Android/Sdk}}"
ANDROID_JAR="${ANDROID_JAR:-$(ls -d "$ANDROID_SDK"/platforms/android-3*/android.jar | sort -V | tail -1)}"
D8="${D8:-$(ls -d "$ANDROID_SDK"/build-tools/*/d8 | sort -V | tail -1)}"
# baksmali and its deps
SMALI_CP="${SMALI_CP:-$(ls "$HOME"/.cache/rlpb/tools/*.jar | tr '\n' :)}"

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
"$java" -cp "$SMALI_CP" com.android.tools.smali.baksmali.Main d "$out/dex/classes.dex" -o "$out/smali"

echo "==> copy"
dest="$repo/patches/extension/radiant"
rm -f "$dest"/PebbleBridge*.smali
cp "$out"/smali/radiant/PebbleBridge*.smali "$dest/"
echo "==> wrote $dest"
