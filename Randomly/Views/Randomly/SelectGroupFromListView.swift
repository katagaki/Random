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
    @State var newItem: String = ""
    @FocusState var focusedField: FocusedField?

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
                ForEach(items, id: \.self) { item in
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
                }
                .onDelete { indexSet in
                    items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .onChange(of: items) {
                if items.count > 0 {
                    scrollView.scrollTo(items.last!, anchor: .bottom)
                }
                groupSize = min(groupSize, maxGroupSize)
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
                                pasteFromClipboard()
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
                TextField(.sharedListNewItem, text: $newItem)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .newItemField)
                    .onSubmit(addNewItem)
                    .padding(.leading)
                Button(.sharedAdd, systemImage: "plus") {
                    addNewItem()
                    focusedField = .newItemField
                }
                .disabled(newItem.isEmpty)
            }
            ToolbarSpacer(.fixed, placement: .bottomBar)
            ToolbarItemGroup(placement: .bottomBar) {
                Text("Select.Group.Size.\(String(Int(groupSize)))")
                    .font(.caption)
                Stepper("", value: $groupSize, in: 1...maxGroupSize, step: 1)
                    .labelsHidden()
            }
            ToolbarSpacer(.fixed, placement: .bottomBar)
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

    func addNewItem() {
        if newItem != "" {
            items.append(
                SelectItem(id: UUID().uuidString,
                           value: newItem))
            newItem = ""
        }
    }

    func pasteFromClipboard() {
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

    enum FocusedField: Hashable {
        case newItemField
    }
}
