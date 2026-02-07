//
//  ShuffleDictionaryView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ShuffleDictionaryView: View {

    @State var items: [SelectItem] = []

    var body: some View {
        DictionaryView(items: $items) {
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
            .padding([.leading, .trailing])
        }
        .navigationTitle("Shared.Shuffle.Dictionary.ViewTitle")
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
