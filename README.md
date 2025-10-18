# TravelBudgetApp

A SwiftUI-based iPhone application for planning travel budgets and tracking expenses per trip. Inspired by modern travel expense trackers, the sample app demonstrates how to group trips, manage currencies, and capture detailed spending records while travelling.

## Features

- **Travel overview** – List current and past trips with destination, duration, and total budget.
- **Budget dashboard** – Visualize the overall budget, spent amount, and remaining balance for each trip.
- **Expense tracking** – Log expenses with categories, member assignments, notes, and timestamps.
- **Sample data** – Preloaded destinations (Europe, South Korea) mirroring the reference screenshots to help you explore the UI quickly.

## Project structure

```
TravelBudgetApp/
├── Package.swift
└── Sources/
    └── App/
        ├── TravelBudgetAppApp.swift      # App entry point
        ├── Models/                       # Core data models (Travel, Expense, Traveler)
        ├── ViewModels/                   # Observable store with sample data
        └── Views/                        # SwiftUI screens and reusable components
```

The project is packaged as a SwiftPM iOS application (requires Xcode 15 or later). You can open the `Package.swift` file directly in Xcode to run the app on the simulator or a connected device.

## Getting started

1. Open `TravelBudgetApp/Package.swift` with Xcode 15+.
2. Select the **TravelBudgetApp** scheme.
3. Choose an iPhone simulator (e.g., iPhone 15 Pro) and press **Run**.

## Next steps

- Connect to a real backend or local persistence (e.g., Core Data, SwiftData) to store trips and expenses.
- Add budget pockets per currency, charts, and photo attachments to mirror the original inspiration fully.
- Localize currency formatting and interface strings for multilingual trips.
