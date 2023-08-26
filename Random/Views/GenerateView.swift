//
//  GenerateView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct GenerateView: View {

    @State var mode: GenerateType
    @State var result: String = ""
    @State var rangeStart: Int = 1
    @State var rangeEnd: Int = 100
    @State var words: [String] = []

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Text(result)
                .font(.system(size: 200.0, weight: .heavy))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding()
            Spacer()
            switch mode {
            case .number:
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("From")
                        .font(.body)
                        .bold()
                    TextField("", value: $rangeStart, format: .number)
                    Text("To")
                        .font(.body)
                        .bold()
                    TextField("", value: $rangeEnd, format: .number)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                Divider()
            default:
                Divider()
            }
            HStack(alignment: .center, spacing: 8.0) {
                Button {
                    UIPasteboard.general.string = result
                } label: {
                    HStack(alignment: .center, spacing: 4.0) {
                        Image(systemName: "doc.on.doc")
                        Text("Copy")
                            .padding([.top, .bottom], 4.0)
                    }
                    .padding([.leading, .trailing], 20.0)
                }
                .buttonStyle(.bordered)
                Button {
                    regenerate()
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
                .disabled(rangeEnd <= rangeStart)
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8.0)
        }
        .task {
            regenerate()
        }
    }
    
    func regenerate() {
        switch mode {
        case .number:
            result = String(Int.random(in: rangeStart...rangeEnd))
        case .letter:
            let letterIndex: Int = Int.random(in: 0...25)
            result = String(Character(UnicodeScalar(65 + letterIndex)!))
        case .word:
            if words.count == 0 {
                let path = Bundle.main.path(forResource: "Wordlist", ofType: "txt")!
                do {
                    let wordlist: String = try String(contentsOfFile: path, encoding: .utf8)
                    words = wordlist.components(separatedBy: .newlines)
                } catch {
                    words = []
                }
            }
            result = words.randomElement()!
        }
    }
}

enum GenerateType {
    case number
    case letter
    case word
}
