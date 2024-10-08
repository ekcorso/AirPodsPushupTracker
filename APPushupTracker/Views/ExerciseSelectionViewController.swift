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
    @State private var isShowingBurpeeCountView = false
    
    let pushup = Pushup.shared
    let squat = Squat.shared
    let burpee = Burpee.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select an exercise")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(30)

                VStack(spacing: 15) {
                    // TODO: Transisiton to new NavLink initializer when removing support for iOS 15
                    NavigationLink(destination: CountViewController(with: pushup), isActive: $isShowingPushupCountView) { EmptyView() }
                    
                    NavigationLink(destination: CountViewController(with: squat), isActive: $isShowingSquatCountView) { EmptyView() }
                    
                    NavigationLink(destination: CountViewController(with: burpee), isActive: $isShowingBurpeeCountView) { EmptyView() }
                    
                    ResizingButton(maxWidth: $maxWidth, action: {
                        self.isShowingPushupCountView = true
                    }, content: {
                        Text(pushup.name)
                    })
                    .buttonStyle(.filledCapsule)
                    .tint(pushup.signatureColor)
                    
                    ResizingButton(maxWidth: $maxWidth, action: {
                        self.isShowingSquatCountView = true
                    }, content: {
                        Text(squat.name)
                    })
                    .buttonStyle(.filledCapsule)
                    .tint(squat.signatureColor)
                    
                    ResizingButton(maxWidth: $maxWidth, action: {
                        self.isShowingBurpeeCountView = true
                    }, content: {
                        Text("\(burpee.name)")
                    })
                    .buttonStyle(.filledCapsule)
                    .tint(burpee.signatureColor)
                }
            }
        }
    }
}

#Preview {
    ExerciseSelectionViewController()
}
