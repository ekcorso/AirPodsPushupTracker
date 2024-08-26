//
//  Burpee.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/22/24.
//

import Foundation
import SwiftUI

class Burpee: Exercise {
    static let shared = Burpee()
    
    // Guesses at possible thresholds. Needs data.
    var downAccelerationThreshold = -0.6
    var upAccelerationThreshold = 0.8
    var pitchThreshold = 0.0
    
    var name = "Burpees"
    
    var signatureColor: Color = .pink
    
    private init() {
        
    }
}
