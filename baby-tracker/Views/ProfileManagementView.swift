import SwiftUI
import SwiftData

struct ProfileManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var name: String = ""
    @State private var birthDate: Date = Date()
    
    var body: some View {
        Form {
            TextField("Baby Name", text: $name)
            DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
            Button("Add Baby") {
                let baby = BabyProfile(name: name, birthDate: birthDate)
                modelContext.insert(baby)
                try? modelContext.save()
            }
        }
    }
}
