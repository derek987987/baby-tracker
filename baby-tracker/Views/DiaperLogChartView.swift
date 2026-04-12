import SwiftUI
import Charts

struct DiaperLogChartView: View {
    let entries: [LogEntry]
    
    var body: some View {
        Chart {
            ForEach(entries.filter { $0.eventType == .wetDiaper || $0.eventType == .dirtyDiaper }) { entry in
                BarMark(
                    x: .value("Day", entry.timestamp, unit: .day),
                    y: .value("Count", 1)
                )
                .foregroundStyle(by: .value("Type", entry.eventType.rawValue))
            }
        }
        .frame(height: 200)
    }
}
