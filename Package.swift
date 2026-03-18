// swift-tools-version: 5.9
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
    .binaryTarget(
      name: "AppLovinAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/AppLovinAdapter.xcframework.zip",
      checksum: "adfc8696d4054063e004a4c7ed0268846d5e1afd3f790b30bddf16dfa520755e"
    ),
    .binaryTarget(
      name: "AppLovinSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/AppLovinSDK.xcframework.zip",
      checksum: "9fe104a46f142e8dc12860533a4e267b051ee635eb16e4174b3fd2d7fa4848b6"
    ),
    .binaryTarget(
      name: "ChartboostAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/ChartboostAdapter.xcframework.zip",
      checksum: "823ae11a048922bba86b4ca576025ceb4427a5625de488e2324550f36b88066b"
    ),
    .binaryTarget(
      name: "ChartboostSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/ChartboostSDK.xcframework.zip",
      checksum: "e6fb6a563304cd32c2f77e6bfadf2cf964bc1c1083d1834e7474185c8482b556"
    ),
    .binaryTarget(
      name: "DTBiOSSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/DTBiOSSDK.xcframework.zip",
      checksum: "7a94cb319a2c694951fdf8b36e431a52e0a2674db65043daddb9ba6f83237734"
    ),
    .binaryTarget(
      name: "DTExchangeAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/DTExchangeAdapter.xcframework.zip",
      checksum: "f6e7d128c1ceaccc26653300a0f24350070bff59150dd3b7d33f3b4cb0a2a75c"
    ),
    .binaryTarget(
      name: "Daro",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/Daro.xcframework.zip",
      checksum: "339da1a054fbfb8711e085e1ea18a34b6e9f0157abed50f858e9ebd190e13e41"
    ),
    .binaryTarget(
      name: "FBAudienceNetwork",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/FBAudienceNetwork.xcframework.zip",
      checksum: "466689d08d82f1426b1f838d308534cb66e40d285758925a40ec71f374921e91"
    ),
    .binaryTarget(
      name: "FiveAd",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/FiveAd.xcframework.zip",
      checksum: "bfed053443b2e4bf68a24bbc7ee687752169985aef542116e5ea849186ab3e53"
    ),
    .binaryTarget(
      name: "GoogleMobileAds",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/GoogleMobileAds.xcframework.zip",
      checksum: "caf8379691f85a69a76e2427117dbcb0e79c9e4415bf318ff524b23d87a943ee"
    ),
    .binaryTarget(
      name: "IASDKCore",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/IASDKCore.xcframework.zip",
      checksum: "ae6d081998540921bca14c0c813767a97da02c6c02092f6499ee57f6a19a8127"
    ),
    .binaryTarget(
      name: "InMobiAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/InMobiAdapter.xcframework.zip",
      checksum: "8f7e02f4fd3ac6d78bcaeebdf192d620534d61350746a3084da9408f42e24190"
    ),
    .binaryTarget(
      name: "InMobiSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/InMobiSDK.xcframework.zip",
      checksum: "8af4d81154ec2455b6d74dab58e8c5d1753cac3ad8cdad890157a5dba6ec5b96"
    ),
    .binaryTarget(
      name: "IronSource",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/IronSource.xcframework.zip",
      checksum: "e6cd7e825f53656c39b083521e9d2f4cac23830add89624613713838ce1c9d74"
    ),
    .binaryTarget(
      name: "IronSourceAdQualitySDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/IronSourceAdQualitySDK.xcframework.zip",
      checksum: "589a57f99361a352defb77e19ba35898e740e8e4c8a676789941d1d7b068c33f"
    ),
    .binaryTarget(
      name: "IronSourceAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/IronSourceAdapter.xcframework.zip",
      checksum: "70d775171dcca12ceef56e4d81006d72c11d9ca6a8e3b5b4828d3828f8c2d574"
    ),
    .binaryTarget(
      name: "LiftoffMonetizeAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/LiftoffMonetizeAdapter.xcframework.zip",
      checksum: "c6396838a3fb83e730d827c66ca77915f12028960023bd0a9da29caa85813dba"
    ),
    .binaryTarget(
      name: "LineAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/LineAdapter.xcframework.zip",
      checksum: "b439f07d308aa5e9560ec025398cad4ba99db8cd48a79f30e6d4ce8da59faac7"
    ),
    .binaryTarget(
      name: "MTGSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDK.xcframework.zip",
      checksum: "f182a77f5f00b29fcc012fb1a289a5f6865b377771eca8e3be26ef0521b46b7c"
    ),
    .binaryTarget(
      name: "MTGSDKBanner",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKBanner.xcframework.zip",
      checksum: "69152261b61635987c968b99912fd35c606650d0e1602f27be17ddc4c34246be"
    ),
    .binaryTarget(
      name: "MTGSDKBidding",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKBidding.xcframework.zip",
      checksum: "cd5aff7729ff299937b3684ef014bd74d5a16d46d9cf9969f46646e963a51f84"
    ),
    .binaryTarget(
      name: "MTGSDKInterstitialVideo",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKInterstitialVideo.xcframework.zip",
      checksum: "3bae2ffb61ae7473a33cc841494a756fec4f8f86dafb40455da0167bf0b17ce4"
    ),
    .binaryTarget(
      name: "MTGSDKNativeAdvanced",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKNativeAdvanced.xcframework.zip",
      checksum: "390ce75be7b70bc0b5d667301fc72af06150e51774417742b77f6e8ae19ba6dd"
    ),
    .binaryTarget(
      name: "MTGSDKNewInterstitial",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKNewInterstitial.xcframework.zip",
      checksum: "dcbf200cc3cf5ec8cf815571300e7640b2e443119a74c97e7311c988a59ad8cc"
    ),
    .binaryTarget(
      name: "MTGSDKReward",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKReward.xcframework.zip",
      checksum: "193c71dad3d1659eae62d08c1f0f1931a1965eb78bc6a807f6e0f9dd73e056b9"
    ),
    .binaryTarget(
      name: "MTGSDKSplash",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MTGSDKSplash.xcframework.zip",
      checksum: "45bc22ffba2a32003a9015d5e2c552da6f478094faa421d3880d5543d613afbf"
    ),
    .binaryTarget(
      name: "MetaAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MetaAdapter.xcframework.zip",
      checksum: "9eef288c7205f014790a75ab6cb59ec5c27480e0cc4c1628356917f338415111"
    ),
    .binaryTarget(
      name: "MintegralAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MintegralAdapter.xcframework.zip",
      checksum: "6ce1ab86589dbdafcdcf149893e262923ea01e5a4268736a928d8ff4b4b08798"
    ),
    .binaryTarget(
      name: "MolocoAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MolocoAdapter.xcframework.zip",
      checksum: "254d34b910a579be7bf4e5ee382446852a52238313e949e2d7f80d6e9efc3386"
    ),
    .binaryTarget(
      name: "MolocoSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/MolocoSDK.xcframework.zip",
      checksum: "694db10e07d8f7ca7d46e40d377b99e89a18d1d81100122d4adc282e1d1ee22f"
    ),
    .binaryTarget(
      name: "PAGAdSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/PAGAdSDK.xcframework.zip",
      checksum: "83de3278c21ac0c545cb7ae466c3b8f55934007af2f2c718a21bc547200e8093"
    ),
    .binaryTarget(
      name: "PangleAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/PangleAdapter.xcframework.zip",
      checksum: "fb41d37c5b0e6d3feafb296def4d7e148517b7e1c9005128738b3d3b6fb93f92"
    ),
    .binaryTarget(
      name: "UnityAdapter",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/UnityAdapter.xcframework.zip",
      checksum: "3058598e3156bf099686a9f236c5b29f157c780dece3e38c2b12e355aa991a15"
    ),
    .binaryTarget(
      name: "UnityAds",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/UnityAds.xcframework.zip",
      checksum: "f1606cda4bfde35e321b55971d46d65a485d8b7b91c63036dcfc76c7b4bf5ac3"
    ),
    .binaryTarget(
      name: "UserMessagingPlatform",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/UserMessagingPlatform.xcframework.zip",
      checksum: "dfc8de8c3cc909deffda214d156a3f55b1ec2207c60025adf74f1801a63beeec"
    ),
    .binaryTarget(
      name: "VungleAdsSDK",
      url: "https://github.com/habitfactory/daro-ios-sdk/releases/download/1.1.53-spm/VungleAdsSDK.xcframework.zip",
      checksum: "bbe1b2e1a09c4ae564b6517a7f977c8d7df9c696e77ab9d5db78d29f2969fffb"
    ),
    .target(
      name: "DaroPackage",
      dependencies: [
        "AppLovinAdapter",
        "AppLovinSDK",
        "ChartboostAdapter",
        "ChartboostSDK",
        "DTBiOSSDK",
        "DTExchangeAdapter",
        "Daro",
        "FBAudienceNetwork",
        "FiveAd",
        "GoogleMobileAds",
        "IASDKCore",
        "InMobiAdapter",
        "InMobiSDK",
        "IronSource",
        "IronSourceAdQualitySDK",
        "IronSourceAdapter",
        "LiftoffMonetizeAdapter",
        "LineAdapter",
        "MTGSDK",
        "MTGSDKBanner",
        "MTGSDKBidding",
        "MTGSDKInterstitialVideo",
        "MTGSDKNativeAdvanced",
        "MTGSDKNewInterstitial",
        "MTGSDKReward",
        "MTGSDKSplash",
        "MetaAdapter",
        "MintegralAdapter",
        "MolocoAdapter",
        "MolocoSDK",
        "PAGAdSDK",
        "PangleAdapter",
        "UnityAdapter",
        "UnityAds",
        "UserMessagingPlatform",
        "VungleAdsSDK"
      ],
      path: "Sources/DaroPackage",
      resources: [
        .copy("Resources/Bundles")
      ],
      linkerSettings: [
      .linkedFramework("AVFAudio"),
      .linkedFramework("AVFoundation"),
      .linkedFramework("AVKit"),
      .linkedFramework("Accelerate"),
      .linkedFramework("AppTrackingTransparency"),
      .linkedFramework("AudioToolbox"),
      .linkedFramework("CFNetwork"),
      .linkedFramework("CoreFoundation"),
      .linkedFramework("CoreGraphics"),
      .linkedFramework("CoreHaptics"),
      .linkedFramework("CoreImage"),
      .linkedFramework("CoreLocation"),
      .linkedFramework("CoreMedia"),
      .linkedFramework("CoreMotion"),
      .linkedFramework("CoreTelephony"),
      .linkedFramework("CoreVideo"),
      .linkedFramework("MediaPlayer"),
      .linkedFramework("MessageUI"),
      .linkedFramework("Network"),
      .linkedFramework("QuartzCore"),
      .linkedFramework("SafariServices"),
      .linkedFramework("Security"),
      .linkedFramework("StoreKit"),
      .linkedFramework("SystemConfiguration"),
      .linkedFramework("WebKit"),
      .linkedLibrary("bz2"),
      .linkedLibrary("c++"),
      .linkedLibrary("c++abi"),
      .linkedLibrary("iconv"),
      .linkedLibrary("resolv"),
      .linkedLibrary("sqlite3"),
      .linkedLibrary("xml2"),
      .linkedLibrary("z"),
        .unsafeFlags(["-ObjC", "-weak_framework", "Combine", "-weak_framework", "CoreML", "-weak_framework", "CryptoKit", "-weak_framework", "DeviceCheck", "-weak_framework", "LocalAuthentication", "-weak_framework", "VideoToolbox"])
      ]
    )
  ]
)
