#!/usr/bin/env python3

import json
import pathlib
import sys

SDK_FRAMEWORKS = [
    "AVFAudio",
    "AVFoundation",
    "AVKit",
    "Accelerate",
    "AppTrackingTransparency",
    "AudioToolbox",
    "CFNetwork",
    "CoreFoundation",
    "CoreGraphics",
    "CoreHaptics",
    "CoreImage",
    "CoreLocation",
    "CoreMedia",
    "CoreMotion",
    "CoreTelephony",
    "CoreVideo",
    "MediaPlayer",
    "MessageUI",
    "Network",
    "QuartzCore",
    "SafariServices",
    "Security",
    "StoreKit",
    "SystemConfiguration",
    "WebKit",
]

def write_manifest(repo_root: pathlib.Path, dist_dir: pathlib.Path, version: str) -> dict:
    payload = {
        "version": version,
        "xcframeworks": sorted(path.name for path in (dist_dir / "XCFrameworks").glob("*.xcframework")),
        "bundles": sorted(path.name for path in (dist_dir / "Bundles").glob("*.bundle")),
        "sdkFrameworks": SDK_FRAMEWORKS,
    }

    manifest = json.dumps(payload, indent=2, ensure_ascii=True) + "\n"
    (dist_dir / "manifest.json").write_text(manifest)
    manifests_dir = repo_root / "manifests"
    manifests_dir.mkdir(parents=True, exist_ok=True)
    (manifests_dir / f"{version}.json").write_text(manifest)
    return payload


def main() -> int:
    if len(sys.argv) != 4:
        print(
            "usage: generate_metadata.py <repo_root> <dist_dir> <version>",
            file=sys.stderr,
        )
        return 1

    repo_root = pathlib.Path(sys.argv[1]).resolve()
    dist_dir = pathlib.Path(sys.argv[2]).resolve()
    version = sys.argv[3]

    if not (dist_dir / "XCFrameworks").is_dir():
        print(f"missing XCFrameworks directory in {dist_dir}", file=sys.stderr)
        return 1
    if not (dist_dir / "Bundles").is_dir():
        print(f"missing Bundles directory in {dist_dir}", file=sys.stderr)
        return 1

    write_manifest(repo_root, dist_dir, version)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
