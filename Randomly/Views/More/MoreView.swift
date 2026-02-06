//
//  MoreView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/23.
//

import SwiftUI

struct MoreView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack(path: $navigationManager.moreTabPath) {
            MoreList(repoName: "katagaki/Random", viewPath: ViewPath.moreAttributions) {
                Section {
                    NavigationLink(value: ViewPath.moreDatasets) {
                        Label("More.Datasets", systemImage: "cylinder.split.1x2")
                    }
                } header: {
                    ListSectionHeader(text: "More.General")
                        .font(.body)
                }
            }
            .navigationDestination(for: ViewPath.self, destination: { viewPath in
                switch viewPath {
                case .moreDatasets: DatasetsView()
                case .moreAttributions: LicensesView(licenses: [
                    License(libraryName: "english-words", text:
"""
This app uses data from the repository english-words.
For more information, visit https://github.com/dwyl/english-words.
"""),
                    License(libraryName: "japanese", text:
"""
This app uses data from the repository japanese, which is licensed by the Creative Commons (CC BY) Attribution.
For more information, visit https://github.com/hingston/japanese.
License information can be found at https://creativecommons.org/licenses/by/2.5/.
""")
                ])
                default: Color.clear
                }
            })
            .navigationTitle("View.More")
        }
    }
}
