import SwiftUI

struct TimelineRow: View {
    let event: CareEvent
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: iconName(for: event.type))
                .foregroundColor(color(for: event.type))
                .padding(10)
                .background(color(for: event.type).opacity(0.15))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.type)
                    .font(.headline)
                Text(event.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    private func iconName(for type: String) -> String {
        switch type {
        case "Feeding": return "fork.knife"
        case "Diaper": return "drop.fill"
        case "Sleep": return "moon.fill"
        default: return "info.circle"
        }
    }
    
    private func color(for type: String) -> Color {
        switch type {
        case "Feeding": return .blue
        case "Diaper": return .green
        case "Sleep": return .purple
        default: return .gray
        }
    }
}
