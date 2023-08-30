//
//  NavigationManager.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/30.
//

import Foundation

class NavigationManager: ObservableObject {

    @Published var randomlyTabPath: [ViewPath] = []
    @Published var neatlyTabPath: [ViewPath] = []
    @Published var moreTabPath: [ViewPath] = []

    func popToRoot(for tab: TabType) {
        switch tab {
        case .randomly:
            randomlyTabPath.removeAll()
        case .neatly:
            neatlyTabPath.removeAll()
        case .more:
            moreTabPath.removeAll()
        }
    }

    func push(_ component: ViewPath, for tab: TabType) {
        switch tab {
        case .randomly:
            randomlyTabPath.append(component)
        case .neatly:
            neatlyTabPath.append(component)
        case .more:
            moreTabPath.append(component)
        }
    }

    func pop(for tab: TabType) {
        switch tab {
        case .randomly:
            if !randomlyTabPath.isEmpty {
                randomlyTabPath.removeLast()
            }
        case .neatly:
            if !neatlyTabPath.isEmpty {
                neatlyTabPath.removeLast()
            }
        case .more:
            if !moreTabPath.isEmpty {
                moreTabPath.removeLast()
            }
        }
    }
}
