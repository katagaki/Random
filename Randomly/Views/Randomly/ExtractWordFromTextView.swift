//
//  ExtractWordFromTextView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ExtractWordFromTextView: View {

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
            LargeDisplayTextView(selectedWord ?? "", fontSize: 200)
                .frame(height: 70)
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
                        Text("Select.WordFromText.LanguageDisclaimer")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8.0)
            Divider()
            ActionBar(primaryActionText: "Shared.Extract",
                      primaryActionIconName: "lasso.sparkles",
                      copyDisabled: .constant(selectedWord == nil),
                      primaryActionDisabled: .constant(words().count == 0)) {
                isTextFieldActive = false
                selectedWord = words().randomElement()!.lowercased()
            } copyAction: {
                if let selectedWord = selectedWord {
                    UIPasteboard.general.string = selectedWord
                }
            }
            .frame(maxWidth: .infinity)
            .horizontalPadding()
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .onAppear {
            isTextFieldActive = true
        }
        .toolbar {
            if let languageCode = Locale.current.language.languageCode {
                if languageCode != .english {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Select.WordFromText.SelectionMode", selection: $mode) {
                                Text("Select.WordFromText.SelectionMode.EnglishOnly")
                                    .tag(WordSelectionMode.english)
                                Text("Select.WordFromText.SelectionMode.KanjiOnly")
                                    .tag(WordSelectionMode.kanjiOnly)
                                Text("Select.WordFromText.SelectionMode.ParticlesBestAttempt")
                                    .tag(WordSelectionMode.particleBestAttempt)
                            }
                        } label: {
                            Text("Select.WordFromText.SelectionMode")
                        }
                    }
                }
            }
        }
        .navigationTitle("Select.WordFromText.ViewTitle")
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
