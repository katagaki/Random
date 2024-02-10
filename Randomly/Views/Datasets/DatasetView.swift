//
//  DatasetView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/10.
//

import SwiftUI

struct DatasetView: View {

    @State var dataset: Dataset
    @State var data: [String] = []
    @State var searchTerm: String = ""
    @State var searchResults: [String] = []

    var body: some View {
        List {
            if searchTerm.trimmingCharacters(in: .whitespaces) == "" {
                ForEach(data, id: \.self) { data in
                    Text(data)
                        .textSelection(.enabled)
                }
            } else {
                ForEach(searchResults, id: \.self) { data in
                    Text(data)
                        .textSelection(.enabled)
                }
            }
        }
        .navigationTitle(NSLocalizedString(dataset.name, comment: ""))
        .listStyle(.plain)
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { oldValue, newValue in
            if newValue.contains(oldValue) {
                searchResults = data.filter({$0.lowercased().contains(newValue.lowercased())})
            } else {
                searchResults = data.filter({$0.lowercased().contains(newValue.lowercased())})
            }
        }
        .onAppear {
            let path = Bundle.main.path(forResource: dataset.fileName,
                                        ofType: dataset.fileExtension)!
            do {
                let loadedData: String = try String(contentsOfFile: path, encoding: .utf8)
                let dataArray: [String] = loadedData.components(separatedBy: .newlines)
                data = dataArray
            } catch {
                debugPrint("Error loading \(dataset.fileName).\(dataset.fileExtension)")
            }
        }
    }
}
