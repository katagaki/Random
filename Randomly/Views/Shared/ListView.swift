//
//  ListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ListView<Content: View>: View {

    @Binding var selectedItem: SelectItem?
    @State var newItem: String = ""
    @Binding var items: [SelectItem]
    @State var isAddingNewItem: Bool = false
    @FocusState var focusedField: FocusedField?
    @ViewBuilder var bottomView: () -> Content

    var body: some View {
        ScrollViewReader { scrollView in
            List(selection: $selectedItem) {
                ForEach(items, id: \.self) { item in
                    Text(item.value)
                        .font(.body)
                }
                .onDelete { indexSet in
                    items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .padding(.bottom, -8.0)
            .onChange(of: items) {
                if items.count > 0 && isAddingNewItem {
                    scrollView.scrollTo(items.last!, anchor: .bottom)
                    isAddingNewItem = false
                }
            }
            .overlay {
                if items.count == 0 {
                    VStack(alignment: .center, spacing: 16.0) {
                        VStack(alignment: .center, spacing: 8.0) {
                            Image(systemName: "questionmark.square.dashed")
                                .resizable()
                                .frame(width: 32,
                                       height: 32)
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
                            .buttonStyle(.borderedProminent)
                            .clipShape(RoundedRectangle(cornerRadius: 99))
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 16.0) {
                    HStack(alignment: .center, spacing: 8.0) {
                        TextField("Shared.List.NewItem",
                                  text: $newItem)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .newItemField)
                        .onSubmit {
                            addNewItem()
                        }
                        Button {
                            addNewItem()
                            focusedField = .newItemField
                        } label: {
                            Image(systemName: "plus")
                            Text("Shared.Add")
                                .bold()
                        }
                        .buttonStyle(.bordered)
                        .clipShape(RoundedRectangle(cornerRadius: 99))
                        .disabled(newItem == "")
                    }
                    bottomView()
                        .frame(maxWidth: .infinity)
                }
                .padding([.top, .bottom], 16.0)
                .padding([.leading, .trailing])
                .background(Material.bar)
                .overlay(alignment: .top) {
                    Rectangle()
                        .frame(height: 1/3)
                        .foregroundColor(.primary.opacity(0.2))
                }
            }
        }
        .onAppear {
            focusedField = .newItemField
        }
        .keyboardToolbar(focusedField: $focusedField)
    }

    func addNewItem() {
        if newItem != "" {
            isAddingNewItem = true
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
