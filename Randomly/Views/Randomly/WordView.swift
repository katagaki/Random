//
//  WordView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct WordView: View {

    enum WordMode: String, CaseIterable {
        case pick = "Word.Mode.Pick"
        case generate = "Word.Mode.Generate"
    }

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

    @State var mode: WordMode = .pick
    @State var word: String = ""
    @State var wordLength: Float = 8
    @State var words: [String] = []
    @State var isAnimating: Bool = false

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
                    if mode == .generate {
                        Text("Generate.Word.Length.\(String(Int(wordLength)))")
                        Slider(value: $wordLength, in: 3...20, step: 1)
                    }
                    Picker("Word.Mode", selection: $mode) {
                        ForEach(WordMode.allCases, id: \.self) { wordMode in
                            Text(LocalizedStringKey(wordMode.rawValue)).tag(wordMode)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
            }
        }
        .randomlyNavigation(title: "Word.ViewTitle")
        .onAppear {
            perform()
        }
        .onChange(of: mode) {
            word = ""
            perform()
        }
        .actionBar(
            text: mode == .pick ? "Shared.Pick" : "Shared.Generate",
            icon: "sparkles",
            action: perform,
            disabled: $isAnimating,
            copyValue: .constant(word),
            copyDisabled: .constant(word.isEmpty)
        )
    }

    func perform() {
        switch mode {
        case .pick:
            pickWord()
        case .generate:
            generateWord()
        }
    }

    func pickWord() {
        if words.isEmpty {
            let fileName: String
            switch Locale.current.language.languageCode ?? .english {
            case .japanese:
                fileName = "Wordlist-JP"
            default:
                fileName = "Wordlist-EN"
            }
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
                do {
                    let wordlist = try String(contentsOfFile: path, encoding: .utf8)
                    words = wordlist.components(separatedBy: .newlines)
                } catch {
                    words.removeAll()
                }
            }
        }
        if let picked = words.randomElement() {
            animateChange {
                word = picked
            }
        }
    }

    func generateWord() {
        let length = Int(wordLength)

        var parts: [String] = []
        var lastWasVowel = false
        var currentLength = 0

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

        while currentLength < length {
            let remaining = length - currentLength

            if lastWasVowel {
                if remaining >= 2 && Bool.random() && currentLength < length - 1 {
                    if let cluster = Self.middleClusters.randomElement() {
                        let addCount = min(cluster.count, remaining)
                        let part = String(cluster.prefix(addCount))
                        parts.append(part)
                        currentLength += part.count
                    }
                } else {
                    if let consonant = Self.consonants.randomElement() {
                        parts.append(consonant)
                        currentLength += 1
                    }
                }
                lastWasVowel = false
            } else {
                if remaining >= 2 && Int.random(in: 1...10) <= 3 {
                    if let doubleVowel = Self.doubleVowels.randomElement() {
                        let addCount = min(doubleVowel.count, remaining)
                        let part = String(doubleVowel.prefix(addCount))
                        parts.append(part)
                        currentLength += part.count
                    }
                } else {
                    if let vowel = Self.vowels.randomElement() {
                        parts.append(vowel)
                        currentLength += 1
                    }
                }
                lastWasVowel = true
            }
        }

        Task {
            isAnimating = true

            if !word.isEmpty {
                repeat {
                    try? await Task.sleep(for: .milliseconds(10))
                    await MainActor.run {
                        withAnimation(.default.speed(3)) {
                            word = String(word.prefix(word.count - 1))
                        }
                    }
                } while !word.isEmpty
            }

            for part in parts {
                try? await Task.sleep(for: .milliseconds(30))
                await MainActor.run {
                    withAnimation(.default.speed(2)) {
                        word.append(part)
                        if word.count > length {
                            word = String(word.prefix(length))
                        }
                    }
                }
            }

            isAnimating = false
        }
    }
}
