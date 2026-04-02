//
//  SelectItemFromListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct SelectItemFromListView: View {

    @State var selectedItem: SelectItem?
    @State var items: [SelectItem] = []
    @State var newItem: String = ""
    @State var editingItem: SelectItem?
    @State var editingValue: String = ""
    @FocusState var focusedField: FocusedField?

    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                ios26Body
            } else {
                legacyBody
            }
        }
        .persistItems(key: "selectItems", items: $items)
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ScrollViewReader { scrollView in
                listContent
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(.sharedCopy, systemImage: "doc.on.doc") {
                                UIPasteboard.general.string = selectedItem!.value
                            }
                            .disabled(selectedItem == nil)
                        }
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(.sharedSelect, systemImage: "lasso.sparkles") {
                                selectedItem = items.randomElement()!
                                scrollView.scrollTo(selectedItem!, anchor: .center)
                            }
                            .buttonStyle(.glassProminent)
                            .disabled(items.count == 0)
                        }
                    }
            }
        }
        .navigationTitle("Select.ItemFromList.ViewTitle")
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
        .onAppear {
            focusedField = .newItemField
        }
    }

    var legacyBody: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ScrollViewReader { scrollView in
                ListView(selectedItem: $selectedItem,
                         items: $items) {
                    ActionBar(primaryActionText: "Shared.Select",
                              primaryActionIconName: "lasso.sparkles",
                              copyDisabled: .constant(selectedItem == nil),
                              primaryActionDisabled: .constant(items.count == 0)) {
                        selectedItem = items.randomElement()!
                        scrollView.scrollTo(selectedItem!, anchor: .center)
                    } copyAction: {
                        UIPasteboard.general.string = selectedItem!.value
                    }
                }
            }
        }
        .navigationTitle("Select.ItemFromList.ViewTitle")
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

    var listContent: some View {
        ScrollViewReader { scrollView in
            List(selection: $selectedItem) {
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
            .onChange(of: items) {
                if items.count > 0 {
                    scrollView.scrollTo(items.last!.id, anchor: .bottom)
                }
            }
            .overlay {
                if items.count == 0 {
                    VStack(alignment: .center, spacing: 16.0) {
                        VStack(alignment: .center, spacing: 8.0) {
                            Image(systemName: "questionmark.square.dashed")
                                .resizable()
                                .frame(width: 32, height: 32)
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
        }
    }

    func addNewItem() {
        if newItem != "" {
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
