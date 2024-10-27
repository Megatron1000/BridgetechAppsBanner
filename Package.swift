// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BridgetechAppsBanner",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v11),
        .tvOS(.v16),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "BridgetechAppsBanner",
            targets: ["BridgetechAppsBanner"]),
    ],
    targets: [
        .target(
            name: "BridgetechAppsBanner",
            resources: [
                .process("whitenoise.png"),
                .process("off.png"),
                .process("bloodpressure.png"),
                .process("cluedup.png"),
                .process("perfectpitch.png"),
                .process("puzzle.png"),
            ]),
    ]
)
