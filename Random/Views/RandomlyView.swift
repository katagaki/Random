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
                        ListRow(image: "ListIcon.Number", title: "Number")
                    }
                    NavigationLink {
                        GenerateView(mode: .letter)
                    } label: {
                        ListRow(image: "ListIcon.Letter", title: "Letter")
                    }
                    NavigationLink {
                        GenerateView(mode: .word)
                    } label: {
                        ListRow(image: "ListIcon.Word", title: "Word")
                    }

                } header: {
                    ListSectionHeader(text: "Generate")
                        .font(.body)
                }
                Section {
                    NavigationLink {
                        SelectItemFromListView()
                    } label: {
                        ListRow(image: "ListIcon.List", title: "Item From List")
                    }
                    ListRow(image: "ListIcon.Doc", title: "Word From Text")
                } header: {
                    ListSectionHeader(text: "Select")
                        .font(.body)
                }
                Section {
                    ListRow(image: "ListIcon.List", title: "List")
                    ListRow(image: "ListIcon.Table", title: "Dictionary")
                } header: {
                    ListSectionHeader(text: "Sort")
                        .font(.body)
                }
                Section {
                    ListRow(image: "ListIcon.Coin", title: "Coin Flip")
                    ListRow(image: "ListIcon.Die", title: "Dice Roll")
                    ListRow(image: "ListIcon.Cards", title: "Card Draw")
                } header: {
                    ListSectionHeader(text: "Do")
                        .font(.body)
                }
            }
            .navigationTitle("Randomly")
        }
    }
}
