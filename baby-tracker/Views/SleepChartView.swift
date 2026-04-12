import SwiftUI
import Charts

struct SleepChartView: View {
    let entries: [LogEntry]
    
    var body: some View {
        Chart {
            ForEach(entries) { entry in
                BarMark(
                    x: .value("Day", entry.timestamp, unit: .day),
                    y: .value("Hours", (entry.duration ?? 0) / 3600)
                )
            }
        }
        .frame(height: 200)
    }
}
