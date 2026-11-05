#!/usr/bin/env bash
# Manager versionCode from a semver <3
#   tools/version-code.sh 2.1.0 -> 20100
set -euo pipefail

version="${1:?usage: version-code.sh <x.y.z>}"
if [[ ! "$version" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    echo "!! Not a x.y.z version: $version" >&2
    exit 1
fi
major="${BASH_REMATCH[1]}" minor="${BASH_REMATCH[2]}" patch="${BASH_REMATCH[3]}"
if (( minor > 99 || patch > 99 )); then
    echo "!! minor/patch over 99 would break versionCode ordering" >&2
    exit 1
fi
echo $(( major * 10000 + minor * 100 + patch ))
