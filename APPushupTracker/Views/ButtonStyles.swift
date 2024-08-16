//
//  ButtonStyles.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/15/24.
//

import Foundation
import SwiftUI

// SelectableButtonStyle must be updated if this is updated
struct GhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundStyle(.tint)
            .background(
                RoundedRectangle(
                    cornerRadius: 5,
                    style: .continuous
                )
                .stroke(.tint, lineWidth: 2)
            )
    }
}

extension ButtonStyle where Self == GhostButtonStyle {
    static var ghost: Self {
        return .init()
    }
}

// SelectableButtonStyle must be updated if this is updated
struct FilledCapusuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .font(.headline)
            .foregroundStyle(.white)
            .background(.tint)
            .clipShape(.buttonBorder)
    }
}

extension ButtonStyle where Self == FilledCapusuleButtonStyle {
    static var filledCapsule: Self {
        return .init()
    }
}

// This type must be updated if either FilledCapusuleButtonStyle or GhostButtonStyle is updated.
struct SelectableButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        // These styles have to be inlined here because of type issues when trying to alternate between calling the two different button styles on the config label
        
        if isSelected {
            // Filled Capusule Style
            configuration.label
                .padding(10)
                .font(.headline)
                .foregroundStyle(.white)
                .background(.tint)
                .clipShape(.buttonBorder)
        } else {
            // Ghost Style
            configuration.label
                .padding(10)
                .foregroundStyle(.tint)
                .background(
                    RoundedRectangle(
                        cornerRadius: 5,
                        style: .continuous
                    )
                    .stroke(.tint, lineWidth: 2)
                )
        }
    }
}

extension ButtonStyle where Self == SelectableButtonStyle {
    static func selectable(isSelected: Bool) -> Self {
        return .init(isSelected: isSelected)
    }
}
