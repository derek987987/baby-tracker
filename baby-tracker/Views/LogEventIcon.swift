import SwiftUI

struct LogEventIcon: View {
    let eventType: EventType
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
            
            Text(emoji)
                .font(.system(size: 20))
        }
        .frame(width: 40, height: 40)
    }
    
    private var backgroundColor: Color {
        switch eventType {
        case .nursing: return Color(red: 255/255, green: 180/255, blue: 180/255)
        case .bottle, .pumping: return Color(red: 255/255, green: 220/255, blue: 160/255)
        case .sleep: return Color(red: 200/255, green: 190/255, blue: 240/255)
        case .wetDiaper: return Color(red: 170/255, green: 220/255, blue: 255/255)
        case .dirtyDiaper: return Color(red: 240/255, green: 200/255, blue: 150/255)
        case .solidFood: return Color(red: 255/255, green: 200/255, blue: 200/255)
        case .vaccination: return Color.red
        case .walk: return Color.green
        case .medicine: return Color.blue
        case .bath: return Color.cyan
        default: return Color.gray
        }
    }
    
    private var emoji: String {
        switch eventType {
        case .nursing: return "🤱"
        case .bottle: return "🍼"
        case .pumping: return "⚡"
        case .sleep: return "💤"
        case .wetDiaper: return "💧"
        case .dirtyDiaper: return "💩"
        case .solidFood: return "🥣"
        case .vaccination: return "💉"
        case .walk: return "🚶"
        case .medicine: return "💊"
        case .bath: return "🛀"
        default: return "📝"
        }
    }
}
