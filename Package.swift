// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftyChrono",
    dependencies: [],
    targets:
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),s
        ]
    ]
)
