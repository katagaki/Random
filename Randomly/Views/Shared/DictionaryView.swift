//
//  DictionaryView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct DictionaryView<Content: View>: View {

    @State var newItemKey: String = ""
    @State var newItemValue: String = ""
    @Binding var items: [SelectItem]
    @State var isAddingNewItem: Bool = false
    @FocusState var focusedField: FocusedField?
    @ViewBuilder var bottomView: () -> Content

    var body: some View {
        ScrollViewReader { scrollView in
            List {
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
            .onChange(of: items) {
                if items.count > 0 && isAddingNewItem {
                    scrollView.scrollTo(items.last!, anchor: .bottom)
                    isAddingNewItem = false
                }
            }
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
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 16.0) {
                    HStack(alignment: .center, spacing: 8.0) {
                        TextField("Shared.List.NewItem.Key",
                                  text: $newItemKey)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .keyField)
                        .onSubmit {
                            focusedField = .valueField
                        }
                        TextField("Shared.List.NewItem.Value",
                                  text: $newItemValue)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .valueField)
                        .onSubmit {
                            addNewItem()
                        }
                        Button {
                            addNewItem()
                            focusedField = .keyField
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
                    bottomView()
                        .frame(maxWidth: .infinity)
                }
                .padding([.top, .bottom], 16.0)
                .background(Material.bar)
                .overlay(alignment: .top) {
                    Rectangle()
                        .frame(height: 1/3)
                        .foregroundColor(.primary.opacity(0.2))
                }
            }
        }
        .onAppear {
            focusedField = .keyField
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Shared.Done") {
                    focusedField = nil
                }
                .bold()
            }
        }
    }

    func addNewItem() {
        if newItemKey != "" && newItemValue != "" {
            isAddingNewItem = true
            items.append(
                SelectItem(id: newItemKey,
                           value: newItemValue))
            newItemKey = ""
            newItemValue = ""
        }
    }

    enum FocusedField: Hashable {
        case keyField
        case valueField
    }
}
