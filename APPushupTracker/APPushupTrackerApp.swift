//
//  APPushupTrackerApp.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI
import Observation

@main
struct APPushupTrackerApp: App {
    @State private var pushupsChartViewModel = PushupChartViewViewModel()
    
    var body: some Scene {
        WindowGroup {
            TrackerTabBar()
                .environment(pushupsChartViewModel)
        }
    }
}
