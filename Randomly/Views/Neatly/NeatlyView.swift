//
//  NeatlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct NeatlyView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack(path: $navigationManager.neatlyTabPath) {
            List {
                Section {
                    NavigationLink(value: ViewPath.nSortList) {
                        Label("Neatly.Sort.List", systemImage: "list.bullet")
                    }
                    NavigationLink(value: ViewPath.nSortDict) {
                        Label("Neatly.Sort.Dictionary", systemImage: "tablecells")
                    }
                } header: {
                    ListSectionHeader(text: "Shared.Sort")
                        .font(.body)
                }
            }
            .navigationDestination(for: ViewPath.self, destination: { viewPath in
                switch viewPath {
                case .nSortList:
                    SortListView()
                case .nSortDict:
                    SortDictionaryView()
                default:
                    Color.clear
                }
            })
            .navigationTitle("View.Neatly")
        }
    }
}
