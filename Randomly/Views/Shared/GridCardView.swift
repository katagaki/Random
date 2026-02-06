//
//  GridCardView.swift
//  Random
//
//  Created by Claude on 2026/02/06.
//

import SwiftUI

struct GridCardView<Destination: Hashable>: View {
    let destination: Destination
    let title: LocalizedStringKey
    let icon: String
    let iconColor: Color?
    let iconGradient: LinearGradient?

    @State private var isPressed = false

    // Convenience initializer for solid colors
    init(destination: Destination, title: LocalizedStringKey, icon: String, iconColor: Color) {
        self.destination = destination
        self.title = title
        self.icon = icon
        self.iconColor = iconColor
        self.iconGradient = nil
    }

    // Initializer for gradients
    init(destination: Destination, title: LocalizedStringKey, icon: String, iconGradient: LinearGradient) {
        self.destination = destination
        self.title = title
        self.icon = icon
        self.iconColor = nil
        self.iconGradient = iconGradient
    }

    private var cornerRadius: CGFloat {
        if #available(iOS 26.0, *) {
            return 24.0
        } else {
            return 12.0
        }
    }

    private var padding: CGFloat {
        if #available(iOS 26.0, *) {
            return 16.0
        } else {
            return 12.0
        }
    }

    var body: some View {
        NavigationLink(value: destination) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20.0, height: 20.0)
                    .padding(2.0)
                    .foregroundStyle(iconGradient != nil ? AnyShapeStyle(iconGradient!) : AnyShapeStyle(iconColor ?? .primary))
                Spacer(minLength: 0.0)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity, minHeight: 60.0, maxHeight: 60.0, alignment: .leading)
            .padding(padding)
            .background(isPressed ? Color(.tertiarySystemGroupedBackground) : Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .buttonStyle(PressableCardButtonStyle(isPressed: $isPressed))
    }
}

struct PressableCardButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressed = newValue
            }
    }
}
