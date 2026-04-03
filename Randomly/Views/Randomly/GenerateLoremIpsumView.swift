//
//  GenerateLoremIpsumView.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct GenerateLoremIpsumView: View {

    enum LoremMode: String, CaseIterable {
        case words = "Generate.LoremIpsum.Mode.Words"
        case sentences = "Generate.LoremIpsum.Mode.Sentences"
        case paragraphs = "Generate.LoremIpsum.Mode.Paragraphs"
    }

    private static let vocabulary: [String] = [
        "lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
        "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore",
        "magna", "aliqua", "enim", "ad", "minim", "veniam", "quis", "nostrud",
        "exercitation", "ullamco", "laboris", "nisi", "aliquip", "ex", "ea", "commodo",
        "consequat", "duis", "aute", "irure", "in", "reprehenderit", "voluptate",
        "velit", "esse", "cillum", "fugiat", "nulla", "pariatur", "excepteur", "sint",
        "occaecat", "cupidatat", "non", "proident", "sunt", "culpa", "qui", "officia",
        "deserunt", "mollit", "anim", "id", "est", "laborum", "at", "vero", "eos",
        "accusamus", "iusto", "odio", "dignissimos", "ducimus", "blanditiis",
        "praesentium", "voluptatum", "deleniti", "atque", "corrupti", "quos", "dolores",
        "quas", "molestias", "excepturi", "obcaecati", "cupiditate", "provident",
        "similique", "mollitia", "animi", "perspiciatis", "unde", "omnis", "iste",
        "natus", "error", "voluptatem", "accusantium", "doloremque", "laudantium",
        "totam", "rem", "aperiam", "eaque", "ipsa", "quae", "ab", "illo", "inventore",
        "veritatis", "quasi", "architecto", "beatae", "vitae", "dicta", "explicabo",
        "nemo", "ipsam", "voluptas", "aspernatur", "aut", "odit", "fugit",
        "consequuntur", "magni", "dolorem", "porro", "quisquam", "nihil", "impedit",
        "quo", "minus", "quod", "maxime", "placeat", "facere", "possimus", "assumenda",
        "repellendus", "temporibus", "quibusdam", "illum", "fugiam", "ratione",
        "voluptatibus", "maiores", "alias", "perferendis", "doloribus", "asperiores",
        "repellat", "nesciunt", "neque", "corporis", "suscipit", "laboriosam",
        "consequatur", "vel", "illum", "dolore", "eu", "recusandae", "itaque",
        "earum", "rerum", "hic", "tenetur", "sapiente", "delectus", "reiciendis",
        "voluptatibus", "maiores", "numquam", "eius", "modi", "tempora", "incidunt",
        "magnam", "aliquam", "quaerat"
    ]

    private static let classicOpening = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    @State var result: String = ""
    @State var mode: LoremMode = .sentences
    @State var count: Float = 3
    @State var isFirstGeneration: Bool = true

    var countRange: ClosedRange<Float> {
        switch mode {
        case .words: return 1...100
        case .sentences: return 1...20
        case .paragraphs: return 1...10
        }
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ScrollView {
                Text(result)
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .textSelection(.enabled)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentTransition(.numericText())
            }
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Picker("Generate.LoremIpsum.Mode", selection: $mode) {
                        ForEach(LoremMode.allCases, id: \.self) { loremMode in
                            Text(LocalizedStringKey(loremMode.rawValue)).tag(loremMode)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("Generate.LoremIpsum.Count.\(String(Int(count)))")
                    Slider(value: $count, in: countRange, step: 1)
                }
                .padding()
            }
        }
        .onChange(of: mode) {
            count = min(count, countRange.upperBound)
            regenerate()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Generate.LoremIpsum.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(result)
        )
    }

    func regenerate() {
        animateChange {
            result = generate()
        }
    }

    func generate() -> String {
        let amount = Int(count)
        let useOpening = isFirstGeneration
        isFirstGeneration = false

        switch mode {
        case .words:
            if useOpening {
                let openingWords = Self.classicOpening
                    .replacingOccurrences(of: ".", with: "")
                    .replacingOccurrences(of: ",", with: "")
                    .components(separatedBy: " ")
                if amount <= openingWords.count {
                    return openingWords.prefix(amount).joined(separator: " ").capitalizingFirst() + "."
                }
                let remaining = generateWords(amount - openingWords.count)
                return openingWords.joined(separator: " ") + " " + remaining + "."
            }
            return generateWords(amount).capitalizingFirst() + "."
        case .sentences:
            if useOpening {
                if amount == 1 {
                    return Self.classicOpening
                }
                let rest = (1..<amount).map { _ in generateSentence() }.joined(separator: " ")
                return Self.classicOpening + " " + rest
            }
            return (0..<amount).map { _ in generateSentence() }.joined(separator: " ")
        case .paragraphs:
            if useOpening {
                let firstParagraph = Self.classicOpening + " " +
                    (1..<Int.random(in: 3...6)).map { _ in generateSentence() }.joined(separator: " ")
                if amount == 1 {
                    return firstParagraph
                }
                let rest = (1..<amount).map { _ in generateParagraph() }.joined(separator: "\n\n")
                return firstParagraph + "\n\n" + rest
            }
            return (0..<amount).map { _ in generateParagraph() }.joined(separator: "\n\n")
        }
    }

    func generateWords(_ count: Int) -> String {
        (0..<count).map { _ in Self.vocabulary.randomElement()! }.joined(separator: " ")
    }

    func generateSentence() -> String {
        let wordCount = Int.random(in: 5...15)
        return generateWords(wordCount).capitalizingFirst() + "."
    }

    func generateParagraph() -> String {
        let sentenceCount = Int.random(in: 3...6)
        return (0..<sentenceCount).map { _ in generateSentence() }.joined(separator: " ")
    }
}

private extension String {
    func capitalizingFirst() -> String {
        prefix(1).uppercased() + dropFirst()
    }
}
