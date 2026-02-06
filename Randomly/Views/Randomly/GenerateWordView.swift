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

    @State var generatedWord: String = ""
    @State var wordLength: Float = 8

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            ScrollView(.horizontal) {
                Text(generatedWord)
                    .font(.system(size: 50, weight: .heavy, design: .monospaced))
                    .lineLimit(1)
                    .textSelection(.enabled)
                    .padding()
            }
            .scrollIndicators(.hidden)
            Spacer()
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Generate.Word.Length.\(String(Int(wordLength)))")
                Slider(value: $wordLength, in: 3...20, step: 1)
            }
            .padding()
            Divider()
            ActionBar(primaryActionText: "Shared.Generate",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(generatedWord.isEmpty),
                      primaryActionDisabled: .constant(false)) {
                generateWord()
            } copyAction: {
                UIPasteboard.general.string = generatedWord
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .navigationTitle("Generate.Word.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            generateWord()
        }
    }

    func generateWord() {
        let length = Int(wordLength)
        var word = ""

        // Start with consonant or cluster (70% chance for cluster at the beginning)
        if length >= 3 && Bool.random() {
            if let cluster = Self.startClusters.randomElement() {
                word.append(cluster)
            }
        } else {
            if let consonant = Self.consonants.randomElement() {
                word.append(consonant)
            }
        }

        // Build the rest of the word with a pattern
        var lastWasVowel = false

        while word.count < length {
            let remaining = length - word.count

            if lastWasVowel {
                // Add consonant or cluster
                if remaining >= 2 && Bool.random() && word.count < length - 1 {
                    // Use a consonant cluster
                    if let cluster = Self.middleClusters.randomElement() {
                        let addCount = min(cluster.count, remaining)
                        word.append(String(cluster.prefix(addCount)))
                    }
                } else {
                    // Add single consonant
                    if let consonant = Self.consonants.randomElement() {
                        word.append(consonant)
                    }
                }
                lastWasVowel = false
            } else {
                // Add vowel (sometimes double vowel for variety)
                if remaining >= 2 && Int.random(in: 1...10) <= 3 {
                    // Add double vowel (30% chance)
                    if let doubleVowel = Self.doubleVowels.randomElement() {
                        let addCount = min(doubleVowel.count, remaining)
                        word.append(String(doubleVowel.prefix(addCount)))
                    }
                } else {
                    // Add single vowel
                    if let vowel = Self.vowels.randomElement() {
                        word.append(vowel)
                    }
                }
                lastWasVowel = true
            }
        }

        // Ensure we don't exceed the target length
        word = String(word.prefix(length))

        // Capitalize first letter
        generatedWord = word.prefix(1).uppercased() + word.dropFirst()
    }
}
