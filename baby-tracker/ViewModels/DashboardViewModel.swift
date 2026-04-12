import Foundation
import SwiftData
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {
    private var modelContext: ModelContext
    @Published var events: [CareEvent] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchEvents()
    }
    
    func fetchEvents() {
        let descriptor = FetchDescriptor<CareEvent>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        do {
            self.events = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch events: \(error)")
        }
    }
    
    func lastEvent(type: String) -> CareEvent? {
        events.first(where: { $0.type == type })
    }
    
    func timeSinceLastEvent(type: String) -> String {
        guard let last = lastEvent(type: type) else { return "Never" }
        let interval = Int(Date().timeIntervalSince(last.timestamp) / 60)
        return "\(interval)m ago"
    }

    func logEvent(type: String, metadata: [String: String] = [:]) {
        let event = CareEvent(type: type, metadata: metadata)
        modelContext.insert(event)
        try? modelContext.save()
        fetchEvents()
    }
}
