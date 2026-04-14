import SwiftUI
import SwiftData

// MARK: - Registration Screens
struct LandingScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack {
            Text("Welcome to PiyoLog!")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(Color(red: 249/255, green: 124/255, blue: 136/255))
                .padding(.top, 60)
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color(red: 253/255, green: 245/255, blue: 244/255))
                    .frame(width: 250, height: 250)
                Text("🐣").font(.system(size: 100))
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: { state.nextStep() }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 249/255, green: 124/255, blue: 136/255))
                        .cornerRadius(30)
                }
                Text("For First-Time Users")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}

struct IntroScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack {
            Button(action: { state.prevStep() }) { 
                HStack(spacing: 2) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundColor(Color(red: 249/255, green: 124/255, blue: 136/255))
            }
            .frame(maxWidth: .infinity, alignment: .leading).padding()
            Spacer()
            Text("Register Your Baby")
                .font(.largeTitle).bold().foregroundColor(Color(red: 249/255, green: 124/255, blue: 136/255))
            Text("Let's get started! Tell us about the baby you'll be tracking.")
            Spacer()
            Button("Next") { state.nextStep() }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 40)
        }
    }
}

struct NicknameScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack {
            Button("Back", action: { state.prevStep() })
            TextField("Nickname", text: $state.nickname)
                .textFieldStyle(.roundedBorder)
            Button("Next") { state.nextStep() }
                .disabled(state.nickname.isEmpty)
        }
        .padding()
    }
}

struct GenderScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack {
            Button("Back", action: { state.prevStep() })
            Picker("Gender", selection: $state.gender) {
                ForEach(Gender.allCases, id: \.self) { Text($0.rawValue).tag($0) }
            }.pickerStyle(.segmented)
            Button("Next") { state.nextStep() }
        }
        .padding()
    }
}

struct DOBScreen: View {
    @ObservedObject var state: BabyAppState
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        VStack {
            Button("Back", action: { state.prevStep() })
            DatePicker("DOB", selection: Binding(get: { state.dob ?? Date() }, set: { state.dob = $0 }), displayedComponents: .date)
            Button("Done") {
                let baby = BabyProfile(name: state.nickname, birthDate: state.dob ?? Date())
                modelContext.insert(baby)
                try? modelContext.save()
                hasCompletedOnboarding = true
            }
        }
        .padding()
    }
}
