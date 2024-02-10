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
This app uses data from the repository english-words.
For more information, visit https://github.com/dwyl/english-words.
"""),
    License(libraryName: "japanese", text:
"""
This app uses data from the repository japanese, which is licensed by the Creative Commons (CC BY) Attribution.
For more information, visit https://github.com/hingston/japanese.
License information can be found at https://creativecommons.org/licenses/by/2.5/.
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
