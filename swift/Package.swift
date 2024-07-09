// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VideoMetadataFetcher",
    platforms: [
        .macOS(.v10_15) // Or the appropriate version for your environment
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "VideoMetadataFetcher",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-enable-experimental-concurrency"])
            ]
        )
    ]
)
