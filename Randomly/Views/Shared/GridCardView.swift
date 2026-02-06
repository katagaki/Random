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
    let iconColor: Color

    @State private var isPressed = false

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
                    .frame(width: 24.0, height: 24.0)
                    .padding(4.0)
                    .foregroundStyle(iconColor)
                Spacer()
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity, minHeight: 70.0, maxHeight: 70.0, alignment: .leading)
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
