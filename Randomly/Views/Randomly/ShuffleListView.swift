//
//  ShuffleListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ShuffleListView: View {

    @State var items: [SelectItem] = []
    @State var newItem: String = ""
    @FocusState var focusedField: FocusedField?

    var body: some View {
        if #available(iOS 26.0, *) {
            ios26Body
        } else {
            legacyBody
        }
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
        ScrollViewReader { scrollView in
            List {
                ForEach(items, id: \.self) { item in
                    Text(item.value)
                        .font(.body)
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
        .navigationTitle("Shared.Shuffle.List.ViewTitle")
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
                Button(.sharedCopy, systemImage: "doc.on.doc") {
                    UIPasteboard.general.string = items.reduce(into: "", { result, item in
                        result += "\(item.value)\n"
                    })
                }
                .disabled(items.isEmpty)
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(.sharedShuffle, systemImage: "arrow.up.and.down.and.sparkles") {
                    items.shuffle()
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
                ActionBar(primaryActionText: "Shared.Shuffle",
                          primaryActionIconName: "arrow.up.and.down.and.sparkles",
                          copyDisabled: .constant(items.count == 0),
                          primaryActionDisabled: .constant(items.count == 0)) {
                    items.shuffle()
                } copyAction: {
                    UIPasteboard.general.string = items.reduce(into: "", { result, item in
                        result += "\(item.value)\n"
                    })
                }
            }
        }
        .navigationTitle("Shared.Shuffle.List.ViewTitle")
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

    func addNewItem() {
        if newItem != "" {
            items.append(
                SelectItem(id: UUID().uuidString,
                           value: newItem))
            newItem = ""
        }
    }

    enum FocusedField: Hashable {
        case newItemField
    }
}
