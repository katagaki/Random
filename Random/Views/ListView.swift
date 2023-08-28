//
//  ListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ListView: View {

    @Binding var selectedItem: SelectItem?
    @State var newItem: String = ""
    @Binding var items: [SelectItem]
    @State var isAddingNewItem: Bool = false
    @FocusState var isInputActive: Bool

    var body: some View {
        ScrollViewReader { scrollView in
            List(selection: $selectedItem) {
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
                TextField("Shared.List.NewItem",
                          text: $newItem)
                .textFieldStyle(.roundedBorder)
                .focused($isInputActive)
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
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Shared.Done") {
                    isInputActive = false
                }
                .bold()
            }
        }
    }
}
