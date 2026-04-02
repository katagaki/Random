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
    @State var editor = ListItemEditor()
    @FocusState var focusedField: ListFocusedField?

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
                List(selection: $selectedItem) {
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
}
