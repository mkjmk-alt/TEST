import SwiftUI

struct BudgetSummaryCard: View {
    let budget: CurrencyAmount
    let spent: Decimal
    let currency: Currency

    private var remaining: Decimal {
        max(budget.value - spent, 0)
    }

    private var progress: Double {
        guard budget.value > 0 else { return 0 }
        let ratio = (spent as NSDecimalNumber).doubleValue / (budget.value as NSDecimalNumber).doubleValue
        return min(max(ratio, 0), 1)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Budget")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(budget.formatted)
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Remaining")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(CurrencyAmount.formatted(remaining, code: currency.rawValue))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                ProgressView(value: progress)
                    .tint(.purple)
                HStack {
                    Label("Spent", systemImage: "creditcard")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(CurrencyAmount.formatted(spent, code: currency.rawValue))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.purple.opacity(0.15), .purple.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }
}

#Preview {
    BudgetSummaryCard(
        budget: CurrencyAmount(value: 3500, currencyCode: Currency.eur.rawValue),
        spent: 2159.61,
        currency: .eur
    )
    .padding()
}
