//
//  GenerateWordView.swift
//  Random
//
//  Created by Claude Code on 2026/02/07.
//

import SwiftUI

struct GenerateWordView: View {

    private static let vowels = [
        "a", "e", "i", "o", "u"
    ]
    private static let consonants = [
        "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"
    ]
    private static let startClusters = [
        "bl", "br", "ch", "cl", "cr", "dr", "fl", "fr", "gl",
        "gr", "pl", "pr", "sc", "sh", "sk", "sl", "sm", "sn",
        "sp", "st", "sw", "th", "tr", "tw", "wh", "wr"
    ]
    private static let middleClusters = [
        "ch", "ck", "gh", "ng", "ph", "sh", "ss", "st", "th"
    ]
    private static let doubleVowels = [
        "ea", "ee", "oo", "ou", "ai", "ay", "ey"
    ]

    @State var word: String = ""
    @State var wordLength: Float = 8

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            ScrollView(.horizontal) {
                Text(word)
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .lineLimit(1)
                    .textSelection(.enabled)
                    .padding()
                    .contentTransition(.numericText())
            }
            .scrollIndicators(.hidden)
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Generate.Word.Length.\(String(Int(wordLength)))")
                    Slider(value: $wordLength, in: 3...20, step: 1)
                }
                .padding()
            }
        }
        .randomlyNavigation(title: "Generate.Word.ViewTitle")
        .onAppear {
            generateWord()
        }
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: generateWord,
            disabled: .constant(false),
            copyValue: .constant(word),
            copyDisabled: .constant(word.isEmpty)
        )
    }

    func generateWord() {
        let length = Int(wordLength)

        // Build word parts synchronously
        var parts: [String] = []
        var lastWasVowel = false
        var currentLength = 0

        // Start with consonant or cluster (70% chance for cluster at the beginning)
        if length >= 3 && Bool.random() {
            if let cluster = Self.startClusters.randomElement() {
                parts.append(cluster)
                currentLength += cluster.count
            }
        } else {
            if let consonant = Self.consonants.randomElement() {
                parts.append(consonant)
                currentLength += 1
            }
        }

        // Build the rest of the word with a pattern
        while currentLength < length {
            let remaining = length - currentLength

            if lastWasVowel {
                // Add consonant or cluster
                if remaining >= 2 && Bool.random() && currentLength < length - 1 {
                    // Use a consonant cluster
                    if let cluster = Self.middleClusters.randomElement() {
                        let addCount = min(cluster.count, remaining)
                        let part = String(cluster.prefix(addCount))
                        parts.append(part)
                        currentLength += part.count
                    }
                } else {
                    // Add single consonant
                    if let consonant = Self.consonants.randomElement() {
                        parts.append(consonant)
                        currentLength += 1
                    }
                }
                lastWasVowel = false
            } else {
                // Add vowel (sometimes double vowel for variety)
                if remaining >= 2 && Int.random(in: 1...10) <= 3 {
                    // Add double vowel (30% chance)
                    if let doubleVowel = Self.doubleVowels.randomElement() {
                        let addCount = min(doubleVowel.count, remaining)
                        let part = String(doubleVowel.prefix(addCount))
                        parts.append(part)
                        currentLength += part.count
                    }
                } else {
                    // Add single vowel
                    if let vowel = Self.vowels.randomElement() {
                        parts.append(vowel)
                        currentLength += 1
                    }
                }
                lastWasVowel = true
            }
        }

        // Clear the word with animation
        withAnimation(.default.speed(2)) {
            word = ""
        }

        // Animate each part being added
        Task {
            for part in parts {
                try? await Task.sleep(for: .milliseconds(30))
                await MainActor.run {
                    withAnimation(.default.speed(2)) {
                        word.append(part)
                        // Ensure we don't exceed the target length
                        if word.count > length {
                            word = String(word.prefix(length))
                        }
                    }
                }
            }
        }
    }
}
