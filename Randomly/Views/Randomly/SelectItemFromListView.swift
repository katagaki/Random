//
//  SelectItemFromListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct SelectItemFromListView: View {

    @State var selectedItem: SelectItem?
    @State var items: [SelectItem] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ScrollViewReader { scrollView in
                ListView(selectedItem: $selectedItem,
                         items: $items) {
                    ActionBar(primaryActionText: "Shared.Select",
                              primaryActionIconName: "lasso.sparkles",
                              copyDisabled: .constant(selectedItem == nil),
                              primaryActionDisabled: .constant(items.count == 0)) {
                        selectedItem = items.randomElement()!
                        scrollView.scrollTo(selectedItem!, anchor: .center)
                    } copyAction: {
                        UIPasteboard.general.string = selectedItem!.value
                    }
                }
            }
        }
        .toolbarBackground(.hidden, for: .tabBar)
        .navigationTitle("Randomly.Select.ItemFromList.ViewTitle")
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
