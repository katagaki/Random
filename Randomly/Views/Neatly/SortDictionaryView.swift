//
//  SortDictionaryView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct SortDictionaryView: View {

    @State var items: [SelectItem] = []

    var body: some View {
        DictionaryView(items: $items) {
            ScrollView(.horizontal) {
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
                .padding([.leading, .trailing])
            }
            .scrollIndicators(.hidden)
            .padding([.leading, .trailing], 0.0)
        }
        .toolbarBackground(.hidden, for: .tabBar)
        .navigationTitle("Shared.Sort.Dictionary.ViewTitle")
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
