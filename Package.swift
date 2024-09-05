// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "zy_lib_idemia_face_ios",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "zy_lib_idemia_face_ios",
            targets: ["zy_lib_idemia_face_ios_target" , "zy_lib_idemia_face_ios_bin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ZYTRUST/BiometricSDK.git", from: "4.34.16"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKAlgorithmPlugin_F6_0_IDD80.git", from: "4.34.6"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKFaceCapturePluginNormal.git", from: "4.34.6"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKUIFaceModePassiveCore.git", from: "2.3.7")
    ],
    targets: [
        .target(
            name: "zy_lib_idemia_face_ios_target",
            dependencies: [
                .product(name: "zyBiometricSDK", package: "BiometricSDK"),
                .product(name: "BiometricSDKAlgorithmPlugin_F6_0_IDD80", package: "BiometricSDKAlgorithmPlugin_F6_0_IDD80"),
                .product(name: "BiometricSDKFaceCapturePluginNormal", package: "BiometricSDKFaceCapturePluginNormal"),
                .product(name: "BiometricSDKUIFaceModePassiveCore", package: "BiometricSDKUIFaceModePassiveCore")
            ],
            path: "Sources/zy_lib_idemia_face_ios_target"
            ,
            resources: [
                .copy("Sources/zy_lib_idemia_face_ios.bundle")
            ]
        ),
        .binaryTarget(
            name: "zy_lib_idemia_face_ios_bin",
            path: "Sources/zy_lib_idemia_face_ios.xcframework"
        )
    ]
)
