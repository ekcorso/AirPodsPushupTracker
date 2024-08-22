//
//  ChartViewViewModelTests.swift
//  APPushupTrackerTests
//
//  Created by Emily Corso on 6/22/24.
//

import XCTest
@testable import APPushupTracker

final class ExerciseChartViewViewModelTests: XCTestCase {
    private let mockViewModel = ExerciseChartViewViewModelMock()
    
    override func setUp() {
    }
    
    override func tearDown() {
        mockViewModel.selectedExercises = [Exercise]()
    }
    
    func testGetAveragePitch() async throws {
        // Arrange
        let pitches = [1, 1.5, 1.2, 0.95]
        let expectedAveragePitch = 1.1625
        
        // Act
        let result = mockViewModel.getAveragePitch(pitches)
        
        // Assert
        XCTAssertEqual(expectedAveragePitch, result)
    }
        
    func testGetAveragePitchWithNoData() async throws {
        // Arrange
        let pitches = [Double]()
        let expectedAveragePitch = 0.0
        
        // Act
        let result = mockViewModel.getAveragePitch(pitches)
        
        // Assert
        XCTAssertEqual(expectedAveragePitch, result)
    }
    
    func testInitializeViewModelWithNoSelectedExercises() async throws {
        
        XCTAssertEqual(mockViewModel.updatePushupDataCallCount, 0)
    }
    
    func testInitializeViewModelWithPushupsSelected() async throws {
        // Act
        mockViewModel.selectedExercises = [Pushup.shared]
        
        // Assert
        XCTAssertEqual(mockViewModel.updatePushupDataCallCount, 1)
        XCTAssertEqual(mockViewModel.updateSquatDataCallCount, 0)

    }
    
    func testInitializeViewModelWithSquatsSelected() async throws {
        // Act
        mockViewModel.selectedExercises = [Squat.shared]
        
        // Assert
        XCTAssertEqual(mockViewModel.updateSquatDataCallCount, 1)
        XCTAssertEqual(mockViewModel.updatePushupDataCallCount, 0)
    }
}
