#!/usr/bin/env bash
# Usage: ./scripts/build-spm-release.sh <version> [pods-project-root]
#
# End-to-end script: extract xcframeworks from Pods → zip + checksum →
# generate Package.swift → verify → commit + tag → create GitHub release.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

VERSION="${1:?Usage: build-spm-release.sh <version> <pods-project-root>}"
PODS_PROJECT_ROOT="${2:?Usage: build-spm-release.sh <version> <pods-project-root>}"
TAG="$VERSION-spm"

export DARO_VERSION="$VERSION"

echo "=== Step 1: Extract xcframeworks + bundles from Pods ==="
"$SCRIPT_DIR/extract_from_pods.sh" "$PODS_PROJECT_ROOT"

echo ""
echo "=== Step 2: Zip + checksum + generate Package.swift ==="
export DARO_RELEASE_TAG="$TAG"
"$SCRIPT_DIR/build_release_assets.sh" "$VERSION"

echo ""
echo "=== Step 3: Verify zip integrity ==="
ERRORS=0
for zip in "$REPO_ROOT/artifacts/$VERSION"/*.xcframework.zip; do
  if zipinfo -1 "$zip" | grep -q "__MACOSX"; then
    echo "ERROR: __MACOSX found in $(basename "$zip")" >&2
    ERRORS=$((ERRORS + 1))
  fi
done
if [[ $ERRORS -gt 0 ]]; then
  echo "FATAL: $ERRORS zips contain __MACOSX artifacts" >&2
  exit 1
fi
echo "All zips clean."

echo ""
echo "=== Step 4: Codesign verification (best-effort) ==="
CODESIGN_WARNINGS=0
for zip in "$REPO_ROOT/artifacts/$VERSION"/*.xcframework.zip; do
  TMPDIR_CS=$(mktemp -d)
  unzip -q "$zip" -d "$TMPDIR_CS" 2>/dev/null
  FRAMEWORK_DIR=$(find "$TMPDIR_CS" -name "*.xcframework" -maxdepth 1 -type d | head -1)
  if [[ -n "$FRAMEWORK_DIR" ]]; then
    for binary in $(find "$FRAMEWORK_DIR" -name "*.framework" -type d); do
      EXEC_NAME=$(basename "$binary" .framework)
      EXEC_PATH="$binary/$EXEC_NAME"
      if [[ -f "$EXEC_PATH" ]]; then
        if ! codesign --verify --verbose=0 "$EXEC_PATH" 2>/dev/null; then
          echo "WARNING: codesign failed for $(basename "$zip"):$EXEC_NAME" >&2
          CODESIGN_WARNINGS=$((CODESIGN_WARNINGS + 1))
        fi
      fi
    done
  fi
  rm -rf "$TMPDIR_CS"
done
if [[ $CODESIGN_WARNINGS -gt 0 ]]; then
  echo "WARNING: $CODESIGN_WARNINGS codesign issues detected (may be expected for some SDKs)"
else
  echo "Codesign OK."
fi

echo ""
echo "=== Step 5: Git commit + tag ==="
cd "$REPO_ROOT"
git add Package.swift Sources/ manifests/
git commit -m "$(cat <<EOF
📦 SPM: Update to $VERSION

Binary targets for Daro iOS SDK v$VERSION via SPM.
Tag: $TAG
EOF
)"
git tag -a "$TAG" -m "SPM binary targets for $VERSION"
git push origin main --tags

echo ""
echo "=== Step 6: Create GitHub release + upload assets ==="
gh release create "$TAG" \
  --repo "habitfactory/daro-ios-sdk" \
  --title "v$VERSION (SPM)" \
  --notes "Daro iOS SDK v$VERSION - SPM binary targets" \
  "$REPO_ROOT/artifacts/$VERSION"/*.xcframework.zip

echo ""
echo "=== Done! ==="
echo "Release: https://github.com/habitfactory/daro-ios-sdk/releases/tag/$TAG"
echo ""
echo "Release URL: https://github.com/habitfactory/daro-ios-sdk/releases/tag/$TAG"
