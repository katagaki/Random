//
//  MoreView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/23.
//

import Komponents
import SwiftUI

struct MoreView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack(path: $navigationManager.moreTabPath) {
            MoreList(repoName: "katagaki/Random", viewPath: ViewPath.moreAttributions) { }
            .navigationDestination(for: ViewPath.self, destination: { viewPath in
                switch viewPath {
                case .moreAttributions: LicensesView()
                default: Color.clear
                }
            })
            .navigationTitle("View.More")
        }
    }
}
