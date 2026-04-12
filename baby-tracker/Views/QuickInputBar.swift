import SwiftUI

struct QuickInputBar: View {
    var onLog: (EventType) -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: { onLog(.bottle) }) { Image(systemName: "bottle.fill").font(.largeTitle) }
            Button(action: { onLog(.nursing) }) { Image(systemName: "heart.fill").font(.largeTitle) }
            Button(action: { onLog(.wetDiaper) }) { Image(systemName: "drop.fill").font(.largeTitle) }
            Button(action: { onLog(.dirtyDiaper) }) { Image(systemName: "trash.fill").font(.largeTitle) }
            Button(action: { onLog(.sleep) }) { Image(systemName: "moon.fill").font(.largeTitle) }
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}
