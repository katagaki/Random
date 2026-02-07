import SwiftUI

/// A reusable range input view with from/to text fields
struct RangeInputView: View {
    let label: LocalizedStringKey
    @Binding var rangeStart: Int
    @Binding var rangeEnd: Int
    var isTextFieldActive: FocusState<Bool>.Binding?

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(label)
                .font(.body)
                .bold()
            HStack(alignment: .center, spacing: 4.0) {
                Text("Shared.RangeFrom")
                    .font(.body)
                TextField("", value: $rangeStart, format: .number)
                    .keyboardType(.numberPad)
                    .focused(isTextFieldActive ?? FocusState<Bool>().projectedValue)
                Text("Shared.RangeTo")
                    .font(.body)
                TextField("", value: $rangeEnd, format: .number)
                    .keyboardType(.numberPad)
                    .focused(isTextFieldActive ?? FocusState<Bool>().projectedValue)
            }
            .textFieldStyle(.roundedBorder)
        }
    }
}
