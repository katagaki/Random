//
//  MoreView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/23.
//

import SwiftUI

class MoreViewController: UIHostingController<MoreView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: MoreView())
    }
}

struct MoreView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Link(destination: URL(string: "https://x.com/katagaki_")!) {
                        HStack {
                            ListRow(image: "ListIcon.Twitter",
                                    title: "More.Help.Twitter",
                                    subtitle: "More.Help.Twitter.Subtitle",
                                    includeSpacer: true)
                            Image(systemName: "safari")
                                .opacity(0.5)
                        }
                        .foregroundColor(.primary)
                    }
                    Link(destination: URL(string: "mailto:ktgk.public@icloud.com")!) {
                        HStack {
                            ListRow(image: "ListIcon.Email",
                                    title: "More.Help.Email",
                                    subtitle: "More.Help.Email.Subtitle",
                                    includeSpacer: true)
                            Image(systemName: "arrow.up.forward.app")
                                .opacity(0.5)
                        }
                        .foregroundColor(.primary)
                    }
                    Link(destination: URL(string: "https://github.com/katagaki/Random")!) {
                        HStack {
                            ListRow(image: "ListIcon.GitHub",
                                    title: "More.Help.GitHub",
                                    subtitle: "More.Help.GitHub.Subtitle",
                                    includeSpacer: true)
                            Image(systemName: "safari")
                                .opacity(0.5)
                        }
                        .foregroundColor(.primary)
                    }
                } header: {
                    ListSectionHeader(text: "More.Help")
                        .font(.body)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("View.More")
        }
    }
}
