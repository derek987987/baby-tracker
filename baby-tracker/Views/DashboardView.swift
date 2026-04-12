import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    @StateObject private var summaryViewModel = SummaryViewModel()
    @State private var showingLogSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header Summary
                HStack(spacing: 20) {
                    summaryItem(type: "Feeding")
                    summaryItem(type: "Diaper")
                    summaryItem(type: "Sleep")
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                
                SummaryView(viewModel: summaryViewModel)
                    .padding(.vertical)

                List(viewModel.events) { event in
                    TimelineRow(event: event)
                }
                .listStyle(.plain)
                
                // Bottom Quick-Log Strip
                HStack {
                    Button(action: { 
                        viewModel.logEvent(type: "Feeding")
                        summaryViewModel.calculateSummary(for: viewModel.events)
                    }) {
                        Label("Feed", systemImage: "fork.knife")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: { 
                        viewModel.logEvent(type: "Diaper")
                        summaryViewModel.calculateSummary(for: viewModel.events)
                    }) {
                        Label("Diaper", systemImage: "drop.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: { 
                        viewModel.logEvent(type: "Sleep")
                        summaryViewModel.calculateSummary(for: viewModel.events)
                    }) {
                        Label("Sleep", systemImage: "moon.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color(.systemBackground))
            }
            .navigationTitle("Baby Tracker")
            .onAppear {
                summaryViewModel.calculateSummary(for: viewModel.events)
            }
        }
    }
    
    @ViewBuilder
    private func summaryItem(type: String) -> some View {
        VStack {
            Text(type)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(viewModel.timeSinceLastEvent(type: type))
                .font(.subheadline)
                .bold()
        }
    }
}
