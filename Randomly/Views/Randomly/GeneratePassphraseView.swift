//
//  GeneratePassphraseView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI

struct GeneratePassphraseView: View {

    @State var passphrase: String = ""
    @State var wordCount: Float = 4
    @State var separator: String = "-"
    @State var words: [String] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            ScrollView(.horizontal) {
                Text(passphrase)
                    .font(.system(size: 30, weight: .heavy, design: .monospaced))
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
                    Text("Generate.Passphrase.WordCount.\(String(Int(wordCount)))")
                    Slider(value: $wordCount, in: 2...8, step: 1)
                    HStack(alignment: .center, spacing: 4.0) {
                        Text("Generate.Passphrase.Separator")
                            .font(.body)
                            .bold()
                        TextField("-", text: $separator)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)
                    }
                }
                .padding()
            }
        }
        .task {
            loadWords()
            regenerate()
        }
        .randomlyNavigation(title: "Generate.Passphrase.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(words.isEmpty),
            copyValue: .constant(passphrase)
        )
    }

    func loadWords() {
        guard let path = Bundle.main.path(forResource: "Wordlist-EN", ofType: "txt") else { return }
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            words = content.components(separatedBy: .newlines)
                .filter { $0.count >= 3 && $0.count <= 8 }
        } catch { }
    }

    func regenerate() {
        guard !words.isEmpty else { return }
        animateChange {
            let selected = (0..<Int(wordCount)).compactMap { _ in words.randomElement() }
            passphrase = selected.joined(separator: separator)
        }
    }
}
