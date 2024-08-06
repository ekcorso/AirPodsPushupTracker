//
//  Squat.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/2/24.
//

import Foundation

class Squat: Exercise {
    static let shared = Squat()
    
    // TODO: Need to rethink these thresholds for Squats. Currently still detecting pushups
    var downAccelerationThreshold = -0.7
    var upAccelerationThreshold = 0.3
    var pitchThreshold = -0.8
    
    private init() {
        
    }
}
