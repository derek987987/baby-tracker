import XCTest
import SwiftData
@testable import baby_tracker

@MainActor
final class DiaperLoggingTests: XCTestCase {
    var container: ModelContainer!
    
    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: LogEntry.self, BabyProfile.self, configurations: config)
    }

    func testLogDiaperCreatesEntry() {
        let baby = BabyProfile(name: "Test Baby", birthDate: Date())
        container.mainContext.insert(baby)
        
        let entry = LogEntry(babyID: baby.id, eventType: .wetDiaper)
        container.mainContext.insert(entry)
        
        let descriptor = FetchDescriptor<LogEntry>()
        let logs = try? container.mainContext.fetch(descriptor)
        
        XCTAssertEqual(logs?.count, 1, "LogEntry should be persisted")
        XCTAssertEqual(logs?.first?.eventType, .wetDiaper)
    }
}
