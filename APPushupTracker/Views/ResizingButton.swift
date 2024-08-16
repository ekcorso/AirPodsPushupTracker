//
//  ResizingButton.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/17/24.
//

import SwiftUI

struct ResizingButton: View {
    // This button will resize to fit the button(s) next to it
    @State private var title: String
    @Binding private var maxWidth: CGFloat
    @State private var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .background(rectReader($maxWidth))
                .frame(minWidth: maxWidth)
        }.id(maxWidth)
    }
    
    init(title: String, maxWidth: Binding<CGFloat>, action: @escaping () -> Void) {
        self.title = title
        self._maxWidth = maxWidth
        self.action = action
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
    return ResizingButton(title: "Test", maxWidth: $localMaxWidth, action: {}).tint(.pink)
}
