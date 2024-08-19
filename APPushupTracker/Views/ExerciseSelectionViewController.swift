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
                    
                    ResizingButton(maxWidth: $maxWidth, action: {
                        self.isShowingPushupCountView = true
                    }, content: {
                        Text(pushup.name)
                    })
                    .buttonStyle(.filledCapsule)
                    .tint(Pushup.shared.signatureColor)
                    
                    ResizingButton(maxWidth: $maxWidth, action: {
                        self.isShowingSquatCountView = true
                    }, content: {
                        Text(squat.name)
                    })
                    .buttonStyle(.filledCapsule)
                    .tint(Squat.shared.signatureColor)
                    
                    ResizingButton(maxWidth: $maxWidth, action: {
                        // Button action not set
                    }, content: {
                        Text("Situps")
                    })
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
