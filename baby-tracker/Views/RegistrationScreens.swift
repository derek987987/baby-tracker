import SwiftUI
import SwiftData

// MARK: - Onboarding Screens
struct LandingScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack {
            Text("Welcome to PiyoLog!")
                .font(Font.system(size: 34, weight: .bold))
                .foregroundColor(Color.appAccent)
                .padding(.top, 60)
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color(red: 253/255, green: 245/255, blue: 244/255))
                    .frame(width: 250, height: 250)
                    .shadow(color: Color.appAccent.opacity(0.2), radius: 20)
                
                Image(systemName: "iphone")
                    .font(Font.system(size: 100, weight: .light))
                    .foregroundColor(Color.gray)
                    .rotationEffect(.degrees(15))
                
                Text("🐣").font(Font.system(size: 60)).offset(x: -70, y: -50).rotationEffect(.degrees(-15))
                Text("🐥").font(Font.system(size: 50)).offset(x: 80, y: 60).rotationEffect(.degrees(15))
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    PrimaryButton(title: "Continue") { state.nextStep() }
                    Text("For First-Time Users")
                        .font(Font.system(size: 14, weight: .bold))
                        .foregroundColor(Color.appTextSecondary)
                }
                .padding(.bottom, 8)
                
                OutlineButton(title: "Share with your partner") {}
                OutlineButton(title: "Transfer Data") {}
                
                Button("Contact Us") { }
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(Color.appAccent)
                    .padding(.top, 16)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
}

struct IntroScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { state.prevStep() }) {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 20, weight: .semibold))
                        Text("Back")
                            .font(Font.system(size: 18, weight: .medium))
                    }
                    .foregroundColor(Color.appAccent)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            Spacer()
            
            VStack(spacing: 24) {
                Text("🐣")
                    .font(Font.system(size: 100))
                    .overlay(
                        Text("✏️")
                            .font(Font.system(size: 40))
                            .offset(x: 40, y: 30)
                            .rotationEffect(.degrees(45)),
                        alignment: .bottomTrailing
                    )
                
                Text("Register Your Baby")
                    .font(Font.system(size: 28, weight: .bold))
                    .foregroundColor(Color.appAccent)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(2)
                
                Text("Let's get started! Tell us about the baby you'll be tracking.")
                    .font(Font.system(size: 16, weight: .medium))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            VStack(spacing: 16) {
                PrimaryButton(title: "Next") { state.nextStep() }
                OutlineButton(title: "Expecting? Tap here!") {}
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
}

struct NicknameScreen: View {
    @ObservedObject var state: BabyAppState
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            BackHeader(
                subtitle: "Register Your Baby",
                title: AnyView(Text("Nickname").font(Font.system(size: 32, weight: .bold)).foregroundColor(Color.white)),
                onBack: { state.prevStep() }
            )
            
            ProgressBar(step: 1)
            
            VStack(alignment: .leading, spacing: 24) {
                Text("Please enter a nickname for your baby. You can always change it later.")
                    .font(Font.system(size: 14, weight: .medium))
                    .foregroundColor(Color.white)
                
                TextField("Nickname", text: $state.nickname)
                    .focused($isFocused)
                    .font(Font.system(size: 20))
                    .padding()
                    .background(Color.appMediumGray.opacity(0.5))
                    .cornerRadius(12)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFocused ? Color.appAccent : Color.clear, lineWidth: 1)
                    )
                
                PrimaryButton(title: "Next", isDisabled: state.nickname.trimmingCharacters(in: .whitespaces).isEmpty) {
                    state.nextStep()
                }
                .padding(.top, 16)
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isFocused = true
            }
        }
    }
}

struct GenderScreen: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack(spacing: 0) {
            BackHeader(
                subtitle: "Register Your Baby",
                title: AnyView(
                    HStack {
                        Text("Gender").font(Font.system(size: 32, weight: .bold)).foregroundColor(Color.white)
                        Text("(optional)").font(Font.system(size: 20, weight: .regular)).foregroundColor(Color.appTextSecondary)
                    }
                ),
                onBack: { state.prevStep() }
            )
            
            ProgressBar(step: 2)
            
            VStack(alignment: .leading, spacing: 32) {
                Text("The gender of your baby is used for the Growth Chart. You can change this setting later.")
                    .font(Font.system(size: 14, weight: .medium))
                    .foregroundColor(Color.white)
                
                HStack(spacing: 0) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                state.gender = gender
                            }
                        }) {
                            Text(gender.rawValue)
                                .font(Font.system(size: 15, weight: .bold))
                                .foregroundColor(state.gender == gender ? Color.white : Color.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(state.gender == gender ? Color.appMediumGray : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(4)
                .background(Color.appMediumGray.opacity(0.5))
                .cornerRadius(12)
                
                PrimaryButton(title: "Next") { state.nextStep() }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}

struct DOBScreen: View {
    @ObservedObject var state: BabyAppState
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var showDatePicker = false
    @State private var tempDate = Date()
    
    var dateString: String {
        if let date = state.dob {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return "Date of birth not set"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            BackHeader(
                subtitle: "Register Your Baby",
                title: AnyView(
                    HStack {
                        Text("Date of Birth").font(Font.system(size: 32, weight: .bold)).foregroundColor(Color.white)
                        Text("(optional)").font(Font.system(size: 20, weight: .regular)).foregroundColor(Color.appTextSecondary)
                    }
                ),
                onBack: { state.prevStep() }
            )
            
            ProgressBar(step: 3)
            
            VStack(alignment: .leading, spacing: 32) {
                Text("Your baby's date of birth is used for the Growth Chart. You can change this setting later.")
                    .font(Font.system(size: 14, weight: .medium))
                    .foregroundColor(Color.white)
                
                HStack(spacing: 16) {
                    Button(action: { showDatePicker.toggle() }) {
                        Text(dateString)
                            .font(Font.system(size: 18, weight: .bold))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { state.dob = nil }) {
                        Text("Reset")
                            .font(Font.system(size: 18, weight: .bold))
                            .foregroundColor(Color.appAccent)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .background(Color(red: 61/255, green: 36/255, blue: 36/255))
                            .cornerRadius(12)
                    }
                }
                
                PrimaryButton(title: "OK") {
                    let baby = BabyProfile(name: state.nickname, birthDate: state.dob ?? Date())
                    modelContext.insert(baby)
                    try? modelContext.save()
                    hasCompletedOnboarding = true
                    state.nextStep()
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                HStack {
                    Spacer()
                    Button("Done") {
                        state.dob = tempDate
                        showDatePicker = false
                    }
                    .font(Font.headline)
                    .padding()
                }
                DatePicker(
                    "Select Date",
                    selection: $tempDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()
                
                Spacer()
            }
            .presentationDetents([.medium])
            .onAppear {
                tempDate = state.dob ?? Date()
            }
        }
    }
}
