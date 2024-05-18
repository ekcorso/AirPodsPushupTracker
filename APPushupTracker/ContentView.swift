//
//  ContentView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var pushupCount = 8
    @State private var maxWidth: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(pushupCount)")
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(15)
            
            VStack(spacing: 10) {
                ResizingButton(backgroundColor: .blue, foregroundColor: .white, title: "Start Counting", maxWidth: $maxWidth, action: startCounting)
                ResizingButton(backgroundColor: .gray, foregroundColor: .black, title: "Stop", maxWidth: $maxWidth, action: stopCounting)
            }
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
