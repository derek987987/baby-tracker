import SwiftUI
import SwiftData

struct ProfileSelector: View {
    @Query(sort: \BabyProfile.name) var babies: [BabyProfile]
    @Binding var activeBabyID: UUID?
    
    var body: some View {
        Menu {
            ForEach(babies) { baby in
                Button(action: { activeBabyID = baby.id }) {
                    Text(baby.name)
                }
            }
        } label: {
            if let activeBaby = babies.first(where: { $0.id == activeBabyID }) {
                Text(activeBaby.name).font(.headline)
            } else {
                Text("Select Baby").font(.headline)
            }
        }
    }
}
