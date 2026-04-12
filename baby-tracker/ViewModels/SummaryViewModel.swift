import Foundation
import SwiftData
import Combine

final class SummaryViewModel: ObservableObject {
    @Published var totalSleepHours: Double = 0
    @Published var totalFeedingVolume: Double = 0
    
    func calculateSummary(for events: [CareEvent]) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let todayEvents = events.filter { calendar.isDate($0.timestamp, inSameDayAs: today) }
        
        totalSleepHours = todayEvents
            .filter { $0.type == "Sleep" }
            .compactMap { Double($0.metadata["duration"] ?? "0") }
            .reduce(0, +)
            
        totalFeedingVolume = todayEvents
            .filter { $0.type == "Feeding" }
            .compactMap { Double($0.metadata["volume"] ?? "0") }
            .reduce(0, +)
    }
}
