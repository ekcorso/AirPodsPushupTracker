//
//  PushupCountViewController.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI
import AVFoundation

struct CountViewController: View {
    @State private var detector: Detector
    
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
        
        guard detector.isActive else {
            return text
        }
        
        guard detector.isDeviceMotionAvailable() else {
            text = "AirPods not connected"
            return text
        }
        
        if detector.isValidPosition {
            text = "You're ready 😎"
        } else {
            text = "Get in position for \(exercise)!"
        }
        
        return text
    }
    
    init(with exercise: Exercise) {
        self.exercise = exercise
        self.detector = Detector(for: exercise)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Group {
                Text(instructionText)
            }
            Text("\(detector.count)")
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(15)
            
            VStack(spacing: 10) {
                ResizingButton(title: "Start Counting", maxWidth: $maxWidth, action: startCounting)
                // Let's deactivate this button if the session is already active
                
                ResizingButton(title: "Stop", maxWidth: $maxWidth, action: stopCounting)
                // Let's deactivate this button if the session has not started yet
            }
        }
    }
    
    private func startCounting() {
        self.detector.initializeData()
        
        if !detector.isActive {
            detector.startSession()
        }
    }
    
    private func stopCounting() {
        if detector.isActive {
            detector.endSession()
        }
        Task {
            await detector.saveData()
        }
    }
}

#Preview {
    CountViewController(with: Pushup.shared)
}
