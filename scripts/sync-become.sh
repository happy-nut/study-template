#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_REPOSITORY="${BECOME_UPSTREAM:-happy-nut/become}"
UPSTREAM_REF="${BECOME_REF:-master}"
REPOSITORY_ROOT="$(git rev-parse --show-toplevel)"
TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

git clone --quiet --depth 1 --branch "$UPSTREAM_REF" \
  "https://github.com/${UPSTREAM_REPOSITORY}.git" "$TEMP_DIR/upstream"

MANIFEST="$TEMP_DIR/upstream/.become/engine-files.txt"
if [[ ! -f "$MANIFEST" ]]; then
  echo "Engine manifest not found: $MANIFEST" >&2
  exit 1
fi

while IFS= read -r path || [[ -n "$path" ]]; do
  [[ -z "$path" || "$path" == \#* ]] && continue

  source_path="$TEMP_DIR/upstream/$path"
  destination_path="$REPOSITORY_ROOT/$path"
  if [[ ! -e "$source_path" ]]; then
    echo "Manifest path missing upstream: $path" >&2
    exit 1
  fi

  rm -rf "$destination_path"
  mkdir -p "$(dirname "$destination_path")"
  cp -R "$source_path" "$destination_path"
  echo "Synced $path"
done < "$MANIFEST"

echo "Become engine sync complete. PROFILE.md and box*/ were not changed."
