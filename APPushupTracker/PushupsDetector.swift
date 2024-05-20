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
    var isValidPosition = false
    
    private let motionManager: MotionManager

    private var isPushupPhase = false
    
    private let downThreshold = -0.5
    private let upThreshold = 0.5
    
    private let proneThreshold = -1
    
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
