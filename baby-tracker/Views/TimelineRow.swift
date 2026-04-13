import SwiftUI

struct TimelineRow: View {
    let entry: LogEntry
    @State private var showingEdit = false
    
    var body: some View {
        Button(action: { showingEdit = true }) {
            HStack(spacing: 15) {
                LogEventIcon(eventType: entry.eventType)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.eventType.rawValue.capitalized)
                        .font(.headline)
                        .scaledToFill()
                        .minimumScaleFactor(0.8)
                    Text(entry.timestamp, style: .time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if let amount = entry.amount {
                    Text("\(amount, specifier: "%.0f")ml")
                        .font(.subheadline)
                        .bold()
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingEdit) {
            EditEntrySheet(entry: entry)
        }
    }
}
