//
//  PickEmojiView.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct PickEmojiView: View {

    @State var result: String = ""

    static let emojiRanges: [ClosedRange<UInt32>] = [
        0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        0x1FA00...0x1FA6F, // Chess Symbols / Extended-A
        0x1FA70...0x1FAFF, // Symbols and Pictographs Extended-A
        0x2600...0x26FF,   // Misc Symbols
        0x2700...0x27BF,   // Dingbats
        0x1F1E0...0x1F1FF  // Flags (Regional Indicators)
    ]

    static let allEmoji: [String] = {
        emojiRanges.flatMap { range in
            range.compactMap { value in
                guard let scalar = Unicode.Scalar(value) else { return nil }
                let character = Character(scalar)
                guard character.isEmoji else { return nil }
                return String(character)
            }
        }
    }()

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(result, fontSize: 200)
            Spacer()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Select.Emoji.ViewTitle")
        .actionBar(
            text: "Shared.Pick",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(result)
        )
    }

    func regenerate() {
        animateChange {
            result = Self.allEmoji.randomElement() ?? "😀"
        }
    }
}

private extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && scalar.value > 0x238C
    }
}
