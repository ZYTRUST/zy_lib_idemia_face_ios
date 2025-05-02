// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "zy_lib_idemia_face_ios",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "zy_lib_idemia_face_ios",
            targets: ["zy_lib_idemia_face_ios_target" , "zy_lib_idemia_face_ios_bin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ZYTRUST/BiometricSDK.git", exact: "4.45.3"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKAlgorithmPlugin_F6_0_IDD80.git", exact: "4.45.2"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKFaceCapturePluginNormal.git", exact: "4.45.2"),
        .package(url: "https://github.com/realm/SwiftLint.git", exact: "0.55.0")
    ],
    ],
    targets: [
        .target(
            name: "zy_lib_idemia_face_ios_target",
            dependencies: [
                .product(name: "zyBiometricSDK", package: "BiometricSDK"),
                .product(name: "BiometricSDKAlgorithmPlugin_F6_0_IDD80", package: "BiometricSDKAlgorithmPlugin_F6_0_IDD80"),
                .product(name: "BiometricSDKFaceCapturePluginNormal", package: "BiometricSDKFaceCapturePluginNormal"),
                .product(name: "SwiftLint", package: "SwiftLint")
            ],
            path: "Sources/zy_lib_idemia_face_ios_target"
            ,
            resources: [
                .process("Resources")
            ]
        ),
        .binaryTarget(
            name: "zy_lib_idemia_face_ios_bin",
            path: "Sources/zy_lib_idemia_face_ios.xcframework"
        )
    ]
)
