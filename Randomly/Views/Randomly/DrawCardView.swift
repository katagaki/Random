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
        if #available(iOS 26.0, *) {
            ios26Body
        } else {
            legacyBody
        }
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
        ScrollView {
            cardGrid
                .padding()
        }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Do.CardDraw.NumberToDraw.\(String(Int(numberOfCardsToDraw)))")
                Slider(value: $numberOfCardsToDraw, in: 1...6, step: 1)
            }
            .bottomBarBackground()
        }
        .task {
            drawCards()
        }
        .onChange(of: numberOfCardsToDraw) {
            drawCards()
        }
        .randomlyNavigation(title: "Do.CardDraw.ViewTitle")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    let cardNames: String = cardsDrawn.reduce(into: "", { partialResult, card in
                        partialResult += card.name() + "\n"
                    })
                    UIPasteboard.general.string = cardNames.trimmingCharacters(in: .whitespacesAndNewlines)
                } label: {
                    Label(.sharedCopy, systemImage: "doc.on.doc")
                }
            }
            ToolbarSpacer(.flexible, placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                Button("Shared.Draw", systemImage: "sparkles") {
                    drawCards()
                }
                .buttonStyle(.glassProminent)
            }
        }
    }

    var legacyBody: some View {
        ScrollView {
            cardGrid
                .padding()
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
            .bottomBarBackground()
        }
        .task {
            drawCards()
        }
        .onChange(of: numberOfCardsToDraw) {
            drawCards()
        }
        .randomlyNavigation(title: "Do.CardDraw.ViewTitle")
    }

    var cardGrid: some View {
        let numberOfCards = cardsDrawn.count

        return Group {
            if numberOfCards == 1 {
                cardView(for: cardsDrawn.first!)
                    .padding()
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16.0) {
                    ForEach(cardsDrawn) { card in
                        cardView(for: card)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func cardView(for card: PlayingCard) -> some View {
        Image(card.imageName())
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .aspectRatio(225.0 / 310.0, contentMode: .fit)
            .background {
                Rectangle()
                    .fill(card.color())
                    .aspectRatio(225.0 / 310.0, contentMode: .fit)
                    .scaleEffect(0.9)
            }
            .drawingGroup()
            .scaleEffect(1.2)
            .shadow(color: .black.opacity(0.2), radius: 10.0, y: 12.0)
            .transition(.push(from: .top).combined(with: .scale))
            .id(card.imageName())
    }

    func drawCards() {
        animateChange {
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
