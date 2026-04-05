// swiftlint:disable file_length
//
//  Intents.swift
//  Intents
//
//  Created by シン・ジャスティン on 2026/04/03.
//

import AppIntents
import Foundation

// MARK: - Generate Number in Range

struct GenerateNumberInRange: AppIntent {
    static var title: LocalizedStringResource { "Intent.GenerateNumber.Title" }
    static var description: IntentDescription { "Intent.GenerateNumber.Description" }

    @Parameter(title: "Intent.GenerateNumber.Minimum", default: 1)
    var minimum: Int

    @Parameter(title: "Intent.GenerateNumber.Maximum", default: 100)
    var maximum: Int

    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        guard maximum >= minimum else {
            throw IntentError.invalidRange
        }
        let result = Int.random(in: minimum...maximum)
        return .result(value: result)
    }
}

// MARK: - Generate Word with Length

struct GenerateWord: AppIntent {
    static var title: LocalizedStringResource { "Intent.GenerateWord.Title" }
    static var description: IntentDescription { "Intent.GenerateWord.Description" }

    @Parameter(title: "Intent.GenerateWord.Length", default: 8, inclusiveRange: (3, 20))
    var length: Int

    private static let vowels = ["a", "e", "i", "o", "u"]
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

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let parts = buildWordParts()
        var word = parts.joined()
        if word.count > length {
            word = String(word.prefix(length))
        }
        return .result(value: word)
    }

    private func buildWordParts() -> [String] {
        var parts: [String] = []
        var lastWasVowel = false
        var currentLength = 0

        if length >= 3 && Bool.random() {
            if let cluster = Self.startClusters.randomElement() {
                parts.append(cluster)
                currentLength += cluster.count
            }
        } else if let consonant = Self.consonants.randomElement() {
            parts.append(consonant)
            currentLength += 1
        }

        while currentLength < length {
            let remaining = length - currentLength
            if lastWasVowel {
                appendConsonantPart(&parts, &currentLength, remaining: remaining)
                lastWasVowel = false
            } else {
                appendVowelPart(&parts, &currentLength, remaining: remaining)
                lastWasVowel = true
            }
        }
        return parts
    }

    private func appendConsonantPart(
        _ parts: inout [String], _ currentLength: inout Int, remaining: Int
    ) {
        if remaining >= 2 && Bool.random() && currentLength < length - 1,
           let cluster = Self.middleClusters.randomElement() {
            let part = String(cluster.prefix(min(cluster.count, remaining)))
            parts.append(part)
            currentLength += part.count
        } else if let consonant = Self.consonants.randomElement() {
            parts.append(consonant)
            currentLength += 1
        }
    }

    private func appendVowelPart(
        _ parts: inout [String], _ currentLength: inout Int, remaining: Int
    ) {
        if remaining >= 2 && Int.random(in: 1...10) <= 3,
           let doubleVowel = Self.doubleVowels.randomElement() {
            let part = String(doubleVowel.prefix(min(doubleVowel.count, remaining)))
            parts.append(part)
            currentLength += part.count
        } else if let vowel = Self.vowels.randomElement() {
            parts.append(vowel)
            currentLength += 1
        }
    }
}

// MARK: - Generate Lorem Ipsum

enum LoremIpsumMode: String, AppEnum {
    case words
    case sentences
    case paragraphs

    static var typeDisplayRepresentation: TypeDisplayRepresentation { "Intent.LoremIpsum.Mode" }
    static var caseDisplayRepresentations: [LoremIpsumMode: DisplayRepresentation] {
        [
            .words: "Intent.LoremIpsum.Mode.Words",
            .sentences: "Intent.LoremIpsum.Mode.Sentences",
            .paragraphs: "Intent.LoremIpsum.Mode.Paragraphs"
        ]
    }
}

struct GenerateLoremIpsum: AppIntent {
    static var title: LocalizedStringResource { "Intent.GenerateLoremIpsum.Title" }
    static var description: IntentDescription { "Intent.GenerateLoremIpsum.Description" }

    @Parameter(title: "Intent.GenerateLoremIpsum.Mode", default: .sentences)
    var mode: LoremIpsumMode

    @Parameter(title: "Intent.GenerateLoremIpsum.Count", default: 3, inclusiveRange: (1, 100))
    var count: Int

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

