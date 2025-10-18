import SwiftUI

struct ExpenseFormView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var note: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var category: Expense.Category = .food
    @State private var selectedMembers: Set<Traveler> = []

    let travel: Travel
    let onSave: (Expense) -> Void

    init(travel: Travel, onSave: @escaping (Expense) -> Void) {
        self.travel = travel
        self.onSave = onSave
        _selectedMembers = State(initialValue: Set(travel.members))
        _category = State(initialValue: travel.expenses.first?.category ?? .food)
    }

    var body: some View {
        Form {
            Section("Expense Details") {
                TextField("Title", text: $title)
                TextField("Note", text: $note, axis: .vertical)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Category", selection: $category) {
                    ForEach(Expense.Category.allCases) { category in
                        Label(category.rawValue, systemImage: category.systemImageName)
                            .tag(category)
                    }
                }
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
            }

            Section("Members") {
                if travel.members.isEmpty {
                    Text("No travel members yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(travel.members) { member in
                        Toggle(isOn: Binding(
                            get: { selectedMembers.contains(member) },
                            set: { isSelected in
                                if isSelected {
                                    selectedMembers.insert(member)
                                } else {
                                    selectedMembers.remove(member)
                                }
                            }
                        )) {
                            Label(member.name, systemImage: member.avatarSystemImage)
                        }
                    }
                }
            }
        }
        .navigationTitle("New Expense")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveExpense() }
                    .disabled(!isFormValid)
            }
        }
    }

    private var isFormValid: Bool {
        guard let value = Decimal(string: amount), value > 0 else { return false }
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func saveExpense() {
        guard let value = Decimal(string: amount) else { return }
        let expense = Expense(
            title: title.isEmpty ? "Untitled Expense" : title,
            note: note,
            amount: CurrencyAmount(value: value, currencyCode: travel.currency.rawValue),
            date: date,
            category: category,
            members: Array(selectedMembers)
        )
        onSave(expense)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        ExpenseFormView(travel: SampleData.travels[0]) { _ in }
    }
}
