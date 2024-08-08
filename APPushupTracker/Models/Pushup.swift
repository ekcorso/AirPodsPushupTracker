//
//  Pushup.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/1/24.
//

import Foundation

class Pushup: Exercise {
    static let shared = Pushup()
    
    var downAccelerationThreshold = -0.7
    var upAccelerationThreshold = 0.3
    var pitchThreshold = -0.8
    
    var name = "Pushups"
    
    private init() {
        
    }
}
