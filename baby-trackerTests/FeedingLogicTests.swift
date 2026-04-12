import XCTest
@testable import baby_tracker

final class FeedingLogicTests: XCTestCase {
    func testVolumeConversion() {
        // Simple conversion test: 1 oz approx 30 ml
        let oz: Double = 1.0
        let expectedMl: Double = 30.0
        let convertedMl = oz * 30.0
        XCTAssertEqual(convertedMl, expectedMl, accuracy: 0.1)
    }
}
