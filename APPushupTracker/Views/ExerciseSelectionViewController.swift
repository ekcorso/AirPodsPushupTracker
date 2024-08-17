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
    @State private var isShowingSquatCountView = false
    @State private var pushupButtonTitle = Pushup.shared.name
    @State private var squatButtonTitle = Squat.shared.name
    @State private var situpButtonTitle = "Situps"
    
    let pushup = Pushup.shared
    let squat = Squat.shared

    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select an exercise")
                    .padding(30)
                    .font(.title)
                
                VStack(spacing: 15) {
                    // TODO: Transisiton to new NavLink initializer when removing support for iOS 15
                    NavigationLink(destination: CountViewController(with: pushup), isActive: $isShowingPushupCountView) { EmptyView() }
                    
                    NavigationLink(destination: CountViewController(with: squat), isActive: $isShowingSquatCountView) { EmptyView() }
                    
                    ResizingButton(title: $pushupButtonTitle, maxWidth: $maxWidth) {
                        self.isShowingPushupCountView = true
                    }
                    .buttonStyle(.filledCapsule)
                    .tint(Pushup.shared.signatureColor)
                    
                    ResizingButton(title: $squatButtonTitle, maxWidth: $maxWidth) {
                        self.isShowingSquatCountView = true
                    }
                    .buttonStyle(.filledCapsule)
                    .tint(Squat.shared.signatureColor)
                    
                    ResizingButton(title: $situpButtonTitle, maxWidth: $maxWidth) {
                        // Button action not set
                    }
                    .buttonStyle(.ghost)
                    .tint(.orange) // TODO: replace with signature color when Pushup is created
                }
                .navigationTitle("Exercise Options")
            }
        }
    }
}

#Preview {
    ExerciseSelectionViewController()
}
