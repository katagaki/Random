//
//  SortShuffleDictionaryView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct SortShuffleDictionaryView: View {

    @State var mode: DictionaryOperationMode
    @State var items: [SelectItem] = []

    var body: some View {
        DictionaryView(items: $items) {
            switch mode {
            case .sort:
                ActionBar(primaryActionText: "Shared.Sort.ByValue",
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
                .secondaryAction {
                    Button {
                        items.sort { lhs, rhs in
                            lhs.id < rhs.id
                        }
                    } label: {
                        Label("Shared.Sort.ByKey", systemImage: "arrow.up.and.down")
                            .bold()
                            .padding(.horizontal, 4.0)
                            .frame(minHeight: 42.0)

                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 99))
                    .disabled(items.count == 0)
                }
                .frame(maxWidth: .infinity)
            case .shuffle:
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
            }
        }
        .navigationTitle(mode == .sort ? "Shared.Sort.Dictionary.ViewTitle" : "Shared.Shuffle.Dictionary.ViewTitle")
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
