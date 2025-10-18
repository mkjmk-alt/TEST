import Foundation

struct Travel: Identifiable, Hashable {
    let id: UUID
    var name: String
    var destination: String
    var startDate: Date
    var endDate: Date
    var members: [Traveler]
    var budget: CurrencyAmount
    var currency: Currency
    var expenses: [Expense]

    init(
        id: UUID = UUID(),
        name: String,
        destination: String,
        startDate: Date,
        endDate: Date,
        members: [Traveler],
        budget: CurrencyAmount,
        currency: Currency,
        expenses: [Expense] = []
    ) {
        self.id = id
        self.name = name
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.members = members
        self.budget = budget
        self.currency = currency
        self.expenses = expenses
    }

    var durationInDays: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day.map { $0 + 1 } ?? 1
    }

    var spentAmount: Decimal {
        expenses.reduce(0) { $0 + $1.amount.value }
    }

    var remainingAmount: Decimal {
        max(budget.value - spentAmount, 0)
    }
}

struct Traveler: Identifiable, Hashable {
    let id: UUID
    var name: String
    var avatarSystemImage: String

    init(id: UUID = UUID(), name: String, avatarSystemImage: String) {
        self.id = id
        self.name = name
        self.avatarSystemImage = avatarSystemImage
    }
}

struct CurrencyAmount: Hashable {
    var value: Decimal
    var currencyCode: String

    static func formatted(_ amount: Decimal, code: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        formatter.maximumFractionDigits = 2
        return formatter.string(for: amount as NSDecimalNumber) ?? "\(amount) \(code)"
    }

    var formatted: String {
        Self.formatted(value, code: currencyCode)
    }
}

enum Currency: String, CaseIterable, Identifiable {
    case usd = "USD"
    case eur = "EUR"
    case krw = "KRW"
    case chf = "CHF"
    case gbp = "GBP"
    case jpy = "JPY"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .usd: return "\u{24}"
        case .eur: return "\u{20AC}"
        case .krw: return "\u{20A9}"
        case .chf: return "CHF"
        case .gbp: return "\u{A3}"
        case .jpy: return "\u{A5}"
        }
    }
}
