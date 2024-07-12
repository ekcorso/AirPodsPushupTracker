//
//  DataStore.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/7/24.
//

import Foundation

actor DataStore {
    static let shared = DataStore()
    
    private let defaults = UserDefaults.standard
    private var accelerationData: [Double]
    private var pitchData: [Double]
    
    struct Key {
        static let accelerationDataKey = "accelerationData"
        static let pitchDataKey = "pitchData"
    }
    
    private init() {
        self.accelerationData = (UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]) ?? [Double]()
        self.pitchData = (UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]) ?? [Double]()
    }
    
    func savePitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pitchDataKey)
        pitchData.append(contentsOf: data)
        
//        avgPitch = getAveragePitch(pitchData)
    }
    
    func saveAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.accelerationDataKey)
        accelerationData.append(contentsOf: data)
        
//        avgUpAcceleration = getAvgUpAcceleration(accelerationData)
//        avgDownAcceleration = getAvgDownAcceleration(accelerationData)
    }
    
    nonisolated func retrievePitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]
    }
    
    nonisolated func retrieveAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]
    }
}
