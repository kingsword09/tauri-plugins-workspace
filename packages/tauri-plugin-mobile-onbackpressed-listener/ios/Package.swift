// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tauri-plugin-mobile-onbackpressed-listener",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "tauri-plugin-mobile-onbackpressed-listener",
            type: .static,
            targets: ["tauri-plugin-mobile-onbackpressed-listener"]),
    ],
    dependencies: [
        .package(name: "Tauri", path: "../.tauri/tauri-api"),
        .package(name: "BackpressedKit", url: "https://github.com/kingsword09/BackpressedKit", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "tauri-plugin-mobile-onbackpressed-listener",
            dependencies: [
                .byName(name: "Tauri"),
                .byName(name: "BackpressedKit")
            ],
            path: "Sources")
    ]
)
