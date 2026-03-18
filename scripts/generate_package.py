#!/usr/bin/env python3

import json
import pathlib
import sys


LIBRARIES = [
    "bz2",
    "c++",
    "c++abi",
    "iconv",
    "resolv",
    "sqlite3",
    "xml2",
    "z",
]

WEAK_FRAMEWORKS = [
    "Combine",
    "CoreML",
    "CryptoKit",
    "DeviceCheck",
    "LocalAuthentication",
    "VideoToolbox",
]


def target_name(filename: str) -> str:
    return filename.removesuffix(".xcframework")


def swift_string_list(values: list[str], indent: int = 8) -> str:
    prefix = " " * indent
    return "\n".join(f'{prefix}"{value}",' for value in values)


def write_package(
    repo_root: pathlib.Path,
    version: str,
    owner: str,
    repo_name: str,
    tag: str,
) -> None:
    manifest_path = repo_root / "manifests" / f"{version}.json"
    checksum_path = repo_root / "manifests" / f"{version}-checksums.json"

    manifest = json.loads(manifest_path.read_text())
    checksums = json.loads(checksum_path.read_text())

    repo_url = f"https://github.com/{owner}/{repo_name}"
    release_base_url = f"{repo_url}/releases/download/{tag}"

    binary_targets = []
    binary_target_names = []
    for filename in manifest["xcframeworks"]:
        name = target_name(filename)
        binary_target_names.append(name)
        binary_targets.append(
            f"""    .binaryTarget(
      name: "{name}",
      url: "{release_base_url}/{filename}.zip",
      checksum: "{checksums[filename]}"
    )"""
        )

    framework_settings = ",\n".join(
        f'      .linkedFramework("{name}")' for name in manifest["sdkFrameworks"]
    )
    library_settings = ",\n".join(f'      .linkedLibrary("{name}")' for name in LIBRARIES)
    weak_framework_flags = ", ".join(
        ['"-ObjC"'] + [f'"{item}"' for name in WEAK_FRAMEWORKS for item in ("-weak_framework", name)]
    )
    bundle_names = [path.name for path in sorted((repo_root / "Sources" / "DaroPackage" / "Resources" / "Bundles").glob("*.bundle"))]

    package = f"""// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "daro-ios-sdk",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "DaroPackage",
      targets: ["DaroPackage"]
    )
  ],
  targets: [
{",\n".join(binary_targets)},
    .target(
      name: "DaroPackage",
      dependencies: [
{",\n".join(f'        "{name}"' for name in binary_target_names)}
      ],
      path: "Sources/DaroPackage",
      resources: [
        .copy("Resources/Bundles")
      ],
      linkerSettings: [
{framework_settings},
{library_settings},
        .unsafeFlags([{weak_framework_flags}])
      ]
    )
  ]
)
"""
    (repo_root / "Package.swift").write_text(package)

    readme = f"""# daro-ios-sdk

Fork of [delightroom/daro-ios-sdk](https://github.com/delightroom/daro-ios-sdk) with SPM binary target support.

- Version: `{version}`
- Package product: `DaroPackage`
- Release assets: `{release_base_url}/<XCFRAMEWORK>.zip`
- Resource bundles copied into the package: {len(bundle_names)}

## Update flow

1. Run `scripts/extract_from_pods.sh` against a project checkout with DaroAds CocoaPods installed.
2. Run `scripts/build_release_assets.sh {version}`.
3. Commit package metadata and bundles.
4. Create tag `{tag}` and upload `artifacts/{version}/*.zip` as release assets.
"""
    (repo_root / "README.md").write_text(readme)


def main() -> int:
    if len(sys.argv) != 6:
        print(
            "usage: generate_package.py <repo_root> <version> <owner> <repo_name> <tag>",
            file=sys.stderr,
        )
        return 1

    repo_root = pathlib.Path(sys.argv[1]).resolve()
    version = sys.argv[2]
    owner = sys.argv[3]
    repo_name = sys.argv[4]
    tag = sys.argv[5]

    write_package(repo_root, version, owner, repo_name, tag)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
