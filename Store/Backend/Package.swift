// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Backend",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.1.3")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMinor(from: "3.1.4")),
        .package(url: "https://github.com/mxcl/PromiseKit.git", .upToNextMinor(from: "5.0.3")),
        .package(url: "https://github.com/OpenKitten/Meow.git", .upToNextMinor(from: "1.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Backend",
            dependencies: ["Kitura", "PromiseKit", "Meow", "SwiftyJSON"]),
    ]
)
