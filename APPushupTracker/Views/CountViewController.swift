//
//  PushupCountViewController.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI
import AVFoundation

struct CountViewController: View {
    @Environment(Detector.self) private var pushupDetector
    @Environment(Detector.self) private var squatDetector
    
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
        
        guard pushupDetector.isActive else {
            return text
        }
        
        guard pushupDetector.isDeviceMotionAvailable() else {
            text = "AirPods not connected"
            return text
        }
        
        if pushupDetector.isValidPosition {
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
            Text("\(pushupDetector.count)")
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(15)
            
            VStack(spacing: 10) {
                ResizingButton(backgroundColor: .blue, foregroundColor: .white, title: "Start Counting", maxWidth: $maxWidth, action: startCounting)         // Let's deactivate this button if the session is already active
                ResizingButton(backgroundColor: .gray, foregroundColor: .black, title: "Stop", maxWidth: $maxWidth, action: stopCounting)         // Let's deactivate this button if the session has not started yet
            }
        }
        .environment(pushupDetector)
        .environment(squatDetector)
    }
    
    private func startCounting() {
        self.pushupDetector.initializeData()
        
        if !pushupDetector.isActive {
            pushupDetector.startSession()
        }
    }
    
    private func stopCounting() {
        if pushupDetector.isActive {
            pushupDetector.endSession()
        }
        Task {
            await pushupDetector.saveData()
        }
    }
}

#Preview {
    CountViewController(with: Pushup.shared)
        .environment(Detector(for: Pushup.shared))
}
