//
//  ExerciseChartViewViewModelMock.swift
//  APPushupTrackerTests
//
//  Created by Emily Corso on 8/12/24.
//

import XCTest
@testable import APPushupTracker

class ExerciseChartViewViewModelMock: ExerciseChartViewViewModel {
    var updatePushupDataCallCount = 0
    var updateSquatDataCallCount = 0
    
    override func updatePushupData() {
        updatePushupDataCallCount += 1
    }
 
    override func updateSquatData() {
        updateSquatDataCallCount += 1
    }
}
