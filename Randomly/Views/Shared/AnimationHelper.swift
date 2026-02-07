import SwiftUI

extension View {
    /// Animates changes with the default animation at 2x speed
    func animateChange(_ action: @escaping () -> Void) {
        withAnimation(.default.speed(2)) {
            action()
        }
    }
}
