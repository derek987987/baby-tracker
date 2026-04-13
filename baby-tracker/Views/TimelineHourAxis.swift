import SwiftUI

struct TimelineHourAxis: View {
    var body: some View {
        VStack(spacing: 40) {
            ForEach(0..<24) { hour in
                Text("\(hour)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .frame(height: 20)
            }
        }
        .padding(.vertical, 10)
    }
}
