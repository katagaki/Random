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
                    ListRow(image: "ListIcon.List", title: "List")
                    ListRow(image: "ListIcon.Table", title: "Dictionary")
                } header: {
                    ListSectionHeader(text: "Sort")
                        .font(.body)
                }
            }
            .navigationTitle("Neatly")
        }
    }
}
