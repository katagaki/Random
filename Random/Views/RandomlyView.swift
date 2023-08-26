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

                } header: {
                    ListSectionHeader(text: "Randomly.Generate")
                        .font(.body)
                }
                Section {
                    NavigationLink {
                        SelectItemFromListView()
                    } label: {
                        ListRow(image: "ListIcon.List",
                                title: "Randomly.Select.ItemFromList")
                    }
                    ListRow(image: "ListIcon.Doc",
                            title: "Randomly.Select.WordFromText")
                } header: {
                    ListSectionHeader(text: "Randomly.Select")
                        .font(.body)
                }
                Section {
                    ListRow(image: "ListIcon.List", 
                            title: "Randomly.Sort.List")
                    ListRow(image: "ListIcon.Table",
                            title: "Randomly.Sort.Dictionary")
                } header: {
                    ListSectionHeader(text: "Randomly.Sort")
                        .font(.body)
                }
                Section {
                    ListRow(image: "ListIcon.Coin", 
                            title: "Randomly.Do.CoinFlip")
                    ListRow(image: "ListIcon.Die",
                            title: "Randomly.Do.DiceRoll")
                    ListRow(image: "ListIcon.Cards",
                            title: "Randomly.Do.CardDraw")
                } header: {
                    ListSectionHeader(text: "Randomly.Do")
                        .font(.body)
                }
            }
            .navigationTitle("View.Randomly")
        }
    }
}
