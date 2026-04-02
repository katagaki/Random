//
//  ListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ListView<Content: View>: View {

    @Binding var selectedItem: SelectItem?
    @Binding var items: [SelectItem]
    @State var editor = ListItemEditor()
    @State var isAddingNewItem: Bool = false
    @FocusState var focusedField: ListFocusedField?
    @ViewBuilder var bottomView: () -> Content

    var body: some View {
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
                    isAddingNewItem = true
                    editor.addNewItem(items: &items)
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
                    EmptyListOverlay {
                        ListItemEditor.pasteFromClipboard(items: &items)
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
}
