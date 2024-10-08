//
//  DataStore.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/7/24.
//

import Foundation

struct Key {
    static let pushupAccelerationDataKey = "pushupAccelerationKey"
    static let pushupPitchDataKey = "pushupPitchData"
    
    static let squatAccelerationKey = "squatAccelerationKey"
    static let squatPitchKey = "squatPitchKey"
    
    static let burpeeAccelerationKey = "burpeeAccelerationKey"
    static let burpeePitchKey = "burpeePitchKey"
}

actor DataStore {
    static let shared = DataStore()
    
    private let defaults = UserDefaults.standard
    
    private init() {
        
    }
    
    func savePushupPitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pushupPitchDataKey)
    }
    
    func savePushupAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pushupAccelerationDataKey)
    }
    
    func saveSquatPitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.squatPitchKey)
    }
    
    func saveSquatAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.squatAccelerationKey)
    }
    
    func saveBurpeePitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.burpeePitchKey)
    }
    
    func saveBurpeeAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.burpeeAccelerationKey)
    }
    
    nonisolated func retrievePushupPitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pushupPitchDataKey) as? [Double]
    }
    
    nonisolated func retrievePushupAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pushupAccelerationDataKey) as? [Double]
    }
    
    nonisolated func retrieveSquatPitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.squatPitchKey) as? [Double]
    }
    
    nonisolated func retrieveSquatAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.squatAccelerationKey) as? [Double]
    }
    
    nonisolated func retrieveBurpeePitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.burpeePitchKey) as? [Double]
    }
    
    nonisolated func retrieveBurpeeAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.burpeeAccelerationKey) as? [Double]
    }
}
