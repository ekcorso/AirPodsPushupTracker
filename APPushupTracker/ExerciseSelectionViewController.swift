//
//  ExerciseSelectionViewController.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/27/24.
//

import SwiftUI

struct ExerciseSelectionViewController: View {
    @State private var maxWidth: CGFloat = .zero

    var body: some View {
        Text("Select an exercise")
            .padding(30)
            .font(.title)
        
        VStack(spacing: 15) {
            ResizingButton(backgroundColor: .blue, foregroundColor: .white, title: "Pushups", maxWidth: $maxWidth) {
                
            }
            ResizingButton(backgroundColor: .green, foregroundColor: .white, title: "Squats", maxWidth: $maxWidth) {
                
            }
            ResizingButton(backgroundColor: .orange, foregroundColor: .white, title: "Situps", maxWidth: $maxWidth) {
                
            }
        }
    }
}

#Preview {
    ExerciseSelectionViewController()
}
