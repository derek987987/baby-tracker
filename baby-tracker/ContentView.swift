import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            DashboardView(viewModel: DashboardViewModel(modelContext: modelContext))
                .tabItem {
                    Label("Logs", systemImage: "pencil.line")
                }
            
            NavigationStack {
                SummaryView(viewModel: SummaryViewModel(modelContext: modelContext), babyID: UUID())
            }
            .tabItem {
                Label("Summary", systemImage: "chart.bar.xaxis")
            }
            
            Text("Growth Chart View")
                .tabItem {
                    Label("Growth Chart", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "line.3.horizontal")
                }
        }
    }
}
