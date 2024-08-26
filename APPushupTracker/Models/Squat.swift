//
//  Squat.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/2/24.
//

import Foundation
import SwiftUI

class Squat: Exercise {
    static let shared = Squat()
    
    var downAccelerationThreshold = -0.35
    var upAccelerationThreshold = 0.4
    var pitchThreshold = -0.4
    
    var name = "Squats"
    
    var signatureColor: Color = .green
    
    private init() {
        
    }
}
