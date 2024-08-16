//
//  ExerciseChartViewViewModel.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/30/24.
//

import Foundation
import Observation

@Observable
class ExerciseChartViewViewModel {
    let dataStore: DataStore = DataStore.shared
    
    // Can I cap the size of this array at 3 exercises?
    var selectedExercises: [Exercise] = [Exercise]() {
        didSet {
            // Is this necessary? Will this trigger the updates in the body property?
            refreshDataForSelectedExercises()
        }
    }
    
    var pushupAccelerationData: [Double] = [0.0]
    var pushupPitchData: [Double] = [0.0]
    
    var pushupAvgPitch: Double = 0
    var pushupAvgUpAcceleration: Double = 0
    var pushupAvgDownAcceleration: Double = 0
    
    var squatAccelerationData: [Double] = [0.0]
    var squatPitchData: [Double] = [0.0]
    
    var squatAvgPitch: Double = 0
    var squatAvgUpAcceleration: Double = 0
    var squatAvgDownAcceleration: Double = 0
    
    init() {
        self.refreshDataForSelectedExercises()
    }
    
    func getAveragePitch(_ data: [Double]) -> Double {
        guard data.count != 0 else { return 0 }
        
        let pitchSum = data.reduce(0, +)
        let pitchCount = Double(data.count)
        
        return Double(pitchSum/pitchCount)
    }
    
    // Rename to refreshDataForSelectedExercises
    func refreshDataForSelectedExercises() {
        guard selectedExercises.count != 0 else { return }
        
        for exercise in selectedExercises {
            switch exercise {
            case is Pushup:
                updatePushupData()
            case is Squat:
                updateSquatData()
            default:
                fatalError("Can't update data-- Exercise type not found.")
            }
        }
    }
    
    func updatePushupData() {
        self.pushupAccelerationData = dataStore.retrievePushupAccelerationData() ?? [Double]()
        self.pushupPitchData = dataStore.retrievePushupPitchData() ?? [Double]()
        
        self.pushupAvgPitch = getAveragePitch(pushupPitchData)
        self.pushupAvgUpAcceleration = getAvgUpAcceleration(pushupAccelerationData)
        self.pushupAvgDownAcceleration = getAvgDownAcceleration(pushupAccelerationData)
    }
    
    func updateSquatData() {
        self.squatAccelerationData = dataStore.retrieveSquatAccelerationData() ?? [Double]()
        self.squatPitchData = dataStore.retrieveSquatPitchData() ?? [Double]()
        
        self.squatAvgPitch = getAveragePitch(squatPitchData)
        self.squatAvgUpAcceleration = getAvgUpAcceleration(squatAccelerationData)
        self.squatAvgDownAcceleration = getAvgDownAcceleration(squatAccelerationData)
    }
    
    // Should the following two funcs be paramaterized to control for which values are thrown out, or can these basic ranges be used for all exercises? Perhaps at least for Squats + Pushups...
    private func getAvgUpAcceleration(_ data: [Double]) -> Double {
        guard data.count != 0 else { return 0 }

        let upAccData = data.filter() { $0 >= 0.3 }
        // We can throw out 0 here because if the acc is 0 the user isn't moving anyway, so it's not relevant to the rep threshold
        // Throwing out some of the other small values here. didUpdateAccelerationY is very sensitive
        
        let avgUpAcc = Double(upAccData.reduce(0, +)) / Double(upAccData.count)
        
        return avgUpAcc
    }
    
    private func getAvgDownAcceleration(_ data: [Double]) -> Double {
        guard data.count != 0 else { return 0 }

        let downAccData = data.filter() { $0 <= -0.7 }
        // We can throw out 0 here because if the acc is 0 the user isn't moving anyway, so it's not relevant to the rep threshold
        // Throwing out some of the other small values here. didUpdateAccelerationY is very sensitive

        let avgDownAcc = Double(downAccData.reduce(0, +)) / Double(downAccData.count)
        
        return avgDownAcc
    }
}
