//
//  SquatsDetector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/31/24.
//

import Foundation
import SwiftUI

@Observable
class SquatsDetector: Detector {
    override init() {
        super.init()
        
        // TODO: Need to rethink these thresholds for Squats. Currently still detecting pushups
        downThreshold = -0.7
        upThreshold = 0.3
        proneThreshold = -0.8
        
        motionManager.delegate = self
    }
    
    // Must call this before utilizing this class
    override func initializeData() {
        accelerationData = dataStore.retrieveSquatAccelerationData() ?? [Double]()
        pitchData = dataStore.retrieveSquatPitchData() ?? [Double]()
    }
    
    override func saveData() async {
        await dataStore.saveSquatPitchData(pitchData)
        await dataStore.saveSquatAccelerationData(accelerationData)
    }
}

// TODO: Need to retool this for Squats. Currently still detecting pushups
extension SquatsDetector: MotionManagerDelegate {
    func didUpdateAccelerationY(_ accelerationY: Double) {
        accelerationData.append(accelerationY)
        
        if accelerationY < downThreshold && !isUpwardPhase {
            // User is movintg downward in a pushup
            isUpwardPhase = true
        } else if accelerationY > upThreshold && isUpwardPhase {
            incrementCount()
            isUpwardPhase = false
        }
    }
    
    func didUpdatePitch(_ pitch: Double) {
        pitchData.append(pitch)
        
        isValidPosition = pitch < proneThreshold
    }
}
