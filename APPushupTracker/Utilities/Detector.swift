//
//  Detector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/30/24.
//

import Foundation
import SwiftUI

@Observable
class Detector {
    var isActive: Bool = false
    var isValidPosition: Bool = false
    var count: Int = 0
    var dataStore = DataStore.shared
    
    let motionManager: MotionManager

    var downThreshold: Double
    var upThreshold: Double
    var proneThreshold: Double
    
    var isUpwardPhase = false

    var exerciseType: Exercise // This type is not quite correct
    
    var accelerationData: [Double]
    var pitchData: [Double]
    
    init(for exercise: Exercise) {
        self.exerciseType = exercise
        
        self.accelerationData = [Double]()
        self.pitchData = [Double]()
        
        self.motionManager = MotionManager()
        
        motionManager.delegate = self
        
        self.downThreshold = 0
        self.upThreshold = 0
        self.proneThreshold = 0
    }
    
    deinit {
        endSession()
    }
    
    // Must call this before utilizing this class
    func initializeData() {
        switch exerciseType {
        case is Pushup:
            initializePushupData()
        case is Squat:
            initializeSquatData()
        default:
            fatalError("Could not initialize movement data. Exercise type is not recognized.")
        }
    }
    
    func initializePushupData() {
        accelerationData = dataStore.retrievePushupAccelerationData() ?? [Double]()
        pitchData = dataStore.retrievePushupPitchData() ?? [Double]()
    }
    
    func initializeSquatData() {
        accelerationData = dataStore.retrieveSquatAccelerationData() ?? [Double]()
        pitchData = dataStore.retrieveSquatPitchData() ?? [Double]()
    }
    
    func saveData() async {
        switch exerciseType {
        case is Pushup:
            await savePushupData()
        case is Squat:
            await saveSquatData()
        default:
            fatalError("Could not save. Exercise type is not recognized.")
        }
    }
    
    func savePushupData() async {
        await dataStore.savePushupPitchData(pitchData)
        await dataStore.savePushupAccelerationData(accelerationData)
    }
    
    func saveSquatData() async {
        await dataStore.saveSquatPitchData(pitchData)
        await dataStore.saveSquatAccelerationData(accelerationData)
    }
    
    func startSession() {
        print("Starting session...")
        motionManager.startUpdates()
        isActive = true
    }
    
    func endSession() {
        motionManager.stopUpdates()
        isActive = false
        
        print("Session ended.")
    }
    
    func isDeviceMotionAvailable() -> Bool {
        return motionManager.isDeviceMotionAvailable()
    }
    
    func incrementCount() {
        count += 1
    }
    
    func resetCount() {
        count = 0
    }
}

extension Detector: MotionManagerDelegate {
    func didUpdateAccelerationY(_ accelerationY: Double) {
        accelerationData.append(accelerationY)

        if accelerationY < downThreshold && !isUpwardPhase {
            // User is movintg downward in a pushup
            isUpwardPhase = true
        } else if accelerationY > upThreshold && isUpwardPhase {
            incrementCount()
            isUpwardPhase = false
        }
    }

    func didUpdatePitch(_ pitch: Double) {
        pitchData.append(pitch)

        isValidPosition = pitch < proneThreshold
    }
}
