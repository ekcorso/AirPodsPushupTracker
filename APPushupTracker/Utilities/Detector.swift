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
    
    private var dataStore = DataStore.shared
    
    private let motionManager: MotionManager

    private var downThreshold: Double = 0
    private var upThreshold: Double = 0
    private var pitchThreshold: Double = 0
    
    private var isUpwardPhase = false

    private var exerciseType: Exercise
    
    private var accelerationData: [Double]
    private var pitchData: [Double]
    
    init(for exercise: Exercise) {
        self.exerciseType = exercise
        
        self.accelerationData = [Double]()
        self.pitchData = [Double]()
        
        self.motionManager = MotionManager()
        
        motionManager.delegate = self
        
        // Initialize thresholds for detecting exercise of current type
        switch exerciseType {
        case is Pushup:
            let pushup = Pushup.shared
            self.downThreshold = pushup.downAccelerationThreshold
            self.upThreshold = pushup.upAccelerationThreshold
            self.pitchThreshold = pushup.pitchThreshold
        case is Squat:
            let squat = Squat.shared
            self.downThreshold = squat.downAccelerationThreshold
            self.upThreshold = squat.upAccelerationThreshold
            self.pitchThreshold = squat.pitchThreshold
        case is Burpee:
            let burpee = Burpee.shared
            self.downThreshold = burpee.downAccelerationThreshold
            self.upThreshold = burpee.upAccelerationThreshold
            self.pitchThreshold = burpee.pitchThreshold
        default:
            self.downThreshold = 0
            self.upThreshold = 0
            self.pitchThreshold = 0
        }
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
        case is Burpee:
            initializeBurpeeData()
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
    
    func initializeBurpeeData() {
        accelerationData = dataStore.retrieveBurpeeAccelerationData() ?? [Double]()
        pitchData = dataStore.retrieveBurpeePitchData() ?? [Double]()
    }
    
    func saveData() async {
        switch exerciseType {
        case is Pushup:
            await savePushupData()
        case is Squat:
            await saveSquatData()
        case is Burpee:
            await saveBurpeeData()
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
    
    func saveBurpeeData() async {
        await dataStore.saveBurpeePitchData(pitchData)
        await dataStore.saveBurpeeAccelerationData(accelerationData)
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

        isValidPosition = pitch < pitchThreshold
    }
}
