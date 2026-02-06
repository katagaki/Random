//
//  RandomlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct RandomlyView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack(path: $navigationManager.randomlyTabPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 28.0) {
                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Generate")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.rGenerateNumber, title: "Randomly.Generate.Number",
                                         icon: "number", iconColor: .blue)
                            GridCardView(destination: ViewPath.rGenerateLetter, title: "Randomly.Generate.Letter",
                                         icon: "character", iconColor: .green)

                            switch Locale.current.language.languageCode ?? .english {
                            case .japanese:
                                GridCardView(destination: ViewPath.rGenerateWordJapanese, title: "Randomly.Generate.Word",
                                             icon: "textformat", iconColor: .teal)
                            default:
                                GridCardView(destination: ViewPath.rGenerateWordEnglish, title: "Randomly.Generate.Word",
                                             icon: "textformat", iconColor: .teal)
                            }

                            GridCardView(destination: ViewPath.rGenerateCountry, title: "Randomly.Generate.Country",
                                         icon: "globe", iconColor: .purple)
                            GridCardView(destination: ViewPath.rGeneratePassword, title: "Randomly.Generate.Password",
                                         icon: "key.fill", iconColor: .orange)
                            GridCardView(destination: ViewPath.rGenerateColor, title: "Randomly.Generate.Color",
                                         icon: "paintpalette.fill",
                                         iconGradient: LinearGradient(
                                             colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple],
                                             startPoint: .leading,
                                             endPoint: .trailing
                                         ))
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Select")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.rSelectItemFromList, title: "Randomly.Select.ItemFromList",
                                         icon: "list.bullet", iconColor: .indigo)
                            GridCardView(destination: ViewPath.rSelectWordFromText, title: "Randomly.Select.WordFromText",
                                         icon: "doc.text", iconColor: .teal)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Shuffle")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.rShuffleList, title: "Randomly.Shuffle.List",
                                         icon: "list.bullet", iconColor: .mint)
                            GridCardView(destination: ViewPath.rShuffleDict, title: "Randomly.Shuffle.Dictionary",
                                         icon: "tablecells", iconColor: .brown)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Do")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.rDoCoinFlip, title: "Randomly.Do.CoinFlip",
                                         icon: "centsign.circle.fill", iconColor: .yellow)
                            GridCardView(destination: ViewPath.rDoDiceRoll, title: "Randomly.Do.DiceRoll",
                                         icon: "die.face.5.fill", iconColor: .red)
                            GridCardView(destination: ViewPath.rDoCardDraw, title: "Randomly.Do.CardDraw",
                                         icon: "square.on.square.fill", iconColor: .gray)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
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
