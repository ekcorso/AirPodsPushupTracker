//
//  ChartViewViewModelTests.swift
//  APPushupTrackerTests
//
//  Created by Emily Corso on 6/22/24.
//

import XCTest
@testable import APPushupTracker

final class ExerciseChartViewViewModelTests: XCTestCase {
    func testGetAveragePitch() async throws {
        // Arrange
        let pitches = [1, 1.5, 1.2, 0.95]
        let expectedAveragePitch = 1.1625
        
        // Act
        let result = ExerciseChartViewViewModel().getAveragePitch(pitches)
        
        // Assert
        XCTAssertEqual(expectedAveragePitch, result)
    }
}
