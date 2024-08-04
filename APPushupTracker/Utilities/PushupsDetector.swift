//
//  PushupsDetector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/19/24.
//

import SwiftUI

@Observable
class PushupsDetector: Detector {
    override init() {
        super.init()
        
        downThreshold = -0.7
        upThreshold = 0.3
        proneThreshold = -0.8
        
        motionManager.delegate = self
    }
    
    // Must call this before utilizing this class
    override func initializeData() {
        accelerationData = dataStore.retrievePushupAccelerationData() ?? [Double]()
        pitchData = dataStore.retrievePushupPitchData() ?? [Double]()
    }
    
    override func saveData() async {
        await dataStore.savePushupPitchData(pitchData)
        await dataStore.savePushupAccelerationData(accelerationData)
    }
}

extension PushupsDetector: MotionManagerDelegate {
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
