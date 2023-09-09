//
//  MainTabView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var tabManager: TabManager
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        TabView(selection: $tabManager.selectedTab) {
            RandomlyView()
                .tabItem {
                    Image(systemName: "shuffle.circle.fill")
                    Text("View.Randomly")
                }
                .tag(TabType.randomly)
            NeatlyView()
                .tabItem {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    Text("View.Neatly")
                }
                .tag(TabType.neatly)
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("View.More")
                }
                .tag(TabType.more)
        }
        .onReceive(tabManager.$selectedTab, perform: { newValue in
            if newValue == tabManager.previouslySelectedTab {
                navigationManager.popToRoot(for: newValue)
            }
            tabManager.previouslySelectedTab = newValue
        })
    }
}
