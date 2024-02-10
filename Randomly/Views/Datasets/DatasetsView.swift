//
//  DatasetsView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/10.
//

import Komponents
import SwiftUI

struct DatasetsView: View {

    let wordlists: [Dataset] = [
        Dataset(name: "Dataset.Wordlist", fileName: "Wordlist-EN", fileExtension: "txt"),
        Dataset(name: "Dataset.Tangolist", fileName: "Wordlist-JP", fileExtension: "txt")
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(wordlists, id: \.name) { wordlistDataset in
                        NavigationLink {
                            DatasetView(dataset: wordlistDataset)
                        } label: {
                            Text(NSLocalizedString(wordlistDataset.name, comment: ""))
                        }
                    }
                } header: {
                    ListSectionHeader(text: "Dataset.Type.Wordlists")
                }
            }
            .navigationTitle("View.Datasets")
            .listStyle(.insetGrouped)
        }
    }
}
