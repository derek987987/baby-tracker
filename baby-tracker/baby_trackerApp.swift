//
//  baby_trackerApp.swift
//  baby-tracker
//
//  Created by Derek Chung on 12/4/2026.
//

import SwiftUI
import SwiftData

@main
struct baby_trackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CareEvent.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
