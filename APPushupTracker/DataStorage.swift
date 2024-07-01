//
//  DataStorage.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/30/24.
//

import Foundation

class DataStorage: ObservableObject {
    let defaults = UserDefaults.standard
  
    @Published var avgPitch: Double = 0
    @Published var accelerationData: [Double]
    @Published var pitchData: [Double]

    init() {
        accelerationData = (UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]) ?? [Double]()
        pitchData = (UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]) ?? [Double]()
        
        avgPitch = getAveragePitch(pitchData)
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
    
    func savePitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pitchDataKey)
        pitchData.append(contentsOf: data)
        
        avgPitch = getAveragePitch(pitchData)
    }
    
    func saveAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.accelerationDataKey)
        accelerationData.append(contentsOf: data)
    }
    
    func retrievePitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]
    }
    
    func retrieveAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]
    }
}
