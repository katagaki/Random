//
//  ShuffleListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ShuffleListView: View {

    @State var items: [SelectItem] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ListView(selectedItem: .constant(nil),
                     items: $items)
            Divider()
            ActionBar(primaryActionText: "Shared.Shuffle",
                      primaryActionIconName: "arrow.up.and.down.and.sparkles",
                      copyDisabled: .constant(items.count == 0),
                      primaryActionDisabled: .constant(items.count == 0)) {
                items.shuffle()
            } copyAction: {
                UIPasteboard.general.string = items.reduce(into: "", { result, item in
                    result += "\(item.value)\n"
                })
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .navigationTitle("Shared.Shuffle.List.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

