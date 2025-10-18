import Foundation

struct Expense: Identifiable, Hashable {
    enum Category: String, CaseIterable, Identifiable {
        case food = "Food"
        case shopping = "Shopping"
        case transport = "Transport"
        case sightseeing = "Sightseeing"
        case stay = "Stay"
        case flight = "Flight"
        case misc = "Misc"

        var id: String { rawValue }

        var systemImageName: String {
            switch self {
            case .food: return "fork.knife"
            case .shopping: return "bag"
            case .transport: return "bus"
            case .sightseeing: return "binoculars"
            case .stay: return "bed.double"
            case .flight: return "airplane"
            case .misc: return "ellipsis.circle"
            }
        }
    }

    let id: UUID
    var title: String
    var note: String
    var amount: CurrencyAmount
    var date: Date
    var category: Category
    var members: [Traveler]

    init(
        id: UUID = UUID(),
        title: String,
        note: String = "",
        amount: CurrencyAmount,
        date: Date,
        category: Category,
        members: [Traveler] = []
    ) {
        self.id = id
        self.title = title
        self.note = note
        self.amount = amount
        self.date = date
        self.category = category
        self.members = members
    }
}
