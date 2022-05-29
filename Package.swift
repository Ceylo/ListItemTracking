// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ListItemTracking",
    platforms: [ .iOS(.v15)],
    products: [
        .library(name: "ListItemTracking", targets: ["ListItemTracking"]),
    ],
    targets: [
        .target(name: "ListItemTracking"),
    ]
)
