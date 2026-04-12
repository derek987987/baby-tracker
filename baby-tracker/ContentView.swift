//
//  ContentView.swift
//  baby-tracker
//
//  Created by Derek Chung on 12/4/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: DashboardViewModel

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: DashboardViewModel(modelContext: modelContext))
    }

    var body: some View {
        DashboardView(viewModel: viewModel)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CareEvent.self, configurations: config)
    return ContentView(modelContext: container.mainContext)
        .modelContainer(container)
}
