import SwiftUI

// MARK: - View Modifiers

/// Applies pill-shaped button styling with bordered style
struct PillButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .clipShape(RoundedRectangle(cornerRadius: 99))
    }
}

/// Applies prominent pill-shaped button styling
struct ProminentPillButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 99))
    }
}

/// Applies navigation styling used in Randomly views
struct RandomlyNavigationStyle: ViewModifier {
    let title: LocalizedStringKey

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

/// Applies bottom bar background styling with separator
struct BottomBarBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom], 16.0)
            .padding([.leading, .trailing])
            .background(Material.bar)
            .overlay(alignment: .top) {
                Rectangle()
                    .frame(height: 1/3)
                    .foregroundColor(.primary.opacity(0.2))
            }
    }
}

/// Applies standard horizontal padding
struct HorizontalPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.leading, .trailing])
    }
}

// MARK: - View Extensions

extension View {
    /// Applies pill-shaped button styling
    func pillButton() -> some View {
        modifier(PillButtonStyle())
    }

    /// Applies prominent pill-shaped button styling
    func prominentPillButton() -> some View {
        modifier(ProminentPillButtonStyle())
    }

    /// Applies Randomly navigation styling
    func randomlyNavigation(title: LocalizedStringKey) -> some View {
        modifier(RandomlyNavigationStyle(title: title))
    }

    /// Applies bottom bar background styling
    func bottomBarBackground() -> some View {
        modifier(BottomBarBackground())
    }

    /// Applies standard horizontal padding
    func horizontalPadding() -> some View {
        modifier(HorizontalPadding())
    }
}

// MARK: - Animation Helper

extension View {
    /// Animates changes with the default animation at 2x speed
    func animateChange(_ action: @escaping () -> Void) {
        withAnimation(.default.speed(2)) {
            action()
        }
    }
}
