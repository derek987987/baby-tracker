import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("useMetric") private var useMetric: Bool = true
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
            Toggle("Use Metric Units (ml)", isOn: $useMetric)
            
            Button("Delete All Data", role: .destructive) {
                try? modelContext.delete(model: LogEntry.self)
                try? modelContext.delete(model: BabyProfile.self)
                try? modelContext.save()
                
                // Reset onboarding
                UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                
                // Kill the app
                exit(0)
            }
        }
        .navigationTitle("Settings")
    }
}
