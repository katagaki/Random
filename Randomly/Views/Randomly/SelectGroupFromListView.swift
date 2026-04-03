//
//  SelectGroupFromListView.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct SelectGroupFromListView: View {

    @State var items: [SelectItem] = []
    @State var selectedItems: [SelectItem] = []
    @State var groupSize: Float = 2
    @State var editor = ListItemEditor()
    @FocusState var focusedField: ListFocusedField?

    var maxGroupSize: Float {
        max(Float(items.count), 1)
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            ios26Body
                .persistItems(key: "selectGroupItems", items: $items)
        } else {
            legacyBody
                .persistItems(key: "selectGroupItems", items: $items)
        }
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
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
                            if selectedItems.contains(item) {
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
                    editor.addNewItem(items: &items)
                }
            }
            .listStyle(.plain)
            .onChange(of: items) {
                if items.count > 0 {
                    scrollView.scrollTo(items.last!.id, anchor: .bottom)
                }
                groupSize = min(groupSize, maxGroupSize)
            }
            .overlay {
                if items.count == 0 {
                    EmptyListOverlay {
                        ListItemEditor.pasteFromClipboard(items: &items)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    HStack(spacing: 12) {
                        Button {
                            if groupSize > 1 {
                                groupSize -= 1
                            }
                        } label: {
                            Image(systemName: "minus")
                        }
                        .disabled(groupSize <= 1)
                        Text("\(Int(groupSize))")
                            .font(.body)
                            .fontWeight(.semibold)
                            .monospacedDigit()
                            .contentTransition(.numericText())
                        Button {
                            if groupSize < maxGroupSize {
                                groupSize += 1
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                        .disabled(groupSize >= maxGroupSize)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .glassEffect(.regular.interactive(), in: .capsule)
                }
                .padding(.trailing)
                .padding(.bottom, 8)
            }
        }
        .navigationTitle("Select.Group.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    items.removeAll()
                    selectedItems.removeAll()
                } label: {
                    Text("Shared.Clear")
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(.sharedCopy, systemImage: "doc.on.doc") {
                    UIPasteboard.general.string = selectedItems.map(\.value).joined(separator: "\n")
                }
                .disabled(selectedItems.isEmpty)
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(.sharedSelect, systemImage: "lasso.sparkles") {
                    selectGroup()
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
                VStack(spacing: 8.0) {
                    HStack {
                        Text("Select.Group.Size.\(String(Int(groupSize)))")
                            .font(.body)
                        Spacer()
                        Stepper("", value: $groupSize, in: 1...maxGroupSize, step: 1)
                            .labelsHidden()
                    }
                    .padding(.horizontal)
                    ActionBar(primaryActionText: "Shared.Select",
                              primaryActionIconName: "lasso.sparkles",
                              copyDisabled: .constant(selectedItems.isEmpty),
                              primaryActionDisabled: .constant(items.isEmpty)) {
                        selectGroup()
                    } copyAction: {
                        UIPasteboard.general.string = selectedItems.map(\.value).joined(separator: "\n")
                    }
                }
            }
        }
        .navigationTitle("Select.Group.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    items.removeAll()
                    selectedItems.removeAll()
                } label: {
                    Text("Shared.Clear")
                }
            }
        }
        .onChange(of: items) {
            groupSize = min(groupSize, maxGroupSize)
        }
    }

    func selectGroup() {
        animateChange {
            selectedItems = Array(items.shuffled().prefix(Int(groupSize)))
        }
    }
}
