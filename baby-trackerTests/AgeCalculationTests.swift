import XCTest
@testable import baby_tracker

final class AgeCalculationTests: XCTestCase {
    
    func testAgeCalculationInDays() {
        let birthDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        let profile = BabyProfile(name: "Test", birthDate: birthDate)
        
        // Simple age calculation helper (could be added to BabyProfile extension)
        let components = Calendar.current.dateComponents([.day], from: profile.birthDate, to: Date())
        XCTAssertEqual(components.day, 10, "Age should be 10 days")
    }
}
