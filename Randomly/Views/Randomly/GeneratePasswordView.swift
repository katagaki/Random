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
            ScrollView(.horizontal) {
                Text(password.attributed())
                    .font(.system(size: 50, weight: .heavy, design: .monospaced))
                    .lineLimit(1)
                    .textSelection(.enabled)
                    .padding()
            }
            .scrollIndicators(.hidden)
            Spacer()
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Generate.Password.MinLength.\(String(Int(minLength)))")
                Slider(value: $minLength, in: 8...128, step: 1) { _ in
                    password.minLength = Int(minLength)
                }
                Text("Generate.Password.MaxLength.\(String(Int(maxLength)))")
                Slider(value: $maxLength, in: 8...128, step: 1) { _ in
                    password.maxLength = Int(maxLength)
                }
            }
            .padding()
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                Toggle(isOn: $useUppercase, label: {
                    Text("Generate.Password.Policy.Uppercase")
                })
                Divider()
                Toggle(isOn: $useLowercase, label: {
                    Text("Generate.Password.Policy.Lowercase")
                })
                Divider()
                Toggle(isOn: $useNumbers, label: {
                    Text("Generate.Password.Policy.Numbers")
                })
                Divider()
                Toggle(isOn: $useSymbols, label: {
                    Text("Generate.Password.Policy.Symbols")
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
        .onChange(of: useUppercase) {
            evaluatePasswordPolicy()
        }
        .onChange(of: useLowercase) {
            evaluatePasswordPolicy()
        }
        .onChange(of: useNumbers) {
            evaluatePasswordPolicy()
        }
        .onChange(of: useSymbols) {
            evaluatePasswordPolicy()
        }
        .navigationTitle("Generate.Password.ViewTitle")
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
