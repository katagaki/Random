//
//  NeatlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import Komponents
import SwiftUI

struct NeatlyView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack(path: $navigationManager.neatlyTabPath) {
            List {
                Section {
                    NavigationLink(value: ViewPath.nSortList) {
                        ListRow(image: "ListIcon.List",
                                title: "Neatly.Sort.List")
                    }
                    NavigationLink(value: ViewPath.nSortDict) {
                        ListRow(image: "ListIcon.Table",
                                title: "Neatly.Sort.Dictionary")
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
