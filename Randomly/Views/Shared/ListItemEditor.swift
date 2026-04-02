//
//  ListItemEditor.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

/// Shared editing state and helper views for list-based tools.
/// Manages inline editing, swipe actions, new-item row, and empty state overlay.
@Observable
class ListItemEditor {
    var editingItemId: String?
    var editingValue: String = ""
    var newItem: String = ""

    func startEditing(_ item: SelectItem) {
        editingItemId = item.id
        editingValue = item.value
    }

    func commitEdit(items: inout [SelectItem]) {
        if let editingItemId, let index = items.firstIndex(where: { $0.id == editingItemId }) {
            if editingValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                items.remove(at: index)
            } else {
                items[index].value = editingValue
            }
        }
        editingItemId = nil
        editingValue = ""
    }

    func addNewItem(items: inout [SelectItem]) {
        if newItem != "" {
            items.append(
                SelectItem(id: UUID().uuidString, value: newItem))
            newItem = ""
        }
    }

    static func pasteFromClipboard(items: inout [SelectItem]) {
        if let string = UIPasteboard.general.string {
            let stringComponents = string.components(separatedBy: .newlines)
            for stringComponent in stringComponents where
            stringComponent.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                items.append(
                    SelectItem(id: UUID().uuidString,
                               value: stringComponent.trimmingCharacters(in: .whitespacesAndNewlines)))
            }
        }
    }
}

enum ListFocusedField: Hashable {
    case newItemField
    case editItemField
}

/// A standard list row that supports inline editing and trailing swipe actions (Edit + Delete).
struct EditableListRow: View {
    let item: SelectItem
    @Bindable var editor: ListItemEditor
    var focusedField: FocusState<ListFocusedField?>.Binding
    var onDelete: () -> Void

    var body: some View {
        if editor.editingItemId == item.id {
            TextField("", text: $editor.editingValue)
                .font(.body)
                .focused(focusedField, equals: .editItemField)
                .submitLabel(.done)
                .onSubmit {
                    // commitEdit is called by the parent since it needs &items
                }
        } else {
            Text(item.value)
                .font(.body)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        onDelete()
                    } label: {
                        Label("Shared.Delete", systemImage: "trash")
                    }
                    Button {
                        editor.startEditing(item)
                        focusedField.wrappedValue = .editItemField
                    } label: {
                        Label("Shared.Edit", systemImage: "pencil")
                    }
                    .tint(.orange)
                }
        }
    }
}

/// The inline new-item TextField shown as the last row in a list.
struct NewItemRow: View {
    @Bindable var editor: ListItemEditor
    var focusedField: FocusState<ListFocusedField?>.Binding
    var onAdd: () -> Void

    var body: some View {
        Section {
            TextField("Shared.List.NewItem", text: $editor.newItem)
                .font(.body)
                .focused(focusedField, equals: .newItemField)
                .submitLabel(.done)
                .onSubmit {
                    onAdd()
                    focusedField.wrappedValue = .newItemField
                }
        }
    }
}

/// Empty list placeholder with paste button.
struct EmptyListOverlay: View {
    var onPaste: () -> Void

    var body: some View {
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
                    onPaste()
                } label: {
                    Label("Shared.Paste", systemImage: "doc.on.clipboard")
                        .bold()
                }
                .prominentPillButton()
            }
        }
    }
}
