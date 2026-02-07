import SwiftUI

/// A large, bold display text view with consistent styling and animations
struct LargeDisplayTextView: View {
    let text: String
    let fontSize: CGFloat
    let fontDesign: Font.Design
    let transitionDirection: TransitionDirection

    enum TransitionDirection {
        case scale
        case flipUp
        case flipDown
    }

    /// Creates a large display text view
    /// - Parameters:
    ///   - text: The text to display
    ///   - fontSize: The font size (default: 120)
    ///   - fontDesign: The font design (default: .rounded)
    ///   - transitionDirection: The direction of the transition animation (default: .scale)
    init(_ text: String, fontSize: CGFloat = 120, fontDesign: Font.Design = .rounded, transitionDirection: TransitionDirection = .scale) {
        self.text = text
        self.fontSize = fontSize
        self.fontDesign = fontDesign
        self.transitionDirection = transitionDirection
    }

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .heavy, design: fontDesign))
            .lineLimit(1)
            .minimumScaleFactor(0.01)
            .textSelection(.enabled)
            .padding()
            .transition(transition)
            .id(text)
    }

    private var transition: AnyTransition {
        switch transitionDirection {
        case .scale:
            return .scale.combined(with: .opacity)
        case .flipUp:
            return .asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            )
        case .flipDown:
            return .asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .bottom).combined(with: .opacity)
            )
        }
    }
}
