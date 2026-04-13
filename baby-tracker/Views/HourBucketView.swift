import SwiftUI

struct HourBucketView: View {
    let hour: Int
    let logs: [LogEntry]
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Time column always visible
            Text("\(hour):00")
                .font(.system(.caption2, design: .rounded))
                .foregroundColor(.gray)
                .frame(width: 50, alignment: .leading)
                .padding(.top, 4)
            
            // Content column
            VStack(alignment: .leading, spacing: 5) {
                if logs.isEmpty {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 30) // Min height to keep bucket visible
                } else {
                    ForEach(logs) { entry in
                        TimelineRow(entry: entry)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
