import SwiftUI

struct ExpenseRow: View {
    let expense: Expense

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: expense.date)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: expense.category.systemImageName)
                .font(.title2)
                .foregroundStyle(.purple)
                .frame(width: 36, height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.purple.opacity(0.1))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.headline)
                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if !expense.note.isEmpty {
                    Text(expense.note)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if !expense.members.isEmpty {
                    HStack {
                        ForEach(expense.members) { member in
                            Label(member.name, systemImage: member.avatarSystemImage)
                                .labelStyle(.iconOnly)
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Text(expense.amount.formatted)
                .font(.headline)
        }
    }
}

#Preview {
    ExpenseRow(
        expense: SampleData.travels[0].expenses[0]
    )
    .padding()
}
