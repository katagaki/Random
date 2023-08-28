//
//  SelectItemFromListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct SelectItemFromListView: View {

    @State var selectedItem: SelectItem? = nil
    @State var items: [SelectItem] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ScrollViewReader { scrollView in
                ListView(selectedItem: $selectedItem,
                         items: $items)
                Divider()
                ActionBar(primaryActionText: "Shared.Select",
                          copyDisabled: .constant(selectedItem == nil), primaryActionDisabled: .constant(items.count == 0)) {
                    selectedItem = items.randomElement()!
                    scrollView.scrollTo(selectedItem!, anchor: .center)
                } copyAction: {
                    UIPasteboard.general.string = selectedItem!.value
                }
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing])
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            }
        }
        .navigationTitle("Randomly.Select.ItemFromList.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
