import SwiftUI

/// Applies standard horizontal padding
struct HorizontalPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.leading, .trailing])
    }
}

extension View {
    /// Applies standard horizontal padding
    func horizontalPadding() -> some View {
        modifier(HorizontalPadding())
    }
}
