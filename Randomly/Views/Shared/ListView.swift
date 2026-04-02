//
//  ListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ListView<Content: View>: View {

    @Binding var selectedItem: SelectItem?
    @State var newItem: String = ""
    @Binding var items: [SelectItem]
    @State var isAddingNewItem: Bool = false
    @State var editingItem: SelectItem?
    @State var editingValue: String = ""
    @FocusState var focusedField: FocusedField?
    @ViewBuilder var bottomView: () -> Content

    var body: some View {
        ScrollViewReader { scrollView in
            List {
                ForEach($items, id: \.id) { $item in
                    if editingItem?.id == item.id {
                        TextField("", text: $editingValue)
                            .font(.body)
                            .focused($focusedField, equals: .editItemField)
                            .submitLabel(.done)
                            .onSubmit {
                                commitEdit()
                            }
                    } else {
                        Text(item.value)
                            .font(.body)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    if let index = items.firstIndex(where: { $0.id == item.id }) {
                                        items.remove(at: index)
                                    }
                                } label: {
                                    Label("Shared.Delete", systemImage: "trash")
                                }
                                Button {
                                    startEditing(item)
                                } label: {
                                    Label("Shared.Edit", systemImage: "pencil")
                                }
                                .tint(.orange)
                            }
                    }
                }
                Section {
                    TextField("Shared.List.NewItem", text: $newItem)
                        .font(.body)
                        .focused($focusedField, equals: .newItemField)
                        .submitLabel(.done)
                        .onSubmit {
                            addNewItem()
                        }
                }
            }
            .listStyle(.plain)
            .padding(.bottom, -8.0)
            .onChange(of: items) {
                if items.count > 0 && isAddingNewItem {
                    scrollView.scrollTo(items.last!.id, anchor: .bottom)
                    isAddingNewItem = false
                }
            }
            .overlay {
                if items.count == 0 {
                    VStack(alignment: .center, spacing: 16.0) {
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
                        if UIPasteboard.general.hasStrings {
                            Button {
                                if let string = UIPasteboard.general.string {
                                    let stringComponents = string.components(separatedBy: .newlines)
                                    for stringComponent in stringComponents where
                                    stringComponent.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                        items.append(
                                            SelectItem(id: UUID().uuidString,
                                                       value: stringComponent.trimmingCharacters(in:
                                                            .whitespacesAndNewlines)))
                                    }
                                }
                            } label: {
                                Label("Shared.Paste", systemImage: "doc.on.clipboard")
                                    .bold()
                            }
                            .prominentPillButton()
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                bottomView()
                    .frame(maxWidth: .infinity)
                    .bottomBarBackground()
            }
        }
        .onAppear {
            focusedField = .newItemField
        }
    }

    func addNewItem() {
        if newItem != "" {
            isAddingNewItem = true
            items.append(
                SelectItem(id: UUID().uuidString,
                           value: newItem))
            newItem = ""
            focusedField = .newItemField
        }
    }

    func startEditing(_ item: SelectItem) {
        editingItem = item
        editingValue = item.value
        focusedField = .editItemField
    }

    func commitEdit() {
        if let editingItem, let index = items.firstIndex(where: { $0.id == editingItem.id }) {
            if editingValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                items.remove(at: index)
            } else {
                items[index].value = editingValue
            }
        }
        editingItem = nil
        editingValue = ""
    }

    enum FocusedField: Hashable {
        case newItemField
        case editItemField
    }
}
