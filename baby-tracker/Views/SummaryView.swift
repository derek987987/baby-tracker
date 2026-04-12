import SwiftUI
import SwiftData

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryViewModel
    let babyID: UUID
    
    var body: some View {
        let logs = viewModel.fetchHistoricalData(for: babyID)
        
        ScrollView {
            VStack {
                Text("Sleep Trends")
                SleepChartView(entries: logs.filter { $0.eventType == .sleep })
                
                Text("Feeding Summary")
                FeedingSummaryView(entries: logs.filter { $0.eventType == .bottle })
                
                Text("Diaper Log")
                DiaperLogChartView(entries: logs)
            }
        }
        .navigationTitle("Analytics")
    }
}
