//
//  Password.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

// Adapted from the Guru project
// https://github.com/katagaki/Guru

import Foundation
import UIKit

class Password: ObservableObject {

    @Published var generated: String = ""
    @Published var minLength: Int = 8
    @Published var maxLength: Int = 16
    @Published var policies: [Policy] = [.containsUppercase, .containsLowercase, .containsNumbers, .containsSymbols]

    init(forPolicies policies: [Policy],
         withMinLength lengthMin: Int,
         withMaxLength lengthMax: Int) {
        self.policies = policies
        minLength = lengthMin
        maxLength = lengthMax
        regenerate()
    }

    func regenerate() {
        repeat {
            let chars: String = characterSet(forPolicies: policies)
            let length: Int = secureRandomNumber(from: minLength, to: maxLength)
            generated = String((0..<length).compactMap { _ in
                chars.randomElement()
            })
        } while (!acceptability(ofPassword: generated))
    }

    private func characterSet(forPolicies policies: [Policy]) -> String {
        var chars: String = ""
        for policy in policies {
            chars += policy.rawValue.shuffled()
        }
        return chars
    }

    private func characterSet(forPolicy policy: Policy, withLength length: Int) -> String {
        var finalChars: String = ""
        let validChars: String = characterSet(forPolicies: [policy])
        for _ in 0..<length {
            finalChars += String(validChars.character(in: secureRandomNumber(to: validChars.count)))
        }
        return finalChars
    }

    func acceptability(ofPassword password: String) -> Bool {
        var passwordAcceptable: Bool = true
        if password.trimmingCharacters(in: .whitespaces).count != password.count {
            return false
        } else {
            for policy in policies where
            password.rangeOfCharacter(from: CharacterSet(charactersIn: policy.rawValue)) == nil {
                passwordAcceptable = false
            }
            return passwordAcceptable
        }
    }

    func attributed() -> AttributedString {
        var attributedString = AttributedString(generated)
        for indice in attributedString.characters.indices {
            let char: Character = attributedString.characters[indice]
            switch true {
            case char.isUppercase:
                attributedString[indice..<attributedString.characters.index(after: indice)].foregroundColor = .indigo
            case char.isLowercase:
                attributedString[indice..<attributedString.characters.index(after: indice)].foregroundColor = .blue
            case char.isNumber:
                attributedString[indice..<attributedString.characters.index(after: indice)].foregroundColor = .red
            default:
                attributedString[indice..<attributedString.characters.index(after: indice)].foregroundColor = .orange
            }
        }
        return attributedString
    }

    // swiftlint:disable identifier_name
    func secureRandomNumber(to: Int) -> Int {
        if to == 0 {
            return 0
        } else {
            return secureRandomNumber() % to
        }
    }
    // swiftlint:enable identifier_name

    // swiftlint:disable identifier_name
    func secureRandomNumber(from: Int, to: Int) -> Int {
        let diff = to - from
        if from == to {
            return from
        } else {
            return from + (secureRandomNumber() % diff)
        }
    }
    // swiftlint:enable identifier_name

    func secureRandomNumber() -> Int {
        let bytesCount = 4
        var random: UInt32 = 0
        var randomBytes = [UInt8](repeating: 0, count: bytesCount)
        _ = SecRandomCopyBytes(kSecRandomDefault, bytesCount, &randomBytes)
        NSData(bytes: randomBytes, length: bytesCount).getBytes(&random, length: bytesCount)
        return Int(random)
    }

    enum Policy: String {
        case containsLowercase = "abcdefghijklmnopqrstuvwxyz"
        case containsUppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case containsNumbers = "0123456789"
        case containsSymbols = ".!-#$"
    }

}

extension String {
    func character(in index: Int) -> Character {
        if index > (Array(self).count - 1) {
            return Character(" ")
        } else {
            return Array(self)[index]
        }
    }
}
