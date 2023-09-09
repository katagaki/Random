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
        VStack(alignment: .center, spacing: 8.0) {
            DictionaryView(items: $items)
            Divider()
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
                        LargeButtonLabel(iconName: "arrow.up.and.down",
                                         text: "Shared.Sort.ByKey")
                        .bold()
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 99))
                    .disabled(items.count == 0)
                }
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing])
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            }
            .scrollIndicators(.hidden)
        }
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
