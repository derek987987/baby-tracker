import SwiftUI
import SwiftData
import Combine

@MainActor
class SummaryViewModel: ObservableObject {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchHistoricalData(for babyID: UUID) -> [LogEntry] {
        let descriptor = FetchDescriptor<LogEntry>(
            predicate: #Predicate { $0.babyID == babyID }
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }
}
