import SwiftUI

struct TravelDetailView: View {
    @EnvironmentObject private var store: TravelStore
    @State private var travel: Travel
    @State private var isAddingExpense = false

    init(travel: Travel) {
        _travel = State(initialValue: travel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                budgetSummary
                expenseSection
            }
            .padding()
        }
        .navigationTitle(travel.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddingExpense = true
                } label: {
                    Label("Add Expense", systemImage: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $isAddingExpense) {
            NavigationStack {
                ExpenseFormView(travel: travel) { expense in
                    store.addExpense(expense, to: travel)
                    if let updatedTravel = store.travels.first(where: { $0.id == travel.id }) {
                        self.travel = updatedTravel
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
        .onChange(of: store.travels) { travels in
            if let updatedTravel = travels.first(where: { $0.id == travel.id }) {
                travel = updatedTravel
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(travel.destination)
                .font(.title2)
                .fontWeight(.semibold)
            Text(dateRange)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            memberAvatars
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var budgetSummary: some View {
        BudgetSummaryCard(budget: travel.budget, spent: travel.spentAmount, currency: travel.currency)
    }

    private var expenseSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Expenses")
                .font(.headline)
            if travel.expenses.isEmpty {
                ContentUnavailableView(
                    "No expenses yet",
                    systemImage: "creditcard",
                    description: Text("Tap the add button to track your first expense.")
                )
            } else {
                ForEach(travel.expenses.sorted(by: { $0.date > $1.date })) { expense in
                    ExpenseRow(expense: expense)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                        )
                }
            }
        }
    }

    private var dateRange: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: travel.startDate)) - \(formatter.string(from: travel.endDate))"
    }

    private var memberAvatars: some View {
        HStack {
            ForEach(travel.members) { member in
                Label(member.name, systemImage: member.avatarSystemImage)
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .padding(6)
                    .background(
                        Circle()
                            .fill(.thinMaterial)
                    )
            }
        }
    }
}

#Preview {
    NavigationStack {
        TravelDetailView(travel: SampleData.travels[0])
            .environmentObject(TravelStore())
    }
}
