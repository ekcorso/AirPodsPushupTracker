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
    
    var isValidPosition = false
    
    private let motionManager: MotionManager

    private var isPushupPhase = false
    
    private let downThreshold: Double = -0.7
    private let upThreshold: Double = 0.4
    
    private let proneThreshold: Double = -1
    
    init() {
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
        if accelerationY < downThreshold && !isPushupPhase {
            // User is movintg downward in a pushup
            isPushupPhase = true
        } else if accelerationY > upThreshold && isPushupPhase {
            incrementCount()
            isPushupPhase = false
        }
    }
    
    func didUpdatePitch(_ pitch: Double) {
        isValidPosition = pitch < proneThreshold
    }
}
