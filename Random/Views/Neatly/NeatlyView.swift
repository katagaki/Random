//
//  NeatlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct NeatlyView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        SortListView(mode: .neatly)
                    } label: {
                        ListRow(image: "ListIcon.List", title: "Neatly.Sort.List")
                    }
                    NavigationLink {
                        Color.clear
                    } label: {
                        ListRow(image: "ListIcon.Table", title: "Neatly.Sort.Dictionary")
                    }
                    .disabled(true)
                } header: {
                    ListSectionHeader(text: "Neatly.Sort")
                        .font(.body)
                }
            }
            .navigationTitle("View.Neatly")
        }
    }
}
