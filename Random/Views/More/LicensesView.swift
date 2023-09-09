//
//  LicensesView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2023/09/09.
//

import SwiftUI

struct LicensesView: View {

    @State var licenses: [License] = [
    License(libraryName: "english-words", text:
"""
This app uses data from the repository english-words. For more informatino, visit https://github.com/dwyl/english-words.
""")
    ]

    var body: some View {
        List(licenses, id: \.libraryName) { license in
            Section {
                Text(license.text)
                    .font(.caption)
                    .monospaced()
            } header: {
                ListSectionHeader(text: license.libraryName)
                    .font(.body)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("ViewTitle.Attributions")
    }
}
