//
//  ButtonStyles.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/15/24.
//

import Foundation
import SwiftUI

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
