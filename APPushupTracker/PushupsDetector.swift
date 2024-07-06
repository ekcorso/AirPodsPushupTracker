//
//  PushupsDetector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/19/24.
//

import SwiftUI

class PushupsDetector: ObservableObject {
    var isActive = false
    
    @Published var count = 0
    
    var accelerationData: [Double]
    var pitchData: [Double]
    let dataStorage = DataStorage()
    
    var isValidPosition = false
    
    private let motionManager: MotionManager

    private var isPushupPhase = false
    
    private let downThreshold: Double = -0.7
    private let upThreshold: Double = 0.3
    
    private let proneThreshold: Double = -0.8
    
    init() {
        accelerationData = dataStorage.retrieveAccelerationData() ?? [Double]()
        pitchData = dataStorage.retrievePitchData() ?? [Double]()
        
        self.motionManager = MotionManager()
        motionManager.delegate = self
    }
    
    deinit {
        endSession()
    }
    
    func startSession() {
        print("Starting session...")
        motionManager.startUpdates()
        isActive = true
    }
    
    func endSession() {
        motionManager.stopUpdates()
        isActive = false
        
        dataStorage.savePitchData(pitchData)
        dataStorage.saveAccelerationData(accelerationData)
        print("Session ended.")
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
