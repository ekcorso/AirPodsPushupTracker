//
//  ResizingButton.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/17/24.
//

import SwiftUI

struct ResizingButton<Content: View>: View {
    // This button will resize to fit the button(s) next to it
    @Binding private var maxWidth: CGFloat
    @State private var action: () -> Void
    let content: Content
    
    var body: some View {
        Button(action: action) {
            content
                .background(rectReader($maxWidth))
                .frame(minWidth: maxWidth)
        }.id(maxWidth)
    }
    
    init(maxWidth: Binding<CGFloat>, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self._maxWidth = maxWidth
        self.action = action
        self.content = content()
    }
    
    private func rectReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { gp -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = max(binding.wrappedValue, gp.frame(in: .local).width)
            }
            return Color.clear
        }
    }
    
}

#Preview {
    @State var localMaxWidth: CGFloat = 100
    return ResizingButton(maxWidth: $localMaxWidth, action: {}) {
        Text("Test")
    }
        .tint(.pink)
}
