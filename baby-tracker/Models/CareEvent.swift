import Foundation
import SwiftData

@Model
final class CareEvent {
    var id: UUID
    var timestamp: Date
    var type: String // Using String to represent Enum for SwiftData compatibility
    var metadata: [String: String]
    
    init(type: String, metadata: [String: String] = [:]) {
        self.id = UUID()
        self.timestamp = Date()
        self.type = type
        self.metadata = metadata
    }
}
