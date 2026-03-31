//
//  MoreList.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/05.
//

import SwiftUI

struct MoreList<Content: View>: View {

    let repoName: String
    let viewPath: ViewPath
    @ViewBuilder var content: () -> Content

    var body: some View {
        List {
            content()

            Section {
                Link(destination: URL(string: "https://github.com/\(repoName)")!) {
                    HStack {
                        Text("More.SourceCode")
                        Spacer()
                        Text(repoName)
                            .foregroundStyle(.secondary)
                    }
                }
                .tint(.primary)

                NavigationLink(value: viewPath) {
                    Label("More.Attributions", systemImage: "doc.text")
                }
            } header: {
                ListSectionHeader(text: "More.About")
                    .font(.body)
            }

        }
    }
}