    // swiftlint:disable:next line_length
    private static let classicOpening = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let result = generate()
        return .result(value: result)
    }

    private func generate() -> String {
        switch mode {
        case .words:
            let openingWords = Self.classicOpening
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: "")
                .components(separatedBy: " ")
            if count <= openingWords.count {
                return openingWords.prefix(count).joined(separator: " ").capitalizingFirst() + "."
            }
            let remaining = generateWords(count - openingWords.count)
            return openingWords.joined(separator: " ") + " " + remaining + "."
        case .sentences:
            if count == 1 {
                return Self.classicOpening
            }
            let rest = (1..<count).map { _ in generateSentence() }.joined(separator: " ")
            return Self.classicOpening + " " + rest
        case .paragraphs:
            let firstParagraph = Self.classicOpening + " " +
                (1..<Int.random(in: 3...6)).map { _ in generateSentence() }.joined(separator: " ")
            if count == 1 {
                return firstParagraph
            }
            let rest = (1..<count).map { _ in generateParagraph() }.joined(separator: "\n\n")
            return firstParagraph + "\n\n" + rest
        }
    }

    private func generateWords(_ count: Int) -> String {
        (0..<count).map { _ in Self.vocabulary.randomElement()! }.joined(separator: " ")
    }

    private func generateSentence() -> String {
        let wordCount = Int.random(in: 5...15)
        return generateWords(wordCount).capitalizingFirst() + "."
    }

    private func generateParagraph() -> String {
        let sentenceCount = Int.random(in: 3...6)
        return (0..<sentenceCount).map { _ in generateSentence() }.joined(separator: " ")
    }
}

// MARK: - Generate Password

struct GeneratePassword: AppIntent {
    static var title: LocalizedStringResource { "Intent.GeneratePassword.Title" }
    static var description: IntentDescription { "Intent.GeneratePassword.Description" }

    @Parameter(title: "Intent.GeneratePassword.MinLength", default: 8, inclusiveRange: (8, 128))
    var minLength: Int

    @Parameter(title: "Intent.GeneratePassword.MaxLength", default: 20, inclusiveRange: (8, 128))
    var maxLength: Int

    @Parameter(title: "Intent.GeneratePassword.Uppercase", default: true)
    var useUppercase: Bool

    @Parameter(title: "Intent.GeneratePassword.Lowercase", default: true)
    var useLowercase: Bool

    @Parameter(title: "Intent.GeneratePassword.Numbers", default: true)
    var useNumbers: Bool

    @Parameter(title: "Intent.GeneratePassword.Symbols", default: true)
    var useSymbols: Bool

    private static let lowercaseChars = "abcdefghijklmnopqrstuvwxyz"
    private static let uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private static let numberChars = "0123456789"
    private static let symbolChars = ".!-#$"

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        guard maxLength >= minLength else {
            throw IntentError.invalidRange
        }
        guard useUppercase || useLowercase || useNumbers || useSymbols else {
            throw IntentError.noCharacterSets
        }

        var chars = ""
        var requiredSets: [String] = []
        if useUppercase {
            chars += Self.uppercaseChars
            requiredSets.append(Self.uppercaseChars)
        }
        if useLowercase {
            chars += Self.lowercaseChars
            requiredSets.append(Self.lowercaseChars)
        }
        if useNumbers {
            chars += Self.numberChars
            requiredSets.append(Self.numberChars)
        }
        if useSymbols {
            chars += Self.symbolChars
            requiredSets.append(Self.symbolChars)
        }

        var password: String
        repeat {
            let length = Int.random(in: minLength...maxLength)
            password = String((0..<length).compactMap { _ in chars.randomElement() })
        } while !requiredSets.allSatisfy({ set in
            password.contains(where: { set.contains($0) })
        })

        return .result(value: password)
    }
}

// MARK: - Generate Colors

struct GenerateColor: AppIntent {
    static var title: LocalizedStringResource { "Intent.GenerateColor.Title" }
    static var description: IntentDescription { "Intent.GenerateColor.Description" }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let red = Int.random(in: 0..<255)
        let green = Int.random(in: 0..<255)
        let blue = Int.random(in: 0..<255)
        let hex = String(format: "#%02X%02X%02X", red, green, blue)
        return .result(value: hex)
    }
}

// MARK: - Generate Coordinates

