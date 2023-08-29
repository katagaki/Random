//
//  GenerateColorView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/29.
//

import SwiftUI

struct GenerateColorView: View {

    @State var red: Int = 0
    @State var green: Int = 0
    @State var blue: Int = 0
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            VStack(alignment: .center, spacing: 4.0) {
                Color(red: Double(red) / 255,
                      green: Double(green) / 255,
                      blue: Double(blue) / 255)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(.primary, lineWidth: 1/3)
                        .opacity(0.3)
                )
                .frame(width: 200, height: 200)
                .padding()
                HStack(alignment: .center, spacing: 2.0) {
                    Text("#")
                        .font(.body)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text("\(hex())")
                        .font(.body)
                        .bold()
                        .textSelection(.enabled)
                }
            }
            Spacer()
            Divider()
            HStack(alignment: .center, spacing: 8.0) {
                HStack(alignment: .center, spacing: 4.0) {
                    Text("Shared.Red")
                        .font(.body)
                        .bold()
                    TextField("", value: $red, format: .number)
                }
                HStack(alignment: .center, spacing: 4.0) {
                    Text("Shared.Green")
                        .font(.body)
                        .bold()
                    TextField("", value: $green, format: .number)
                }
                HStack(alignment: .center, spacing: 4.0) {
                    Text("Shared.Blue")
                        .font(.body)
                        .bold()
                    TextField("", value: $blue, format: .number)
                }
            }
            .textFieldStyle(.roundedBorder)
            .focused($isTextFieldActive)
            .disabled(true)
            .padding()
            Divider()
            ScrollView(.horizontal) {
                ActionBar(primaryActionText: "Shared.Generate",
                          primaryActionIconName: "sparkles",
                          copyDisabled: .constant(false),
                          primaryActionDisabled: .constant(false)) {
                    regenerate()
                } copyAction: {
                    UIPasteboard.general.string = "\(red), \(green), \(blue)"
                } .secondaryAction {
                    Button {
                        UIPasteboard.general.string = 
                        """
                        Color(red: \(red) / 255, green: \(green) / 255, blue: \(blue) / 255)
                        """
                    } label: {
                        LargeButtonLabel(iconName: "doc.on.doc",
                                         text: "Shared.Copy.SwiftUICode")
                    }
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 99))
                }
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing])
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            }
            .scrollIndicators(.hidden)
        }
        .task {
            regenerate()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Shared.Done") {
                    isTextFieldActive = false
                }
                .bold()
            }
        }
        .navigationTitle("Randomly.Generate.Color.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func regenerate() {
        red = (0..<255).randomElement() ?? 0
        green = (0..<255).randomElement() ?? 0
        blue = (0..<255).randomElement() ?? 0
    }
    
    func hex() -> String {
        Color(red: Double(red) / 255,
              green: Double(green) / 255,
              blue: Double(blue) / 255).toHex() ?? ""
    }
}

#Preview {
    GenerateColorView(red: 0, green: 0, blue: 0)
}

// Adapted from https://blog.eidinger.info/from-hex-to-color-and-back-in-swiftui
extension Color {
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, 
                components.count >= 3 else {
            return nil
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])

        return String(format: "%02lX%02lX%02lX",
                      lroundf(r * 255),
                      lroundf(g * 255),
                      lroundf(b * 255))
    }
}
