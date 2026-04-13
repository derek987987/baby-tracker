import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var logs: [LogEntry]
    @ObservedObject var viewModel: DashboardViewModel
    @Query private var babies: [BabyProfile]
    @State private var activeBabyID: UUID?
    @State private var showingManualEntry = false
    @State private var selectedEvent: EventType?
    
    var body: some View {
        NavigationStack {
            VStack {
                ProfileSelector(activeBabyID: $activeBabyID)
                
                if let baby = babies.first(where: { $0.id == activeBabyID }) ?? babies.first {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(0..<24, id: \.self) { hour in
                                HourBucketView(hour: hour, logs: viewModel.logs(for: hour, in: logs.filter { $0.babyID == baby.id }))
                            }
                        }
                        .padding(.top)
                    }
                    
                    QuickInputBar(onLog: { event in
                        selectedEvent = event
                        showingManualEntry = true
                    })
                    .padding(.bottom)
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
                    ManualEntryForm(babyID: baby.id, defaultType: selectedEvent ?? .nursing)
                } else {
                    ProfileManagementView()
                }
            }
        }
    }
}
