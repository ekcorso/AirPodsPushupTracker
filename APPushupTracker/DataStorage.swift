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
    @Published var accelerationData: [Double] = (UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]) ?? [Double]()
    @Published var pitchData: [Double] = (UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]) ?? [Double]()

    
    struct Key {
        static let accelerationDataKey = "accelerationData"
        static let pitchDataKey = "pitchData"
    }
    
    func getAveragePitch(_ data: [Double]) -> Double {
        let pitchSum = data.reduce(0, +)
        let pitchCount = Double(data.count)
        
        return Double(pitchSum/pitchCount)
    }
    
    func savePitchData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.pitchDataKey)
    }
    
    func saveAccelerationData(_ data: [Double]) {
        defaults.setValue(data, forKey: Key.accelerationDataKey)
    }
    
    func retrievePitchData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]
    }
    
    func retrieveAccelerationData() -> [Double]? {
        return UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]
    }
}
