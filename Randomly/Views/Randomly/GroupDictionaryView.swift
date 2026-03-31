//
//  GroupDictionaryView.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct GroupDictionaryView: View {

    @State var items: [SelectItem] = []
    @State var groupedItems: [[SelectItem]] = []
    @State var groupCount: Float = 2

    var maxGroupCount: Float {
        max(Float(items.count), 1)
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            if !groupedItems.isEmpty {
                List {
                    ForEach(Array(groupedItems.enumerated()), id: \.offset) { index, group in
                        Section {
                            ForEach(group, id: \.self) { item in
                                HStack(alignment: .center, spacing: 8.0) {
                                    Text(item.id)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                    Text(item.value)
                                        .font(.body)
                                }
                            }
                        } header: {
                            Text("Group.GroupLabel.\(String(index + 1))")
                                .font(.headline)
                        }
                    }
                }
                .listStyle(.plain)
            } else {
                DictionaryView(items: $items) {
                    EmptyView()
                }
            }
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    HStack {
                        Text("Group.GroupCount.\(String(Int(groupCount)))")
                            .font(.body)
                        Spacer()
                        Stepper("", value: $groupCount, in: 2...maxGroupCount, step: 1)
                            .labelsHidden()
                    }
                }
                .padding()
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0.0) {
            ActionBar(primaryActionText: "Group.Action",
                      primaryActionIconName: "rectangle.3.group",
                      copyDisabled: .constant(groupedItems.isEmpty),
                      primaryActionDisabled: .constant(items.count < 2)) {
                group()
            } copyAction: {
                copyGroups()
            }
            .frame(maxWidth: .infinity)
            .bottomBarBackground()
        }
        .navigationTitle("Group.Dictionary.ViewTitle")
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
            groupedItems.removeAll()
        }
        .persistItems(key: "groupDictItems", items: $items)
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
            text += group.map { "\($0.id): \($0.value)" }.joined(separator: "\n")
            text += "\n\n"
        }
        UIPasteboard.general.string = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
