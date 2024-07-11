//
//  DataStorageTests.swift
//  APPushupTrackerTests
//
//  Created by Emily Corso on 6/22/24.
//

import XCTest
@testable import APPushupTracker

final class DataStorageTests: XCTestCase {
    let dataStore = DataStore()
    
    func testGetAveragePitch() async throws {
        // Arrange
        let pitches = [1, 1.5, 1.2, 0.95]
        let expectedAveragePitch = 1.1625
        
        // Act
        let result = await PushupChartViewViewModel(dataStore: dataStore).getAveragePitch(pitches)
        
        // Assert
        XCTAssertEqual(expectedAveragePitch, result)
    }
}
