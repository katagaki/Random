import SwiftUI

/// Applies bottom bar background styling with separator
struct BottomBarBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom], 16.0)
            .padding([.leading, .trailing])
            .background(.bar)
            .overlay(alignment: .top) {
                Rectangle()
                    .frame(height: 1/3)
                    .foregroundColor(.primary.opacity(0.2))
            }
    }
}

extension View {
    /// Applies bottom bar background styling
    func bottomBarBackground() -> some View {
        modifier(BottomBarBackground())
    }
}
