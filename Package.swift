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
            targets: ["zy_lib_idemia_face_ios_target","zy_lib_idemia_face_ios_bin" ] // Define el producto usando el target binario
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ZYTRUST/BiometricSDK.git", from: "4.34.16"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKAlgorithmPlugin_F6_0_IDD80.git", from: "4.34.6"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKFaceCapturePluginNormal.git", from: "4.34.6"),
        .package(url: "https://github.com/ZYTRUST/BiometricSDKUIFaceModePassiveCore.git", from: "2.3.7")
    ],
    targets: [
        .binaryTarget(
            name: "zy_lib_idemia_face_ios_bin",
            path: "Sources/zy_lib_idemia_face_ios.xcframework" // Ruta al archivo binario
        ),
        .target(
            name: "zy_lib_idemia_face_ios_target",
            path: "Sources/zy_lib_idemia_face_ios_target",
            resources: [.copy("zy_lib_idemia_face_ios.bundle")]// Incluir el bundle como recurso
        )
    ]
)
