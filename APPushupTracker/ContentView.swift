//
//  ContentView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var pushupCount = 8
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(pushupCount)")
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(15)
            
            Button("Start Counting") {
                startCounting()
            }
            .padding()
            .font(.headline)
            .foregroundStyle(.black)
            .background(.green)
            .clipShape(.buttonBorder)
            
            Button("Stop") {
                stopCounting()
            }
            .padding()
            .font(.headline)
            .foregroundStyle(.black)
            .background(.red)
            .clipShape(.buttonBorder)
        }
    }
    
    private func startCounting() {
        // Begin reading updates from CMHeadphoneMotionManager
    }
    
    private func stopCounting() {
        // Pause updates
    }
}

#Preview {
    ContentView()
}
