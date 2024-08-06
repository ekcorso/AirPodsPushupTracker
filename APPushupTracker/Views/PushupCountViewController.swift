//
//  PushupCountViewController.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI
import AVFoundation

struct PushupCountViewController: View {
    @Environment(Detector.self) private var pushupsDetector
    
    @State private var pushupCount = 8 {
        didSet {
            AudioServicesPlaySystemSound(1103)
        }
    }
    
    @State private var maxWidth: CGFloat = .zero
    
    private let exercise: Exercise
    
    private let startText = "Press start to begin"
    
    private var instructionText: String {
        var text = startText
        
        guard pushupsDetector.isActive else {
            return text
        }
        
        guard pushupsDetector.isDeviceMotionAvailable() else {
            text = "AirPods not connected"
            return text
        }
        
        if pushupsDetector.isValidPosition {
            text = "You're ready 😎"
        } else {
            text = "Get in position for \(exercise)!"
        }
        
        return text
    }
    
    init(with exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Group {
                Text(instructionText)
            }
            Text("\(pushupsDetector.count)")
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(15)
            
            VStack(spacing: 10) {
                ResizingButton(backgroundColor: .blue, foregroundColor: .white, title: "Start Counting", maxWidth: $maxWidth, action: startCounting)         // Let's deactivate this button if the session is already active
                ResizingButton(backgroundColor: .gray, foregroundColor: .black, title: "Stop", maxWidth: $maxWidth, action: stopCounting)         // Let's deactivate this button if the session has not started yet
            }
        }
        .environment(pushupsDetector)
    }
    
    private func startCounting() {
        self.pushupsDetector.initializeData()
        
        if !pushupsDetector.isActive {
            pushupsDetector.startSession()
        }
    }
    
    private func stopCounting() {
        if pushupsDetector.isActive {
            pushupsDetector.endSession()
        }
        Task {
            await pushupsDetector.saveData()
        }
    }
}

#Preview {
    PushupCountViewController(with: Pushup.shared)
        .environment(Detector(for: Pushup.shared))
}
