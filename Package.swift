// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: ["KeychainAccess"]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)
