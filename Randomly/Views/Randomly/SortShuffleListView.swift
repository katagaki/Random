//
//  SortShuffleListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/27.
//

import SwiftUI

struct SortShuffleListView: View {

    let mode: ListOperationMode

    @State var items: [SelectItem] = []
    @State var newItem: String = ""
    @State var editingItem: SelectItem?
    @State var editingValue: String = ""
    @FocusState var focusedField: FocusedField?

    var persistenceKey: String {
        mode == .shuffle ? "shuffleListItems" : "sortListItems"
    }

    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                ios26Body
            } else {
                legacyBody
            }
        }
        .persistItems(key: persistenceKey, items: $items)
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
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
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    items.removeAll()
                } label: {
                    Text("Shared.Clear")
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(.sharedCopy, systemImage: "doc.on.doc") {
                    UIPasteboard.general.string = items.reduce(into: "", { result, item in
                        result += "\(item.value)\n"
                    })
                }
                .disabled(items.isEmpty)
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(operationButtonLabel, systemImage: operationButtonIcon) {
                    performOperation()
                }
                .buttonStyle(.glassProminent)
                .disabled(items.isEmpty)
            }
        }
        .onAppear {
            focusedField = .newItemField
        }
    }

    var legacyBody: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ListView(selectedItem: .constant(nil),
                     items: $items) {
                ActionBar(primaryActionText: operationButtonLabelKey,
                          primaryActionIconName: operationButtonIcon,
                          copyDisabled: .constant(items.count == 0),
                          primaryActionDisabled: .constant(items.count == 0)) {
                    performOperation()
                } copyAction: {
                    UIPasteboard.general.string = items.reduce(into: "", { result, item in
                        result += "\(item.value)\n"
                    })
                }
            }
        }
        .navigationTitle(navigationTitle)
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

    // Computed properties for mode-specific values
    private var navigationTitle: LocalizedStringKey {
        switch mode {
        case .sort:
            return "Shared.Sort.List.ViewTitle"
        case .shuffle:
            return "Shared.Shuffle.List.ViewTitle"
        }
    }

    private var operationButtonLabel: LocalizedStringKey {
        switch mode {
        case .sort:
            return "Shared.Sort"
        case .shuffle:
            return "Shared.Shuffle"
        }
    }

    private var operationButtonLabelKey: LocalizedStringKey {
        switch mode {
        case .sort:
            return "Shared.Sort"
        case .shuffle:
            return "Shared.Shuffle"
        }
    }

    private var operationButtonIcon: String {
        switch mode {
        case .sort:
            return "arrow.up.and.down"
        case .shuffle:
            return "arrow.up.and.down.and.sparkles"
        }
    }

    // Operation execution
    private func performOperation() {
        switch mode {
        case .sort:
            items.sort { lhs, rhs in
                lhs.value < rhs.value
            }
        case .shuffle:
            items.shuffle()
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
