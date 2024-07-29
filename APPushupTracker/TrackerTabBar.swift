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
            ExerciseSelectionViewController()
                .tabItem {
                    Label("Select Exercise", systemImage: "figure.run")
                }
            PushupChartView()
                .tabItem {
                    Label("Data", systemImage: "chart.xyaxis.line")
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
        .environment(PushupChartViewViewModel())
}
