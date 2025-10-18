import SwiftUI

struct TravelListView: View {
    @EnvironmentObject private var store: TravelStore

    var body: some View {
        NavigationStack {
            List {
                Section("Ongoing") {
                    ForEach(store.travels.filter { $0.endDate >= Date() }) { travel in
                        NavigationLink(value: travel) {
                            TravelCardView(travel: travel)
                        }
                    }
                }

                Section("Past Trips") {
                    ForEach(store.travels.filter { $0.endDate < Date() }) { travel in
                        NavigationLink(value: travel) {
                            TravelCardView(travel: travel)
                        }
                    }
                }
            }
            .navigationDestination(for: Travel.self) { travel in
                TravelDetailView(travel: travel)
                    .environmentObject(store)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Travels")
        }
    }
}

private struct TravelCardView: View {
    let travel: Travel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(travel.name)
                .font(.headline)
            Text(travel.destination)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Label("\(travel.durationInDays) days", systemImage: "calendar")
                Spacer()
                Text(travel.budget.formatted)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        TravelListView()
            .environmentObject(TravelStore())
    }
}
