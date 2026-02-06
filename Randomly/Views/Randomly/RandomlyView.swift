//
//  RandomlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct RandomlyView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack(path: $navigationManager.randomlyTabPath) {
            List {
                Section {
                    NavigationLink(value: ViewPath.rGenerateNumber) {
                        Label("Randomly.Generate.Number", systemImage: "number")
                    }
                    NavigationLink(value: ViewPath.rGenerateLetter) {
                        Label("Randomly.Generate.Letter", systemImage: "character")
                    }
                    switch Locale.current.language.languageCode ?? .english {
                    case .japanese:
                        NavigationLink(value: ViewPath.rGenerateWordJapanese) {
                            Label("Randomly.Generate.Word", systemImage: "textformat")
                        }
                    default:
                        NavigationLink(value: ViewPath.rGenerateWordEnglish) {
                            Label("Randomly.Generate.Word", systemImage: "textformat")
                        }
                    }
                    NavigationLink(value: ViewPath.rGenerateCountry) {
                        Label("Randomly.Generate.Country", systemImage: "globe")
                    }
                    NavigationLink(value: ViewPath.rGeneratePassword) {
                        Label("Randomly.Generate.Password", systemImage: "key.fill")
                    }
                    NavigationLink(value: ViewPath.rGenerateColor) {
                        Label("Randomly.Generate.Color", systemImage: "paintpalette.fill")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Generate")
                        .font(.body)
                }
                Section {
                    NavigationLink(value: ViewPath.rSelectItemFromList) {
                        Label("Randomly.Select.ItemFromList", systemImage: "list.bullet")
                    }
                    NavigationLink(value: ViewPath.rSelectWordFromText) {
                        Label("Randomly.Select.WordFromText", systemImage: "doc.text")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Select")
                        .font(.body)
                }
                Section {
                    NavigationLink(value: ViewPath.rShuffleList) {
                        Label("Randomly.Shuffle.List", systemImage: "list.bullet")
                    }
                    NavigationLink(value: ViewPath.rShuffleDict) {
                        Label("Randomly.Shuffle.Dictionary", systemImage: "tablecells")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Shuffle")
                        .font(.body)
                }
                Section {
                    NavigationLink(value: ViewPath.rDoCoinFlip) {
                        Label("Randomly.Do.CoinFlip", systemImage: "centsign.circle.fill")
                    }
                    NavigationLink(value: ViewPath.rDoDiceRoll) {
                        Label("Randomly.Do.DiceRoll", systemImage: "die.face.5.fill")
                    }
                    NavigationLink(value: ViewPath.rDoCardDraw) {
                        Label("Randomly.Do.CardDraw", systemImage: "square.on.square.fill")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Do")
                        .font(.body)
                }
            }
            .navigationDestination(for: ViewPath.self, destination: { viewPath in
                switch viewPath {
                case .rGenerateNumber:
                    GenerateView(mode: .number)
                case .rGenerateLetter:
                    GenerateView(mode: .letter)
                case .rGenerateWordEnglish:
                    GenerateView(mode: .englishWord)
                case .rGenerateWordJapanese:
                    GenerateView(mode: .japaneseWord)
                case .rGeneratePassword:
                    GeneratePasswordView()
                case .rGenerateColor:
                    GenerateColorView()
                case .rGenerateCountry:
                    GenerateCountryView()
                case .rSelectItemFromList:
                    SelectItemFromListView()
                case .rSelectWordFromText:
                    SelectWordFromTextView()
                case .rShuffleList:
                    ShuffleListView()
                case .rShuffleDict:
                    ShuffleDictionaryView()
                case .rDoDiceRoll:
                    RollDiceView()
                case .rDoCoinFlip:
                    FlipCoinView()
                case .rDoCardDraw:
                    DrawCardView()
                default:
                    Color.clear
                }
            })
            .navigationTitle("View.Randomly")
        }
    }
}
