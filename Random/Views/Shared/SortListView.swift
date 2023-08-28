//
//  SortListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/27.
//

import SwiftUI

struct SortListView: View {

    @State var mode: SortType
    @State var items: [SelectItem] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ListView(selectedItem: .constant(nil),
                     items: $items)
            Divider()
            ActionBar(primaryActionText: "Shared.Sort",
                      copyDisabled: .constant(items.count == 0),
                      primaryActionDisabled: .constant(items.count == 0)) {
                switch mode {
                case .randomly:
                    items.shuffle()
                case .neatly:
                    items.sort { lhs, rhs in
                        lhs.value < rhs.value
                    }
                }
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
        .navigationTitle("Shared.Sort.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum SortType {
    case randomly
    case neatly
}
