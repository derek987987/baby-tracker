import Foundation
import SwiftData

@Model
final class DailySummary {
    var date: Date
    var totalSleepDuration: TimeInterval
    var totalFeedingVolume: Double
    
    init(date: Date, totalSleepDuration: TimeInterval = 0, totalFeedingVolume: Double = 0) {
        self.date = date
        self.totalSleepDuration = totalSleepDuration
        self.totalFeedingVolume = totalFeedingVolume
    }
}
