import SwiftUI

struct LogCareView: View {
    @ObservedObject var viewModel: DashboardViewModel
    let babyID: UUID
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Log Activity")
                .font(.headline)
            
            HStack {
                Button("Feeding") {
                    viewModel.logEvent(.bottle, babyID: babyID)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Diaper") {
                    viewModel.logEvent(.wetDiaper, babyID: babyID)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Sleep") {
                    viewModel.logEvent(.sleep, babyID: babyID)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding()
    }
}
