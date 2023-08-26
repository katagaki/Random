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
                    ListRow(image: "ListIcon.List", title: "Neatly.Sort.List")
                    ListRow(image: "ListIcon.Table", title: "Neatly.Sort.Dictionary")
                } header: {
                    ListSectionHeader(text: "Neatly.Sort")
                        .font(.body)
                }
            }
            .navigationTitle("View.Neatly")
        }
    }
}
