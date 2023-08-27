//
//  GenerateView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import Combine
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
                .minimumScaleFactor(0.01)
                .padding()
            Spacer()
            switch mode {
            case .number:
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Shared.RangeFrom")
                        .font(.body)
                        .bold()
                    TextField("", value: $rangeStart, format: .number)
                        .limitInputLength(value: $rangeStart, length: 17)
                    Text("Shared.RangeTo")
                        .font(.body)
                        .bold()
                    TextField("", value: $rangeEnd, format: .number)
                        .limitInputLength(value: $rangeEnd, length: 17)
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
                    LargeButtonLabel(iconName: "doc.on.doc",
                                     text: "Shared.Copy")
                }
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                Button {
                    regenerate()
                } label: {
                    LargeButtonLabel(iconName: "sparkles",
                                     text: "Randomly.Generate")
                    .bold()
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                .disabled(rangeEnd <= rangeStart || rangeStart < -99999999999999999 || rangeEnd > 99999999999999999)
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .task {
            regenerate()
        }
        .navigationTitle(NSLocalizedString(mode.rawValue, comment: ""))
        .navigationBarTitleDisplayMode(.inline)
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
                    words.removeAll()
                }
            }
            result = words.randomElement()!
        }
    }
}

enum GenerateType: String {
    case number = "Randomly.Generate.Number.ViewTitle"
    case letter = "Randomly.Generate.Letter.ViewTitle"
    case word = "Randomly.Generate.Word.ViewTitle"
}

// Modified input length limiter from:
// https://sanzaru84.medium.com/swiftui-an-updated-approach-to-limit-the-amount-of-characters-in-a-textfield-view-984c942a156

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: Int
    var length: Int

    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            content
                .onChange(of: $value.wrappedValue) {
                    value = Int(String($0).prefix(length))!
                }
        } else {
            content
                .onReceive(Just(value)) {
                    value = Int(String($0).prefix(length))!
                }
        }
    }
}

extension View {
    func limitInputLength(value: Binding<Int>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
