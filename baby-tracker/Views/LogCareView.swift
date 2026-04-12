import SwiftUI

struct LogCareView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Log Activity")
                .font(.headline)
            
            HStack {
                Button("Feeding") {
                    viewModel.logEvent(type: "Feeding")
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Diaper") {
                    viewModel.logEvent(type: "Diaper")
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Sleep") {
                    viewModel.logEvent(type: "Sleep")
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding()
    }
}
