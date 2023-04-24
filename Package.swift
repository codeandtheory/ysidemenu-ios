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
        .package(url: "https://github.com/adamayoung/swiftlint-plugin.git", from: "0.3.2")
    ],
    targets: [
        .target(
            name: "YSideMenu",
            dependencies: ["YCoreUI"],
            plugins: [
                        .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
                    ]
        ),
        .testTarget(
            name: "YSideMenuTests",
            dependencies: ["YSideMenu"]
        )
    ]
)
