import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var logs: [LogEntry]
    @ObservedObject var viewModel: DashboardViewModel
    @Query private var babies: [BabyProfile]
    @State private var activeBabyID: UUID?
    @State private var showingManualEntry = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ProfileSelector(activeBabyID: $activeBabyID)
                
                if let baby = babies.first(where: { $0.id == activeBabyID }) ?? babies.first {
                    List(logs.filter { $0.babyID == baby.id }) { log in
                        TimelineRow(entry: log)
                    }
                    
                    QuickInputBar(onLog: { event in
                        viewModel.logEvent(event, babyID: baby.id)
                    })
                } else {
                    Text("Add a baby profile to get started.")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingManualEntry = true }) { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showingManualEntry) {
                if let baby = babies.first(where: { $0.id == activeBabyID }) ?? babies.first {
                    ManualEntryForm(babyID: baby.id)
                } else {
                    ProfileManagementView()
                }
            }
        }
    }
}
