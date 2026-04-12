import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var logs: [LogEntry]
    @ObservedObject var viewModel: DashboardViewModel
    @Query private var babies: [BabyProfile]
    
    @State private var showingManualEntry = false
    
    var body: some View {
        NavigationStack {
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
            .toolbar {
                Button(action: { showingManualEntry = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingManualEntry) {
                if let baby = babies.first {
                    ManualEntryForm(babyID: baby.id)
                }
            }
        }
    }
}
