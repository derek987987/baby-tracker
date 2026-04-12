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
}
