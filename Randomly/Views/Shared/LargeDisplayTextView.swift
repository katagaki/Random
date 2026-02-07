import SwiftUI

/// A large, bold display text view with consistent styling and animations
struct LargeDisplayTextView: View {
    let text: String
    let fontSize: CGFloat
    let fontDesign: Font.Design

    /// Creates a large display text view
    /// - Parameters:
    ///   - text: The text to display
    ///   - fontSize: The font size (default: 120)
    ///   - fontDesign: The font design (default: .rounded)
    init(_ text: String, fontSize: CGFloat = 120, fontDesign: Font.Design = .rounded) {
        self.text = text
        self.fontSize = fontSize
        self.fontDesign = fontDesign
    }

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .heavy, design: fontDesign))
            .lineLimit(1)
            .minimumScaleFactor(0.01)
            .textSelection(.enabled)
            .padding()
            .transition(.scale.combined(with: .opacity))
            .id(text)
    }
}
