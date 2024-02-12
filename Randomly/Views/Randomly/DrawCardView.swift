//
//  DrawCardView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/12.
//

import SwiftUI

struct DrawCardView: View {

    let cardTypes: [String] = ["Club", "Diamond", "Heart", "Spade"]
    let cardNumbers: [Int] = Array(1...13)
    @State var cardType: String?
    @State var cardNumber: Int?

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            if let cardType, let cardNumber {
                Image("\(cardType)\(cardNumber)")
                .resizable()
                .scaledToFit()
                .frame(width: 350.0, height: 350.0)
                .foregroundStyle(Color.white)
                .background {
                    Group {
                        if cardType == "Club" || cardType == "Spade" {
                            Rectangle()
                                .fill(Color.black)
                        } else {
                            Rectangle()
                                .fill(Color.red)
                        }
                    }
                    .frame(width: 225.0, height: 310.0)
                }
                .drawingGroup()
                .shadow(color: .black.opacity(0.2), radius: 10.0, y: 12.0)
                .transition(.push(from: .top).combined(with: .scale))
                .id("\(cardType)\(cardNumber)")
            }
            Spacer()
            ActionBar(primaryActionText: "Shared.Draw",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(false),
                      primaryActionDisabled: .constant(false)) {
                drawCard()
            } copyAction: {
                UIPasteboard.general.string = cardName()
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .task {
            drawCard()
        }
        .navigationTitle("Randomly.Do.CardDraw.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func drawCard() {
        withAnimation(.default.speed(2)) {
            cardType = cardTypes.randomElement()!
            cardNumber = cardNumbers.randomElement()!
        }
    }

    func cardName() -> String {
        if let cardType, let cardNumber {
            let cardTypeLocalizedString = NSLocalizedString("Randomly.Do.CardDraw.\(cardType)", comment: "")
            let cardNumberLocalizedString = NSLocalizedString("Randomly.Do.CardDraw.\(cardNumber)", comment: "")
            return String.localizedStringWithFormat(
                NSLocalizedString("Randomly.Do.CardDraw.CardName.%1$@.%2$@", comment: ""),
                cardTypeLocalizedString,
                cardNumberLocalizedString)
        }
        return ""
    }
}
