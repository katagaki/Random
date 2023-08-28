//
//  MainTabView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RandomlyView()
                .tabItem {
                    Image(systemName: "shuffle.circle.fill")
                    Text("View.Randomly")
                }
            NeatlyView()
                .tabItem {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    Text("View.Neatly")
                }
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("View.More")
                }
        }
    }
}
