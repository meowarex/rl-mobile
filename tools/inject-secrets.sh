#!/usr/bin/env bash
# Fills in the API creds (env or .env)
#
#   tools/inject-secrets.sh <patches-dir>
#
# Locally only run on a copy of patches/ !!
set -euo pipefail

dir="${1:?usage: inject-secrets.sh <patches-dir>}"
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -f "$repo/.env" ]; then
    set -a
    . "$repo/.env"
    set +a
fi

for key in RL_ACCESS_TOKEN_ID RL_ACCESS_TOKEN; do
    value="${!key:-}"
    if [ -z "$value" ]; then
        echo "!! Missing $key (set in .env or env)" >&2
        exit 1
    fi
    # Goes into sed + smali
    if [[ ! "$value" =~ ^[A-Za-z0-9]+$ ]]; then
        echo "!! $key must be alphanumeric" >&2
        exit 1
    fi
done

find "$dir" -name '*.smali' -print0 | xargs -0 sed -i \
    -e "s/__RL_ACCESS_TOKEN_ID__/$RL_ACCESS_TOKEN_ID/g" \
    -e "s/__RL_ACCESS_TOKEN__/$RL_ACCESS_TOKEN/g"

if grep -rl '__RL_ACCESS_TOKEN' "$dir" >/dev/null; then
    echo "!! Placeholders left in $dir" >&2
    exit 1
fi
echo "==> injected RL API creds into $dir"
