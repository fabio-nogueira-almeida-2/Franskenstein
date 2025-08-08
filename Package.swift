// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Frankenstein",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "FrankensteinApp", targets: ["FrankensteinApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/skiptools/skip.git", from: "1.6.5"),
        .package(url: "https://github.com/skiptools/skip-fuse-ui.git", from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "FrankensteinApp",
            dependencies: [
                .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .testTarget(
            name: "FrankensteinTests",
            dependencies: [
                "FrankensteinApp",
                .product(name: "SkipTest", package: "skip"),
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
    ]
) 