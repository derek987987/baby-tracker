import SwiftUI
import SwiftData

struct ManualEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    let babyID: UUID
    @State var eventType: EventType
    @State private var timestamp: Date = Date()
    @State private var amount: String = ""
    @State private var notes: String = ""
    @State private var side: Side = .left
    
    init(babyID: UUID, defaultType: EventType) {
        self.babyID = babyID
        self._eventType = State(initialValue: defaultType)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Activity", selection: $eventType.animation()) {
                    ForEach(EventType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                
                DatePicker("Time", selection: $timestamp)
                
                // Dynamic Input based on event type
                switch eventType {
                case .nursing:
                    Picker("Side", selection: $side) {
                        Text("Left").tag(Side.left)
                        Text("Right").tag(Side.right)
                    }
                    .pickerStyle(.segmented)
                case .bottle, .pumping:
                    TextField("Amount (ml)", text: $amount)
                        .keyboardType(.decimalPad)
                case .wetDiaper, .dirtyDiaper:
                    Text("Logging: \(eventType.rawValue.capitalized)")
                        .foregroundColor(.secondary)
                default:
                    EmptyView()
                }
                
                TextEditor(text: $notes)
                    .frame(height: 80)
                    .overlay(alignment: .topLeading) {
                        if notes.isEmpty { Text("Optional notes...").foregroundColor(.gray).padding(.top, 8) }
                    }
            }
            .navigationTitle("Log Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let entry = LogEntry(
                            babyID: babyID,
                            eventType: eventType,
                            timestamp: timestamp,
                            side: eventType == .nursing ? side : nil,
                            amount: Double(amount),
                            notes: notes
                        )
                        modelContext.insert(entry)
                        try? modelContext.save()
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        dismiss()
                    }
                }
            }
        }
    }
}
