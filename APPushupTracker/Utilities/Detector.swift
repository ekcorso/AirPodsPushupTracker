//
//  Detector.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/30/24.
//

import Foundation

protocol Detector {
    var isActive: Bool { get set }
    var isValidPosition: Bool { get set }
    var count: Int { get set }
    var dataStore: DataStore { get set }
    
    func initializeData()
    func saveData() async
}
