import SwiftUI

/// Applies bottom bar background styling with separator
struct BottomBarBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .padding()
                .glassEffect(.regular, in: .rect(cornerRadius: 38.0))
                .padding()
        } else {
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
}

extension View {
    /// Applies bottom bar background styling
    func bottomBarBackground() -> some View {
        modifier(BottomBarBackground())
    }
}
