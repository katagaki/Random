//
//  SortListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/27.
//

import SwiftUI

struct SortListView: View {

    @State var items: [SelectItem] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ListView(selectedItem: .constant(nil),
                     items: $items) {
                ActionBar(primaryActionText: "Shared.Sort",
                          primaryActionIconName: "arrow.up.and.down",
                          copyDisabled: .constant(items.count == 0),
                          primaryActionDisabled: .constant(items.count == 0)) {
                    items.sort { lhs, rhs in
                        lhs.value < rhs.value
                    }
                } copyAction: {
                    UIPasteboard.general.string = items.reduce(into: "", { result, item in
                        result += "\(item.value)\n"
                    })
                }
            }
        }
        .toolbarBackground(.hidden, for: .tabBar)
        .navigationTitle("Shared.Sort.List.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    items.removeAll()
                } label: {
                    Text("Shared.Clear")
                }
            }
        }
    }
}
