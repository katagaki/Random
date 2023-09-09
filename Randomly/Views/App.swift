//
//  App.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

@main
struct RandomlyApp: App {

    @StateObject var tabManager = TabManager()
    @StateObject var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(tabManager)
                .environmentObject(navigationManager)
        }
    }
}
