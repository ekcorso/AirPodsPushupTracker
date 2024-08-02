//
//  Squat.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/2/24.
//

import Foundation

class Squat: Exercise {
    static let shared = Squat()
    
    private override init() {
        super.init()
        
        // TODO: Need to rethink these thresholds for Squats. Currently still detecting pushups
        self.downAccelerationThreshold = -0.7
        self.upAccelerationThreshold = 0.3
        self.pitchThreshold = -0.8
        
        self.accelerationKey = "squatAccelerationKey"
        self.pitchKey = "squatPitchKey"
    }
}
