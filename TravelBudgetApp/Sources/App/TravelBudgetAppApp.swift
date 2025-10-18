import SwiftUI

@main
struct TravelBudgetAppApp: App {
    @StateObject private var store = TravelStore()

    var body: some Scene {
        WindowGroup {
            TravelListView()
                .environmentObject(store)
        }
    }
}
