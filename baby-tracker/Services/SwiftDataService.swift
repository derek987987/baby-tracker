import Foundation
import SwiftData

final class SwiftDataService {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addEvent(_ event: CareEvent) {
        modelContext.insert(event)
    }
    
    func fetchEvents() throws -> [CareEvent] {
        let descriptor = FetchDescriptor<CareEvent>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
}
