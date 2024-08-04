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
}

actor DataStore {
    static let shared = DataStore()
    
    private let defaults = UserDefaults.standard
    
    private var pushupAccelerationData: [Double]
    private var pushupPitchData: [Double]
    
    private var squatAccelerationData: [Double]
    private var squatPitchData: [Double]
    
    private init() {
        self.pushupAccelerationData = (UserDefaults.standard.array(forKey: Key.pushupAccelerationDataKey) as? [Double]) ?? [Double]()
        self.pushupPitchData = (UserDefaults.standard.array(forKey: Key.pushupAccelerationDataKey) as? [Double]) ?? [Double]()
        
        self.squatAccelerationData = (UserDefaults.standard.array(forKey: Key.squatAccelerationKey) as? [Double]) ?? [Double]()
        self.squatPitchData = (UserDefaults.standard.array(forKey: Key.squatPitchKey) as? [Double]) ?? [Double]()
    }
    
    func savePushupPitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pushupPitchDataKey)
        pushupPitchData.append(contentsOf: data)
    }
    
    func savePushupAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pushupAccelerationDataKey)
        pushupAccelerationData.append(contentsOf: data)
    }
    
    func saveSquatPitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.squatPitchKey)
        pushupPitchData.append(contentsOf: data)
    }
    
    func saveSquatAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.squatAccelerationKey)
        pushupAccelerationData.append(contentsOf: data)
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
}
