// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "YSideMenu",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YSideMenu",
            targets: ["YSideMenu"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/yml-org/YCoreUI.git",
            from: "1.7.0"
        ),
        .package(
            url: "https://github.com/yml-org/YMatterType.git",
            from: "1.6.0"
        )
    ],
    targets: [
        .target(
            name: "YSideMenu",
            dependencies: ["YCoreUI", "YMatterType"]
        ),
        .testTarget(
            name: "YSideMenuTests",
            dependencies: ["YSideMenu"]
        )
    ]
)
