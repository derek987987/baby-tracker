import SwiftUI

struct NursingTimerView: View {
    @State private var activeSide: Side? = nil
    var onLog: (Side, TimeInterval) -> Void
    
    var body: some View {
        HStack {
            Button("Left") { activeSide = .left }
                .buttonStyle(.borderedProminent)
                .tint(activeSide == .left ? .blue : .gray)
            
            Button("Right") { activeSide = .right }
                .buttonStyle(.borderedProminent)
                .tint(activeSide == .right ? .blue : .gray)
        }
    }
}
