//
//  Pushup.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/1/24.
//

import Foundation

class Pushup: Exercise {
    static let shared = Pushup()
    
    private override init() {
        super.init()
        
        self.downAccelerationThreshold = -0.7
        self.upAccelerationThreshold = 0.3
        self.pitchThreshold = -0.8
    }
}
