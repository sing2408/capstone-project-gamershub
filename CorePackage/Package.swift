// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorePackage",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "CorePackage",
            targets: ["CorePackage"]),
    ],
    targets: [
        .target(
            name: "CorePackage",
            dependencies: [],
            resources: [
                .process("Data/Models/GamersHubDataModel.xcdatamodel")
            ]
        ),
        .testTarget(
            name: "CorePackageTests",
            dependencies: ["CorePackage"]
        ),
    ]
)
