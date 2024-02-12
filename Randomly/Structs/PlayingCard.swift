//
//  PlayingCard.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/13.
//

import Foundation

struct PlayingCard {
    var type: DrawnCardType
    var number: Int
    
    func name() -> String {
        let cardTypeLocalizedString = NSLocalizedString("Randomly.Do.CardDraw.\(type.rawValue)", comment: "")
        let cardNumberLocalizedString = NSLocalizedString("Randomly.Do.CardDraw.\(number)", comment: "")
        return String.localizedStringWithFormat(
            NSLocalizedString("Randomly.Do.CardDraw.CardName.%1$@.%2$@", comment: ""),
            cardTypeLocalizedString,
            cardNumberLocalizedString)
    }
}
