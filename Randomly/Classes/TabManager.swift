//
//  TabManager.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/30.
//

import Foundation

class TabManager: ObservableObject {
    @Published var selectedTab: TabType = .randomly
    @Published var previouslySelectedTab: TabType = .randomly
}
