//
//  PlayingCard.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/13.
//

import Foundation
import SwiftUI

struct PlayingCard: Identifiable {

    let id = UUID()
    var type: PlayingCardType
    var number: Int

    func name() -> String {
        let cardTypeLocalizedString = NSLocalizedString("Do.CardDraw.\(type.rawValue)", comment: "")
        let cardNumberLocalizedString = NSLocalizedString("Do.CardDraw.\(number)", comment: "")
        return String.localizedStringWithFormat(
            NSLocalizedString("Do.CardDraw.CardName.%1$@.%2$@", comment: ""),
            cardTypeLocalizedString,
            cardNumberLocalizedString)
    }

    func imageName() -> String {
        return "\(type.rawValue)\(number)"
    }

    func color() -> Color {
        switch type {
        case .club, .spade:
            return Color.black
        case .diamond, .heart:
            return Color.red
        }
    }
}
