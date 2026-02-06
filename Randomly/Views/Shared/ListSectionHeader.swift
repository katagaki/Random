//
//  ListSectionHeader.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/05.
//

import SwiftUI

struct ListSectionHeader: View {

    let text: LocalizedStringKey

    var body: some View {
        Text(text)
            .foregroundStyle(.primary)
            .font(.body)
            .bold()
    }
}
