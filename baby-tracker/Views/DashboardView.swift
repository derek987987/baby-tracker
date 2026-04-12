import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var logs: [LogEntry]
    @ObservedObject var viewModel: DashboardViewModel
    @Query private var babies: [BabyProfile]
    
    var body: some View {
        VStack {
            if let baby = babies.first {
                Text(baby.name)
                    .font(.largeTitle)
                
                List(logs) { log in
                    TimelineRow(entry: log)
                }
                
                QuickInputBar(onLog: { event in
                    viewModel.logEvent(event, babyID: baby.id)
                })
            } else {
                Text("No baby profile found.")
            }
        }
    }
}
