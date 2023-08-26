//
//  SelectItemFromListView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct SelectItemFromListView: View {

    @State var result: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Text(result)
                .font(.system(size: 200.0, weight: .heavy))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding()
            Spacer()
            Divider()
            HStack(alignment: .center, spacing: 8.0) {
                Button {
                    UIPasteboard.general.string = result
                } label: {
                    HStack(alignment: .center, spacing: 4.0) {
                        Image(systemName: "doc.on.doc")
                        Text("Copy Result")
                            .padding([.top, .bottom], 4.0)
                    }
                    .padding([.leading, .trailing], 20.0)
                }
                .buttonStyle(.bordered)
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 4.0) {
                        Image(systemName: "sparkles")
                        Text("Generate")
                            .padding([.top, .bottom], 4.0)
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 20.0)
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8.0)
        }
    }
}

#Preview {
    SelectItemFromListView()
}
