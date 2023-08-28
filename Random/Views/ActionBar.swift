//
//  ActionBar.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ActionBar: View {

    @State var primaryActionText: String
    @Binding var copyDisabled: Bool
    @Binding var primaryActionDisabled: Bool
    var primaryAction: () -> Void
    var copyAction: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Button {
                copyAction()
            } label: {
                LargeButtonLabel(iconName: "doc.on.doc",
                                 text: "Shared.Copy")
            }
            .buttonStyle(.bordered)
            .clipShape(RoundedRectangle(cornerRadius: 99))
            .disabled(copyDisabled)
            Button {
                primaryAction()
            } label: {
                LargeButtonLabel(iconName: "scope",
                                 text: 
                                    NSLocalizedString(primaryActionText, 
                                                      comment: ""))
                .bold()
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 99))
            .disabled(primaryActionDisabled)
        }
    }
}
