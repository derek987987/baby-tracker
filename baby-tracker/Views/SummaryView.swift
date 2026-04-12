import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Today's Summary")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack(spacing: 30) {
                summaryBox(title: "Sleep", value: String(format: "%.1f h", viewModel.totalSleepHours), color: .purple.opacity(0.2))
                summaryBox(title: "Feeding", value: String(format: "%.0f ml", viewModel.totalFeedingVolume), color: .blue.opacity(0.2))
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    private func summaryBox(title: String, value: String, color: Color) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title3)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .cornerRadius(10)
    }
}
