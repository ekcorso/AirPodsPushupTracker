//
//  DataStorage.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/30/24.
//

import Foundation
import Observation

@Observable
class DataStorage {
    let defaults = UserDefaults.standard
  
    var avgPitch: Double = 0
    var avgUpAcceleration: Double = 0
    var avgDownAcceleration: Double = 0
    var accelerationData: [Double]
    var pitchData: [Double]

    init() {
        accelerationData = (UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]) ?? [Double]()
        pitchData = (UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]) ?? [Double]()
        
        avgPitch = getAveragePitch(pitchData)
        avgUpAcceleration = getAvgUpAcceleration(accelerationData)
        avgDownAcceleration = getAvgDownAcceleration(accelerationData)
    }
    
    struct Key {
        static let accelerationDataKey = "accelerationData"
        static let pitchDataKey = "pitchData"
    }
    
    func getAveragePitch(_ data: [Double]) -> Double {
        guard data.count != 0 else { return 0 }
        
        let pitchSum = data.reduce(0, +)
        let pitchCount = Double(data.count)
        
        return Double(pitchSum/pitchCount)
    }
    
    func getAvgUpAcceleration(_ data: [Double]) -> Double {
        guard data.count != 0 else { return 0 }

        let upAccData = data.filter() { $0 >= 0.3 }
        // We can throw out 0 here because if the acc is 0 the user isn't moving anyway, so it's not relevant to the rep threshold
        // Throwing out some of the other small values here. didUpdateAccelerationY is very sensitive
        
        let avgUpAcc = Double(upAccData.reduce(0, +)) / Double(upAccData.count)
        
        return avgUpAcc
    }
    
    func getAvgDownAcceleration(_ data: [Double]) -> Double {
        guard data.count != 0 else { return 0 }

        let downAccData = data.filter() { $0 <= -0.7 }
        // We can throw out 0 here because if the acc is 0 the user isn't moving anyway, so it's not relevant to the rep threshold
        // Throwing out some of the other small values here. didUpdateAccelerationY is very sensitive

        let avgDownAcc = Double(downAccData.reduce(0, +)) / Double(downAccData.count)
        
        return avgDownAcc
    }
    
    func savePitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pitchDataKey)
        pitchData.append(contentsOf: data)
        
        avgPitch = getAveragePitch(pitchData)
    }
    
    func saveAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.accelerationDataKey)
        accelerationData.append(contentsOf: data)
        
        avgUpAcceleration = getAvgUpAcceleration(accelerationData)
        avgDownAcceleration = getAvgDownAcceleration(accelerationData)
    }
    
    func retrievePitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]
    }
    
    func retrieveAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]
    }
}
