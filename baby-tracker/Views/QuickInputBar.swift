import SwiftUI

struct QuickInputBar: View {
    var onLog: (EventType) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(EventType.allCases, id: \.self) { event in
                    Button(action: { onLog(event) }) {
                        VStack {
                            LogEventIcon(eventType: event)
                            Text(event.rawValue.capitalized)
                                .font(.caption2)
                                .foregroundColor(.primary)
                        }
                    }
                    .frame(width: 60)
                }
            }
            .padding()
        }
        .background(.ultraThinMaterial)
    }
}
