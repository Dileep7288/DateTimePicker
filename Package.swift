// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DateTimePicker",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DateTimePicker",
            targets: ["DateTimePicker"]
        ),
    ],
    targets: [
        .target(
            name: "DateTimePicker",
            path: "Sources/DateTimePicker"
        )
    ]
)
