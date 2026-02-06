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
                        Label("More.ViewOnGitHub", systemImage: "link")
                        Spacer()
                        Image(systemName: "arrow.up.forward")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                
                NavigationLink(value: viewPath) {
                    Label("More.Attributions", systemImage: "doc.text")
                }
            } header: {
                ListSectionHeader(text: "More.About")
                    .font(.body)
            }
            
            Section {
                HStack {
                    Text("More.Version")
                    Spacer()
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        Text(version)
                            .foregroundStyle(.secondary)
                    }
                }
                
                HStack {
                    Text("More.Build")
                    Spacer()
                    if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        Text(build)
                            .foregroundStyle(.secondary)
                    }
                }
            } header: {
                ListSectionHeader(text: "More.AppInformation")
                    .font(.body)
            }
        }
    }
}
