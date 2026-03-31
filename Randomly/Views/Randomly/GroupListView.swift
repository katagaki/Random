//
//  GroupListView.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct GroupListView: View {

    @State var items: [SelectItem] = []
    @State var groupedItems: [[SelectItem]] = []
    @State var groupCount: Float = 2
    @State var newItem: String = ""
    @FocusState var focusedField: FocusedField?

    var maxGroupCount: Float {
        max(Float(items.count), 2)
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            ios26Body
                .persistItems(key: "groupListItems", items: $items)
        } else {
            legacyBody
                .persistItems(key: "groupListItems", items: $items)
        }
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
        ScrollViewReader { scrollView in
            List {
                if !groupedItems.isEmpty {
                    ForEach(Array(groupedItems.enumerated()), id: \.offset) { index, group in
                        Section {
                            ForEach(group, id: \.self) { item in
                                Text(item.value)
                                    .font(.body)
                            }
                        } header: {
                            Text("Group.GroupLabel.\(String(index + 1))")
                                .font(.headline)
                        }
                    }
                } else {
                    ForEach(items, id: \.self) { item in
                        Text(item.value)
                            .font(.body)
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                }
            }
            .listStyle(.plain)
            .onChange(of: items) {
                if items.count > 0 && groupedItems.isEmpty {
                    scrollView.scrollTo(items.last!, anchor: .bottom)
                }
                groupCount = min(groupCount, maxGroupCount)
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
        .navigationTitle("Group.List.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    items.removeAll()
                    groupedItems.removeAll()
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
                Text("Group.GroupCount.\(String(Int(groupCount)))")
                    .font(.caption)
                Stepper("", value: $groupCount, in: 2...maxGroupCount, step: 1)
                    .labelsHidden()
            }
            ToolbarSpacer(.fixed, placement: .bottomBar)
            ToolbarItemGroup(placement: .bottomBar) {
                Button(.sharedCopy, systemImage: "doc.on.doc") {
                    copyGroups()
                }
                .disabled(groupedItems.isEmpty)
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Group.Action", systemImage: "rectangle.3.group") {
                    group()
                }
                .buttonStyle(.glassProminent)
                .disabled(items.count < 2)
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
                    if !groupedItems.isEmpty {
                        ScrollView(.horizontal) {
                            HStack(spacing: 8.0) {
                                ForEach(Array(groupedItems.enumerated()), id: \.offset) { index, group in
                                    VStack(alignment: .leading, spacing: 4.0) {
                                        Text("Group.GroupLabel.\(String(index + 1))")
                                            .font(.caption)
                                            .bold()
                                        ForEach(group, id: \.self) { item in
                                            Text(item.value)
                                                .font(.body)
                                        }
                                    }
                                    .padding(8.0)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    HStack {
                        Text("Group.GroupCount.\(String(Int(groupCount)))")
                            .font(.body)
                        Spacer()
                        Stepper("", value: $groupCount, in: 2...maxGroupCount, step: 1)
                            .labelsHidden()
                    }
                    .padding(.horizontal)
                    ActionBar(primaryActionText: "Group.Action",
                              primaryActionIconName: "rectangle.3.group",
                              copyDisabled: .constant(groupedItems.isEmpty),
                              primaryActionDisabled: .constant(items.count < 2)) {
                        group()
                    } copyAction: {
                        copyGroups()
                    }
                }
            }
        }
        .navigationTitle("Group.List.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    items.removeAll()
                    groupedItems.removeAll()
                } label: {
                    Text("Shared.Clear")
                }
            }
        }
        .onChange(of: items) {
            groupCount = min(groupCount, maxGroupCount)
        }
    }

    func group() {
        animateChange {
            let shuffled = items.shuffled()
            let count = Int(groupCount)
            groupedItems = (0..<count).map { index in
                shuffled.enumerated()
                    .filter { $0.offset % count == index }
                    .map(\.element)
            }
        }
    }

    func copyGroups() {
        var text = ""
        for (index, group) in groupedItems.enumerated() {
            text += "Group \(index + 1):\n"
            text += group.map(\.value).joined(separator: "\n")
            text += "\n\n"
        }
        UIPasteboard.general.string = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func addNewItem() {
        if newItem != "" {
            groupedItems.removeAll()
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
