//
//  NeatlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct NeatlyView: View {

    @EnvironmentObject var navigationManager: NavigationManager

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack(path: $navigationManager.neatlyTabPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Sort")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.nSortList, title: "Neatly.Sort.List",
                                         icon: "list.bullet", iconColor: .blue)
                            GridCardView(destination: ViewPath.nSortDict, title: "Neatly.Sort.Dictionary",
                                         icon: "tablecells", iconColor: .purple)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Count")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.nCountUp, title: "Neatly.Count.Up",
                                         icon: "plus.circle.fill", iconColor: Locale.current.language.languageCode == .japanese ? .red : .green)
                            GridCardView(destination: ViewPath.nCountDown, title: "Neatly.Count.Down",
                                         icon: "minus.circle.fill", iconColor: Locale.current.language.languageCode == .japanese ? .blue : .red)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: ViewPath.self, destination: { viewPath in
                switch viewPath {
                case .nSortList:
                    SortListView()
                case .nSortDict:
                    SortDictionaryView()
                case .nCountUp:
                    NeatlyCountUpView()
                case .nCountDown:
                    NeatlyCountDownView()
                default:
                    Color.clear
                }
            })
            .navigationTitle("View.Neatly")
        }
    }
}
