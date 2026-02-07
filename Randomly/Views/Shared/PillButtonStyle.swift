import SwiftUI

/// Applies pill-shaped button styling with bordered style
struct PillButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .clipShape(RoundedRectangle(cornerRadius: 99))
    }
}

extension View {
    /// Applies pill-shaped button styling
    func pillButton() -> some View {
        modifier(PillButtonStyle())
    }
}
