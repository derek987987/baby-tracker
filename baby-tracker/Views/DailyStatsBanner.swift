import SwiftUI

struct DailyStatsBanner: View {
    let sleepTotal: Double
    let milkTotal: Double
    let diaperCount: Int
    
    var body: some View {
        HStack {
            Text("Sleep: \(sleepTotal, specifier: "%.1f")h")
            Text("Milk: \(milkTotal, specifier: "%.0f")ml")
            Text("Diapers: \(diaperCount)")
        }
        .font(.caption)
        .padding()
    }
}
