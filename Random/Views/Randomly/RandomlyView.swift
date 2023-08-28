//
//  RandomlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct RandomlyView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        GenerateView(mode: .number)
                    } label: {
                        ListRow(image: "ListIcon.Number",
                                title: "Randomly.Generate.Number")
                    }
                    NavigationLink {
                        GenerateView(mode: .letter)
                    } label: {
                        ListRow(image: "ListIcon.Letter",
                                title: "Randomly.Generate.Letter")
                    }
                    NavigationLink {
                        GenerateView(mode: .word)
                    } label: {
                        ListRow(image: "ListIcon.Word",
                                title: "Randomly.Generate.Word")
                    }
                    NavigationLink {
                        GeneratePasswordView()
                    } label: {
                        ListRow(image: "ListIcon.Password",
                                title: "Randomly.Generate.Password")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Generate")
                        .font(.body)
                }
                Section {
                    NavigationLink {
                        SelectItemFromListView()
                    } label: {
                        ListRow(image: "ListIcon.List",
                                title: "Randomly.Select.ItemFromList")
                    }
                    NavigationLink {
                        SelectWordFromTextView()
                    } label: {
                        ListRow(image: "ListIcon.Doc",
                                title: "Randomly.Select.WordFromText")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Select")
                        .font(.body)
                }
                Section {
                    NavigationLink {
                        ShuffleListView()
                    } label: {
                        ListRow(image: "ListIcon.List",
                                title: "Randomly.Shuffle.List")
                    }
                    NavigationLink {
                        ShuffleDictionaryView()
                    } label: {
                        ListRow(image: "ListIcon.Table",
                                title: "Randomly.Shuffle.Dictionary")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Shuffle")
                        .font(.body)
                }
                Section {
                    NavigationLink {
                        Color.clear
                    } label: {
                        ListRow(image: "ListIcon.Coin",
                                title: "Randomly.Do.CoinFlip")
                    }
                    NavigationLink {
                        Color.clear
                    } label: {
                        ListRow(image: "ListIcon.Die",
                                title: "Randomly.Do.DiceRoll")
                    }
                    NavigationLink {
                        Color.clear
                    } label: {
                        ListRow(image: "ListIcon.Cards",
                                title: "Randomly.Do.CardDraw")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Do")
                        .font(.body)
                }
                .disabled(true)
            }
            .navigationTitle("View.Randomly")
        }
    }
}
