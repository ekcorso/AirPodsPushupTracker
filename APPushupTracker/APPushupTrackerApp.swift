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
    @Environment(PushupsDetector.self) private var pushupsDetector
    
    var body: some Scene {
        WindowGroup {
            TrackerTabBar()
                .environment(pushupsDetector)
                .environment(dataStorage)
        }
    }
}
