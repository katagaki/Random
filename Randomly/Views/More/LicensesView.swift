//
//  LicensesView.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/05.
//

import SwiftUI

struct LicensesView: View {
    
    let licenses: [License]
    
    var body: some View {
        List {
            ForEach(licenses, id: \.libraryName) { license in
                Section {
                    Text(license.text)
                        .font(.body)
                        .textSelection(.enabled)
                } header: {
                    ListSectionHeader(text: LocalizedStringKey(license.libraryName))
                        .font(.body)
                }
            }
        }
        .navigationTitle("More.Attributions")
        .navigationBarTitleDisplayMode(.inline)
    }
}
