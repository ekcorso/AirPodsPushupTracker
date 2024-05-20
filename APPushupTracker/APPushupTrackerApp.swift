//
//  APPushupTrackerApp.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI

@main
struct APPushupTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TrackerTabBar()
                .environmentObject(PushupsDetector())
        }
    }
}
