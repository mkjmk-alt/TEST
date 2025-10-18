// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TravelBudgetApp",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .iOSApplication(
            name: "TravelBudgetApp",
            targets: ["App"],
            bundleIdentifier: "com.example.travelbudget",
            teamIdentifier: "ABCDE12345",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder,
            accentColor: .presetColor(.purple),
            supportedDeviceFamilies: [
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .portraitUpsideDown,
                .landscapeLeft,
                .landscapeRight
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "App",
            path: "Sources/App"
        )
    ]
)
