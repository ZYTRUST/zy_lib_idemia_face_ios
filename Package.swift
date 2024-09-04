// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "zy_lib_idemia_face_ios",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "zy_lib_idemia_face_ios",
            targets: ["zy_lib_idemia_face_ios_target"]  // Usa el target que tiene las dependencias
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ZYTRUST/BiometricSDK.git", from: "4.34.10"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKAlgorithmPlugin_F6_0_IDD80.git", from: "4.34.4"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKFaceCapturePluginNormal.git", from: "4.34.4"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKUIFaceModePassiveCore.git", from: "2.3.5"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.1")
    ],
    targets: [
        .binaryTarget(
            name: "zy_lib_idemia_face_ios",
            path: "zy_lib_idemia_face_ios.xcframework"
        ),
        .target(
            name: "zy_lib_idemia_face_ios_target",
            dependencies: [
                .product(name: "BiometricSDKAlgorithmPlugin_F6_0_IDD80", package: "BiometricSDKAlgorithmPlugin_F6_0_IDD80"),
                .product(name: "BiometricSDKFaceCapturePluginNormal", package: "BiometricSDKFaceCapturePluginNormal"),
                .product(name: "BiometricSDKUIFaceModePassiveCore", package: "BiometricSDKUIFaceModePassiveCore"),
                .product(name: "Lottie", package: "lottie-ios")
            ]
        )
    ]
)
