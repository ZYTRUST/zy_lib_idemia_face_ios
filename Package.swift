// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "zy_lib_idemia_face_ios",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "zy_lib_idemia_face_ios",
            targets: ["zy_lib_idemia_face_ios"]
        )
    ],
    dependencies: [
        // Dependencias de otros paquetes
    ],
    targets: [
        .binaryTarget(
            name: "zy_lib_idemia_face_ios",
            path: "zy_lib_idemia_face_ios.xcframework"
        )
    ]
)
