//
//  DataStore.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/7/24.
//

import Foundation

    let defaults = UserDefaults.standard

actor DataStore {
    
    init() {
        accelerationData = (UserDefaults.standard.array(forKey: Key.accelerationDataKey) as? [Double]) ?? [Double]()
        pitchData = (UserDefaults.standard.array(forKey: Key.pitchDataKey) as? [Double]) ?? [Double]()
    }
}
