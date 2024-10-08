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
    
    @State private var maxWidth: CGFloat = .zero
    
    @State private var isButtonSelected: Bool = false
    @State private var buttonTitle: String = "Start Counting"
    private var startButtonTitle = "Start Counting"
    private var stopButtonTitle = "Stop Counting"
    
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
            text = "Get in position for \(exercise.name)!"
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
            .font(.title2)
            .fontWeight(.medium)
            
            Text("\(detector.count)")
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(15)
            
            VStack(spacing: 10) {
                ResizingButton(maxWidth: $maxWidth, action: {
                    isButtonSelected ? stopCounting() : startCounting()
                    
                    isButtonSelected.toggle()
                }, content: {
                  Text(isButtonSelected ? stopButtonTitle : startButtonTitle)
                })
                    .buttonStyle(.selectable(isSelected: !isButtonSelected))
                    .tint(exercise.signatureColor)
            }
        }
        .onDisappear() {
            stopCounting()
            isButtonSelected = false
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
