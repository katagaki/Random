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
                        ListRow(image: "ListIcon.Number",
                                title: "Randomly.Generate.Number")
                    }
                    NavigationLink(value: ViewPath.rGenerateLetter) {
                        ListRow(image: "ListIcon.Letter",
                                title: "Randomly.Generate.Letter")
                    }
                    NavigationLink(value: ViewPath.rGenerateWord) {
                        ListRow(image: "ListIcon.Word",
                                title: "Randomly.Generate.Word")
                    }
                    NavigationLink(value: ViewPath.rGeneratePassword) {
                        ListRow(image: "ListIcon.Password",
                                title: "Randomly.Generate.Password")
                    }
                    NavigationLink(value: ViewPath.rGenerateColor) {
                        ListRow(image: "ListIcon.Color",
                                title: "Randomly.Generate.Color")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Generate")
                        .font(.body)
                }
                Section {
                    NavigationLink(value: ViewPath.rSelectItemFromList) {
                        ListRow(image: "ListIcon.List",
                                title: "Randomly.Select.ItemFromList")
                    }
                    NavigationLink(value: ViewPath.rSelectWordFromText) {
                        ListRow(image: "ListIcon.Doc",
                                title: "Randomly.Select.WordFromText")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Select")
                        .font(.body)
                }
                Section {
                    NavigationLink(value: ViewPath.rShuffleList) {
                        ListRow(image: "ListIcon.List",
                                title: "Randomly.Shuffle.List")
                    }
                    NavigationLink(value: ViewPath.rShuffleDict) {
                        ListRow(image: "ListIcon.Table",
                                title: "Randomly.Shuffle.Dictionary")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Shuffle")
                        .font(.body)
                }
//                Section {
//                    NavigationLink(value: ViewPath.rDoCoinFlip) {
//                        ListRow(image: "ListIcon.Coin",
//                                title: "Randomly.Do.CoinFlip")
//                    }
//                    NavigationLink(value: ViewPath.rDoDiceRoll) {
//                        ListRow(image: "ListIcon.Die",
//                                title: "Randomly.Do.DiceRoll")
//                    }
//                    NavigationLink(value: ViewPath.rDoCardDraw) {
//                        ListRow(image: "ListIcon.Cards",
//                                title: "Randomly.Do.CardDraw")
//                    }
//                } header: {
//                    ListSectionHeader(text: "Shared.Do")
//                        .font(.body)
//                }
//                .disabled(true)
            }
            .navigationDestination(for: ViewPath.self, destination: { component in
                switch component {
                case .rGenerateNumber:
                    GenerateView(mode: .number)
                case .rGenerateLetter:
                    GenerateView(mode: .letter)
                case .rGenerateWord:
                    GenerateView(mode: .word)
                case .rGeneratePassword:
                    GeneratePasswordView()
                case .rGenerateColor:
                    GenerateColorView()
                case .rSelectItemFromList:
                    SelectItemFromListView()
                case .rSelectWordFromText:
                    SelectWordFromTextView()
                case .rShuffleList:
                    ShuffleListView()
                case .rShuffleDict:
                    ShuffleDictionaryView()
                case .rDoCoinFlip, .rDoDiceRoll, .rDoCardDraw:
                    Color.clear
                    // TODO: Implement
                default:
                    Color.clear
                }
            })
            .navigationTitle("View.Randomly")
        }
    }
}
