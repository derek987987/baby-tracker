import Foundation
import SwiftData

struct SwiftDataService {
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveBabyProfile(_ profile: BabyProfile) {
        modelContext.insert(profile)
    }
    
    func saveLogEntry(_ entry: LogEntry) {
        modelContext.insert(entry)
    }
}
