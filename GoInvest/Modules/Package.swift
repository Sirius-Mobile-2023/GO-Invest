// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
            .iOS(.v16)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Modules",
            targets: ["DomainModels", "QuoteClient", "Quotes", "Profile", "QuoteDetail", "Theme"]
        )
    ],
    dependencies: [
      .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DomainModels",
            dependencies: []
        ),
        .target(
            name: "QuoteClient",
            dependencies: ["DomainModels"]
        ),
        .target(
            name: "Quotes",
            dependencies: ["Theme", "DomainModels"]
        ),
        .target(
            name: "Profile",
            dependencies: []
        ),
        .target(
            name: "QuoteDetail",
            dependencies: ["Theme"]
        ),
        .target(
            name: "Theme",
            dependencies: []
        ),

    ]
)
