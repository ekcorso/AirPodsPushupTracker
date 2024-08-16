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
                    
                    ResizingButton(title: pushup.name, maxWidth: $maxWidth) {
                        self.isShowingPushupCountView = true
                    }
                    
                    ResizingButton(title: squat.name, maxWidth: $maxWidth) {
                        self.isShowingSquatCountView = true
                    }
                    
                    ResizingButton(title: "Situps", maxWidth: $maxWidth) {
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
}
