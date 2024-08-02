//
//  ExerciseSelectionViewController.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/27/24.
//

import SwiftUI

struct ExerciseSelectionViewController: View {
    @State private var maxWidth: CGFloat = .zero
    @State private var isShowingPushupCountView = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Select an exercise")
                    .padding(30)
                    .font(.title)
                
                VStack(spacing: 15) {
                    // TODO: Transisiton to new NavLink initializer when removing support for iOS 15
                    NavigationLink(destination: PushupCountViewController(), isActive: $isShowingPushupCountView) { EmptyView() }
                    
                    ResizingButton(backgroundColor: .blue, foregroundColor: .white, title: "Pushups", maxWidth: $maxWidth) {
                        self.isShowingPushupCountView = true
                    }
                    
                    ResizingButton(backgroundColor: .green, foregroundColor: .white, title: "Squats", maxWidth: $maxWidth) {
                        // Button action not set
                    }
                    ResizingButton(backgroundColor: .orange, foregroundColor: .white, title: "Situps", maxWidth: $maxWidth) {
                        // Button action not set
                    }
                }
                .navigationTitle("Exercise Options")
            }
        }
    }
}

#Preview {
    ExerciseSelectionViewController()
        .environment(PushupsDetector())
}
