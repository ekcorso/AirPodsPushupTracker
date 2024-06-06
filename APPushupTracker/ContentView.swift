//
//  ContentView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @Environment(PushupsDetector.self) private var pushupsDetector
    
    @State private var pushupCount = 8 {
        didSet {
            AudioServicesPlaySystemSound(1103)
        }
    }
    
    @State private var maxWidth: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: 10) {
            Group {
                if pushupsDetector.isValidPosition {
                    Text("Good form-- you're ready to go!")
                        .font(.title)
                } else {
                    Text("Get into position!")
                        .font(.title)
                }
            }
            Text("\(pushupsDetector.count)")
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
        if !pushupsDetector.isActive {
            pushupsDetector.startSession()
        }
    }
    
    private func stopCounting() {
        if pushupsDetector.isActive {
            pushupsDetector.endSession()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PushupsDetector())
}
