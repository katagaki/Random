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
    @State var editor = ListItemEditor()
    @FocusState var focusedField: ListFocusedField?

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
                ForEach(items, id: \.id) { item in
                    EditableListRow(
                        item: item,
                        editor: editor,
                        focusedField: $focusedField,
                        onDelete: {
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                items.remove(at: index)
                            }
                        }
                    )
                    .onSubmit {
                        editor.commitEdit(items: &items)
                    }
                }
                NewItemRow(editor: editor, focusedField: $focusedField) {
                    editor.addNewItem(items: &items)
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
                    EmptyListOverlay {
                        ListItemEditor.pasteFromClipboard(items: &items)
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
}
