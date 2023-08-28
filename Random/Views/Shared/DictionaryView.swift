//
//  DictionaryView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct DictionaryView: View {

    @State var newItemKey: String = ""
    @State var newItemValue: String = ""
    @Binding var items: [SelectItem]
    @State var isAddingNewItem: Bool = false
    @FocusState var isKeyTextFieldActive: Bool
    @FocusState var isValueTextFieldActive: Bool

    var body: some View {
        ScrollViewReader { scrollView in
            List() {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .center, spacing: 8.0) {
                        Text(item.id)
                            .font(.body)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(item.value)
                            .font(.body)
                    }
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
            .overlay {
                if items.count == 0 {
                    VStack(alignment: .center, spacing: 8.0) {
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .frame(width: 32,
                                   height: 32)
                            .foregroundStyle(.secondary)
                        Text("Shared.List.NoItems")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            Divider()
            HStack(alignment: .center, spacing: 8.0) {
                TextField("Shared.List.NewItem.Key",
                          text: $newItemKey)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.next)
                .focused($isKeyTextFieldActive)
                .onSubmit {
                    isValueTextFieldActive = true
                }
                TextField("Shared.List.NewItem.Value",
                          text: $newItemValue)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .focused($isValueTextFieldActive)
                .onSubmit {
                    addNewItem()
                }
                Button {
                    addNewItem()
                } label: {
                    Image(systemName: "plus")
                    Text("Shared.Add")
                        .bold()
                }
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                .disabled(newItemKey == "" || newItemValue == "")
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8.0)
        }
        .onAppear {
            isKeyTextFieldActive = true
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Shared.Done") {
                    isKeyTextFieldActive = false
                    isValueTextFieldActive = false
                }
                .bold()
            }
        }
    }
    
    func addNewItem() {
        isAddingNewItem = true
        items.append(
            SelectItem(id: newItemKey,
                       value: newItemValue))
        newItemKey = ""
        newItemValue = ""
        isKeyTextFieldActive = true
    }
}