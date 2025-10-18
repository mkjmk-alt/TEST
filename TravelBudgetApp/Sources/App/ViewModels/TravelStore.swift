import Foundation

final class TravelStore: ObservableObject {
    @Published private(set) var travels: [Travel]

    init(travels: [Travel] = SampleData.travels) {
        self.travels = travels
    }

    func addExpense(_ expense: Expense, to travel: Travel) {
        guard let index = travels.firstIndex(where: { $0.id == travel.id }) else { return }
        travels[index].expenses.append(expense)
    }

    func updateTravel(_ travel: Travel) {
        guard let index = travels.firstIndex(where: { $0.id == travel.id }) else { return }
        travels[index] = travel
    }
}

enum SampleData {
    static let travels: [Travel] = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        let members = [
            Traveler(name: "Alice", avatarSystemImage: "person.circle"),
            Traveler(name: "Ben", avatarSystemImage: "person.circle.fill")
        ]

        let europe = Travel(
            name: "Europe",
            destination: "Italy, France, Austria",
            startDate: formatter.date(from: "2025/07/08") ?? Date(),
            endDate: formatter.date(from: "2025/07/28") ?? Date(),
            members: members,
            budget: CurrencyAmount(value: 3500, currencyCode: Currency.eur.rawValue),
            currency: .eur,
            expenses: [
                Expense(
                    title: "Venice Gondola Ride",
                    note: "Evening ride across the canal",
                    amount: CurrencyAmount(value: 150, currencyCode: Currency.eur.rawValue),
                    date: formatter.date(from: "2025/07/10") ?? Date(),
                    category: .sightseeing,
                    members: members
                ),
                Expense(
                    title: "Paris Cafe",
                    note: "Afternoon coffee and pastries",
                    amount: CurrencyAmount(value: 35, currencyCode: Currency.eur.rawValue),
                    date: formatter.date(from: "2025/07/15") ?? Date(),
                    category: .food,
                    members: members
                )
            ]
        )

        let korea = Travel(
            name: "South Korea",
            destination: "Seoul",
            startDate: formatter.date(from: "2025/08/08") ?? Date(),
            endDate: formatter.date(from: "2025/08/28") ?? Date(),
            members: members,
            budget: CurrencyAmount(value: 4000000, currencyCode: Currency.krw.rawValue),
            currency: .krw,
            expenses: [
                Expense(
                    title: "Starfield Lunch",
                    note: "Sandwich at Starfield Coex Mall",
                    amount: CurrencyAmount(value: 8000, currencyCode: Currency.krw.rawValue),
                    date: formatter.date(from: "2025/08/08") ?? Date(),
                    category: .food,
                    members: members
                ),
                Expense(
                    title: "T-money top up",
                    note: "Subway pass recharge",
                    amount: CurrencyAmount(value: 50000, currencyCode: Currency.krw.rawValue),
                    date: formatter.date(from: "2025/08/09") ?? Date(),
                    category: .transport,
                    members: members
                )
            ]
        )

        return [europe, korea]
    }()
}
