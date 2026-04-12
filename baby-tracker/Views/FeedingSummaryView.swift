import SwiftUI
import Charts

struct FeedingSummaryView: View {
    let entries: [LogEntry]
    
    var body: some View {
        Chart {
            ForEach(entries) { entry in
                BarMark(
                    x: .value("Day", entry.timestamp, unit: .day),
                    y: .value("Amount", entry.amount ?? 0)
                )
            }
        }
        .frame(height: 200)
    }
}
