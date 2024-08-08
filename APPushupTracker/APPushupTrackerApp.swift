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
    @State private var pushupDetector = Detector(for: Pushup.shared) // Need to generalize this or duplicate it for the other exercises
    @State private var squatDetector = Detector(for: Squat.shared)
    @State private var pushupsChartViewModel = PushupChartViewViewModel()
    
    var body: some Scene {
        WindowGroup {
            TrackerTabBar()
                .environment(pushupDetector)
                .environment(squatDetector)
                .environment(pushupsChartViewModel)
        }
    }
}
