//
//  APPushupTrackerApp.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI

@main
struct APPushupTrackerApp: App {
    @StateObject private var dataStorage = DataStorage()
    @StateObject private var pushupsDetector = PushupsDetector()
    
    var body: some Scene {
        WindowGroup {
            TrackerTabBar()
                .environmentObject(pushupsDetector)
                .environmentObject(dataStorage)
        }
    }
}
