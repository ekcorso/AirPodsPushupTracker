//
//  APPushupTrackerApp.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI

@main
struct APPushupTrackerApp: App {
    @Environment(PushupChartViewViewModel.self) private var dataStorage
    @StateObject private var pushupsDetector = PushupsDetector()
    
    var body: some Scene {
        WindowGroup {
            TrackerTabBar()
                .environmentObject(pushupsDetector)
                .environment(dataStorage)
        }
    }
}
