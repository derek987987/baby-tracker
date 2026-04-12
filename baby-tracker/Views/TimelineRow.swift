import SwiftUI

struct TimelineRow: View {
    let entry: LogEntry
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(entry.eventType.rawValue.capitalized)
                    .font(.headline)
                Text(entry.timestamp, style: .time)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let amount = entry.amount {
                Text("\(amount, specifier: "%.0f") ml")
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
    
    private var iconName: String {
        switch entry.eventType {
        case .sleep: return "moon.fill"
        case .nursing: return "heart.fill"
        case .bottle: return "bottle.fill"
        case .wetDiaper, .dirtyDiaper: return "drop.fill"
        case .solidFood: return "fork.knife"
        }
    }
}
