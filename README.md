# daro-ios-sdk

Fork of [delightroom/daro-ios-sdk](https://github.com/delightroom/daro-ios-sdk) with SPM binary target support.

- Version: `1.1.53`
- Package product: `DaroPackage`
- Release assets: `https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/<XCFRAMEWORK>.zip`
- Resource bundles copied into the package: 14

## Update flow

1. Run `scripts/extract_from_pods.sh` against a project checkout with DaroAds CocoaPods installed.
2. Run `scripts/build_release_assets.sh 1.1.53`.
3. Commit package metadata and bundles.
4. Create tag `1.1.53-spm` and upload `artifacts/1.1.53/*.zip` as release assets.
