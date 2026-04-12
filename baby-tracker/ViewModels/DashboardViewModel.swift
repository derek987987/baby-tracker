import SwiftUI
import SwiftData
import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func logEvent(_ eventType: EventType, babyID: UUID) {
        let entry = LogEntry(babyID: babyID, eventType: eventType)
        modelContext.insert(entry)
        try? modelContext.save()
    }
    
    func logFeeding(babyID: UUID, type: EventType, amount: Double? = nil, side: Side? = nil) {
        let entry = LogEntry(babyID: babyID, eventType: type, side: side, amount: amount)
        modelContext.insert(entry)
        try? modelContext.save()
    }
}
