import Foundation
import SwiftData

enum EventType: String, Codable, CaseIterable {
    case sleep, nursing, bottle, wetDiaper, dirtyDiaper, solidFood
}

enum Side: String, Codable, CaseIterable {
    case left, right
}

@Model
final class LogEntry {
    var id: UUID
    var babyID: UUID
    var eventType: EventType
    var timestamp: Date
    var duration: TimeInterval?
    var side: Side?
    var amount: Double?
    var notes: String?
    
    init(babyID: UUID, eventType: EventType, timestamp: Date = Date(), duration: TimeInterval? = nil, side: Side? = nil, amount: Double? = nil, notes: String? = nil) {
        self.id = UUID()
        self.babyID = babyID
        self.eventType = eventType
        self.timestamp = timestamp
        self.duration = duration
        self.side = side
        self.amount = amount
        self.notes = notes
    }
}
