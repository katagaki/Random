//
//  SortListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/27.
//

import SwiftUI

struct SortListView: View {

    @State var mode: SortType
    @State var newItem: String = ""
    @State var items: [SelectItem] = []
    @State var isAddingNewItem: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ScrollViewReader { scrollView in
                List {
                    ForEach(items, id: \.self) { item in
                        Text(item.value)
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                .padding(.bottom, -8.0)
                .onChange(of: items, perform: { _ in
                    if items.count > 0 && isAddingNewItem {
                        scrollView.scrollTo(items.last!, anchor: .bottom)
                        isAddingNewItem = false
                    }
                })
                Divider()
                HStack {
                    TextField("Randomly.Select.ItemFromList.NewItem",
                              text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        isAddingNewItem = true
                        items.append(
                            SelectItem(id: UUID().uuidString,
                                       value: newItem))
                        newItem = ""
                    } label: {
                        Image(systemName: "plus")
                        Text("Shared.Add")
                            .bold()
                    }
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 99))
                    .disabled(newItem == "")
                }
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 8.0)
                Divider()
                HStack(alignment: .center, spacing: 8.0) {
                    Button {
                        UIPasteboard.general.string = items.reduce(into: "", { result, item in
                            result += "\(item.value)\n"
                        })
                    } label: {
                        LargeButtonLabel(iconName: "doc.on.doc",
                                         text: "Shared.Copy")
                    }
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 99))
                    .disabled(items.count == 0)
                    Button {
                        switch mode {
                        case .randomly:
                            items.shuffle()
                        case .neatly:
                            items.sort { lhs, rhs in
                                lhs.value < rhs.value
                            }
                        }
                    } label: {
                        LargeButtonLabel(iconName: "scope",
                                         text: "Shared.Sort")
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
        }
        .navigationTitle("Shared.Sort.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum SortType {
    case randomly
    case neatly
}
