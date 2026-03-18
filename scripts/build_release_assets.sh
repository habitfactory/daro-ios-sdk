#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

VERSION="${1:-${DARO_VERSION:-1.1.53}}"
OWNER="${DARO_REPO_OWNER:-habitfactory}"
REPO_NAME="${DARO_REPO_NAME:-daro-ios-sdk}"
TAG="${DARO_RELEASE_TAG:-$VERSION-spm}"
DIST_DIR="$REPO_ROOT/dist"
ARTIFACT_DIR="$REPO_ROOT/artifacts/$VERSION"
CHECKSUM_FILE="$REPO_ROOT/manifests/${VERSION}-checksums.json"
RESOURCE_DIR="$REPO_ROOT/Sources/DaroPackage/Resources/Bundles"

if [[ ! -d "$DIST_DIR/XCFrameworks" ]]; then
  echo "Missing dist/XCFrameworks. Run scripts/extract_from_pods.sh first." >&2
  exit 1
fi

rm -rf "$ARTIFACT_DIR" "$RESOURCE_DIR"
mkdir -p "$ARTIFACT_DIR" "$RESOURCE_DIR"

for bundle_path in "$DIST_DIR"/Bundles/*.bundle; do
  rsync -a "$bundle_path" "$RESOURCE_DIR/"
done

python3 - <<'PY' "$DIST_DIR" "$ARTIFACT_DIR" "$CHECKSUM_FILE"
import json
import pathlib
import subprocess
import sys

dist_dir = pathlib.Path(sys.argv[1])
artifact_dir = pathlib.Path(sys.argv[2])
checksum_file = pathlib.Path(sys.argv[3])
checksums = {}

for xcframework in sorted((dist_dir / "XCFrameworks").glob("*.xcframework")):
    zip_name = f"{xcframework.name}.zip"
    zip_path = artifact_dir / zip_name

    # Strip extended attributes to prevent __MACOSX in zip
    subprocess.run(["xattr", "-rc", str(xcframework)], check=False)
    # Remove any ._ AppleDouble files
    subprocess.run(
        ["find", str(xcframework), "-name", "._*", "-delete"],
        check=False,
    )

    subprocess.run(
        [
            "ditto",
            "-c",
            "-k",
            "--keepParent",
            "--norsrc",
            str(xcframework),
            str(zip_path),
        ],
        check=True,
    )
    checksum = subprocess.check_output(
        ["swift", "package", "compute-checksum", str(zip_path)],
        text=True,
    ).strip()
    checksums[xcframework.name] = checksum

checksum_file.write_text(json.dumps(checksums, indent=2, sort_keys=True) + "\n")
PY

python3 "$SCRIPT_DIR/generate_package.py" \
  "$REPO_ROOT" \
  "$VERSION" \
  "$OWNER" \
  "$REPO_NAME" \
  "$TAG"

echo "Prepared Swift package assets for $VERSION"
echo "  artifacts: $ARTIFACT_DIR"
echo "  checksums: $CHECKSUM_FILE"
