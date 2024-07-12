//
//  PushupsDetector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/19/24.
//

import SwiftUI

@Observable
class PushupsDetector {
    var isActive = false
    
    var count = 0
    
    var accelerationData: [Double]
    var pitchData: [Double]
    let dataStore = DataStore.shared
    
    var isValidPosition = false
    
    private let motionManager: MotionManager

    private var isPushupPhase = false
    
    private let downThreshold: Double = -0.7
    private let upThreshold: Double = 0.3
    
    private let proneThreshold: Double = -0.8
    
    init() {
        self.accelerationData = [Double]()
        self.pitchData = [Double]()
        
        self.motionManager = MotionManager()
        motionManager.delegate = self
    }
    
    deinit {
        endSession()
    }
    
    // Must call this before utilizing this class
    func initializePitchAndAccelerationData() {
        accelerationData = dataStore.retrieveAccelerationData() ?? [Double]()
        pitchData = dataStore.retrievePitchData() ?? [Double]()
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
    
    func savePitchAndAccelerationData() async {
        await dataStore.savePitchData(pitchData)
        await dataStore.saveAccelerationData(accelerationData)
    }
    
    func incrementCount() {
        count += 1
    }
    
    func resetCount() {
        count = 0
    }
}

extension PushupsDetector: MotionManagerDelegate {
    func didUpdateAccelerationY(_ accelerationY: Double) {
        accelerationData.append(accelerationY)
        
        if accelerationY < downThreshold && !isPushupPhase {
            // User is movintg downward in a pushup
            isPushupPhase = true
        } else if accelerationY > upThreshold && isPushupPhase {
            incrementCount()
            isPushupPhase = false
        }
    }
    
    func didUpdatePitch(_ pitch: Double) {
        pitchData.append(pitch)
        
        isValidPosition = pitch < proneThreshold
    }
}
