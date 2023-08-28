//
//  ListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ListView: View {

    @Binding var selectedItem: SelectItem?
    @State var newItem: String = ""
    @Binding var items: [SelectItem]
    @State var isAddingNewItem: Bool = false
    @FocusState var isTextFieldActive: Bool

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
            .onChange(of: items, perform: { _ in
                if items.count > 0 && isAddingNewItem {
                    scrollView.scrollTo(items.last!, anchor: .bottom)
                    isAddingNewItem = false
                }
            })
            .overlay {
                if items.count == 0 {
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
                }
            }
            Divider()
            HStack(alignment: .center, spacing: 8.0) {
                TextField("Shared.List.NewItem",
                          text: $newItem)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .focused($isTextFieldActive)
                .onSubmit {
                    addNewItem()
                }
                Button {
                    addNewItem()
                } label: {
                    Image(systemName: "plus")
                    Text("Shared.Add")
                        .bold()
                }
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                .disabled(newItem == "")
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8.0)
        }
        .onAppear {
            isTextFieldActive = true
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Shared.Done") {
                    isTextFieldActive = false
                }
                .bold()
            }
        }
    }
    
    func addNewItem() {
        isAddingNewItem = true
        items.append(
            SelectItem(id: UUID().uuidString,
                       value: newItem))
        newItem = ""
        isTextFieldActive = true
    }
}
