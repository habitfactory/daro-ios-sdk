#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ $# -lt 1 ]]; then
  echo "usage: extract_from_pods.sh <pods-project-root> [version]" >&2
  echo "  pods-project-root: path to a project checkout that has CocoaPods installed" >&2
  exit 1
fi

PODS_PROJECT_ROOT="$1"
VERSION="${2:-${DARO_VERSION:-1.1.53}}"
PODS_SCHEME="${PODS_SCHEME:-Pods-customer}"
DIST_DIR="$REPO_ROOT/dist"
ARTIFACTS_DIR="$REPO_ROOT/artifacts"
BUILD_DIR="$PODS_PROJECT_ROOT/build/Debug-iphoneos"

# --- xcframework paths ---
# Paths without version numbers (stable across updates)
STABLE_XCFRAMEWORK_PATHS=(
  "Pods/DaroAds/Daro.xcframework"
  "Pods/ChartboostSDK/ChartboostSDK.xcframework"
  "Pods/FBAudienceNetwork/Static/FBAudienceNetwork.xcframework"
  "Pods/FiveAd/FiveAd.xcframework"
  "Pods/Fyber_Marketplace_SDK/IASDKCore/IASDKCore.xcframework"
  "Pods/InMobiSDK/InMobiSDK.xcframework"
  "Pods/IronSourceAdQualitySDK/IronSourceAdQualitySDK.xcframework"
  "Pods/IronSourceSDK/IronSource/IronSource.xcframework"
  "Pods/MolocoSDKiOS/MolocoSDK.xcframework"
  "Pods/UnityAds/UnityAds.xcframework"
  "Pods/VungleAds/static/VungleAdsSDK.xcframework"
)

# xcframeworks with version numbers in path — use find to resolve dynamically
DYNAMIC_XCFRAMEWORK_DIRS=(
  "Pods/Ads-Global/SDK|PAGAdSDK.xcframework"
  "Pods/AmazonPublisherServicesSDK|DTBiOSSDK.xcframework"
  "Pods/AppLovinSDK|AppLovinSDK.xcframework"
  "Pods/Google-Mobile-Ads-SDK|GoogleMobileAds.xcframework"
  "Pods/GoogleMobileAdsMediationAppLovin|AppLovinAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationChartboost|ChartboostAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationFacebook|MetaAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationFyber|DTExchangeAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationInMobi|InMobiAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationIronSource|IronSourceAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationLine|LineAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationMintegral|MintegralAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationMoloco|MolocoAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationPangle|PangleAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationUnity|UnityAdapter.xcframework"
  "Pods/GoogleMobileAdsMediationVungle|LiftoffMonetizeAdapter.xcframework"
  "Pods/GoogleUserMessagingPlatform|UserMessagingPlatform.xcframework"
  "Pods/MintegralAdSDK|MTGSDK.xcframework"
  "Pods/MintegralAdSDK|MTGSDKBanner.xcframework"
  "Pods/MintegralAdSDK|MTGSDKBidding.xcframework"
  "Pods/MintegralAdSDK|MTGSDKInterstitialVideo.xcframework"
  "Pods/MintegralAdSDK|MTGSDKNativeAdvanced.xcframework"
  "Pods/MintegralAdSDK|MTGSDKNewInterstitial.xcframework"
  "Pods/MintegralAdSDK|MTGSDKReward.xcframework"
  "Pods/MintegralAdSDK|MTGSDKSplash.xcframework"
)

SOURCE_BUNDLES=(
  "Pods/Ads-Global/SDK/PAGAdSDK.bundle"
)

BUILD_BUNDLES=(
  "Ads-Global/AdsGlobalSDK.bundle"
  "DaroAds/DaroAdsResources.bundle"
  "FBAudienceNetwork/FBAudienceNetwork.bundle"
  "FiveAd/FiveAd_resources.bundle"
  "Fyber_Marketplace_SDK/Fyber_Marketplace_SDK.bundle"
  "Google-Mobile-Ads-SDK/GoogleMobileAdsResources.bundle"
  "GoogleUserMessagingPlatform/UserMessagingPlatformResources.bundle"
  "IronSourceAdQualitySDK/IronSourceAdQualityPrivacyInfo.bundle"
  "IronSourceSDK/IronSourcePrivacyInfo.bundle"
  "MintegralAdSDK/MTGSDK.bundle"
  "MolocoSDKiOS/MolocoSDK.bundle"
  "UnityAds/UnityAdsResources.bundle"
  "VungleAds/VungleAds.bundle"
)

if [[ ! -d "$PODS_PROJECT_ROOT/Pods" ]]; then
  echo "Pods directory not found at $PODS_PROJECT_ROOT/Pods" >&2
  exit 1
fi

echo "Building $PODS_SCHEME resources from $PODS_PROJECT_ROOT"
xcodebuild \
  -project "$PODS_PROJECT_ROOT/Pods/Pods.xcodeproj" \
  -scheme "$PODS_SCHEME" \
  -configuration Debug \
  -sdk iphoneos \
  CODE_SIGNING_ALLOWED=NO \
  build >/tmp/daro-pods-build.log 2>&1 || {
    echo "WARNING: $PODS_SCHEME build failed (bundles may be missing). Check /tmp/daro-pods-build.log" >&2
  }

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR/XCFrameworks" "$DIST_DIR/Bundles" "$ARTIFACTS_DIR"

# Copy stable-path xcframeworks
for relative_path in "${STABLE_XCFRAMEWORK_PATHS[@]}"; do
  source_path="$PODS_PROJECT_ROOT/$relative_path"
  if [[ ! -d "$source_path" ]]; then
    echo "Missing xcframework: $source_path" >&2
    exit 1
  fi
  rsync -a "$source_path" "$DIST_DIR/XCFrameworks/"
done

# Copy dynamic-path xcframeworks (version number in path)
for entry in "${DYNAMIC_XCFRAMEWORK_DIRS[@]}"; do
  search_dir="${entry%%|*}"
  framework_name="${entry##*|}"

  found_path=$(find "$PODS_PROJECT_ROOT/$search_dir" -name "$framework_name" -maxdepth 3 -type d 2>/dev/null | head -1)
  if [[ -z "$found_path" ]]; then
    echo "Missing xcframework: $framework_name in $search_dir" >&2
    exit 1
  fi
  rsync -a "$found_path" "$DIST_DIR/XCFrameworks/"
done

for relative_path in "${SOURCE_BUNDLES[@]}"; do
  source_path="$PODS_PROJECT_ROOT/$relative_path"
  if [[ ! -d "$source_path" ]]; then
    echo "Missing source bundle: $source_path" >&2
    exit 1
  fi
  rsync -a "$source_path" "$DIST_DIR/Bundles/"
done

for relative_path in "${BUILD_BUNDLES[@]}"; do
  source_path="$BUILD_DIR/$relative_path"
  if [[ ! -d "$source_path" ]]; then
    echo "WARNING: Missing built bundle: $source_path (skipping)" >&2
    continue
  fi
  rsync -a "$source_path" "$DIST_DIR/Bundles/"
done

python3 "$SCRIPT_DIR/generate_metadata.py" "$REPO_ROOT" "$DIST_DIR" "$VERSION"

rm -f "$ARTIFACTS_DIR/DaroBundle-$VERSION.zip"
ditto -c -k --sequesterRsrc --keepParent "$DIST_DIR" "$ARTIFACTS_DIR/DaroBundle-$VERSION.zip"

echo "Created Daro bundle:"
echo "  dist: $DIST_DIR"
echo "  zip:  $ARTIFACTS_DIR/DaroBundle-$VERSION.zip"
