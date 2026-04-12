import Foundation
import SwiftData

@Model
final class BabyProfile {
    var id: UUID
    var name: String
    var birthDate: Date
    var isActive: Bool
    
    init(name: String, birthDate: Date, isActive: Bool = true) {
        self.id = UUID()
        self.name = name
        self.birthDate = birthDate
        self.isActive = isActive
    }
}
