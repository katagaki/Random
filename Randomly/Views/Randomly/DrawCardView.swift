//
//  DrawCardView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/12.
//

import SwiftUI

struct DrawCardView: View {

    @State var cardsInDeck: [PlayingCard] = []
    @State var cardsDrawn: [PlayingCard] = []
    @State var numberOfCardsToDraw: Float = 1.0

    var body: some View {
        ScrollView {
            let scale: Float = 1.0 - (0.07 * (numberOfCardsToDraw - 1))
            VStack(alignment: .center, spacing: 16.0) {
                ForEach(cardsDrawn) { card in
                    Image(card.imageName())
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity,
                               minHeight: CGFloat(350.0 * scale),
                               maxHeight: CGFloat(350.0 * scale))
                        .background {
                            Rectangle()
                                .fill(card.color())
                                .frame(width: CGFloat(225.0 * scale), height: CGFloat(310.0 * scale))
                        }
                        .drawingGroup()
                        .shadow(color: .black.opacity(0.2), radius: 10.0, y: 12.0)
                        .transition(.push(from: .top).combined(with: .scale))
                        .id(card.imageName())
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .center, spacing: 16.0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Do.CardDraw.NumberToDraw.\(String(Int(numberOfCardsToDraw)))")
                    Slider(value: $numberOfCardsToDraw, in: 1...6, step: 1)
                }
                ActionBar(primaryActionText: "Shared.Draw",
                          primaryActionIconName: "sparkles",
                          copyDisabled: .constant(false),
                          primaryActionDisabled: .constant(false)) {
                    drawCards()
                } copyAction: {
                    let cardNames: String = cardsDrawn.reduce(into: "", { partialResult, card in
                        partialResult += card.name() + "\n"
                    })
                    UIPasteboard.general.string = cardNames.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                .frame(maxWidth: .infinity)
            }
            .padding([.top, .bottom], 16.0)
            .padding([.leading, .trailing])
            .background(Material.bar)
            .overlay(alignment: .top) {
                Rectangle()
                    .frame(height: 1/3)
                    .foregroundColor(.primary.opacity(0.2))
            }
        }
        .toolbarBackground(.hidden, for: .tabBar)
        .task {
            drawCards()
        }
        .onChange(of: numberOfCardsToDraw) {
            drawCards()
        }
        .navigationTitle("Do.CardDraw.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func drawCards() {
        withAnimation(.default.speed(2)) {
            resetDeck()
            for _ in 0..<Int(numberOfCardsToDraw) {
                cardsDrawn.append(cardsInDeck.remove(at: (0..<cardsInDeck.count).randomElement()!))
            }
        }
    }

    func resetDeck() {
        let cardTypes: [PlayingCardType] = [.club, .diamond, .heart, .spade]
        let cardNumbers: [Int] = Array(1...13)
        cardsDrawn.removeAll()
        cardsInDeck.removeAll()
        for cardType in cardTypes {
            for cardNumber in cardNumbers {
                cardsInDeck.append(PlayingCard(type: cardType, number: cardNumber))
            }
        }
        cardsInDeck.shuffle()
    }
}
