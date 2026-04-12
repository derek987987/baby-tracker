import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            DashboardView(viewModel: DashboardViewModel(modelContext: modelContext))
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
            
            NavigationStack {
                SummaryView(viewModel: SummaryViewModel(modelContext: modelContext), babyID: UUID()) // Placeholder babyID
            }
            .tabItem {
                Label("Analytics", systemImage: "chart.bar")
            }
        }
    }
}
