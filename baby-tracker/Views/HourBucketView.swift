import SwiftUI

struct HourBucketView: View {
    let hour: Int
    let logs: [LogEntry]
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(hour):00")
                .font(.caption2)
                .foregroundColor(.gray)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 5) {
                ForEach(logs) { entry in
                    TimelineRow(entry: entry)
                }
            }
        }
        .padding(.vertical, 5)
    }
}
