import SwiftUI

struct SettingsView: View {
    @AppStorage("useMetric") private var useMetric: Bool = true
    
    var body: some View {
        Form {
            Toggle("Use Metric Units (ml)", isOn: $useMetric)
        }
        .navigationTitle("Settings")
    }
}
