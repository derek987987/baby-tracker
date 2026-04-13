import SwiftUI

struct LandingView: View {
    @State private var showingRegistration = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Welcome to BabyTracker!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 235/255, green: 130/255, blue: 130/255))
            
            ZStack {
                Circle()
                    .fill(Color(red: 250/255, green: 240/255, blue: 240/255))
                    .frame(width: 250, height: 250)
                Text("🐣")
                    .font(.system(size: 100))
            }
            .padding()
            
            VStack(spacing: 15) {
                Button(action: { showingRegistration = true }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 235/255, green: 130/255, blue: 130/255))
                        .cornerRadius(25)
                }
                Text("For First-Time Users")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Button("Share with your partner") {}
                    .buttonStyle(.bordered)
                
                Button("Transfer Data") {}
                    .buttonStyle(.bordered)
                
                Button("Contact Us") {}
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .sheet(isPresented: $showingRegistration) {
            BabyRegistrationFlow()
        }
    }
}
