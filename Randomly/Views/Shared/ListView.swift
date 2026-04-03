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
                    if editor.editingItemId == item.id {
                        TextField("", text: $editor.editingValue)
                            .font(.body)
                            .focused($focusedField, equals: .editItemField)
                            .submitLabel(.done)
                            .onSubmit {
                                editor.commitEdit(items: &items)
                            }
                    } else {
                        HStack {
                            Text(item.value)
                                .font(.body)
                            Spacer()
                            if selectedItem == item {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items.remove(at: index)
                                }
                            } label: {
                                Label("Shared.Delete", systemImage: "trash")
                            }
                            Button {
                                editor.startEditing(item)
                                focusedField = .editItemField
                            } label: {
                                Label("Shared.Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
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
