//
//  TrackerTabBar.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI

struct TrackerTabBar: View {
    
    init() {
        setupTabBarAppearance()
    }
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Track Pushups", systemImage: "play.circle")
                }
            
            ContentView() // TODO: Replace this placeholder
                .tabItem {
                    Label("Track Pushups", systemImage: "play.circle")
                }
        }
    }
    
    func setupTabBarAppearance() {
        let standardAppearance = UITabBarAppearance()
        
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.shadowColor = .black.withAlphaComponent(0.5)
        
        UITabBar.appearance().standardAppearance =  standardAppearance
        UITabBar.appearance().scrollEdgeAppearance = standardAppearance
    }
}

#Preview {
    TrackerTabBar()
        .environmentObject(PushupsDetector())
}
