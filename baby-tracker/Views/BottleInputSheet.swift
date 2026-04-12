import SwiftUI

struct BottleInputSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var amount: String = ""
    var onSave: (Double) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Amount (ml)", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Log Bottle")
            .toolbar {
                Button("Save") {
                    if let value = Double(amount) {
                        onSave(value)
                        dismiss()
                    }
                }
            }
        }
    }
}
