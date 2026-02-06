//
//  PickNumberLetterWordView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import Combine
import SwiftUI

struct PickNumberLetterWordView: View {

    @State var mode: GenerateType
    @State var result: String = ""
    @State var rangeStart: Int = 1
    @State var rangeEnd: Int = 100
    @State var words: [String] = []
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Text(result)
                .font(.system(size: 200.0, weight: .heavy, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .textSelection(.enabled)
                .padding()
                .transition(.scale.combined(with: .opacity))
                .id(result)
            Spacer()
            switch mode {
            case .number:
                Divider()
                HStack(alignment: .center, spacing: 4.0) {
                    Text("Shared.RangeFrom")
                        .font(.body)
                        .bold()
                    TextField("", value: $rangeStart, format: .number)
                        .limitInputLength(value: $rangeStart, length: 17)
                        .focused($isTextFieldActive)
                    Text("Shared.RangeTo")
                        .font(.body)
                        .bold()
                    TextField("", value: $rangeEnd, format: .number)
                        .limitInputLength(value: $rangeEnd, length: 17)
                        .focused($isTextFieldActive)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                Divider()
            default:
                Divider()
            }
            ActionBar(primaryActionText: "Shared.Pick",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(false),
                      primaryActionDisabled: .constant(rangeEnd <= rangeStart ||
                                                       rangeStart < -99999999999999999 ||
                                                       rangeEnd > 99999999999999999)) {
                regenerate()
            } copyAction: {
                UIPasteboard.general.string = result
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .task {
            regenerate()
        }
        .navigationTitle(NSLocalizedString(mode.rawValue, comment: ""))
        .navigationBarTitleDisplayMode(.inline)
    }

    func regenerate() {
        withAnimation(.default.speed(2)) {
            switch mode {
            case .number:
                result = String(Int.random(in: rangeStart...rangeEnd))
            case .letter:
                let letterIndex: Int = Int.random(in: 0...25)
                result = String(Character(UnicodeScalar(65 + letterIndex)!))
            case .englishWord:
                if words.count == 0 {
                    let path = Bundle.main.path(forResource: "Wordlist-EN", ofType: "txt")!
                    do {
                        let wordlist: String = try String(contentsOfFile: path, encoding: .utf8)
                        words = wordlist.components(separatedBy: .newlines)
                    } catch {
                        words.removeAll()
                    }
                }
                result = words.randomElement()!
            case .japaneseWord:
                if words.count == 0 {
                    let path = Bundle.main.path(forResource: "Wordlist-JP", ofType: "txt")!
                    do {
                        let wordlist: String = try String(contentsOfFile: path, encoding: .utf8)
                        words = wordlist.components(separatedBy: .newlines)
                    } catch {
                        words.removeAll()
                    }
                }
                result = words.randomElement()!
            }
        }
    }
}

// swiftlint:disable line_length
// Modified input length limiter from:
// https://sanzaru84.medium.com/swiftui-an-updated-approach-to-limit-the-amount-of-characters-in-a-textfield-view-984c942a156
// swiftlint:enable line_length

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: Int
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(Just(value)) {
                value = Int(String($0).prefix(length))!
            }
    }
}

extension View {
    func limitInputLength(value: Binding<Int>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
