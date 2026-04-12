import SwiftUI
import SwiftData

struct ManualEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    let babyID: UUID
    @State private var eventType: EventType = .nursing
    @State private var timestamp: Date = Date()
    @State private var amount: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $eventType) {
                    ForEach(EventType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                DatePicker("Time", selection: $timestamp)
                TextField("Amount (ml)", text: $amount)
                    .keyboardType(.decimalPad)
                TextEditor(text: $notes)
                    .frame(minHeight: 100)
            }
            .navigationTitle("Manual Entry")
            .toolbar {
                Button("Save") {
                    let entry = LogEntry(babyID: babyID, eventType: eventType, timestamp: timestamp, amount: Double(amount), notes: notes)
                    modelContext.insert(entry)
                    try? modelContext.save()
                    dismiss()
                }
            }
        }
    }
}
