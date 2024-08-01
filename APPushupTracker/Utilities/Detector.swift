//
//  Detector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/30/24.
//

import Foundation

class Detector {
    var isActive: Bool = false
    var isValidPosition: Bool = false
    var count: Int = 0
    var dataStore = DataStore.shared
    
    let motionManager: MotionManager

    var downThreshold: Double
    var upThreshold: Double
    var proneThreshold: Double
    
    var isUpwardPhase = false

    var accelerationData: [Double]
    var pitchData: [Double]
    
    init() {
        self.accelerationData = [Double]()
        self.pitchData = [Double]()
        
        self.motionManager = MotionManager()
        self.downThreshold = 0
        self.upThreshold = 0
        self.proneThreshold = 0
    }
    
    deinit {
        endSession()
    }
    
    // Must call this before utilizing this class
    func initializeData() {
        accelerationData = dataStore.retrieveAccelerationData() ?? [Double]()
        pitchData = dataStore.retrievePitchData() ?? [Double]()
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
    
    func saveData() async {
        await dataStore.savePitchData(pitchData)
        await dataStore.saveAccelerationData(accelerationData)
    }
    
    func isDeviceMotionAvailable() -> Bool {
        return motionManager.isDeviceMotionAvailable()
    }
    
    func incrementCount() {
        count += 1
    }
    
    func resetCount() {
        count = 0
    }
}
