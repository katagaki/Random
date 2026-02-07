import SwiftUI

/// Applies prominent pill-shaped button styling
struct ProminentPillButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 99))
    }
}

extension View {
    /// Applies prominent pill-shaped button styling
    func prominentPillButton() -> some View {
        modifier(ProminentPillButtonStyle())
    }
}
