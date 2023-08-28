//
//  GeneratePasswordView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct GeneratePasswordView: View {

    @ObservedObject var password = Password(
        forPolicies: [.containsUppercase, .containsLowercase, .containsNumbers, .containsSymbols],
        withMinLength: 8,
        withMaxLength: 20)
    @State var minLength: Float = 8
    @State var maxLength: Float = 20
    @State var useLowercase: Bool = true
    @State var useUppercase: Bool = true
    @State var useNumbers: Bool = true
    @State var useSymbols: Bool = true

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Text(password.attributed())
                .font(.system(size: 200.0, weight: .heavy, design: .monospaced))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .textSelection(.enabled)
                .padding()
            Spacer()
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Randomly.Generate.Password.MinLength")
                HStack(alignment: .center, spacing: 8.0) {
                    Text(String(Int(minLength)))
                    Slider(value: $minLength, in: 8...128, step: 1) { _ in
                        password.minLength = Int(minLength)
                    }
                }
                Text("Randomly.Generate.Password.MaxLength")
                HStack(alignment: .center, spacing: 8.0) {
                    Text(String(Int(maxLength)))
                    Slider(value: $maxLength, in: 8...128, step: 1) { _ in
                        password.maxLength = Int(maxLength)
                    }
                }
            }
            .padding()
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                Toggle(isOn: $useUppercase, label: {
                    Text("Randomly.Generate.Password.Policy.Uppercase")
                })
                Divider()
                Toggle(isOn: $useLowercase, label: {
                    Text("Randomly.Generate.Password.Policy.Lowercase")
                })
                Divider()
                Toggle(isOn: $useNumbers, label: {
                    Text("Randomly.Generate.Password.Policy.Numbers")
                })
                Divider()
                Toggle(isOn: $useSymbols, label: {
                    Text("Randomly.Generate.Password.Policy.Symbols")
                })
            }
            .padding([.leading, .trailing])
            Divider()
            ActionBar(primaryActionText: "Shared.Generate",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(false),
                      primaryActionDisabled: .constant(maxLength < minLength ||
                                                       !useUppercase && !useLowercase && !useNumbers && !useSymbols)) {
                password.regenerate()
            } copyAction: {
                UIPasteboard.general.string = password.generated
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .onChange(of: useUppercase, perform: { _ in
            evaluatePasswordPolicy()
        })
        .onChange(of: useLowercase, perform: { _ in
            evaluatePasswordPolicy()
        })
        .onChange(of: useNumbers, perform: { _ in
            evaluatePasswordPolicy()
        })
        .onChange(of: useSymbols, perform: { _ in
            evaluatePasswordPolicy()
        })
        .navigationTitle("Randomly.Generate.Password.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func evaluatePasswordPolicy() {
        var policies: [Password.Policy] = []
        if useUppercase { policies.append(.containsUppercase) }
        if useLowercase { policies.append(.containsLowercase) }
        if useNumbers { policies.append(.containsNumbers) }
        if useSymbols { policies.append(.containsSymbols) }
        password.policies.removeAll()
        password.policies.append(contentsOf: policies)
    }

}
