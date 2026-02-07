import SwiftUI

/// Applies navigation styling used in Randomly views
struct RandomlyNavigationStyle: ViewModifier {
    let title: LocalizedStringKey

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    /// Applies Randomly navigation styling
    func randomlyNavigation(title: LocalizedStringKey) -> some View {
        modifier(RandomlyNavigationStyle(title: title))
    }
}