struct GenerateCoordinates: AppIntent {
    static var title: LocalizedStringResource { "Intent.GenerateCoordinates.Title" }
    static var description: IntentDescription { "Intent.GenerateCoordinates.Description" }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let landRegions: [(latRange: ClosedRange<Double>, lonRange: ClosedRange<Double>)] = [
            (15...72, -168...(-52)),
            (-56...13, -82...(-34)),
            (36...71, -10...40),
            (-35...37, -18...52),
            (-10...77, 26...180),
            (-47...(-10), 113...180),
            (40...77, -180...(-130))
        ]

        let latitude: Double
        let longitude: Double

        if Double.random(in: 0...1) < 0.8 {
            let region = landRegions.randomElement()!
            latitude = Double.random(in: region.latRange)
            longitude = Double.random(in: region.lonRange)
        } else {
            latitude = Double.random(in: -90...90)
            longitude = Double.random(in: -180...180)
        }

        let result = "\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))"
        return .result(value: result)
    }
}

// MARK: - Select Letter

struct SelectLetter: AppIntent {
    static var title: LocalizedStringResource { "Intent.SelectLetter.Title" }
    static var description: IntentDescription { "Intent.SelectLetter.Description" }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let letterIndex = Int.random(in: 0...25)
        let letter = String(Character(UnicodeScalar(65 + letterIndex)!))
        return .result(value: letter)
    }
}

// MARK: - Select Word

struct SelectWord: AppIntent {
    static var title: LocalizedStringResource { "Intent.SelectWord.Title" }
    static var description: IntentDescription { "Intent.SelectWord.Description" }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        guard let path = Bundle.main.path(forResource: "Wordlist-EN", ofType: "txt"),
              let wordlist = try? String(contentsOfFile: path, encoding: .utf8) else {
            throw IntentError.wordlistUnavailable
        }
        let words = wordlist.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard let word = words.randomElement() else {
            throw IntentError.wordlistUnavailable
        }
        return .result(value: word)
    }
}

// MARK: - Select Emoji

struct SelectEmoji: AppIntent {
    static var title: LocalizedStringResource { "Intent.SelectEmoji.Title" }
    static var description: IntentDescription { "Intent.SelectEmoji.Description" }

    private static let emojiRanges: [ClosedRange<UInt32>] = [
        0x1F600...0x1F64F,
        0x1F300...0x1F5FF,
        0x1F680...0x1F6FF,
        0x1F900...0x1F9FF,
        0x1FA00...0x1FA6F,
        0x1FA70...0x1FAFF,
        0x2600...0x26FF,
        0x2700...0x27BF,
        0x1F1E0...0x1F1FF
    ]

    private static let allEmoji: [String] = {
        emojiRanges.flatMap { range in
            range.compactMap { value in
                guard let scalar = Unicode.Scalar(value) else { return nil }
                let character = Character(scalar)
                guard character.unicodeScalars.first.map({
                    $0.properties.isEmoji && $0.value > 0x238C
                }) == true else { return nil }
                return String(character)
            }
        }
    }()

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let emoji = Self.allEmoji.randomElement() ?? "😀"
        return .result(value: emoji)
    }
}

// MARK: - Select Date

struct SelectDate: AppIntent {
    static var title: LocalizedStringResource { "Intent.SelectDate.Title" }
    static var description: IntentDescription { "Intent.SelectDate.Description" }

    @Parameter(title: "Intent.SelectDate.StartDate")
    var startDate: Date?

    @Parameter(title: "Intent.SelectDate.EndDate")
    var endDate: Date?

    func perform() async throws -> some IntentResult & ReturnsValue<Date> {
        let start = startDate ?? Date(timeIntervalSince1970: 885686400)
        let end = endDate ?? Date()
        guard end > start else {
            throw IntentError.invalidRange
        }
        let randomInterval = TimeInterval.random(in: start.timeIntervalSince1970...end.timeIntervalSince1970)
        let result = Date(timeIntervalSince1970: randomInterval)
        return .result(value: result)
    }
}

// MARK: - Select Time

struct SelectTime: AppIntent {
    static var title: LocalizedStringResource { "Intent.SelectTime.Title" }
    static var description: IntentDescription { "Intent.SelectTime.Description" }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let randomHour = Int.random(in: 0...23)
        let randomMinute = Int.random(in: 0...59)

        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = randomHour
        components.minute = randomMinute
        components.second = 0

        let date = calendar.date(from: components) ?? Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return .result(value: formatter.string(from: date))
    }
}

// SelectCountry, CountryData, RandomlyShortcuts, IntentError, and helpers
// are in IntentsSupport.swift
