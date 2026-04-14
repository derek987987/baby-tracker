import SwiftUI
import SwiftData

struct EditEntrySheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    let entry: LogEntry
    @State private var eventType: EventType
    @State private var timestamp: Date
    @State private var amount: String
    @State private var notes: String
    
    init(entry: LogEntry) {
        self.entry = entry
        _eventType = State(initialValue: entry.eventType)
        _timestamp = State(initialValue: entry.timestamp)
        _amount = State(initialValue: entry.amount != nil ? String(entry.amount!) : "")
        _notes = State(initialValue: entry.notes ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Activity", selection: $eventType) {
                    ForEach(EventType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                DatePicker("Time", selection: $timestamp)
                TextField("Amount (ml)", text: $amount)
                    .keyboardType(.decimalPad)
                TextEditor(text: $notes)
                    .frame(height: 100)
                
                Button("Delete Entry", role: .destructive) {
                    modelContext.delete(entry)
                    try? modelContext.save()
                    dismiss()
                }
            }
            .navigationTitle("Edit Entry")
            .toolbar {
                Button("Save") {
                    entry.eventType = eventType
                    entry.timestamp = timestamp
                    entry.amount = Double(amount)
                    entry.notes = notes
                    try? modelContext.save()
                    dismiss()
                }
            }
        }
    }
}
