import SwiftUI
import SwiftData

struct BabyRegistrationFlow: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    @State private var step = 0
    @State private var name: String = ""
    @State private var gender: String = "Gender not set"
    @State private var birthDate: Date = Date()
    @FocusState private var isNameFocused: Bool
    
    // Derived binding to ensure button updates immediately
    private var isNextDisabled: Bool {
        if step == 0 { return name.trimmingCharacters(in: .whitespaces).isEmpty }
        return false
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Progress Bar
            HStack(spacing: 4) {
                ForEach(0..<4) { i in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(i <= step ? Color(red: 235/255, green: 130/255, blue: 130/255) : .gray.opacity(0.3))
                        .frame(height: 4)
                }
            }
            .padding(.horizontal, 60)
            .padding(.top)

            // Content Area 
            VStack(spacing: 20) {
                switch step {
                case 0:
                    registrationView(title: "Nickname", prompt: "Please enter a nickname for your baby. You can always change it later.", content: 
                        TextField("Nickname", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .focused($isNameFocused)
                            .submitLabel(.next)
                    )
                case 1:
                    registrationView(title: "Gender", prompt: "The gender of your baby is used for the Growth Chart. You can change this setting later.", content: Picker("Gender", selection: $gender) {
                        Text("Boy").tag("Boy")
                        Text("Girl").tag("Girl")
                        Text("Gender not set").tag("Gender not set")
                    }.pickerStyle(.segmented))
                case 2:
                    VStack(spacing: 15) {
                        Text("Register Your Baby").font(.subheadline).foregroundColor(.gray)
                        Text("Date of Birth").font(.largeTitle).bold()
                        Text("Your baby’s date of birth is used for the Growth Chart. You can change this setting later.").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center)
                        
                        DatePicker("", selection: $birthDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                    }
                case 3:
                    VStack(spacing: 20) {
                        Text("Registration Complete").font(.title).bold().foregroundColor(Color(red: 235/255, green: 130/255, blue: 130/255))
                        Text("🐣").font(.system(size: 80))
                        VStack(alignment: .leading, spacing: 10) {
                            summaryRow(label: "Nickname", value: name)
                            summaryRow(label: "Gender", value: gender)
                            summaryRow(label: "Date of Birth", value: birthDate.formatted(date: .abbreviated, time: .omitted))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(.secondarySystemBackground)))
                        Text("Finally, pick the style you like best!").font(.subheadline)
                    }
                default: EmptyView()
                }
            }
            .padding()
            
            Spacer()
            
            Button(step == 3 ? "Done" : "Next") {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    if step < 3 {
                        step += 1
                    } else {
                        let baby = BabyProfile(name: name, birthDate: birthDate)
                        modelContext.insert(baby)
                        try? modelContext.save()
                        hasCompletedOnboarding = true
                    }
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isNextDisabled ? Color.gray : Color(red: 235/255, green: 130/255, blue: 130/255))
            .cornerRadius(25)
            .padding(.horizontal, 40)
            .padding(.bottom)
            .disabled(isNextDisabled)
        }
        .background(Color(.systemBackground))
    }
    
    @ViewBuilder
    func registrationView<Content: View>(title: String, prompt: String, content: Content) -> some View {
        VStack(spacing: 15) {
            Text("Register Your Baby").font(.subheadline).foregroundColor(.gray)
            Text(title).font(.largeTitle).bold()
            Text(prompt).font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center)
            content.padding()
        }
    }
    
    @ViewBuilder
    func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label).foregroundColor(.gray)
            Spacer()
            Text(value).bold()
        }
    }
}
