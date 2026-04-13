import SwiftUI

struct MenuView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Account")) {
                    Label("Account & Sharing", systemImage: "person.2")
                }
                
                Section(header: Text("Journal")) {
                    Label("Search Logs", systemImage: "magnifyingglass")
                    Label("Export Logs", systemImage: "doc.text")
                    Label("Calendar", systemImage: "calendar")
                }
                
                Section(header: Text("Preferences")) {
                    NavigationLink(destination: SettingsView()) {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                Section {
                    Label("About Premium Plan", systemImage: "star.fill")
                        .foregroundColor(.orange)
                }
                
                Section(header: Text("Support")) {
                    Label("Notifications", systemImage: "bell")
                    Label("Rate This App", systemImage: "star")
                    Label("Contact Us", systemImage: "envelope")
                    Label("Share with Friends", systemImage: "square.and.arrow.up")
                    Label("Terms & Conditions", systemImage: "doc.text.magnifyingglass")
                }
                
                Section(header: Text("Debug")) {
                    Button("Reset Onboarding", role: .destructive) {
                        hasCompletedOnboarding = false
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}
