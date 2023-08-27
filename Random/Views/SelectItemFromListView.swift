//
//  SelectItemFromListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct SelectItemFromListView: View {

    @State var selectedItem: SelectItem? = nil
    @State var newItem: String = ""
    @State var items: [SelectItem] = []
    @State var isAddingNewItem: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
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
                    .disabled(newItem == "")
                }
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 8.0)
                Divider()
                HStack(alignment: .center, spacing: 8.0) {
                    Button {
                        UIPasteboard.general.string = selectedItem!.value
                    } label: {
                        HStack(alignment: .center, spacing: 4.0) {
                            Image(systemName: "doc.on.doc")
                            Text("Shared.Copy")
                                .padding([.top, .bottom], 8.0)
                        }
                        .padding([.leading, .trailing], 20.0)
                    }
                    .buttonStyle(.bordered)
                    .disabled(selectedItem == nil)
                    Button {
                        selectedItem = items.randomElement()!
                        scrollView.scrollTo(selectedItem!, anchor: .center)
                    } label: {
                        HStack(alignment: .center, spacing: 4.0) {
                            Image(systemName: "scope")
                            Text("Randomly.Select")
                                .bold()
                                .padding([.top, .bottom], 8.0)
                        }
                        .frame(maxWidth: .infinity)
                        .padding([.leading, .trailing], 20.0)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(items.count == 0)
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
