//
//  Exercise.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/1/24.
//

import Foundation

class Exercise {
    var downAccelerationThreshold: Double
    var upAccelerationThreshold: Double
    var pitchThreshold: Double
    
    var accelerationKey: String
    var pitchKey: String
    
    init() {
        self.downAccelerationThreshold = 0.0
        self.upAccelerationThreshold = 0.0
        self.pitchThreshold = 0.0
        
        self.accelerationKey = ""
        self.pitchKey = ""
    }
}
