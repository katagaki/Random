//
//  SelectWordFromTextView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct SelectWordFromTextView: View {

    // TODO: Improve Japanese word selection using wordlist
    let japaneseKana = CharacterSet(charactersIn:
    """
    あいうえおぁぃぅぇぉ
    かきくけこがぎぐげご
    さしすせそざじずぜぞ
    たちつてとだぢづでどっ
    なにぬねの
    はひふへほばびぶべぼぱぴぷぺぽ
    まみむめも
    やゆよゃゅょ
    らりるれろ
    わゐゑをゎ
    ん
    アイウエオァィゥェォ
    カキクケコガギグゲゴヵ
    サシスセソザジズゼゾ
    タチツテトダヂヅデドッ
    ナニヌネノ
    ハヒフヘホバビブベボパピプペポ
    マミムメモ
    ヤユヨャュョ
    ラリルレロ
    ワヰヱヲヮ
    ン
    """)
    let japaneseParticles = CharacterSet(charactersIn:
    """
    がなにのはをも
    """)
    let japaneseSymbols = CharacterSet(charactersIn:
    """
    　！”＃＄％＆’（）ー＝＾〜＼｜￥＠｀「「『［；＋：＊」』］、＜，。＞．・？／_
    """)
    @State var mode: WordSelectionMode = .kanjiOnly
    @State var text: String = ""
    @State var selectedWord: String?
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Text(selectedWord ?? "")
                .frame(height: 70)
                .font(.system(size: 200.0, weight: .heavy, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .padding()
            Divider()
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Shared.EnterText")
                    .font(.body)
                    .bold()
                TextEditor(text: $text)
                    .focused($isTextFieldActive)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.primary, lineWidth: 1/3)
                            .opacity(0.3)
                    )
                if let languageCode = Locale.current.language.languageCode {
                    if languageCode != .english {
                        Text("Randomly.Select.WordFromText.LanguageDisclaimer")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8.0)
            Divider()
            ActionBar(primaryActionText: "Shared.Select",
                      primaryActionIconName: "lasso.sparkles",
                      copyDisabled: .constant(selectedWord == nil),
                      primaryActionDisabled: .constant(words().count == 0)) {
                selectedWord = words().randomElement()!.lowercased()
            } copyAction: {
                if let selectedWord = selectedWord {
                    UIPasteboard.general.string = selectedWord
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .onAppear {
            isTextFieldActive = true
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Shared.Done") {
                    isTextFieldActive = false
                }
                .bold()
            }
            if let languageCode = Locale.current.language.languageCode {
                if languageCode != .english {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Randomly.Select.WordFromText.SelectionMode", selection: $mode) {
                                Text("Randomly.Select.WordFromText.SelectionMode.EnglishOnly")
                                    .tag(WordSelectionMode.english)
                                Text("Randomly.Select.WordFromText.SelectionMode.KanjiOnly")
                                    .tag(WordSelectionMode.kanjiOnly)
                                Text("Randomly.Select.WordFromText.SelectionMode.ParticlesBestAttempt")
                                    .tag(WordSelectionMode.particleBestAttempt)
                            }
                        } label: {
                            Text("Randomly.Select.WordFromText.SelectionMode")
                        }
                    }
                }
            }
        }
        .navigationTitle("Randomly.Select.WordFromText.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func words() -> [String] {
        if let languageCode = Locale.current.language.languageCode {
            var textComponents: [String] = []
            switch languageCode {
            case .english:
                textComponents = text.components(separatedBy: .letters.inverted
                    .union(.whitespacesAndNewlines))
            case .japanese:
                switch mode {
                case .english:
                    textComponents = text.components(separatedBy: .symbols
                        .union(.whitespacesAndNewlines))
                case .kanjiOnly:
                    textComponents = text.components(separatedBy: japaneseKana
                        .union(japaneseSymbols)
                        .union(.whitespacesAndNewlines))
                case .particleBestAttempt:
                    textComponents = text.components(separatedBy: japaneseParticles
                        .union(japaneseSymbols)
                        .union(.whitespacesAndNewlines))
                }
            default: break
            }
            textComponents.removeAll { textComponent in
                textComponent == ""
            }
            return textComponents
        } else {
            return []
        }
    }
}
